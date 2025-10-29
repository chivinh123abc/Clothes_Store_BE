import express from 'express'
import { orderController } from './order.controller.js'
import { orderValidation } from './order.validation.js'

const Router = express.Router()

Router.route('/create').post(orderValidation.createNew, orderController.createNew)

Router.route('/:order_id')
  .put(orderValidation.update, orderController.update)
  .get(orderController.getOrder)

export const orderRoute = Router
