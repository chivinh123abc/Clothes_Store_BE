import express from 'express'
import { variantController } from './variant.controller.js'
import { variantValidation } from './variant.validation.js'
const Router = express.Router()

// variant la nhung type de chia theo vd(Color, Size)
Router.route('/')
  .post(variantValidation.createNew, variantController.createNew)
  .put(variantValidation.update, variantController.update)
  .get(variantController.getVariant)

export const variantRoute = Router
