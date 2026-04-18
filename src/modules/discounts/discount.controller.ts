import { Request, Response } from 'express'
import { discountService } from './discount.service.js'

const create = async (req: Request, res: Response) => {
  try {
    const data = await discountService.createDiscount(req.body)
    res.status(201).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const getAll = async (req: Request, res: Response) => {
  try {
    const data = await discountService.getAllDiscounts()
    res.status(200).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const getById = async (req: Request, res: Response) => {
  try {
    const data = await discountService.getDiscountById(Number(req.params.id))
    if (!data) return res.status(404).json({ message: 'Discount not found' })
    res.status(200).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const update = async (req: Request, res: Response) => {
  try {
    const data = await discountService.updateDiscount(Number(req.params.id), req.body)
    if (!data) return res.status(404).json({ message: 'Discount not found' })
    res.status(200).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const deleteDiscount = async (req: Request, res: Response) => {
  try {
    const success = await discountService.deleteDiscount(Number(req.params.id))
    if (!success) return res.status(404).json({ message: 'Discount not found' })
    res.status(200).json({ message: 'Discount deleted' })
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

export const discountController = {
  create,
  getAll,
  getById,
  update,
  deleteDiscount
}
