import express from 'express'
import { orderController } from './order.controller.js'
import { orderValidation } from './order.validation.js'

const Router = express.Router()

Router.route('/')
  .post(orderValidation.createNew, orderController.createNew)
  .put(orderValidation.update, orderController.update)
  .get(orderController.getOrderById)

export const orderRoute = Router
