import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { orderItemService } from './order_item.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdOrderItem = await orderItemService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdOrderItem)
  } catch (error) {
    next(error)
  }
}

const getOrderItemById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const orderItemId = req.body.order_item_id
    const gotOrderItem = await orderItemService.getOrderItemById(orderItemId)
    res.status(StatusCodes.ACCEPTED).json(gotOrderItem)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const updatedOrderItem = await orderItemService.update(req.body)
    res.status(StatusCodes.ACCEPTED).json(updatedOrderItem)
  } catch (error) {
    next(error)
  }
}

export const orderItemController = {
  createNew,
  getOrderItemById,
  update
}
