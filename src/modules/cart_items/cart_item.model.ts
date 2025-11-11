import { pool } from '../../configs/database.js'
import { CartItemCreateDto, CartItemReponseDto } from '../types/cart_item.js'

const create = async (reqBody: CartItemCreateDto): Promise<CartItemReponseDto> => {
  const createdEntries = Object.entries(reqBody).filter(([_, v]) => v !== undefined)

  const fields = createdEntries.map(([k]) => k)
  const indexs = createdEntries.map(([_], index) => `$${index + 1}`)
  const values = createdEntries.map(([_, v]) => v)

  const queryData = `
    INSERT INTO cart_items(${fields.join(', ')})
    VALUES (${indexs.join(', ')})
    RETURNING *
  `

  const result = await pool.query(queryData, values)
  return result.rows[0]
}

const getCartItemById = async (cart_item_id: number): Promise<CartItemReponseDto | null> => {
  const result = await pool.query(`
    SELECT *
    FROM cart_items
    WHERE cart_item_id = $1
    `, [cart_item_id])

  return result.rows[0] || null
}

export const cartItemModel = {
  create,
  getCartItemById
}
