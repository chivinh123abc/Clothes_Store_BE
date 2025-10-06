import _ from 'lodash'
import { pool } from '../../configs/database.js'
import { VariationCreateDto, VariationResponseDto, VariationUpdateDto } from '../types/variations.js'

const create = async (reqBody: VariationCreateDto): Promise<VariationResponseDto> => {
  const result = await pool.query(`
    INSERT INTO variations (category_id, variation_name, variation_slug)
    VALUES ($1, $2, $3)
    RETURNING *
    `, [reqBody.category_id, reqBody.variation_name, reqBody.variation_slug]
  )
  return result.rows[0]
}

const getVariationById = async (variation_id: number): Promise<VariationResponseDto | null> => {
  const result = await pool.query(`
      SELECT *
      FROM variations
      WHERE variation_id = $1
    `, [variation_id]
  )

  return result.rows.length > 0 ? result.rows[0] : null
}

const getVariationBySlug = async (variation_slug: string): Promise<VariationResponseDto | null> => {
  const result = await pool.query(`
      SELECT *
      FROM variations
      WHERE variation_slug = $1
    `, [variation_slug]
  )

  return result.rows.length > 0 ? result.rows[0] : null
}

const update = async (reqBody: VariationUpdateDto): Promise<VariationResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined && k !== 'variation_id')
  if (updatedEntries.length === 0) {
    return null
  }


  const fields = updatedEntries.map(([key, _], index) => `${key} = $${index + 1}`)
  const values = updatedEntries.map(([_, value]) => value)

  fields.push('updated_at = NOW()')
  values.push(reqBody.variation_id)

  const queryData = `
    UPDATE variations
    SET ${fields.join(', ')}
    WHERE variation_id = $${updatedEntries.length + 1}
    RETURNING *
  `
  const result = await pool.query(queryData, values)

  return result.rows.length > 0 ? result.rows[0] : null
}

export const variationModel = {
  create,
  update,
  getVariationById,
  getVariationBySlug
}
