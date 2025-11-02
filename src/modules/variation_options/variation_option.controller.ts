import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { variationOptionService } from './variation_option.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdVariationOption = await variationOptionService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdVariationOption)
  } catch (error) {
    next(error)
  }
}

const getVariationOptionById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const variation_option_id = req.body.variation_option_id

    const foundVariationOption = await variationOptionService.getVariationOptionById(variation_option_id)

    res.status(StatusCodes.CREATED).json(foundVariationOption)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    req.body.variation_option_id = req.body.variation_option_id
    const updatedVariationOption = await variationOptionService.update(req.body)
    res.status(StatusCodes.ACCEPTED).json(updatedVariationOption)
  } catch (error) {
    next(error)
  }
}

export const variationOptionController = {
  createNew,
  getVariationOptionById,
  update
}
