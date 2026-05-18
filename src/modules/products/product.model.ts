import { pool } from '../../configs/database.js'
import { ProductCreateDto, ProductResponseDto, ProductUpdateDto } from '../types/products.js'

const create = async (reqBody: any): Promise<ProductResponseDto> => {
  const client = await pool.connect()
  try {
    await client.query('BEGIN')

    const { items, collection_ids, ...rawProductData } = reqBody

    // Whitelist only columns that exist in the products table
    const ALLOWED_PRODUCT_COLUMNS = ['product_name', 'category_id', 'product_slug', 'product_description', 'is_bestseller']
    const productData = Object.fromEntries(
      Object.entries(rawProductData).filter(([key]) => ALLOWED_PRODUCT_COLUMNS.includes(key))
    )

    // 1. Insert product
    const createEntries = Object.entries(productData).filter(([_, v]) => v !== undefined)
    const field_keys = createEntries.map(([key]) => `${key}`)
    const field_values = createEntries.map(([_], index) => `$${index + 1}`)
    const values = createEntries.map(([_, value]) => value)

    const createProductQuery = `
      INSERT INTO products (${field_keys.join(', ')})
      VALUES (${field_values.join(', ')})
      RETURNING *
    `
    const createdProductRes = await client.query(createProductQuery, values)
    const newProduct = createdProductRes.rows[0]
    const productId = newProduct.product_id

    // 2. Insert product collections links
    if (collection_ids && Array.isArray(collection_ids)) {
      for (const colId of collection_ids) {
        await client.query(
          'INSERT INTO product_collections (product_id, collection_id) VALUES ($1, $2) ON CONFLICT DO NOTHING',
          [productId, colId]
        )
      }
    }

    // 3. Insert product items (variants)
    if (items && Array.isArray(items)) {
      for (const item of items) {
        const { sku, stock_quantity, product_item_price, size, discount_id, product_item_image } = item

        // Insert product_item
        const insertItemRes = await client.query(
          `INSERT INTO product_items (product_id, sku, stock_quantity, product_item_price, product_item_image, discount_id)
           VALUES ($1, $2, $3, $4, $5, $6)
           RETURNING *`,
          [productId, sku, stock_quantity, product_item_price, product_item_image || null, discount_id || null]
        )
        const newItem = insertItemRes.rows[0]

        // Map size string to variant_option_id
        if (size) {
          // Find variant_option_id for this category & size
          let optionRes = await client.query(
            `SELECT vo.variant_option_id 
             FROM variant_options vo
             JOIN variants v ON vo.variant_id = v.variant_id
             WHERE v.category_id = $1 AND UPPER(vo.variant_option_value) = UPPER($2)
             LIMIT 1`,
            [newProduct.category_id, size]
          )

          // Fallback: search globally
          if (optionRes.rows.length === 0) {
            optionRes = await client.query(
              'SELECT variant_option_id FROM variant_options WHERE UPPER(variant_option_value) = UPPER($1) LIMIT 1',
              [size]
            )
          }

          if (optionRes.rows.length > 0) {
            const variantOptionId = optionRes.rows[0].variant_option_id
            await client.query(
              `INSERT INTO product_configurations (product_item_id, variant_option_id)
               VALUES ($1, $2) ON CONFLICT DO NOTHING`,
              [newItem.product_item_id, variantOptionId]
            )
          }
        }
      }
    }

    await client.query('COMMIT')
    return newProduct
  } catch (error) {
    await client.query('ROLLBACK')
    throw error
  } finally {
    client.release()
  }
}

