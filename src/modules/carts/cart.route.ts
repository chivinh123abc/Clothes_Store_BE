import express from 'express'
import { cartController } from './cart.controller.js'
import { cartValidation } from './cart.validation.js'

const Router = express.Router()

Router.route('/')
  .post(cartValidation.createNew, cartController.createNew)
  .get(cartController.getCartById)

export const cartRoute = Router
