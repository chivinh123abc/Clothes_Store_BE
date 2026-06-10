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

const getCartByUserId = async (user_id: number): Promise<CartResponseDto | null> => {
  const result = await pool.query(`
      SELECT *
      FROM carts
      WHERE user_id = $1
    `, [user_id])
  return result.rows[0] || null
}

const getCartItemsDetails = async (cart_id: number): Promise<any[]> => {
  const result = await pool.query(`
    SELECT 
      ci.cart_item_id,
      pi.product_id as id,
      p.product_name as name,
      pi.product_item_image as "imageUrl",
      vo.variant_option_value as size,
      ci.quantity,
      pi.product_item_price as "originalPrice",
      CASE 
        WHEN d.active = true AND d.discount_percent IS NOT NULL 
        THEN pi.product_item_price * (1 - d.discount_percent::float/100)
        ELSE pi.product_item_price
      END as price
    FROM cart_items ci
    JOIN product_items pi ON ci.product_item_id = pi.product_item_id
    JOIN products p ON pi.product_id = p.product_id
    LEFT JOIN discounts d ON pi.discount_id = d.discount_id
    LEFT JOIN product_configurations pc ON pi.product_item_id = pc.product_item_id
    LEFT JOIN variant_options vo ON pc.variant_option_id = vo.variant_option_id
    WHERE ci.cart_id = $1
    ORDER BY MAX(ci.created_at) OVER(PARTITION BY pi.product_id) DESC, ci.created_at ASC
  `, [cart_id])
  return result.rows
}

const findProductItemId = async (product_id: number, size: string): Promise<number | null> => {
  const result = await pool.query(`
    SELECT pi.product_item_id
    FROM product_items pi
    JOIN product_configurations pc ON pi.product_item_id = pc.product_item_id
    JOIN variant_options vo ON pc.variant_option_id = vo.variant_option_id
    WHERE pi.product_id = $1 AND UPPER(vo.variant_option_value) = UPPER($2)
    LIMIT 1
  `, [product_id, size])
  return result.rows[0]?.product_item_id || null
}

const addOrUpdateCartItem = async (cart_id: number, product_item_id: number, quantity: number, price: number): Promise<any> => {
  const exist = await pool.query(`
    SELECT cart_item_id, quantity FROM cart_items
    WHERE cart_id = $1 AND product_item_id = $2
  `, [cart_id, product_item_id])

  if (exist.rows.length > 0) {
    const newQty = exist.rows[0].quantity + quantity
    const newPrice = (price / quantity) * newQty
    const result = await pool.query(`
      UPDATE cart_items
      SET quantity = $3, price = $4, updated_at = NOW()
      WHERE cart_item_id = $1
      RETURNING *
    `, [exist.rows[0].cart_item_id, cart_id, newQty, newPrice])
    return result.rows[0]
  } else {
    const result = await pool.query(`
      INSERT INTO cart_items(cart_id, product_item_id, quantity, price)
      VALUES ($1, $2, $3, $4)
      RETURNING *
    `, [cart_id, product_item_id, quantity, price])
    return result.rows[0]
  }
}

const updateCartItemQuantity = async (cart_id: number, product_item_id: number, quantity: number, price: number): Promise<any> => {
  const result = await pool.query(`
    UPDATE cart_items
    SET quantity = $3, price = $4, updated_at = NOW()
    WHERE cart_id = $1 AND product_item_id = $2
    RETURNING *
  `, [cart_id, product_item_id, quantity, price])
  return result.rows[0]
}

const deleteCartItem = async (cart_id: number, product_item_id: number): Promise<boolean> => {
  const result = await pool.query(`
    DELETE FROM cart_items
    WHERE cart_id = $1 AND product_item_id = $2
  `, [cart_id, product_item_id])
  return (result.rowCount ?? 0) > 0
}

const clearCartItems = async (cart_id: number): Promise<boolean> => {
  await pool.query(`
    DELETE FROM cart_items
    WHERE cart_id = $1
  `, [cart_id])
  return true
}

const getCartItem = async (cart_id: number, product_item_id: number): Promise<any> => {
  const result = await pool.query(`
    SELECT cart_item_id, quantity FROM cart_items
    WHERE cart_id = $1 AND product_item_id = $2
  `, [cart_id, product_item_id])
  return result.rows[0] || null
}

const updateCartItemSizeOnly = async (cart_id: number, old_product_item_id: number, new_product_item_id: number, price: number): Promise<any> => {
  const result = await pool.query(`
    UPDATE cart_items
    SET product_item_id = $3, price = $4, updated_at = NOW()
    WHERE cart_id = $1 AND product_item_id = $2
    RETURNING *
  `, [cart_id, old_product_item_id, new_product_item_id, price])
  return result.rows[0]
}

export const cartModel = {
  create,
  getCartById,
  getCartByUserId,
  getCartItemsDetails,
  findProductItemId,
  addOrUpdateCartItem,
  updateCartItemQuantity,
  deleteCartItem,
  clearCartItems,
  getCartItem,
  updateCartItemSizeOnly
}
