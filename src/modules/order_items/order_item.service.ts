import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { orderModel } from '../orders/order.model.js'
import { productItemModel } from '../product_items/product_item.model.js'
import { OrderItemCreateDto, OrderItemResponseDto, OrderItemUpdateDto } from '../types/order_items.js'
import { orderItemModel } from './order_item.model.js'

const createNew = async (reqBody: OrderItemCreateDto): Promise<OrderItemResponseDto> => {
  try {
    // Kiem tra Order
    const existOrder = await orderModel.findOrderById(reqBody.order_id)
    if (!existOrder) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not exist'))
    }
    // Kiem tra Product Item
    const existProductItem = await productItemModel.findProductItemById(reqBody.product_item_id)
    if (!existProductItem) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Product_item not exist'))
    }

    reqBody.unit_price = Number(existProductItem.product_item_price)

    const result = await orderItemModel.create(reqBody)
    return result
  } catch (error) {
    throw error
  }
}

const getOrderItemById = async (order_item_id: number): Promise<OrderItemResponseDto> => {
  try {
    const result = await orderItemModel.getOrderItemById(order_item_id)
    if (!result) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Order item not exist'))
    }
    return result
  } catch (error) {
    throw error
  }
}

const update = async (reqBody: OrderItemUpdateDto) => {
  try {
    const existOrderItem = await orderItemModel.getOrderItemById(reqBody.order_item_id)
    if (!existOrderItem) {
      throw (new ApiError(StatusCodes.NOT_FOUND, 'Order item not exist'))
    }

    const result = await orderItemModel.update(reqBody)
    return result
  } catch (error) {
    throw error
  }
}


export const orderItemService = {
  createNew,
  getOrderItemById,
  update
}
