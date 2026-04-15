import express from 'express'
import { authMiddleware } from '../../middlewares/authMiddleware.js'
import { productController } from './product.controller.js'
import { productValidation } from './product.validation.js'

const Router = express.Router()

Router.route('/')
  .get(productController.getAll)
  .post(authMiddleware.isAuthorized, authMiddleware.isAdmin, productValidation.createNew, productController.createNew)

Router.route('/:id')
  .get(productController.getProduct)
  .put(authMiddleware.isAuthorized, authMiddleware.isAdmin, productValidation.update, productController.update)
  .delete(authMiddleware.isAuthorized, authMiddleware.isAdmin, productController.deleteProduct)

export const productRoute = Router
