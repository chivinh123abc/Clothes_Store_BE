import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import Joi from 'joi'
import ApiError from '../../utils/ApiError.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  const correctCondition = Joi.object({
    user_id: Joi.number().integer().min(1).required(),
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


export const cartValidation = {
  createNew
}
