import express from 'express'
import { authMiddleware } from '../../middlewares/authMiddleware.js'
import { reviewsController } from './reviews.controller.js'

const Router = express.Router()

Router.route('/')
  .post(authMiddleware.isAuthorized, reviewsController.createNew)
  .get(reviewsController.getAllReviews)

Router.route('/product/:productId')
  .get(reviewsController.getReviewsByProductId)

Router.route('/:id')
  .put(authMiddleware.isAuthorized, reviewsController.updateReview)
  .delete(authMiddleware.isAuthorized, reviewsController.deleteReview)

export const reviewsRoute = Router
