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
        next(error);
    }
});
const getMyCart = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const cartItems = yield cartService.getMyCart(userId);
        res.status(StatusCodes.OK).json(cartItems);
    }
    catch (error) {
        next(error);
    }
});
const addItemToCart = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const { product_id, size, quantity } = req.body;
        const result = yield cartService.addItemToCart(userId, Number(product_id), size, Number(quantity));
        res.status(StatusCodes.OK).json(result);
    }
    catch (error) {
        next(error);
    }
});
const updateItemQuantity = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const { product_id, size, quantity } = req.body;
        const result = yield cartService.updateItemQuantity(userId, Number(product_id), size, Number(quantity));
        res.status(StatusCodes.OK).json(result);
    }
    catch (error) {
        next(error);
    }
});
const removeItemFromCart = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const { product_id, size } = req.body;
        const result = yield cartService.removeItemFromCart(userId, Number(product_id), size);
        res.status(StatusCodes.OK).json({ success: result });
    }
    catch (error) {
        next(error);
    }
});
const syncCart = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const clientItems = req.body.items || [];
        const syncedItems = yield cartService.syncCart(userId, clientItems);
        res.status(StatusCodes.OK).json(syncedItems);
    }
    catch (error) {
        next(error);
    }
});
const clearCart = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const result = yield cartService.clearCart(userId);
        res.status(StatusCodes.OK).json({ success: result });
    }
    catch (error) {
        next(error);
    }
});
const updateItemSize = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const { product_id, old_size, new_size } = req.body;
        const result = yield cartService.updateItemSize(userId, Number(product_id), old_size, new_size);
        res.status(StatusCodes.OK).json(result);
    }
    catch (error) {
        next(error);
    }
});
export const cartController = {
    createNew,
    getCartById,
    getMyCart,
    addItemToCart,
    updateItemQuantity,
    removeItemFromCart,
    syncCart,
    clearCart,
    updateItemSize
};
//# sourceMappingURL=cart.controller.js.map