import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { variantService } from './variant.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await variantService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(result)
  } catch (error) {
    next(error)
  }
}

const getVariant = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const variant_id = req.body.variant_id
    const result = await variantService.getVaration(variant_id)
    res.status(StatusCodes.CREATED).json(result)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    req.body.variant_id = req.body.variant_id
    const result = await variantService.update(req.body)
    res.status(StatusCodes.CREATED).json(result)
  } catch (error) {
    next(error)
  }
}

export const variantController = {
  createNew,
  getVariant,
  update
}
