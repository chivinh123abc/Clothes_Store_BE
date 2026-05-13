import { pool } from '../../configs/database.js'
import {
  UserResponseDto,
  UserRegisterDto,
  UserUpdateDto,
  UserEntity
} from '../types/user.js'

// CREATE da xong
const create = async (reqBody: any): Promise<UserResponseDto> => {
  const updatedEntries = Object.entries(reqBody).filter(([_, v]) => v !== undefined)
  const columns = updatedEntries.map(([key]) => key)
  const placeholders = updatedEntries.map((_, index) => `$${index + 1}`)
  const values = updatedEntries.map(([_, value]) => value)

  const query = `
    INSERT INTO users (${columns.join(', ')})
    VALUES (${placeholders.join(', ')})
    RETURNING user_id, username, email, phone_number, role, avatar, created_at, updated_at, is_active
  `
  const result = await pool.query(query, values)
  return result.rows[0]
}

//Ham nay ok
const findUserByEmail = async (email: string): Promise<UserEntity | null> => {
  const result = await pool.query(
    `
      SELECT user_id, username, password, email, phone_number, role, avatar, created_at, updated_at, is_active, is_destroy, verify_token
      FROM users
      WHERE email = $1 AND is_destroy = false
    `, [email]
  )
  return result.rows.length > 0 ? result.rows[0] : null
}

const findUserByIdentifier = async (identifier: string): Promise<UserEntity | null> => {
  const result = await pool.query(
    `
      SELECT user_id, username, password, email, phone_number, role, avatar, created_at, updated_at, is_active, is_destroy, verify_token
      FROM users
      WHERE (email = $1 OR username = $1) AND is_destroy = false
    `, [identifier]
  )
  return result.rows.length > 0 ? result.rows[0] : null
}

//Ham nay ok not
const findUserById = async (user_id: number): Promise<UserEntity | null> => {
  const result = await pool.query(
    `
      SELECT user_id, username, password, email, phone_number, role, avatar, created_at, updated_at, is_active, is_destroy, verify_token
      FROM users
      WHERE user_id = $1 AND is_destroy = false
    `,
    [user_id]
  )
  return result.rows.length > 0 ? result.rows[0] : null
}

const update = async (user_id: number, reqBody: UserUpdateDto): Promise<UserResponseDto | null> => {
  const updatedEntries = Object.entries(reqBody).filter(([_, v]) => v !== undefined)

  if (updatedEntries.length === 0) {
    return null
  }
  const fields = updatedEntries.map(([key], index) => `${key} = $${index + 1}`)
  const values = updatedEntries.map(([_, value]) => value)

  fields.push('updated_at = NOW()')

  values.push(user_id)

  const queryData = `
    UPDATE users
    SET ${fields.join(', ')}
    WHERE user_id = $${updatedEntries.length + 1}
    RETURNING user_id, username, email, phone_number, avatar, created_at, updated_at, is_destroy, is_active, verify_token
    `
  const result = await pool.query(queryData, values)
  return result.rows[0] || null
}

const softDelete = async (user_id: number): Promise<UserResponseDto> => {
  const result = await pool.query(
    `
    UPDATE users
    SET is_destroy = $1
    WHERE user_id = $2
    RETURNING user_id, is_destroy
    `, [true, user_id]
  )

  return result.rows[0] || false
}

const findAll = async (): Promise<UserResponseDto[]> => {
  const result = await pool.query(
    `
    SELECT user_id, username, email, phone_number, role, avatar, created_at, updated_at, is_active, is_destroy, verify_token
    FROM users
    ORDER BY created_at DESC
    `
  )
  return result.rows
}

const adminDelete = async (user_id: number): Promise<boolean> => {
  const result = await pool.query(
    `
    DELETE FROM users
    WHERE user_id = $1
    `, [user_id]
  )
  return (result.rowCount ?? 0) > 0
}

export const userModel = {
  create,
  findUserById,
  findUserByEmail,
  findUserByIdentifier,
  update,
  softDelete,
  findAll,
  adminDelete
}
