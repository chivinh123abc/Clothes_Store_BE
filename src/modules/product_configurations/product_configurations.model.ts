import { pool } from '../../configs/database.js'
import { ProductConfigurationCheckPrimaryKeyDto, ProductConfigurationCreateDto, ProductConfigurationResponseDto, ProductConfigurationUpdateDto } from '../types/product_configurations.js'


const create = async (reqBody: ProductConfigurationCreateDto): Promise<ProductConfigurationResponseDto> => {
  const result = await pool.query(`
    INSERT INTO product_configurations(product_item_id, variation_option_id)
    VALUES ($1, $2)
    RETURNING *
    `, [reqBody.product_item_id, reqBody.variation_option_id])

  return result.rows[0]
}

const isExistPrimaryKey = async (reqBody: ProductConfigurationCheckPrimaryKeyDto): Promise<boolean> => {
  const result = await pool.query(
    `
      SELECT *
      FROM product_configurations
      WHERE product_item_id = $1 AND variation_option_id = $2
    `, [reqBody.product_item_id, reqBody.variation_option_id]
  )
  return result.rows.length > 0
}

const update = async (reqBody: ProductConfigurationUpdateDto): Promise<ProductConfigurationResponseDto | null> => {
  const result = await pool.query(`
      UPDATE product_configurations
      SET product_item_id = $1, variation_option_id = $2
      WHERE product_item_id = $3 AND variation_option_id = $4
      RETURNING *
    `, [reqBody.new_product_item_id, reqBody.new_variation_option_id, reqBody.old_product_item_id, reqBody.old_variation_option_id])
  return result.rows.length > 0 ? result.rows[0] : null
}

export const productConfigurationModel = {
  create,
  isExistPrimaryKey,
  update
}
