import { pool } from '../../configs/database.js'
import { CartCreateDto, CartResponseDto } from '../types/carts.js'

const create = async (reqBody: CartCreateDto): Promise<CartResponseDto> => {
  const createdEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined)

  const fields = createdEntries.map(([k]) => k)
  const indexs = createdEntries.map((_, index) => `$${index + 1}`)
  const values = createdEntries.map(([_, v]) => v)

  const queryData = `
    INSERT INTO carts(${fields.join(', ')})
    VALUES (${indexs.join(', ')})
    RETURNING *
  `

  const result = await pool.query(queryData, values)
  return result.rows[0]
}

const getCartById = async (cart_id: number): Promise<CartResponseDto> => {
  const result = await pool.query(`
      SELECT *
      FROM carts
      WHERE cart_id = $1
    `, [cart_id])
  return result.rows[0] || null
}

export const cartModel = {
  create,
  getCartById
}
