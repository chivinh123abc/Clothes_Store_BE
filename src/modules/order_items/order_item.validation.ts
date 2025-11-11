import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import Joi from 'joi'
import ApiError from '../../utils/ApiError.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  const correctCondition = Joi.object({
    order_id: Joi.number().integer().min(1).required(),
    product_item_id: Joi.number().integer().min(1).required(),
    quantity: Joi.number().integer().min(1).required(),
  })
  try {
    await correctCondition.validateAsync(req.body, { abortEarly: false })
    next()
  } catch (error) {
    let errorMessage = 'Unaccepted input'

    if (error instanceof Error) {
      errorMessage = error.message
    } else if (typeof error === 'string') {
      errorMessage = error
    }
    next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage))
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  const correctCondition = Joi.object({
    order_item_id: Joi.number().integer().min(1).optional(),
    // product_item_id: Joi.number().integer().min(1).optional(),
    quantity: Joi.number().integer().min(1).optional(),
  })
  try {
    await correctCondition.validateAsync(req.body, { abortEarly: false })
    next()
  } catch (error) {
    let errorMessage = 'Unaccepted input'

    if (error instanceof Error) {
      errorMessage = error.message
    } else if (typeof error === 'string') {
      errorMessage = error
    }
    next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage))
  }
}
export const orderItemValidation = {
  createNew,
  update
}
