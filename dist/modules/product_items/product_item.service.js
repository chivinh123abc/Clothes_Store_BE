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
import { productModel } from '../products/product.model.js';
import { productItemModel } from './product_item.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        if (!reqBody.product_id) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'product_id must be exist');
        }
        const existProduct = yield productModel.findProductById(reqBody.product_id);
        if (!existProduct) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'this product_id is not exist');
        }
        const createdProductItem = yield productItemModel.create(reqBody);
        return createdProductItem;
    }
    catch (error) {
        throw (error);
    }
});
const getProductItem = (product_item_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const result = yield productItemModel.findProductItemById(product_item_id);
        if (!result) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'This product item is not exist');
        }
        return result;
    }
    catch (error) {
        throw (error);
    }
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        if (reqBody.product_id) {
            const existProduct = yield productModel.findProductById(reqBody.product_id);
            if (!existProduct) {
                throw new ApiError(StatusCodes.NOT_FOUND, 'This product is not exist');
            }
        }
        if (reqBody.sku) {
            const existProduct = yield productItemModel.findProductItemBySKU(reqBody.sku);
            if (!existProduct) {
                throw new ApiError(StatusCodes.NOT_FOUND, 'The product item with this sku is not exist');
            }
        }
        const existProductItem = yield productItemModel.findProductItemById(reqBody.product_item_id);
        if (!existProductItem) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'This product item is not exist');
        }
        const result = yield productItemModel.update(reqBody);
        return result;
    }
    catch (error) {
        throw (error);
    }
});
export const productItemService = {
    createNew,
    getProductItem,
    update
};
//# sourceMappingURL=product_item.service.js.map