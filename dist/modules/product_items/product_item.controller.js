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
import { productItemService } from './product_item.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdProductItem = yield productItemService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdProductItem);
    }
    catch (error) {
        next(error);
    }
});
const getProductItem = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const product_item_id = req.body.product_item_id;
        const gotProductItem = yield productItemService.getProductItem(product_item_id);
        res.status(StatusCodes.CREATED).json(gotProductItem);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const product_item_id = req.body.product_item_id;
        const updateData = Object.assign({ product_item_id: product_item_id }, req.body);
        const gotProductItem = yield productItemService.update(updateData);
        res.status(StatusCodes.CREATED).json(gotProductItem);
    }
    catch (error) {
        next(error);
    }
});
export const productItemController = {
    createNew,
    getProductItem,
    update
};
//# sourceMappingURL=product_item.controller.js.map