import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { slugify } from '../../utils/formatters.js'
import { variantOptionCreateDto, variantOptionResponseDto, variantOptionUpdateDto } from '../types/variant_options.js'
import { variantModel } from '../variants/variant.model.js'
import { variantOptionModel } from './variant_option.model.js'

const createNew = async (reqBody: variantOptionCreateDto): Promise<variantOptionResponseDto> => {
  try {

    reqBody.variant_option_slug = slugify(reqBody.variant_option_value)

    const existVariant = await variantModel.getVariantById(reqBody.variant_id)
    if (!existVariant) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'This variant id is not exist, check again')
    }

    const existVariantOption = await variantOptionModel.getVariantOptionBySlug(reqBody.variant_option_slug)

    if (existVariantOption) {
      throw new ApiError(StatusCodes.CONFLICT, 'This variant options name already exist, check again')
    }


    const createdVariantOption = await variantOptionModel.create(reqBody)
    return createdVariantOption
  } catch (error) {
    throw (error)
  }
}

const getVariantOptionById = async (variant_option_id: number): Promise<variantOptionResponseDto> => {
  try {
    const foundVariantOption = await variantOptionModel.getVariantOptionById(variant_option_id)

    if (!foundVariantOption) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'This variant option is not exist, check again')
    }

    return foundVariantOption
  } catch (error) {
    throw error
  }
}

const update = async (reqBody: variantOptionUpdateDto): Promise<variantOptionResponseDto> => {
  try {
    if (reqBody.variant_option_value) {
      reqBody.variant_option_slug = slugify(reqBody.variant_option_value)
      const foundvariantOption = await variantOptionModel.getVariantOptionBySlug(reqBody.variant_option_slug)
      if (foundvariantOption) {
        throw new ApiError(StatusCodes.CONFLICT, 'This name already exist by someway')
      }
    }

    if (reqBody.variant_id) {
      const existVariant = await variantModel.getVariantById(reqBody.variant_id)
      if (!existVariant) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'This variant id is not exist, check again')
      }
    }

    const updatedVariantOption = await variantOptionModel.update(reqBody)
    if (!updatedVariantOption) {
      throw new ApiError(StatusCodes.CONFLICT, 'Can not update by some reason')
    }
    return updatedVariantOption
  } catch (error) {
    throw error
  }
}

export const variantOptionService = {
  createNew,
  getVariantOptionById,
  update
}
