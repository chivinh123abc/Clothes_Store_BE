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
import { categoryService } from './category.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const newCategory = yield categoryService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(newCategory);
    }
    catch (error) {
        next(error);
    }
});
const getAll = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const categories = yield categoryService.getAll();
        res.status(StatusCodes.OK).json(categories);
    }
    catch (error) {
        next(error);
    }
});
const getCategory = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const category_id = Number(req.params.id);
        const thisCategory = yield categoryService.getCategory(category_id);
        res.status(StatusCodes.OK).json(thisCategory);
    }
    catch (error) {
        next(error);
    }
});
const updateCategory = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const category_id = Number(req.params.id);
        const updatedCategory = yield categoryService.updateCategory(category_id, req.body);
        res.status(StatusCodes.OK).json(updatedCategory);
    }
    catch (error) {
        next(error);
    }
});
const deleteCategory = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const category_id = Number(req.params.id);
        yield categoryService.deleteCategory(category_id);
        res.status(StatusCodes.OK).json({ message: 'Category deleted successfully' });
    }
    catch (error) {
        next(error);
    }
});
export const categoryController = {
    createNew,
    getCategory,
    updateCategory,
    getAll,
    deleteCategory
};
//# sourceMappingURL=category.controller.js.map