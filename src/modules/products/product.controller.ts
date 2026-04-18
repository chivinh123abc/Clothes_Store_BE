import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { productService } from './product.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdProduct = await productService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdProduct)
  } catch (error) {
    next(error)
  }
}

const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const products = await productService.getAll()
    res.status(StatusCodes.OK).json(products)
  } catch (error) {
    next(error)
  }
}

const getProduct = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const product_id = parseInt(req.params.id)
    const gotProduct = await productService.getProduct(product_id)
    res.status(StatusCodes.OK).json(gotProduct)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const product_id = parseInt(req.params.id)
    const updatedProduct = await productService.update(product_id, req.body)
    res.status(StatusCodes.OK).json(updatedProduct)
  } catch (error) {
    next(error)
  }
}

const deleteProduct = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const product_id = parseInt(req.params.id)
    await productService.deleteProduct(product_id)
    res.status(StatusCodes.OK).json({ message: 'Product deleted successfully' })
  } catch (error) {
    next(error)
  }
}

const getByCollectionSlug = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const products = await productService.getByCollectionSlug(req.params.slug)
    res.status(StatusCodes.OK).json(products)
  } catch (error) {
    next(error)
  }
}

export const productController = {
  createNew,
  getProduct,
  update,
  getAll,
  getByCollectionSlug,
  deleteProduct
}
