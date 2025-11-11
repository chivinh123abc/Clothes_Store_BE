import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { CartCreateDto, CartResponseDto } from '../types/carts.js'
import { userModel } from '../users/user.model.js'
import { cartModel } from './cart.model.js'

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

export const cartService = {
  createNew,
  getCartById
}
