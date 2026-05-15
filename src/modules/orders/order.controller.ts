import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
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

export const orderController = {
  createNew,
  update,
  getOrderById,
  getAllOrders,
  deleteOrder
}
