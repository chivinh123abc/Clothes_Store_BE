import express from 'express'
import { variationController } from './variation.controller.js'
import { variationValidation } from './variation.validation.js'
const Router = express.Router()

Router.route('/create').post(variationValidation.createNew, variationController.createNew)

Router.route('/:variation_id')
  .put(variationValidation.update, variationController.update)
  .get(variationController.getVariation)
export const variationRoute = Router
