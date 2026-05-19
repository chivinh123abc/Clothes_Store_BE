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
import { categoryModel } from './category.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        reqBody.category_slug = slugify(reqBody.category_name);
        const existCategory = yield categoryModel.findCategoryBySlugName(reqBody.category_slug);
        if (existCategory) {
            throw new ApiError(StatusCodes.CONFLICT, 'This category already exist!');
        }
        const result = yield categoryModel.create(reqBody);
        return result;
    }
    catch (error) {
        throw error;
    }
});
const getCategory = (category_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existCategory = yield categoryModel.findCategoryById(category_id);
        if (!existCategory) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'category not found');
        }
        const result = yield categoryModel.findCategoryById(category_id);
        return result;
    }
    catch (error) {
        throw error;
    }
});
const updateCategory = (category_id, reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existCategory = yield categoryModel.findCategoryById(category_id);
        if (!existCategory) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'category not found');
        }
        reqBody.category_slug = slugify(reqBody.category_name);
        const existCategory2 = yield categoryModel.findCategoryBySlugName(reqBody.category_slug);
        if (existCategory2) {
            throw new ApiError(StatusCodes.CONFLICT, 'category name is duplicated');
        }
        const result = yield categoryModel.update(category_id, reqBody);
        return result;
    }
    catch (error) {
        throw error;
    }
});
const getAll = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        return yield categoryModel.findAll();
    }
    catch (error) {
        throw error;
    }
});
const deleteCategory = (category_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existCategory = yield categoryModel.findCategoryById(category_id);
        if (!existCategory) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'category not found');
        }
        return yield categoryModel.deleteCategory(category_id);
    }
    catch (error) {
        throw error;
    }
});
export const categoryService = {
    createNew,
    getCategory,
    updateCategory,
    getAll,
    deleteCategory
};
//# sourceMappingURL=category.service.js.map