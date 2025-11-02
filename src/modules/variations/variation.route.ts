import express from 'express'
import { variationController } from './variation.controller.js'
import { variationValidation } from './variation.validation.js'
const Router = express.Router()

// VARIATION la nhung type de chia theo vd(Color, Size)
Router.route('/')
  .post(variationValidation.createNew, variationController.createNew)
  .put(variationValidation.update, variationController.update)
  .get(variationController.getVariation)

export const variationRoute = Router
