import express from 'express'
import { authMiddleware } from '../../middlewares/authMiddleware.js'
import { discountController } from './discount.controller.js'

const route = express.Router()

route.get('/', discountController.getAll)
route.get('/:id', discountController.getById)

// Admin only
route.post('/', authMiddleware.isAuthorized, authMiddleware.isAdmin, discountController.create)
route.put('/:id', authMiddleware.isAuthorized, authMiddleware.isAdmin, discountController.update)
route.delete('/:id', authMiddleware.isAuthorized, authMiddleware.isAdmin, discountController.deleteDiscount)

export const discountRoute = route
