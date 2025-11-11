import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { cartItemService } from './cart_item.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdCartItem = await cartItemService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdCartItem)
  } catch (error) {
    next(error)
  }
}

const getCartItemById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const gotdCartItem = await cartItemService.getCartItemById(req.body.cart_item_id)
    res.status(StatusCodes.ACCEPTED).json(gotdCartItem)
  } catch (error) {
    next(error)
  }
}

export const cartItemController = {
  createNew,
  getCartItemById
}