const findProductById = async (product_id: number): Promise<ProductResponseDto | null> => {
  const result = await pool.query(`
    SELECT 
      p.*, 
      cat.category_name,
      (
        SELECT JSON_AGG(item_data)
        FROM (
          SELECT 
            pi.*,
            vo_size.variant_option_value as size,
            disc.discount_percent,
            CASE 
              WHEN disc.discount_percent IS NOT NULL 
              THEN pi.product_item_price * (1 - disc.discount_percent::float/100)
              ELSE NULL
            END as sale_price
          FROM product_items pi
          LEFT JOIN product_configurations conf ON pi.product_item_id = conf.product_item_id
          LEFT JOIN variant_options vo_size ON conf.variant_option_id = vo_size.variant_option_id
          LEFT JOIN discounts disc ON pi.discount_id = disc.discount_id
          WHERE pi.product_id = p.product_id
        ) item_data
      ) as items,
      (
        SELECT COALESCE(JSON_AGG(coll_data), '[]'::json)
        FROM (
          SELECT col_inner.collection_id, col_inner.collection_name, col_inner.collection_slug
          FROM collections col_inner
          JOIN product_collections pc_inner ON col_inner.collection_id = pc_inner.collection_id
          WHERE pc_inner.product_id = p.product_id
        ) coll_data
      ) as collections
    FROM products p
    LEFT JOIN categories cat ON p.category_id = cat.category_id
    WHERE p.product_id = $1
    `,
    [product_id]
  )
  return result.rows.length > 0 ? result.rows[0] : null
}

const findProductBySlug = async (product_slug: string): Promise<ProductResponseDto | null> => {
  const result = await pool.query(`
    SELECT 
      p.*, 
      cat.category_name,
      (
        SELECT JSON_AGG(item_data)
        FROM (
          SELECT 
            pi.*,
            vo_size.variant_option_value as size,
            disc.discount_percent,
            CASE 
              WHEN disc.discount_percent IS NOT NULL 
              THEN pi.product_item_price * (1 - disc.discount_percent::float/100)
              ELSE NULL
            END as sale_price
          FROM product_items pi
          LEFT JOIN product_configurations conf ON pi.product_item_id = conf.product_item_id
          LEFT JOIN variant_options vo_size ON conf.variant_option_id = vo_size.variant_option_id
          LEFT JOIN discounts disc ON pi.discount_id = disc.discount_id
          WHERE pi.product_id = p.product_id
        ) item_data
      ) as items,
      (
        SELECT COALESCE(JSON_AGG(coll_data), '[]'::json)
        FROM (
          SELECT col_inner.collection_id, col_inner.collection_name, col_inner.collection_slug
          FROM collections col_inner
          JOIN product_collections pc_inner ON col_inner.collection_id = pc_inner.collection_id
          WHERE pc_inner.product_id = p.product_id
        ) coll_data
      ) as collections
    FROM products p
    LEFT JOIN categories cat ON p.category_id = cat.category_id
    WHERE p.product_slug = $1
    `,
    [product_slug]
  )
  return result.rows.length > 0 ? result.rows[0] : null
}

