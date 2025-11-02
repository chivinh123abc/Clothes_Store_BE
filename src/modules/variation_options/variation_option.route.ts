import express from 'express'
import { variationOptionController } from './variation_option.controller.js'
import { variationOptionValidation } from './variation_option.validation.js'
const Router = express.Router()

Router.route('/')
  .post(variationOptionValidation.createNew, variationOptionController.createNew)
  .get(variationOptionController.getVariationOptionById)
  .put(variationOptionValidation.update, variationOptionController.update)

export const variationOptionRoute = Router
