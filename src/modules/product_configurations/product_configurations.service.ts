import { StatusCodes } from 'http-status-codes'
import ApiError from '../../utils/ApiError.js'
import { generateSKUwithSlug } from '../../utils/formatters.js'
import { productItemModel } from '../product_items/product_item.model.js'
import { productModel } from '../products/product.model.js'
import { ProductConfigurationCreateDto, ProductConfigurationResponseDto, ProductConfigurationUpdateDto } from '../types/product_configurations.js'
import { variantOptionModel } from '../variant_options/variant_option.model.js'
import { productConfigurationModel } from './product_configurations.model.js'


const createNew = async (reqBody: ProductConfigurationCreateDto): Promise<ProductConfigurationResponseDto> => {
  try {
    const existPrimaryKey = await productConfigurationModel.isExistPrimaryKey(reqBody)
    if (existPrimaryKey) {
      throw new ApiError(StatusCodes.CONFLICT, 'This both key value is exist, please do another pair')
    }
    //get and check
    const existProductItem = await productItemModel.findProductItemById(reqBody.product_item_id)
    if (!existProductItem) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist with this product_item_id')
    } else if (!existProductItem?.product_id) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist product_id')
    } else if (existProductItem.sku) {
      throw new ApiError(StatusCodes.CONFLICT, 'This product item already exist sku')
    }
    const existVariantOption = await variantOptionModel.getVariantOptionById(reqBody.variant_option_id)
    if (!existVariantOption) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist with this variant_option_id')
    } else if (!existVariantOption?.variant_option_value) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist variant_option_value')
    }
    const existProduct = await productModel.findProductById(existProductItem.product_id)
    if (!existProduct) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist')
    } else if (!existProduct.product_slug) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist slug')
    }



    let skuUpdater = ''

    skuUpdater += generateSKUwithSlug(existProduct?.product_slug)
    skuUpdater += '-'
    skuUpdater += generateSKUwithSlug(existVariantOption?.variant_option_value)

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

const update = async (reqBody: ProductConfigurationUpdateDto) => {
  try {
    const existPrimaryKey = await productConfigurationModel.isExistPrimaryKey({
      product_item_id: reqBody.old_product_item_id,
      variant_option_id: reqBody.old_variant_option_id
    })
    if (!existPrimaryKey) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'This both key value is not exist, please do available pair')
    }

    //Kiem tra new location
    //get and check
    const existProductItem = await productItemModel.findProductItemById(reqBody.new_product_item_id)
    if (!existProductItem) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist with this product_item_id')
    } else if (!existProductItem?.product_id) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist product_id')
    } else if (existProductItem.sku && (reqBody.new_product_item_id !== reqBody.old_product_item_id)) {
      throw new ApiError(StatusCodes.CONFLICT, 'This product item already exist sku')
    }
    const existVariantOption = await variantOptionModel.getVariantOptionById(reqBody.new_variant_option_id)
    if (!existVariantOption) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist with this variant_option_id')
    } else if (!existVariantOption?.variant_option_value) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist variant_option_value')
    }
    const existProduct = await productModel.findProductById(existProductItem.product_id)
    if (!existProduct) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist')
    } else if (!existProduct.product_slug) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist slug')
    }

    let skuUpdater = ''

    skuUpdater += generateSKUwithSlug(existProduct?.product_slug)
    skuUpdater += '-'
    skuUpdater += generateSKUwithSlug(existVariantOption?.variant_option_value)

    const existProductSKU = await productItemModel.findProductItemBySKU(skuUpdater)
    if (existProductSKU) {
      throw new ApiError(StatusCodes.CONFLICT, 'This sku already exist')
    }

    const updatedProductConfiguration = await productConfigurationModel.update(reqBody)
    const updatedProductItem = await productItemModel.update({
      product_item_id: reqBody.new_product_item_id,
      sku: skuUpdater
    })

    return updatedProductConfiguration
  } catch (error) {
    throw (error)
  }
}

export const productConfigurationService = {
  createNew,
  update
}
