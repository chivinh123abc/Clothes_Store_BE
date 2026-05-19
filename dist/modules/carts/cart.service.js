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
import { userModel } from '../users/user.model.js';
import { cartModel } from './cart.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existUser = yield userModel.findUserById(reqBody.user_id);
        if (!existUser) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'User not found'));
        }
        const createdCart = yield cartModel.create(reqBody);
        return createdCart;
    }
    catch (error) {
        throw error;
    }
});
const getCartById = (cart_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const gotCart = yield cartModel.getCartById(cart_id);
        return gotCart;
    }
    catch (error) {
        throw error;
    }
});
export const cartService = {
    createNew,
    getCartById
};
//# sourceMappingURL=cart.service.js.map