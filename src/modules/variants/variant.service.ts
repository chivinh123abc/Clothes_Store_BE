import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { slugify } from '../../utils/formatters.js'
import { categoryModel } from '../categories/category.model.js'
import { variantCreateDto, variantResponseDto, variantUpdateDto } from '../types/variants.js'
import { variantModel } from './variant.model.js'

const createNew = async (reqBody: variantCreateDto): Promise<variantResponseDto> => {
  try {
    reqBody.variant_slug = slugify(reqBody.variant_name)
    const existVariant = await variantModel.getVariantBySlug(reqBody.variant_slug)
    if (existVariant) {
      throw new ApiError(StatusCodes.CONFLICT, 'variant_name already exist')
    }
    const createdVariant = await variantModel.create(reqBody)
    return createdVariant
  } catch (error) {
    throw error
  }
}

const getVaration = async (variant_id: number): Promise<variantResponseDto> => {
  try {
    const resultVariant = await variantModel.getVariantById(variant_id)
    if (!resultVariant) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variant_id is not exist')
    }
    return resultVariant
  } catch (error) {
    throw error
  }
}

const update = async (reqBody: variantUpdateDto): Promise<variantResponseDto> => {
  try {
    const existVariant = await variantModel.getVariantById(reqBody.variant_id)
    if (!existVariant) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variant_id is not exist')
    }

    if (reqBody.category_id) {
      const existCategory = await categoryModel.findCategoryById(reqBody.category_id)
      if (!existCategory) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'categories_id is not exist')
      }
    }

    if (reqBody.variant_name) {
      reqBody.variant_slug = slugify(reqBody.variant_name)
      const existVariant = await variantModel.getVariantBySlug(reqBody.variant_slug)
      if (existVariant) {
        throw new ApiError(StatusCodes.CONFLICT, 'variant name already exist')
      }
    }

    const updatedVariant = await variantModel.update(reqBody)
    if (!updatedVariant) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Can not update this validation')
    }
    return updatedVariant
  } catch (error) {
    throw error
  }
}

export const variantService = {
  createNew,
  getVaration,
  update
}
