import { pool } from '../../configs/database.js'
import { ProductItemCreateDto, ProductItemResponseDto, ProductItemUpdateDto } from '../types/product_items.js'

const create = async (reqBody: ProductItemCreateDto): Promise<ProductItemResponseDto> => {
  const { product_id, stock_quantity, product_item_price, sku, product_item_image, discount_id } = reqBody
  const result = await pool.query(`
    INSERT INTO product_items (product_id, stock_quantity, product_item_price, sku, product_item_image, discount_id)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING *
    `,
    [product_id, stock_quantity, product_item_price, sku, product_item_image, discount_id]
  )
  return result.rows[0]
}

const findProductItemById = async (product_item_id: number): Promise<ProductItemResponseDto | null> => {
  const result = await pool.query(`
    SELECT 
      pi.*,
      d.discount_percent,
      CASE 
        WHEN d.active = true AND d.discount_percent IS NOT NULL 
        THEN pi.product_item_price * (1 - d.discount_percent::float/100)
        ELSE pi.product_item_price
      END as sale_price,
      vo.variant_option_value as size
    FROM product_items pi
    LEFT JOIN discounts d ON pi.discount_id = d.discount_id
    LEFT JOIN product_configurations pc ON pi.product_item_id = pc.product_item_id
    LEFT JOIN variant_options vo ON pc.variant_option_id = vo.variant_option_id
    WHERE pi.product_item_id = $1 
    `,
    [product_item_id]
  )
  return result.rows[0] || null
}

const findProductItemBySKU = async (sku: string): Promise<ProductItemResponseDto | null> => {
  const result = await pool.query(`
    SELECT 
      pi.*,
      d.discount_percent,
      CASE 
        WHEN d.active = true AND d.discount_percent IS NOT NULL 
        THEN pi.product_item_price * (1 - d.discount_percent::float/100)
        ELSE pi.product_item_price
      END as sale_price
    FROM product_items pi
    LEFT JOIN discounts d ON pi.discount_id = d.discount_id
    WHERE pi.sku = $1 
    `,
    [sku]
  )
  return result.rows[0] || null
}

const update = async (reqBody: ProductItemUpdateDto): Promise<ProductItemResponseDto | null> => {
  const { product_item_id, ...data } = reqBody
  const entries = Object.entries(data).filter(([_, v]) => v !== undefined)
  if (entries.length === 0) return null

  const fields = entries.map(([k], i) => `${k} = $${i + 1}`)
  const values = entries.map(([_, v]) => v)

  fields.push('updated_at = NOW()')
  values.push(product_item_id)

  const query = `
    UPDATE product_items 
    SET ${fields.join(', ')} 
    WHERE product_item_id = $${values.length} 
    RETURNING *
  `
  const result = await pool.query(query, values)
  return result.rows[0]
}

export const productItemModel = {
  create,
  findProductItemById,
  update,
  findProductItemBySKU
}
