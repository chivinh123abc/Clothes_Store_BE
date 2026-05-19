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
import { slugify } from '../../utils/formatters.js';
import { categoryModel } from '../categories/category.model.js';
import { productModel } from './product.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        if (!reqBody.product_name) {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'product_name not to be undefined!');
        }
        if (!reqBody.category_id) {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'category_id not to be undefined!');
        }
        reqBody.product_slug = slugify(reqBody.product_name);
        const existProduct = yield productModel.findProductBySlug(reqBody.product_slug);
        if (existProduct) {
            throw new ApiError(StatusCodes.CONFLICT, 'This product already exist');
        }
        const existCategory = yield categoryModel.findCategoryById(reqBody.category_id);
        if (!existCategory) {
            throw new ApiError(StatusCodes.CONFLICT, 'This category is not exist');
        }
        const result = yield productModel.create(reqBody);
        return result;
    }
    catch (error) {
        throw error;
    }
});
const getProduct = (product_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const result = yield productModel.findProductById(product_id);
        if (!result) {
            throw new ApiError(StatusCodes.CONFLICT, 'This product is not exist');
        }
        return result;
    }
    catch (error) {
        throw error;
    }
});
const update = (product_id, reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existProduct = yield productModel.findProductById(product_id);
        if (!existProduct) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'product_id is not exist');
        }
        if (reqBody.category_id) {
            const existCategory = yield categoryModel.findCategoryById(reqBody.category_id);
            if (!existCategory) {
                throw new ApiError(StatusCodes.CONFLICT, 'This category is not exist');
            }
        }
        if (reqBody.product_name) {
            reqBody.product_slug = slugify(reqBody.product_name);
            const existProduct2 = yield productModel.findProductBySlug(reqBody.product_slug);
            if (existProduct2 && existProduct2.product_id !== product_id) {
                throw new ApiError(StatusCodes.CONFLICT, 'This name already exist');
            }
        }
        const updatedProduct = yield productModel.update(product_id, reqBody);
        return updatedProduct;
    }
    catch (error) {
        throw error;
    }
});
const getAll = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        return yield productModel.findAll();
    }
    catch (error) {
        throw error;
    }
});
const deleteProduct = (product_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existProduct = yield productModel.findProductById(product_id);
        if (!existProduct) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Product not found');
        }
        return yield productModel.deleteProduct(product_id);
    }
    catch (error) {
        throw error;
    }
});
const getByCollectionSlug = (slug) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        return yield productModel.getByCollectionSlug(slug);
    }
    catch (error) {
        throw error;
    }
});
export const productService = {
    createNew,
    getProduct,
    update,
    getAll,
    getByCollectionSlug,
    deleteProduct
};
//# sourceMappingURL=product.service.js.map