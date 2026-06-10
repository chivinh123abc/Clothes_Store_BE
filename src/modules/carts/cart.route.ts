import express from 'express'
import { cartController } from './cart.controller.js'
import { cartValidation } from './cart.validation.js'
import { authMiddleware } from '../../middlewares/authMiddleware.js'

const Router = express.Router()

Router.route('/')
  .post(cartValidation.createNew, cartController.createNew)
  .get(cartController.getCartById)

Router.route('/my-cart')
  .get(authMiddleware.isAuthorized, cartController.getMyCart)

Router.route('/add-item')
  .post(authMiddleware.isAuthorized, cartController.addItemToCart)

Router.route('/update-item')
  .put(authMiddleware.isAuthorized, cartController.updateItemQuantity)

Router.route('/delete-item')
  .delete(authMiddleware.isAuthorized, cartController.removeItemFromCart)

Router.route('/sync-cart')
  .post(authMiddleware.isAuthorized, cartController.syncCart)

Router.route('/clear')
  .post(authMiddleware.isAuthorized, cartController.clearCart)

Router.route('/change-size')
  .put(authMiddleware.isAuthorized, cartController.updateItemSize)

export const cartRoute = Router
