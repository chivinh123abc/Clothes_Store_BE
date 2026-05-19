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
import { productService } from './product.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdProduct = yield productService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdProduct);
    }
    catch (error) {
        next(error);
    }
});
const getAll = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const products = yield productService.getAll();
        res.status(StatusCodes.OK).json(products);
    }
    catch (error) {
        next(error);
    }
});
const getProduct = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const product_id = parseInt(req.params.id);
        const gotProduct = yield productService.getProduct(product_id);
        res.status(StatusCodes.OK).json(gotProduct);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const product_id = parseInt(req.params.id);
        const updatedProduct = yield productService.update(product_id, req.body);
        res.status(StatusCodes.OK).json(updatedProduct);
    }
    catch (error) {
        next(error);
    }
});
const deleteProduct = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const product_id = parseInt(req.params.id);
        yield productService.deleteProduct(product_id);
        res.status(StatusCodes.OK).json({ message: 'Product deleted successfully' });
    }
    catch (error) {
        next(error);
    }
});
const getByCollectionSlug = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const products = yield productService.getByCollectionSlug(req.params.slug);
        res.status(StatusCodes.OK).json(products);
    }
    catch (error) {
        next(error);
    }
});
export const productController = {
    createNew,
    getProduct,
    update,
    getAll,
    getByCollectionSlug,
    deleteProduct
};
//# sourceMappingURL=product.controller.js.map