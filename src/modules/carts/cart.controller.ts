import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { cartService } from './cart.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdCart = await cartService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdCart)
  } catch (error) {
    next(error)
  }
}

const getCartById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const gotCart = await cartService.getCartById(req.body.cart_id)
    res.status(StatusCodes.ACCEPTED).json(gotCart)
  } catch (error) {
    throw error
  }
}

export const cartController = {
  createNew,
  getCartById
}
