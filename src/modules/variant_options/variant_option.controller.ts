import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { variantOptionService } from './variant_option.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdVariantOption = await variantOptionService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdVariantOption)
  } catch (error) {
    next(error)
  }
}

const getVariantOptionById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const variant_option_id = req.body.variant_option_id

    const foundVariantOption = await variantOptionService.getvariantOptionById(variant_option_id)

    res.status(StatusCodes.CREATED).json(foundVariantOption)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    req.body.variant_option_id = req.body.variant_option_id
    const updatedVariantOption = await variantOptionService.update(req.body)
    res.status(StatusCodes.ACCEPTED).json(updatedVariantOption)
  } catch (error) {
    next(error)
  }
}

export const variantOptionController = {
  createNew,
  getVariantOptionById,
  update
}
