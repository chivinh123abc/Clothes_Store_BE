import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { OrderCreateDto, OrderResponseDto, OrderUpdateDto } from '../types/orders.js'
import { userModel } from '../users/user.model.js'
import { orderModel } from './order.model.js'

const createNew = async (reqBody: OrderCreateDto): Promise<OrderResponseDto> => {
  try {
    const existUser = await userModel.findUserById(reqBody.user_id)
    if (!existUser) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'User not found'))
    }
    const createdOrder = await orderModel.create(reqBody)
    return createdOrder
  } catch (error) {
    throw (error)
  }
}

const update = async (reqBody: OrderUpdateDto): Promise<OrderResponseDto> => {
  try {
    const existOrder = await orderModel.findOrderById(reqBody.order_id)
    if (!existOrder) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not found'))
    }

    if (reqBody.user_id) {
      const existUser = await userModel.findUserById(reqBody.user_id)
      if (!existUser) {
        throw (new ApiError(StatusCodes.NOT_FOUND, 'User not found'))
      }
    }

    const updatedOrder = await orderModel.update(reqBody)

    if (!updatedOrder) {
      throw (new ApiError(StatusCodes.CONFLICT, 'Updated Failed'))
    }

    return updatedOrder
  } catch (error) {
    throw (error)
  }
}

const getOrder = async (order_id: number): Promise<OrderResponseDto> => {
  try {
    const existOrder = await orderModel.findOrderById(order_id)
    if (!existOrder) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not found'))
    }
    return existOrder
  } catch (error) {
    throw error
  }
}

export const orderService = {
  createNew,
  update,
  getOrder
}
