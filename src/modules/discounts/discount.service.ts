import { DiscountCreateDto, DiscountUpdateDto } from '../types/discounts.js'
import { discountModel } from './discount.model.js'

const createDiscount = async (data: DiscountCreateDto) => {
  return await discountModel.create(data)
}

const getAllDiscounts = async () => {
  return await discountModel.findAll()
}

const getDiscountById = async (id: number) => {
  return await discountModel.findById(id)
}

const updateDiscount = async (id: number, data: DiscountUpdateDto) => {
  return await discountModel.update(id, data)
}

const deleteDiscount = async (id: number) => {
  return await discountModel.deleteDiscount(id)
}

export const discountService = {
  createDiscount,
  getAllDiscounts,
  getDiscountById,
  updateDiscount,
  deleteDiscount
}
