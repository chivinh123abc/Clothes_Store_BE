import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import Joi from 'joi'
import ApiError from '../../utils/ApiError.js'
import { OrderStatus } from '../constants/orders.enum.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  const correctCondition = Joi.object({
    user_id: Joi.number().integer().min(1).required(),
    status: Joi.string().valid(...Object.values(OrderStatus)).default(OrderStatus.PENDING),
    total_amount: Joi.number().precision(2).min(0).default(0),
    comment: Joi.string().min(5).max(255).optional()
  })
  try {
    req.body = await correctCondition.validateAsync(req.body)
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
    order_id: Joi.number().integer().min(1).required(),
    user_id: Joi.number().integer().min(1).optional(),
    status: Joi.string().valid(...Object.values(OrderStatus)).optional(),
    total_amount: Joi.number().precision(2).min(0).optional(),
    comment: Joi.string().min(5).max(255).optional()
  }).min(1)
  try {
    req.body = await correctCondition.validateAsync(req.body)
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

export const orderValidation = {
  createNew,
  update
}

