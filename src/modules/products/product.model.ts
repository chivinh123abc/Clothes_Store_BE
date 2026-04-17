import { pool } from '../../configs/database.js'
import { ProductCreateDto, ProductResponseDto, ProductUpdateDto } from '../types/products.js'

const create = async (reqBody: ProductCreateDto): Promise<ProductResponseDto> => {
  const createEntries = Object.entries(reqBody).filter(([_, v]) => v !== undefined)
  const field_keys = createEntries.map(([key]) => `${key}`)
  const field_values = createEntries.map(([_], index) => `$${index + 1}`)
  const values = createEntries.map(([_, value]) => value)

  const createData = `
    INSERT INTO products (${field_keys.join(', ')})
    VALUES (${field_values.join(', ')})
    RETURNING *
  `
  const createdProduct = await pool.query(createData, values)
  return createdProduct.rows[0]
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
              ELSE pi.product_item_price
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
              ELSE pi.product_item_price
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

const update = async (product_id: number, reqBody: ProductUpdateDto): Promise<ProductResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([_, value]) => value !== undefined)
  if (updatedEntries.length === 0) return null

  const fields = updatedEntries.map(([key], index) => `${key} = $${index + 1}`)
  const value = updatedEntries.map(([_, value]) => value)

  fields.push('updated_at = NOW()')
  value.push(product_id)

  const queryData = `
    UPDATE products
    SET ${fields.join(', ')}
    WHERE product_id = $${updatedEntries.length + 1}
    RETURNING *
  `
  const updatedProduct = await pool.query(queryData, value)
  return updatedProduct.rows[0]
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
              ELSE pi.product_item_price
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
                ELSE pi.product_item_price
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
