import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { generateSKUwithSlug } from '../../utils/formatters.js'
import { productItemModel } from '../product_items/product_item.model.js'
import { productModel } from '../products/product.model.js'
import { ProductConfigurationCreateDto, ProductConfigurationResponseDto } from '../types/product_configurations.js'
import { variationOptionModel } from '../variation_options/variation_option.model.js'
import { productConfigurationModel } from './product_configurations.model.js'


const createNew = async (reqBody: ProductConfigurationCreateDto): Promise<ProductConfigurationResponseDto> => {
  try {
    const existPrimaryKey = await productConfigurationModel.isExistPrimaryKey(reqBody)
    if (existPrimaryKey) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'This both key value is exist, please do another pair')
    }
    //get and check
    const existProductItem = await productItemModel.findProductItemById(reqBody.product_item_id)
    if (!existProductItem?.product_id) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist product_id')
    } else if (existProductItem.sku) {
      throw new ApiError(StatusCodes.CONFLICT, 'This product item already exist sku')
    }
    const existVariationOption = await variationOptionModel.getVariationOptionById(reqBody.variation_item_id)
    if (!existVariationOption?.variation_option_value) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Variation option not exist variation_option_value')
    }
    const existProduct = await productModel.findProductById(existProductItem.product_id)
    if (!existProduct?.product_slug) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist')
    }



    let skuUpdater = ''

    skuUpdater += generateSKUwithSlug(existProduct?.product_slug)
    skuUpdater += '-'
    skuUpdater += generateSKUwithSlug(existVariationOption?.variation_option_value)

    const existProductSKU = await productItemModel.findProductItemBySKU(skuUpdater)
    if (existProductSKU) {
      throw new ApiError(StatusCodes.CONFLICT, 'This sku already exist')
    }

    const createdProductConfiguration = await productConfigurationModel.create(reqBody)
    const updatedProductItem = await productItemModel.update({
      product_item_id: reqBody.product_item_id,
      sku: skuUpdater
    })
    return createdProductConfiguration
  } catch (error) {
    throw (error)
  }
}

export const productConfigurationService = {
  createNew
}
