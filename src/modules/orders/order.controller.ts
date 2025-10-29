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
    const n_order_id = req.params.order_id
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

const getOrder = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const order_id = Number(req.params.order_id)
    const gotOrder = await orderService.getOrder(order_id)
    res.status(StatusCodes.ACCEPTED).json(gotOrder)
  } catch (error) {
    next(error)
  }
}

export const orderController = {
  createNew,
  update,
  getOrder
}
