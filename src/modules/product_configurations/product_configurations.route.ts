import express from 'express'
import { productConfigurationController } from './product_configurations.controller.js'
import { productConfigurationValidation } from './product_configurations.validation.js'

const Router = express.Router()

Router.route('/create')
  .post(productConfigurationValidation.createNew, productConfigurationController.createNew)

Router.route('/update')
  .put(productConfigurationValidation.update, productConfigurationController.update)

export const productConfigurationRoute = Router

