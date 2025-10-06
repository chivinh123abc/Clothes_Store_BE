import { pool } from '../../configs/database.js'
import { ProductCheckPrimaryKeyDto, ProductConfigurationCreateDto, ProductConfigurationResponseDto } from '../types/product_configurations.js'


const create = async (reqBody: ProductConfigurationCreateDto): Promise<ProductConfigurationResponseDto> => {
  const result = await pool.query(`
    INSERT INTO product_configurations(product_item_id, variation_option_id)
    VALUES ($1, $2)
    RETURNING *
    `, [reqBody.product_item_id, reqBody.variation_item_id])

  return result.rows[0]
}

const isExistPrimaryKey = async (reqBody: ProductCheckPrimaryKeyDto): Promise<boolean> => {
  const result = await pool.query(
    `
      SELECT 1
      FROM product_configurations
      WHERE product_item_id = $1 AND variation_option_id = $2
      LIMIT 1
    `, [reqBody.product_item_id, reqBody.variation_item_id]
  )
  return (result.rowCount ?? 0) > 0
}

export const productConfigurationModel = {
  create,
  isExistPrimaryKey
}
