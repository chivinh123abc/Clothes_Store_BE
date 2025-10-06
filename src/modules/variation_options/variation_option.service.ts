import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { slugify } from '../../utils/formatters.js'
import { VariationOptionCreateDto, VariationOptionResponseDto, VariationOptionUpdateDto } from '../types/variation_options.js'
import { variationModel } from '../variations/variation.model.js'
import { variationOptionModel } from './variation_option.model.js'

const createNew = async (reqBody: VariationOptionCreateDto): Promise<VariationOptionResponseDto> => {
  try {

    reqBody.variation_option_slug = slugify(reqBody.variation_option_value)

    const existVariation = await variationModel.getVariationById(reqBody.variation_id)
    if (!existVariation) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'This variation id is not exist, check again')
    }

    const existVariationOption = await variationOptionModel.getVariationOptionBySlug(reqBody.variation_option_slug)

    if (existVariationOption) {
      throw new ApiError(StatusCodes.CONFLICT, 'This variation options name already exist, check again')
    }


    const createdVariationOption = await variationOptionModel.create(reqBody)
    return createdVariationOption
  } catch (error) {
    throw (error)
  }
}

const getVariationOptionById = async (variation_option_id: number): Promise<VariationOptionResponseDto> => {
  try {
    const foundVariationOption = await variationOptionModel.getVariationOptionById(variation_option_id)

    if (!foundVariationOption) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'This variation option is not exist, check again')
    }

    return foundVariationOption
  } catch (error) {
    throw error
  }
}

const update = async (reqBody: VariationOptionUpdateDto): Promise<VariationOptionResponseDto> => {
  try {
    if (reqBody.variation_option_value) {
      reqBody.variation_option_slug = slugify(reqBody.variation_option_value)
      const foundVariationOption = await variationOptionModel.getVariationOptionBySlug(reqBody.variation_option_slug)
      if (foundVariationOption) {
        throw new ApiError(StatusCodes.CONFLICT, 'This name already exist by someway')
      }
    }

    if (reqBody.variation_id) {
      const existVariation = await variationModel.getVariationById(reqBody.variation_id)
      if (!existVariation) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'This variation id is not exist, check again')
      }
    }

    const updatedVariationOption = await variationOptionModel.update(reqBody)
    if (!updatedVariationOption) {
      throw new ApiError(StatusCodes.CONFLICT, 'Can not update by some reason')
    }
    return updatedVariationOption
  } catch (error) {
    throw error
  }
}

export const variationOptionService = {
  createNew,
  getVariationOptionById,
  update
}
