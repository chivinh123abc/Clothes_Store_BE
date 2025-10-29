import _ from 'lodash'
import { pool } from '../../configs/database.js'
import { OrderCreateDto, OrderResponseDto, OrderUpdateDto } from '../types/orders.js'

const create = async (reqBody: OrderCreateDto): Promise<OrderResponseDto> => {
  const createdEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined)

  const fields = createdEntries.map(([k]) => k)
  const indexs = createdEntries.map(([_], index) => `$${index + 1}`)
  const values = createdEntries.map(([_, v]) => v)

  const queryData = `
    INSERT INTO orders(${fields.join(', ')})
    VALUES (${indexs.join(', ')})
    RETURNING *
  `
  const result = await pool.query(queryData, values)

  return result.rows[0]
}

const findOrderById = async (order_id: number): Promise<OrderResponseDto | null> => {
  const result = await pool.query(`
      SELECT *
      FROM orders
      WHERE order_id = $1
    `, [order_id])
  return result.rows[0] || null
}

const findAllOrderByUserId = async (user_id: number): Promise<OrderResponseDto | null> => {
  const result = await pool.query(`
      SELECT *
      FROM orders
      WHERE user_id = $1
    `, [user_id])
  return result.rows[0] || null
}

const update = async (reqBody: OrderUpdateDto): Promise<OrderResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined && k !== 'order_id')

  if (updatedEntries.length === 0) {
    return null
  }

  const fields = updatedEntries.map(([k], index) => `${k} = $${index + 1}`)
  const values = updatedEntries.map(([_, v]) => v)

  fields.push('updated_at = NOW()')
  values.push(reqBody.order_id)

  const querryData = `
    UPDATE orders
    SET ${fields.join(', ')}
    WHERE order_id = $${updatedEntries.length + 1}
    RETURNING *
  `

  const result = await pool.query(querryData, values)

  return result.rows[0]
}

export const orderModel = {
  create,
  update,
  findOrderById,
  findAllOrderByUserId
}
