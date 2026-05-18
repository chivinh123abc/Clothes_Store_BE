import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { orderService } from './order.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdOrder = await orderService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdOrder)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const n_order_id = req.body.order_id
    const reqBody = {
      order_id: n_order_id,
      ...req.body
    }
    const updatedOrder = await orderService.update(reqBody)
    res.status(StatusCodes.ACCEPTED).json(updatedOrder)
  } catch (error) {
    next(error)
  }
}

const getOrderById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params
    const gotOrder = await orderService.getOrder(Number(id))
    res.status(StatusCodes.OK).json(gotOrder)
  } catch (error) {
    next(error)
  }
}

const getAllOrders = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const orders = await orderService.getAllOrders()
    res.status(StatusCodes.OK).json(orders)
  } catch (error) {
    next(error)
  }
}

const deleteOrder = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params
    await orderService.deleteOrder(Number(id))
    res.status(StatusCodes.NO_CONTENT).send()
  } catch (error) {
    next(error)
  }
}

const getOrdersByUserId = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { userId } = req.params
    
    // Security: Only allow the logged-in user to see their own orders, or Admin to see anyone's orders
    if (req.jwtDecoded?.user_id !== Number(userId) && req.jwtDecoded?.role !== 1) {
      throw new ApiError(StatusCodes.FORBIDDEN, 'Forbidden (You can only access your own orders)')
    }

    const orders = await orderService.getOrdersByUserId(Number(userId))
    res.status(StatusCodes.OK).json(orders)
  } catch (error) {
    next(error)
  }
}

const cancelOrder = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { orderId } = req.params
    const userId = req.jwtDecoded?.user_id
    const isAdmin = req.jwtDecoded?.role === 1

    if (!userId) {
      throw new ApiError(StatusCodes.UNAUTHORIZED, 'Unauthorized')
    }

    const updatedOrder = await orderService.cancelOrder(Number(orderId), userId, isAdmin)
    res.status(StatusCodes.OK).json(updatedOrder)
  } catch (error) {
    next(error)
  }
}

export const orderController = {
  createNew,
  update,
  getOrderById,
  getAllOrders,
  deleteOrder,
  getOrdersByUserId,
  cancelOrder
}
