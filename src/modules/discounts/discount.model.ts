import { pool } from '../../configs/database.js'
import { DiscountCreateDto, DiscountResponseDto, DiscountUpdateDto } from '../types/discounts.js'

const create = async (data: DiscountCreateDto): Promise<DiscountResponseDto> => {
  const { name, description, discount_percent, active } = data
  const result = await pool.query(`
    INSERT INTO discounts (name, description, discount_percent, active)
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `, [name, description, discount_percent, active ?? true])
  return result.rows[0]
}

const findAll = async (): Promise<DiscountResponseDto[]> => {
  const result = await pool.query('SELECT * FROM discounts ORDER BY created_at DESC')
  return result.rows
}

const findById = async (id: number): Promise<DiscountResponseDto | null> => {
  const result = await pool.query('SELECT * FROM discounts WHERE discount_id = $1', [id])
  return result.rows[0] || null
}

const update = async (id: number, data: DiscountUpdateDto): Promise<DiscountResponseDto | null> => {
  const entries = Object.entries(data).filter(([_, v]) => v !== undefined)
  if (entries.length === 0) return null

  const fields = entries.map(([k], i) => `${k} = $${i + 1}`)
  const values = entries.map(([_, v]) => v)

  fields.push('updated_at = NOW()')
  values.push(id)

  const query = `
    UPDATE discounts SET ${fields.join(', ')} WHERE discount_id = $${values.length} RETURNING *
  `
  const result = await pool.query(query, values)
  return result.rows[0]
}

const deleteDiscount = async (id: number): Promise<boolean> => {
  const result = await pool.query('DELETE FROM discounts WHERE discount_id = $1', [id])
  return (result.rowCount ?? 0) > 0
}

export const discountModel = {
  create,
  findAll,
  findById,
  update,
  deleteDiscount
}
