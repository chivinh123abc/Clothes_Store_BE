import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { productConfigurationService } from './product_configurations.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdProductConfiguration = await productConfigurationService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdProductConfiguration)
  } catch (error) {
    next(error)
  }
}

export const productConfigurationController = {
  createNew
}
