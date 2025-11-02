import express from 'express'
import { orderItemController } from './order_item.controller.js'
import { orderItemValidation } from './order_item.validation.js'

const Router = express.Router()

Router.route('/')
  .post(orderItemValidation.createNew, orderItemController.createNew)
  .get(orderItemController.getOrderItemById)

export const orderItemRoute = Router