const update = async (product_id: number, reqBody: any): Promise<ProductResponseDto | null> => {
  const client = await pool.connect()
  try {
    await client.query('BEGIN')

    const { items, collection_ids, ...rawProductData } = reqBody

    // Whitelist only columns that exist in the products table
    const ALLOWED_PRODUCT_COLUMNS = ['product_name', 'category_id', 'product_slug', 'product_description', 'is_bestseller']
    const productData = Object.fromEntries(
      Object.entries(rawProductData).filter(([key]) => ALLOWED_PRODUCT_COLUMNS.includes(key))
    )

    // 1. Update product main fields if any
    let updatedProduct = null
    const updatedEntries = Object.entries(productData).filter(([_, value]) => value !== undefined)
    if (updatedEntries.length > 0) {
      const fields = updatedEntries.map(([key], index) => `${key} = $${index + 1}`)
      const value = updatedEntries.map(([_, val]) => val)

      fields.push('updated_at = NOW()')
      value.push(product_id)

      const queryData = `
        UPDATE products
        SET ${fields.join(', ')}
        WHERE product_id = $${updatedEntries.length + 1}
        RETURNING *
      `
      const updatedProductRes = await client.query(queryData, value)
      updatedProduct = updatedProductRes.rows[0]
    } else {
      const currentProductRes = await client.query('SELECT * FROM products WHERE product_id = $1', [product_id])
      updatedProduct = currentProductRes.rows[0]
    }

    if (!updatedProduct) {
      await client.query('ROLLBACK')
      return null
    }

    // 2. Sync product collections links
    if (collection_ids && Array.isArray(collection_ids)) {
      await client.query('DELETE FROM product_collections WHERE product_id = $1', [product_id])
      for (const colId of collection_ids) {
        await client.query(
          'INSERT INTO product_collections (product_id, collection_id) VALUES ($1, $2) ON CONFLICT DO NOTHING',
          [product_id, colId]
        )
      }
    }

    // 3. Sync product items (variants)
    if (items && Array.isArray(items)) {
      // Get all current items
      const currentItemsRes = await client.query('SELECT product_item_id FROM product_items WHERE product_id = $1', [product_id])
      const currentItemIds = currentItemsRes.rows.map(r => r.product_item_id)

      // We will keep/update or insert
      const incomingItemIds: number[] = []

      for (const item of items) {
        const { product_item_id, sku, stock_quantity, product_item_price, size, discount_id, product_item_image } = item

        if (product_item_id) {
          // Update existing
          incomingItemIds.push(product_item_id)
          await client.query(
            `UPDATE product_items 
             SET sku = $1, stock_quantity = $2, product_item_price = $3, product_item_image = $4, discount_id = $5, updated_at = NOW()
             WHERE product_item_id = $6`,
            [sku, stock_quantity, product_item_price, product_item_image || null, discount_id || null, product_item_id]
          )

          // Update size variant option if changed
          if (size) {
            await client.query('DELETE FROM product_configurations WHERE product_item_id = $1', [product_item_id])

            // Find variant_option_id for this category & size
            let optionRes = await client.query(
              `SELECT vo.variant_option_id 
               FROM variant_options vo
               JOIN variants v ON vo.variant_id = v.variant_id
               WHERE v.category_id = $1 AND UPPER(vo.variant_option_value) = UPPER($2)
               LIMIT 1`,
              [updatedProduct.category_id, size]
            )

            // Fallback: search globally
            if (optionRes.rows.length === 0) {
              optionRes = await client.query(
                'SELECT variant_option_id FROM variant_options WHERE UPPER(variant_option_value) = UPPER($1) LIMIT 1',
                [size]
              )
            }

            if (optionRes.rows.length > 0) {
              const variantOptionId = optionRes.rows[0].variant_option_id
              await client.query(
                `INSERT INTO product_configurations (product_item_id, variant_option_id)
                 VALUES ($1, $2) ON CONFLICT DO NOTHING`,
                [product_item_id, variantOptionId]
              )
            }
          }
        } else {
          // Insert new item
          const insertItemRes = await client.query(
            `INSERT INTO product_items (product_id, sku, stock_quantity, product_item_price, product_item_image, discount_id)
             VALUES ($1, $2, $3, $4, $5, $6)
             RETURNING *`,
            [product_id, sku, stock_quantity, product_item_price, product_item_image || null, discount_id || null]
          )
          const newItem = insertItemRes.rows[0]
          incomingItemIds.push(newItem.product_item_id)

          if (size) {
            // Find variant_option_id for this category & size
            let optionRes = await client.query(
              `SELECT vo.variant_option_id 
               FROM variant_options vo
               JOIN variants v ON vo.variant_id = v.variant_id
               WHERE v.category_id = $1 AND UPPER(vo.variant_option_value) = UPPER($2)
               LIMIT 1`,
              [updatedProduct.category_id, size]
            )

            // Fallback: search globally
            if (optionRes.rows.length === 0) {
              optionRes = await client.query(
                'SELECT variant_option_id FROM variant_options WHERE UPPER(variant_option_value) = UPPER($1) LIMIT 1',
                [size]
              )
            }

            if (optionRes.rows.length > 0) {
              const variantOptionId = optionRes.rows[0].variant_option_id
              await client.query(
                `INSERT INTO product_configurations (product_item_id, variant_option_id)
                 VALUES ($1, $2) ON CONFLICT DO NOTHING`,
                [newItem.product_item_id, variantOptionId]
              )
            }
          }
        }
      }

      // Delete items not in incomingItemIds
      const itemsToDelete = currentItemIds.filter(id => !incomingItemIds.includes(id))
      if (itemsToDelete.length > 0) {
        await client.query(
          'DELETE FROM product_configurations WHERE product_item_id = ANY($1)',
          [itemsToDelete]
        )
        await client.query(
          'DELETE FROM product_items WHERE product_item_id = ANY($1)',
          [itemsToDelete]
        )
      }
    }

    await client.query('COMMIT')
    return updatedProduct
  } catch (error) {
    await client.query('ROLLBACK')
    throw error
  } finally {
    client.release()
  }
}

