import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { reviewsModel } from './reviews.model.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }

    const { product_id, rating, text, image_url } = req.body
    if (!product_id || !rating || !text) {
      res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing product_id, rating or text' })
      return
    }

    const newReview = await reviewsModel.create(Number(userId), Number(product_id), Number(rating), text, image_url)
    res.status(StatusCodes.CREATED).json(newReview)
  } catch (error) {
    next(error)
  }
}

const getReviewsByProductId = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const productId = Number(req.params.productId)
    const reviews = await reviewsModel.findByProductId(productId)
    res.status(StatusCodes.OK).json(reviews)
  } catch (error) {
    next(error)
  }
}

const getAllReviews = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const reviews = await reviewsModel.findAllReviews()
    res.status(StatusCodes.OK).json(reviews)
  } catch (error) {
    next(error)
  }
}

const updateReview = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }

    const { rating, text, image_url } = req.body
    if (!rating || !text) {
      res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing rating or text' })
      return
    }

    const isAdmin = Number(req.jwtDecoded?.role) === 1
    const updatedReview = await reviewsModel.update(Number(id), Number(userId), Number(rating), text, image_url, isAdmin)
    if (!updatedReview) {
      res.status(StatusCodes.NOT_FOUND).json({ message: 'Review not found or unauthorized' })
      return
    }
    res.status(StatusCodes.OK).json(updatedReview)
  } catch (error) {
    next(error)
  }
}

const deleteReview = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params
    const userId = req.jwtDecoded?.user_id
    if (!userId) {
      res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' })
      return
    }

    const isAdmin = Number(req.jwtDecoded?.role) === 1
    const deleted = await reviewsModel.remove(Number(id), Number(userId), isAdmin)
    if (!deleted) {
      res.status(StatusCodes.NOT_FOUND).json({ message: 'Review not found or unauthorized' })
      return
    }
    res.status(StatusCodes.OK).json({ message: 'Review deleted successfully' })
  } catch (error) {
    next(error)
  }
}

export const reviewsController = {
  createNew,
  getReviewsByProductId,
  getAllReviews,
  updateReview,
  deleteReview
}
