import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { CartCreateDto, CartResponseDto } from '../types/carts.js'
import { userModel } from '../users/user.model.js'
import { cartModel } from './cart.model.js'
import { productItemModel } from '../product_items/product_item.model.js'

const createNew = async (reqBody: CartCreateDto): Promise<CartResponseDto> => {
  try {
    const existUser = await userModel.findUserById(reqBody.user_id)
    if (!existUser) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'User not found'))
    }

    const createdCart = await cartModel.create(reqBody)
    return createdCart
  } catch (error) {
    throw error
  }
}

const getCartById = async (cart_id: number): Promise<CartResponseDto> => {
  try {
    const gotCart = await cartModel.getCartById(cart_id)
    return gotCart
  } catch (error) {
    throw error
  }
}

const getOrCreateCart = async (user_id: number): Promise<CartResponseDto> => {
  let cart = await cartModel.getCartByUserId(user_id)
  if (!cart) {
    cart = await createNew({ user_id })
  }
  return cart
}

const getMyCart = async (user_id: number): Promise<any[]> => {
  const cart = await getOrCreateCart(user_id)
  if (!cart.cart_id) return []
  return await cartModel.getCartItemsDetails(cart.cart_id)
}

const addItemToCart = async (user_id: number, product_id: number, size: string, quantity: number): Promise<any> => {
  const cart = await getOrCreateCart(user_id)
  const cart_id = cart.cart_id!

  const product_item_id = await cartModel.findProductItemId(product_id, size)
  if (!product_item_id) {
    throw new ApiError(StatusCodes.NOT_FOUND, `Product variant with size ${size} not found`)
  }

  const productItem = await productItemModel.findProductItemById(product_item_id)
  if (!productItem) {
    throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant details not found')
  }

  // Check stock limits
  const existItem = await cartModel.getCartItem(cart_id, product_item_id)
  const currentQuantity = existItem ? existItem.quantity : 0
  const targetQuantity = currentQuantity + quantity

  if (targetQuantity > productItem.stock_quantity) {
    throw new ApiError(StatusCodes.BAD_REQUEST, `Số lượng trong giỏ hàng vượt quá tồn kho (tối đa là ${productItem.stock_quantity})`)
  }

  const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price)
  const price = unitPrice * quantity

  return await cartModel.addOrUpdateCartItem(cart_id, product_item_id, quantity, price)
}

const updateItemQuantity = async (user_id: number, product_id: number, size: string, quantity: number): Promise<any> => {
  const cart = await cartModel.getCartByUserId(user_id)
  if (!cart || !cart.cart_id) {
    throw new ApiError(StatusCodes.NOT_FOUND, 'Cart not found for this user')
  }

  const product_item_id = await cartModel.findProductItemId(product_id, size)
  if (!product_item_id) {
    throw new ApiError(StatusCodes.NOT_FOUND, `Product variant with size ${size} not found`)
  }

  const productItem = await productItemModel.findProductItemById(product_item_id)
  if (!productItem) {
    throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant details not found')
  }

  // Check stock limits
  if (quantity > productItem.stock_quantity) {
    throw new ApiError(StatusCodes.BAD_REQUEST, `Số lượng trong giỏ hàng vượt quá tồn kho (tối đa là ${productItem.stock_quantity})`)
  }

  const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price)
  const price = unitPrice * quantity

  return await cartModel.updateCartItemQuantity(cart.cart_id, product_item_id, quantity, price)
}

const removeItemFromCart = async (user_id: number, product_id: number, size: string): Promise<boolean> => {
  const cart = await cartModel.getCartByUserId(user_id)
  if (!cart || !cart.cart_id) {
    throw new ApiError(StatusCodes.NOT_FOUND, 'Cart not found for this user')
  }

  const product_item_id = await cartModel.findProductItemId(product_id, size)
  if (!product_item_id) {
    throw new ApiError(StatusCodes.NOT_FOUND, `Product variant with size ${size} not found`)
  }

  return await cartModel.deleteCartItem(cart.cart_id, product_item_id)
}

