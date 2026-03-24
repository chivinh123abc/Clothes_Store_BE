import _ from 'lodash'
import { pool } from '../../configs/database.js'
import { variantOptionCreateDto, variantOptionResponseDto, variantOptionUpdateDto } from '../types/variant_options.js'

const create = async (reqBody: variantOptionCreateDto): Promise<variantOptionResponseDto> => {
  const result = await pool.query(`
    INSERT INTO variant_options(variant_id, variant_option_value, variant_option_slug)
    VALUES ($1, $2, $3)
    RETURNING *
    `, [reqBody.variant_id, reqBody.variant_option_value, reqBody.variant_option_slug])

  return result.rows[0]
}

const getVariantOptionById = async (variant_option_id: number): Promise<variantOptionResponseDto | null> => {
  const result = await pool.query(`
    SELECT *
    FROM variant_options
    WHERE variant_option_id = $1
    `, [variant_option_id])

  return result.rows.length > 0 ? result.rows[0] : null
}

const getVariantOptionBySlug = async (variant_option_slug: string): Promise<variantOptionResponseDto | null> => {
  const result = await pool.query(`
    SELECT *
    FROM variant_options
    WHERE variant_option_slug = $1
    `, [variant_option_slug])

  return result.rows.length > 0 ? result.rows[0] : null
}

const update = async (reqBody: variantOptionUpdateDto): Promise<variantOptionResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([key, value]) => value !== undefined && key !== 'variant_option_id')


  if (updatedEntries.length === 0) {
    return null
  }


  const fields = updatedEntries.map(([key], index) => `${key} = $${index + 1}`)
  const values = updatedEntries.map(([_, value]) => value)

  fields.push('updated_at = NOW()')
  values.push(reqBody.variant_option_id)


  const queryData = `
    UPDATE variant_options
    SET ${fields.join(', ')}
    WHERE variant_option_id = $${updatedEntries.length + 1}
    RETURNING *
  `

  const result = await pool.query(queryData, values)
  return result.rows.length > 0 ? result.rows[0] : null
}

export const variantOptionModel = {
  create,
  getVariantOptionById,
  getVariantOptionBySlug,
  update
}
