import { pool } from '../../configs/database.js'
import { OrderItemCreateDto, OrderItemResponseDto, OrderItemUpdateDto } from '../types/order_items.js'

const create = async (reqBody: OrderItemCreateDto): Promise<OrderItemResponseDto> => {
  const createdEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined)

  const fields = createdEntries.map(([k]) => k)
  const indexs = createdEntries.map(([], index) => `$${index + 1}`)
  const values = createdEntries.map(([_, v]) => v)

  const queryData = `
    INSERT INTO order_items(${fields.join(', ')})
    VALUES(${indexs.join(', ')})
    RETURNING *
    `

  const result = await pool.query(queryData, values)
  return result.rows[0]
}

const getOrderItemById = async (order_item_id: number): Promise<OrderItemResponseDto | null> => {
  const result = await pool.query(`
    SELECT *
    FROM order_items
    WHERE order_item_id = $1
  `, [order_item_id])
  return result.rows[0] || null
}

const update = async (reqBody: OrderItemUpdateDto): Promise<OrderItemResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined && k !== 'order_item_id')

  const fields = updatedEntries.map(([k], index) => `${k} = $${index + 1}`)
  const values = updatedEntries.map(([_, v]) => v)

  fields.push('updated_at = NOW()')
  values.push(reqBody.order_item_id)

  const queryData = `
    UPDATE order_items
    SET ${fields.join(', ')}
    WHERE order_item_id = $${updatedEntries.length + 1}
    RETURNING *
  `

  const result = await pool.query(queryData, values)
  return result.rows[0] || null
}

export const orderItemModel = {
  create,
  getOrderItemById,
  update
}
