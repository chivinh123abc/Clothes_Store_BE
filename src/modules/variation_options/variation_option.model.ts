import _ from 'lodash'
import { pool } from '../../configs/database.js'
import { VariationOptionCreateDto, VariationOptionResponseDto, VariationOptionUpdateDto } from '../types/variation_options.js'

const create = async (reqBody: VariationOptionCreateDto): Promise<VariationOptionResponseDto> => {
  const result = await pool.query(`
    INSERT INTO variation_options(variation_id, variation_option_value, variation_option_slug)
    VALUES ($1, $2, $3)
    RETURNING *
    `, [reqBody.variation_id, reqBody.variation_option_value, reqBody.variation_option_slug])

  return result.rows[0]
}

const getVariationOptionById = async (variation_option_id: number): Promise<VariationOptionResponseDto | null> => {
  const result = await pool.query(`
    SELECT *
    FROM variation_options
    WHERE variation_option_id = $1
    `, [variation_option_id])

  return result.rows.length > 0 ? result.rows[0] : null
}

const getVariationOptionBySlug = async (variation_option_slug: string): Promise<VariationOptionResponseDto | null> => {
  const result = await pool.query(`
    SELECT *
    FROM variation_options
    WHERE variation_option_slug = $1
    `, [variation_option_slug])

  return result.rows.length > 0 ? result.rows[0] : null
}

const update = async (reqBody: VariationOptionUpdateDto): Promise<VariationOptionResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([key, value]) => value !== undefined && key !== 'variation_option_id')


  if (updatedEntries.length === 0) {
    return null
  }


  const fields = updatedEntries.map(([key], index) => `${key} = $${index + 1}`)
  const values = updatedEntries.map(([_, value]) => value)

  fields.push('updated_at = NOW()')
  values.push(reqBody.variation_option_id)


  const queryData = `
    UPDATE variation_options
    SET ${fields.join(', ')}
    WHERE variation_option_id = $${updatedEntries.length + 1}
    RETURNING *
  `

  const result = await pool.query(queryData, values)
  return result.rows.length > 0 ? result.rows[0] : null
}

export const variationOptionModel = {
  create,
  getVariationOptionById,
  getVariationOptionBySlug,
  update
}
