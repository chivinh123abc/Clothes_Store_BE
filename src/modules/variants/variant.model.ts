import _ from 'lodash'
import { pool } from '../../configs/database.js'
import { variantCreateDto, variantResponseDto, variantUpdateDto } from '../types/variants.js'

const create = async (reqBody: variantCreateDto): Promise<variantResponseDto> => {
  const result = await pool.query(`
    INSERT INTO variants (category_id, variant_name, variant_slug)
    VALUES ($1, $2, $3)
    RETURNING *
    `, [reqBody.category_id, reqBody.variant_name, reqBody.variant_slug]
  )
  return result.rows[0]
}

const getVariantById = async (variant_id: number): Promise<variantResponseDto | null> => {
  const result = await pool.query(`
      SELECT *
      FROM variants
      WHERE variant_id = $1
    `, [variant_id]
  )

  return result.rows.length > 0 ? result.rows[0] : null
}

const getVariantBySlug = async (variant_slug: string): Promise<variantResponseDto | null> => {
  const result = await pool.query(`
      SELECT *
      FROM variants
      WHERE variant_slug = $1
    `, [variant_slug]
  )

  return result.rows.length > 0 ? result.rows[0] : null
}

const update = async (reqBody: variantUpdateDto): Promise<variantResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined && k !== 'variant_id')
  if (updatedEntries.length === 0) {
    return null
  }


  const fields = updatedEntries.map(([key, _], index) => `${key} = $${index + 1}`)
  const values = updatedEntries.map(([_, value]) => value)

  fields.push('updated_at = NOW()')
  values.push(reqBody.variant_id)

  const queryData = `
    UPDATE variants
    SET ${fields.join(', ')}
    WHERE variant_id = $${updatedEntries.length + 1}
    RETURNING *
  `
  const result = await pool.query(queryData, values)

  return result.rows.length > 0 ? result.rows[0] : null
}

export const variantModel = {
  create,
  update,
  getVariantById,
  getVariantBySlug
}
