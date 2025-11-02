import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { variationService } from './variation.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await variationService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(result)
  } catch (error) {
    next(error)
  }
}

const getVariation = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const variation_id = req.body.variation_id
    const result = await variationService.getVaration(variation_id)
    res.status(StatusCodes.CREATED).json(result)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    req.body.variation_id = req.body.variation_id
    const result = await variationService.update(req.body)
    res.status(StatusCodes.CREATED).json(result)
  } catch (error) {
    next(error)
  }
}

export const variationController = {
  createNew,
  getVariation,
  update
}
