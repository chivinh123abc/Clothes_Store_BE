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
import { cartModel } from '../carts/cart.model.js';
import { productItemModel } from '../product_items/product_item.model.js';
import { cartItemModel } from './cart_item.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existCart = yield cartModel.getCartById(reqBody.cart_id);
        if (!existCart) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Not found this Cart'));
        }
        const existProductItem = yield productItemModel.findProductItemById(reqBody.product_item_id);
        if (!(existProductItem === null || existProductItem === void 0 ? void 0 : existProductItem.product_item_price)) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Not found this Product Item'));
        }
        reqBody.price = existProductItem.product_item_price * reqBody.quantity;
        const createdCartItem = yield cartItemModel.create(reqBody);
        return createdCartItem;
    }
    catch (error) {
        throw error;
    }
});
const getCartItemById = (cart_item_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existCartItem = yield cartItemModel.getCartItemById(cart_item_id);
        if (!existCartItem) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Not found this Cart Item'));
        }
        return existCartItem;
    }
    catch (error) {
        throw (error);
    }
});
export const cartItemService = {
    createNew,
    getCartItemById
};
//# sourceMappingURL=cart_item.service.js.map