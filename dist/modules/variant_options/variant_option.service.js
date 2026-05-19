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
import { variantModel } from '../variants/variant.model.js';
import { variantOptionModel } from './variant_option.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        reqBody.variant_option_slug = slugify(reqBody.variant_option_value);
        const existVariant = yield variantModel.getVariantById(reqBody.variant_id);
        if (!existVariant) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'This variant id is not exist, check again');
        }
        const existVariantOption = yield variantOptionModel.getVariantOptionBySlug(reqBody.variant_option_slug);
        if (existVariantOption) {
            throw new ApiError(StatusCodes.CONFLICT, 'This variant options name already exist, check again');
        }
        const createdVariantOption = yield variantOptionModel.create(reqBody);
        return createdVariantOption;
    }
    catch (error) {
        throw (error);
    }
});
const getVariantOptionById = (variant_option_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const foundVariantOption = yield variantOptionModel.getVariantOptionById(variant_option_id);
        if (!foundVariantOption) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'This variant option is not exist, check again');
        }
        return foundVariantOption;
    }
    catch (error) {
        throw error;
    }
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        if (reqBody.variant_option_value) {
            reqBody.variant_option_slug = slugify(reqBody.variant_option_value);
            const foundvariantOption = yield variantOptionModel.getVariantOptionBySlug(reqBody.variant_option_slug);
            if (foundvariantOption) {
                throw new ApiError(StatusCodes.CONFLICT, 'This name already exist by someway');
            }
        }
        if (reqBody.variant_id) {
            const existVariant = yield variantModel.getVariantById(reqBody.variant_id);
            if (!existVariant) {
                throw new ApiError(StatusCodes.NOT_FOUND, 'This variant id is not exist, check again');
            }
        }
        const updatedVariantOption = yield variantOptionModel.update(reqBody);
        if (!updatedVariantOption) {
            throw new ApiError(StatusCodes.CONFLICT, 'Can not update by some reason');
        }
        return updatedVariantOption;
    }
    catch (error) {
        throw error;
    }
});
export const variantOptionService = {
    createNew,
    getVariantOptionById,
    update
};
//# sourceMappingURL=variant_option.service.js.map