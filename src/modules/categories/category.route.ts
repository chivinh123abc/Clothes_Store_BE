import express from 'express'
import { authMiddleware } from '../../middlewares/authMiddleware.js'
import { categoryController } from './category.controller.js'
import { categoryValidation } from './category.validation.js'

const Router = express.Router()

Router.route('/')
  .post(authMiddleware.isAuthorized, categoryValidation.createNew, categoryController.createNew)
  .get(categoryController.getAll)

Router.route('/:id')
  .get(categoryController.getCategory)
  .put(authMiddleware.isAuthorized, categoryController.updateCategory)
  .delete(authMiddleware.isAuthorized, categoryValidation.deleteCategory, categoryController.deleteCategory)


export const categoryRoute = Router
