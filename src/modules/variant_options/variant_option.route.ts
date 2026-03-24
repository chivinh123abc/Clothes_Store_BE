import express from 'express'
import { variantOptionController } from './variant_option.controller.js'
import { variantOptionValidation } from './variant_option.validation.js'
const Router = express.Router()

Router.route('/')
  .post(variantOptionValidation.createNew, variantOptionController.createNew)
  .get(variantOptionController.getVariantOptionById)
  .put(variantOptionValidation.update, variantOptionController.update)

export const variantOptionRoute = Router
