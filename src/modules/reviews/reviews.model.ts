import { pool } from '../../configs/database.js'

const create = async (userId: number, productId: number, rating: number, text: string, imageUrl?: string): Promise<any> => {
  const result = await pool.query(
    `
      INSERT INTO reviews (user_id, product_id, rating, text, image_url)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `,
    [userId, productId, rating, text, imageUrl || null]
  )
  return result.rows[0]
}

const findByProductId = async (productId: number): Promise<any[]> => {
  const result = await pool.query(
    `
      SELECT r.*, u.username, u.avatar, u.display_name,
             (SELECT product_item_image FROM product_items pi WHERE pi.product_id = r.product_id LIMIT 1) as product_image
      FROM reviews r
      JOIN users u ON r.user_id = u.user_id
      WHERE r.product_id = $1
      ORDER BY r.created_at DESC
    `,
    [productId]
  )
  return result.rows
}

const findAllReviews = async (): Promise<any[]> => {
  const result = await pool.query(
    `
      SELECT r.*, u.username, u.avatar, u.display_name, p.product_name as product,
             (SELECT product_item_image FROM product_items pi WHERE pi.product_id = r.product_id LIMIT 1) as product_image
      FROM reviews r
      JOIN users u ON r.user_id = u.user_id
      JOIN products p ON r.product_id = p.product_id
      ORDER BY r.created_at DESC
    `
  )
  return result.rows
}

const update = async (reviewId: number, userId: number, rating: number, text: string, imageUrl?: string, isAdmin?: boolean): Promise<any> => {
  let result
  if (isAdmin) {
    result = await pool.query(
      `
        UPDATE reviews
        SET rating = $1, text = $2, image_url = $3
        WHERE review_id = $4
        RETURNING *
      `,
      [rating, text, imageUrl || null, reviewId]
    )
  } else {
    result = await pool.query(
      `
        UPDATE reviews
        SET rating = $1, text = $2, image_url = $3
        WHERE review_id = $4 AND user_id = $5
        RETURNING *
      `,
      [rating, text, imageUrl || null, reviewId, userId]
    )
  }
  return result.rows[0]
}

const remove = async (reviewId: number, userId: number, isAdmin?: boolean): Promise<boolean> => {
  let result
  if (isAdmin) {
    result = await pool.query(
      `
        DELETE FROM reviews
        WHERE review_id = $1
        RETURNING *
      `,
      [reviewId]
    )
  } else {
    result = await pool.query(
      `
        DELETE FROM reviews
        WHERE review_id = $1 AND user_id = $2
        RETURNING *
      `,
      [reviewId, userId]
    )
  }
  return (result.rowCount ?? 0) > 0
}

export const reviewsModel = {
  create,
  findByProductId,
  findAllReviews,
  update,
  remove
}
