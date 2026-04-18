import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { categoryService } from './category.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const newCategory = await categoryService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(newCategory)
  } catch (error) {
    next(error)
  }
}

const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const categories = await categoryService.getAll()
    res.status(StatusCodes.OK).json(categories)
  } catch (error) {
    next(error)
  }
}

const getCategory = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const category_id = Number(req.params.id)
    const thisCategory = await categoryService.getCategory(category_id)
    res.status(StatusCodes.OK).json(thisCategory)
  } catch (error) {
    next(error)
  }
}
const updateCategory = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const category_id = Number(req.params.id)
    const updatedCategory = await categoryService.updateCategory(category_id, req.body)
    res.status(StatusCodes.OK).json(updatedCategory)
  } catch (error) {
    next(error)
  }
}

const deleteCategory = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const category_id = Number(req.params.id)
    await categoryService.deleteCategory(category_id)
    res.status(StatusCodes.OK).json({ message: 'Category deleted successfully' })
  } catch (error) {
    next(error)
  }
}

export const categoryController = {
  createNew,
  getCategory,
  updateCategory,
  getAll,
  deleteCategory
}
