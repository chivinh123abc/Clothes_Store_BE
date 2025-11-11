import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { cartModel } from '../carts/cart.model.js'
import { productItemModel } from '../product_items/product_item.model.js'
import { CartItemCreateDto, CartItemReponseDto } from '../types/cart_item.js'
import { cartItemModel } from './cart_item.model.js'

const createNew = async (reqBody: CartItemCreateDto) => {
  try {
    const existCart = await cartModel.getCartById(reqBody.cart_id)
    if (!existCart) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Not found this Cart'))
    }

    const existProductItem = await productItemModel.findProductItemById(reqBody.product_item_id)
    if (!existProductItem?.product_item_price) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Not found this Product Item'))
    }

    reqBody.price = existProductItem.product_item_price * reqBody.quantity
    const createdCartItem = await cartItemModel.create(reqBody)
    return createdCartItem
  } catch (error) {
    throw error
  }
}

const getCartItemById = async (cart_item_id: number): Promise<CartItemReponseDto> => {
  try {
    const existCartItem = await cartItemModel.getCartItemById(cart_item_id)
    if (!existCartItem) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Not found this Cart Item'))
    }
    return existCartItem
  } catch (error) {
    throw (error)
  }
}

export const cartItemService = {
  createNew,
  getCartItemById
}
