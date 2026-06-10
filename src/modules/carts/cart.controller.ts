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
    next(error)
  }
}

const getMyCart = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }
    const cartItems = await cartService.getMyCart(userId)
    res.status(StatusCodes.OK).json(cartItems)
  } catch (error) {
    next(error)
  }
}

const addItemToCart = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }
    const { product_id, size, quantity } = req.body
    const result = await cartService.addItemToCart(userId, Number(product_id), size, Number(quantity))
    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

const updateItemQuantity = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }
    const { product_id, size, quantity } = req.body
    const result = await cartService.updateItemQuantity(userId, Number(product_id), size, Number(quantity))
    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

const removeItemFromCart = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }
    const { product_id, size } = req.body
    const result = await cartService.removeItemFromCart(userId, Number(product_id), size)
    res.status(StatusCodes.OK).json({ success: result })
  } catch (error) {
    next(error)
  }
}

const syncCart = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }
    const clientItems = req.body.items || []
    const syncedItems = await cartService.syncCart(userId, clientItems)
    res.status(StatusCodes.OK).json(syncedItems)
  } catch (error) {
    next(error)
  }
}

const clearCart = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }
    const result = await cartService.clearCart(userId)
    res.status(StatusCodes.OK).json({ success: result })
  } catch (error) {
    next(error)
  }
}

const updateItemSize = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }
    const { product_id, old_size, new_size } = req.body
    const result = await cartService.updateItemSize(userId, Number(product_id), old_size, new_size)
    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

export const cartController = {
  createNew,
  getCartById,
  getMyCart,
  addItemToCart,
  updateItemQuantity,
  removeItemFromCart,
  syncCart,
  clearCart,
  updateItemSize
}
