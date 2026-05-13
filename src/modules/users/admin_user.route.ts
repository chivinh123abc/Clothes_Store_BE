import express from 'express'
import { authMiddleware } from '../../middlewares/authMiddleware.js'
import { userController } from './user.controller.js'

const Router = express.Router()

// All routes here require Authorization and Admin role
Router.use(authMiddleware.isAuthorized)
Router.use(authMiddleware.isAdmin)

Router.route('/')
  .get(userController.findAll)
  .post(userController.adminCreate)

Router.route('/:id')
  .put(userController.adminUpdate)
  .delete(userController.adminDelete)

export const adminUserRoute = Router
