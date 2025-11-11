import express from 'express'
import { cartItemController } from './cart_item.controller.js'
import { cartItemValidation } from './cart_item.validation.js'

const Router = express.Router()

Router.route('/')
  .post(cartItemValidation.createNew, cartItemController.createNew)
  .get(cartItemController.getCartItemById)

export const cartItemRoute = Router
