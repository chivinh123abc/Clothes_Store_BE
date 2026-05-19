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
import { cartItemService } from './cart_item.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdCartItem = yield cartItemService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdCartItem);
    }
    catch (error) {
        next(error);
    }
});
const getCartItemById = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const gotdCartItem = yield cartItemService.getCartItemById(req.body.cart_item_id);
        res.status(StatusCodes.ACCEPTED).json(gotdCartItem);
    }
    catch (error) {
        next(error);
    }
});
export const cartItemController = {
    createNew,
    getCartItemById
};
//# sourceMappingURL=cart_item.controller.js.map