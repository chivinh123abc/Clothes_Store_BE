import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { OrderStatus } from '../constants/orders.enum.js'
import { orderItemModel } from '../order_items/order_item.model.js'
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



const getOrder = async (order_id: number): Promise<any> => {
  try {
    const existOrder = await orderModel.findOrderById(order_id)
    if (!existOrder) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not found'))
    }
    
    const items = await orderItemModel.findAllByOrderId(order_id)
    
    return {
      ...existOrder,
      items
    }
  } catch (error) {
    throw error
  }
}

const getAllOrders = async (): Promise<OrderResponseDto[]> => {
  try {
    return await orderModel.findAllOrders()
  } catch (error) {
    throw error
  }
}

const deleteOrder = async (order_id: number): Promise<void> => {
  try {
    const existOrder = await orderModel.findOrderById(order_id)
    if (!existOrder) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not found'))
    }
    await orderModel.deleteOrder(order_id)
  } catch (error) {
    throw error
  }
}

const getOrdersByUserId = async (user_id: number): Promise<any[]> => {
  try {
    const orders = await orderModel.findAllOrderByUserId(user_id)
    const ordersWithItems = await Promise.all(
      orders.map(async (order) => {
        const items = await orderItemModel.findAllByOrderId(order.order_id!)
        return {
          ...order,
          items
        }
      })
    )
    return ordersWithItems
  } catch (error) {
    throw error
  }
}

const cancelOrder = async (order_id: number, user_id: number, isAdmin: boolean): Promise<OrderResponseDto> => {
  try {
    const order = await orderModel.findOrderById(order_id)
    if (!order) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Order not found')
    }

    // Security: Must be owner or admin
    if (order.user_id !== user_id && !isAdmin) {
      throw new ApiError(StatusCodes.FORBIDDEN, 'Forbidden (You can only cancel your own orders)')
    }

    // Business Logic: Can only cancel if still pending
    if (order.status !== 'pending') {
      throw new ApiError(StatusCodes.BAD_REQUEST, 'Only pending orders can be cancelled')
    }

    const updatedOrder = await orderModel.update({
      order_id,
      status: OrderStatus.CANCELLED
    })

    if (!updatedOrder) {
      throw new ApiError(StatusCodes.CONFLICT, 'Cancel order failed')
    }

    return updatedOrder!
  } catch (error) {
    throw error
  }
}

export const orderService = {
  createNew,
  update,
  getOrder,
  getAllOrders,
  deleteOrder,
  getOrdersByUserId,
  cancelOrder
}