const findAll = async (): Promise<ProductResponseDto[]> => {
  const result = await pool.query(`
    SELECT 
      p.*, 
      cat.category_name,
      (
        SELECT JSON_AGG(item_data)
        FROM (
          SELECT 
            pi.*,
            vo_size.variant_option_value as size,
            disc.discount_percent,
            CASE 
              WHEN disc.discount_percent IS NOT NULL 
              THEN pi.product_item_price * (1 - disc.discount_percent::float/100)
              ELSE NULL
            END as sale_price
          FROM product_items pi
          LEFT JOIN product_configurations conf ON pi.product_item_id = conf.product_item_id
          LEFT JOIN variant_options vo_size ON conf.variant_option_id = vo_size.variant_option_id
          LEFT JOIN discounts disc ON pi.discount_id = disc.discount_id
          WHERE pi.product_id = p.product_id
        ) item_data
      ) as items,
      (
        SELECT COALESCE(JSON_AGG(coll_data), '[]'::json)
        FROM (
          SELECT col_inner.collection_id, col_inner.collection_name, col_inner.collection_slug
          FROM collections col_inner
          JOIN product_collections pc_inner ON col_inner.collection_id = pc_inner.collection_id
          WHERE pc_inner.product_id = p.product_id
        ) coll_data
      ) as collections
    FROM products p
    LEFT JOIN categories cat ON p.category_id = cat.category_id
    ORDER BY p.created_at DESC
  `)
  return result.rows
}

const getByCollectionSlug = async (slug: string): Promise<ProductResponseDto[]> => {
  const result = await pool.query(`
    WITH RECURSIVE collection_hierarchy AS (
      SELECT collection_id FROM collections WHERE collection_slug = $1
      UNION ALL
      SELECT c_recursive.collection_id FROM collections c_recursive
      JOIN collection_hierarchy ch ON c_recursive.parent_collection_id = ch.collection_id
    )
    SELECT * FROM (
      SELECT DISTINCT ON (p.product_id)
        p.*, 
        cat.category_name,
        (
          SELECT JSON_AGG(item_data)
          FROM (
            SELECT 
              pi.*,
              vo_size.variant_option_value as size,
              disc.discount_percent,
              CASE 
                WHEN disc.discount_percent IS NOT NULL 
                THEN pi.product_item_price * (1 - disc.discount_percent::float/100)
                ELSE NULL
              END as sale_price
            FROM product_items pi
            LEFT JOIN product_configurations conf ON pi.product_item_id = conf.product_item_id
            LEFT JOIN variant_options vo_size ON conf.variant_option_id = vo_size.variant_option_id
            LEFT JOIN discounts disc ON pi.discount_id = disc.discount_id
            WHERE pi.product_id = p.product_id
          ) item_data
        ) as items,
        (
          SELECT COALESCE(JSON_AGG(coll_data), '[]'::json)
          FROM (
            SELECT col_inner.collection_id, col_inner.collection_name, col_inner.collection_slug
            FROM collections col_inner
            JOIN product_collections pc_inner ON col_inner.collection_id = pc_inner.collection_id
            WHERE pc_inner.product_id = p.product_id
          ) coll_data
        ) as collections
      FROM products p
      LEFT JOIN categories cat ON p.category_id = cat.category_id
      JOIN product_collections pc_link ON p.product_id = pc_link.product_id
      WHERE pc_link.collection_id IN (SELECT collection_id FROM collection_hierarchy)
      ORDER BY p.product_id, p.created_at DESC
    ) t
    ORDER BY t.created_at DESC
  `, [slug])
  return result.rows
}

const deleteProduct = async (product_id: number): Promise<boolean> => {
  const result = await pool.query(`
    DELETE FROM products
    WHERE product_id = $1
  `, [product_id])
  return (result.rowCount ?? 0) > 0
}

export const productModel = {
  create,
  findProductById,
  findProductBySlug,
  update,
  findAll,
  getByCollectionSlug,
  deleteProduct
}