const syncCart = async (user_id: number, clientItems: any[]): Promise<any[]> => {
  const cart = await getOrCreateCart(user_id)
  const cart_id = cart.cart_id!

  for (const item of clientItems) {
    try {
      const product_item_id = await cartModel.findProductItemId(Number(item.id), item.size)
      if (!product_item_id) continue

      const productItem = await productItemModel.findProductItemById(product_item_id)
      if (!productItem) continue

      const existItem = await cartModel.getCartItem(cart_id, product_item_id)
      const currentQuantity = existItem ? existItem.quantity : 0
      const allowedQuantity = Math.min(Number(item.quantity), productItem.stock_quantity - currentQuantity)
      if (allowedQuantity <= 0) continue

      const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price)
      const price = unitPrice * allowedQuantity

      await cartModel.addOrUpdateCartItem(cart_id, product_item_id, allowedQuantity, price)
    } catch (err) {
      console.error('Failed to sync item:', item, err)
    }
  }

  return await cartModel.getCartItemsDetails(cart_id)
}

const clearCart = async (user_id: number): Promise<boolean> => {
  const cart = await cartModel.getCartByUserId(user_id)
  if (!cart || !cart.cart_id) return true
  return await cartModel.clearCartItems(cart.cart_id)
}

const updateItemSize = async (user_id: number, product_id: number, oldSize: string, newSize: string): Promise<any> => {
  const cart = await cartModel.getCartByUserId(user_id)
  if (!cart || !cart.cart_id) {
    throw new ApiError(StatusCodes.NOT_FOUND, 'Cart not found for this user')
  }

  const old_product_item_id = await cartModel.findProductItemId(product_id, oldSize)
  const new_product_item_id = await cartModel.findProductItemId(product_id, newSize)
  if (!old_product_item_id || !new_product_item_id) {
    throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant not found')
  }

  const productItem = await productItemModel.findProductItemById(new_product_item_id)
  if (!productItem) {
    throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant details not found')
  }

  const existNew = await cartModel.getCartItem(cart.cart_id, new_product_item_id)

  if (existNew) {
    // Case: duplicate size exists. We merge the old item into the new item
    const existOld = await cartModel.getCartItem(cart.cart_id, old_product_item_id)
    const oldQty = existOld?.quantity || 0
    const newQty = existNew.quantity + oldQty

    // Check stock limit for the new size
    if (newQty > productItem.stock_quantity) {
      throw new ApiError(StatusCodes.BAD_REQUEST, `Không thể thay đổi size. Tổng số lượng vượt quá tồn kho của size mới (tối đa là ${productItem.stock_quantity})`)
    }

    const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price)
    const price = unitPrice * newQty

    // 1. Update quantity of the duplicate variant
    await cartModel.updateCartItemQuantity(cart.cart_id, new_product_item_id, newQty, price)
    // 2. Delete the old variant record
    await cartModel.deleteCartItem(cart.cart_id, old_product_item_id)
    return { hasDuplicate: true }
  } else {
    // Case: No duplicate size exists. Update size in-place (keeps created_at and maintains ordering)
    const existOld = await cartModel.getCartItem(cart.cart_id, old_product_item_id)
    const oldQty = existOld?.quantity || 0

    // Check stock limit for the new size
    if (oldQty > productItem.stock_quantity) {
      throw new ApiError(StatusCodes.BAD_REQUEST, `Không thể thay đổi size. Số lượng hiện có vượt quá tồn kho của size mới (tối đa là ${productItem.stock_quantity})`)
    }

    const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price)
    const price = unitPrice * oldQty

    const updated = await cartModel.updateCartItemSizeOnly(cart.cart_id, old_product_item_id, new_product_item_id, price)
    return { hasDuplicate: false, updated }
  }
}

export const cartService = {
  createNew,
  getCartById,
  getMyCart,
  addItemToCart,
  updateItemQuantity,
  removeItemFromCart,
  syncCart,
  clearCart,
  updateItemSize
}
