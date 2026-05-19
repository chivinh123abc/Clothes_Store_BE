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
import { cartService } from './cart.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdCart = yield cartService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdCart);
    }
    catch (error) {
        next(error);
    }
});
const getCartById = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const gotCart = yield cartService.getCartById(req.body.cart_id);
        res.status(StatusCodes.ACCEPTED).json(gotCart);
    }
    catch (error) {
        throw error;
    }
});
export const cartController = {
    createNew,
    getCartById
};
//# sourceMappingURL=cart.controller.js.map