var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { StatusCodes } from 'http-status-codes';
import ApiError from '../../utils/ApiError.js';
import { generateSKUwithSlug } from '../../utils/formatters.js';
import { productItemModel } from '../product_items/product_item.model.js';
import { productModel } from '../products/product.model.js';
import { variantOptionModel } from '../variant_options/variant_option.model.js';
import { productConfigurationModel } from './product_configurations.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existPrimaryKey = yield productConfigurationModel.isExistPrimaryKey(reqBody);
        if (existPrimaryKey) {
            throw new ApiError(StatusCodes.CONFLICT, 'This both key value is exist, please do another pair');
        }
        //get and check
        const existProductItem = yield productItemModel.findProductItemById(reqBody.product_item_id);
        if (!existProductItem) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist with this product_item_id');
        }
        else if (!(existProductItem === null || existProductItem === void 0 ? void 0 : existProductItem.product_id)) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist product_id');
        }
        else if (existProductItem.sku) {
            throw new ApiError(StatusCodes.CONFLICT, 'This product item already exist sku');
        }
        const existVariantOption = yield variantOptionModel.getVariantOptionById(reqBody.variant_option_id);
        if (!existVariantOption) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist with this variant_option_id');
        }
        else if (!(existVariantOption === null || existVariantOption === void 0 ? void 0 : existVariantOption.variant_option_value)) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist variant_option_value');
        }
        const existProduct = yield productModel.findProductById(existProductItem.product_id);
        if (!existProduct) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist');
        }
        else if (!existProduct.product_slug) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist slug');
        }
        let skuUpdater = '';
        skuUpdater += generateSKUwithSlug(existProduct === null || existProduct === void 0 ? void 0 : existProduct.product_slug);
        skuUpdater += '-';
        skuUpdater += generateSKUwithSlug(existVariantOption === null || existVariantOption === void 0 ? void 0 : existVariantOption.variant_option_value);
        const existProductSKU = yield productItemModel.findProductItemBySKU(skuUpdater);
        if (existProductSKU) {
            throw new ApiError(StatusCodes.CONFLICT, 'This sku already exist');
        }
        const createdProductConfiguration = yield productConfigurationModel.create(reqBody);
        const updatedProductItem = yield productItemModel.update({
            product_item_id: reqBody.product_item_id,
            sku: skuUpdater
        });
        return createdProductConfiguration;
    }
    catch (error) {
        throw (error);
    }
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existPrimaryKey = yield productConfigurationModel.isExistPrimaryKey({
            product_item_id: reqBody.old_product_item_id,
            variant_option_id: reqBody.old_variant_option_id
        });
        if (!existPrimaryKey) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'This both key value is not exist, please do available pair');
        }
        //Kiem tra new location
        //get and check
        const existProductItem = yield productItemModel.findProductItemById(reqBody.new_product_item_id);
        if (!existProductItem) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist with this product_item_id');
        }
        else if (!(existProductItem === null || existProductItem === void 0 ? void 0 : existProductItem.product_id)) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product item not exist product_id');
        }
        else if (existProductItem.sku && (reqBody.new_product_item_id !== reqBody.old_product_item_id)) {
            throw new ApiError(StatusCodes.CONFLICT, 'This product item already exist sku');
        }
        const existVariantOption = yield variantOptionModel.getVariantOptionById(reqBody.new_variant_option_id);
        if (!existVariantOption) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist with this variant_option_id');
        }
        else if (!(existVariantOption === null || existVariantOption === void 0 ? void 0 : existVariantOption.variant_option_value)) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'variant option not exist variant_option_value');
        }
        const existProduct = yield productModel.findProductById(existProductItem.product_id);
        if (!existProduct) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist');
        }
        else if (!existProduct.product_slug) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product not exist slug');
        }
        let skuUpdater = '';
        skuUpdater += generateSKUwithSlug(existProduct === null || existProduct === void 0 ? void 0 : existProduct.product_slug);
        skuUpdater += '-';
        skuUpdater += generateSKUwithSlug(existVariantOption === null || existVariantOption === void 0 ? void 0 : existVariantOption.variant_option_value);
        const existProductSKU = yield productItemModel.findProductItemBySKU(skuUpdater);
        if (existProductSKU) {
            throw new ApiError(StatusCodes.CONFLICT, 'This sku already exist');
        }
        const updatedProductConfiguration = yield productConfigurationModel.update(reqBody);
        const updatedProductItem = yield productItemModel.update({
            product_item_id: reqBody.new_product_item_id,
            sku: skuUpdater
        });
        return updatedProductConfiguration;
    }
    catch (error) {
        throw (error);
    }
});
export const productConfigurationService = {
    createNew,
    update
};
//# sourceMappingURL=product_configurations.service.js.map