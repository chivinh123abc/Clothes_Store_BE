import express from 'express'
import { productItemController } from './product_item.controller.js'
import { productItemValidation } from './product_item.validation.js'

const Router = express.Router()

//chua co validation update
Router.route('/')
  .post(productItemValidation.createNew, productItemController.createNew)
  .get(productItemController.getProductItem)
  .put(productItemController.update)

export const productItemRoute = Router
