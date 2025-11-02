import express from 'express'
import { productController } from './product.controller.js'
import { productValidation } from './product.validation.js'

const Router = express.Router()

Router.route('/')
  .post(productValidation.createNew, productController.createNew)
  .get(productController.getProduct)
  .put(productValidation.update, productController.update)

export const productRoute = Router
