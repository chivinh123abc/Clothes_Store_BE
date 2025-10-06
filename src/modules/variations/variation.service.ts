import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { slugify } from '../../utils/formatters.js'
import { categoryModel } from '../categories/category.model.js'
import { VariationCreateDto, VariationResponseDto, VariationUpdateDto } from '../types/variations.js'
import { variationModel } from './variation.model.js'

const createNew = async (reqBody: VariationCreateDto): Promise<VariationResponseDto> => {
  try {
    reqBody.variation_slug = slugify(reqBody.variation_name)
    const existVariation = await variationModel.getVariationBySlug(reqBody.variation_slug)
    if (existVariation) {
      throw new ApiError(StatusCodes.CONFLICT, 'variation_name already exist')
    }
    const createdVariation = await variationModel.create(reqBody)
    return createdVariation
  } catch (error) {
    throw error
  }
}

const getVaration = async (variation_id: number): Promise<VariationResponseDto> => {
  try {
    const resultVariation = await variationModel.getVariationById(variation_id)
    if (!resultVariation) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variation_id is not exist')
    }
    return resultVariation
  } catch (error) {
    throw error
  }
}

const update = async (reqBody: VariationUpdateDto): Promise<VariationResponseDto> => {
  try {
    const existVariation = await variationModel.getVariationById(reqBody.variation_id)
    if (!existVariation) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variation_id is not exist')
    }

    if (reqBody.category_id) {
      const existCategory = await categoryModel.findCategoryById(reqBody.category_id)
      if (!existCategory) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'categories_id is not exist')
      }
    }

    if (reqBody.variation_name) {
      reqBody.variation_slug = slugify(reqBody.variation_name)
      const existVariation = await variationModel.getVariationBySlug(reqBody.variation_slug)
      if (existVariation) {
        throw new ApiError(StatusCodes.CONFLICT, 'variation name already exist')
      }
    }

    const updatedVariation = await variationModel.update(reqBody)
    if (!updatedVariation) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Can not update this validation')
    }
    return updatedVariation
  } catch (error) {
    throw error
  }
}

export const variationService = {
  createNew,
  getVaration,
  update
}
