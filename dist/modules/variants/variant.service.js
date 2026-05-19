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
import { variantModel } from './variant.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        reqBody.variant_slug = slugify(reqBody.variant_name);
        const existVariant = yield variantModel.getVariantBySlug(reqBody.variant_slug);
        if (existVariant) {
            throw new ApiError(StatusCodes.CONFLICT, 'variant_name already exist');
        }
        const createdVariant = yield variantModel.create(reqBody);
        return createdVariant;
    }
    catch (error) {
        throw error;
    }
});
const getVaration = (variant_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const resultVariant = yield variantModel.getVariantById(variant_id);
        if (!resultVariant) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'variant_id is not exist');
        }
        return resultVariant;
    }
    catch (error) {
        throw error;
    }
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existVariant = yield variantModel.getVariantById(reqBody.variant_id);
        if (!existVariant) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'variant_id is not exist');
        }
        if (reqBody.category_id) {
            const existCategory = yield categoryModel.findCategoryById(reqBody.category_id);
            if (!existCategory) {
                throw new ApiError(StatusCodes.NOT_FOUND, 'categories_id is not exist');
            }
        }
        if (reqBody.variant_name) {
            reqBody.variant_slug = slugify(reqBody.variant_name);
            const existVariant = yield variantModel.getVariantBySlug(reqBody.variant_slug);
            if (existVariant) {
                throw new ApiError(StatusCodes.CONFLICT, 'variant name already exist');
            }
        }
        const updatedVariant = yield variantModel.update(reqBody);
        if (!updatedVariant) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Can not update this validation');
        }
        return updatedVariant;
    }
    catch (error) {
        throw error;
    }
});
export const variantService = {
    createNew,
    getVaration,
    update
};
//# sourceMappingURL=variant.service.js.map