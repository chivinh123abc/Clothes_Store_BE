import express from 'express'
import { collectionController } from './collection.controller.js'

const route = express.Router()

route.post('/', collectionController.create)
route.get('/', collectionController.getAll)
route.get('/:id', collectionController.getById)
route.put('/:id', collectionController.update)
route.delete('/:id', collectionController.deleteCollection)

export const collectionRoute = route
