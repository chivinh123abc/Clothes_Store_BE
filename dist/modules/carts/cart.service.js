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
import { productItemModel } from '../product_items/product_item.model.js';
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
const getOrCreateCart = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    let cart = yield cartModel.getCartByUserId(user_id);
    if (!cart) {
        cart = yield createNew({ user_id });
    }
    return cart;
});
const getMyCart = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    const cart = yield getOrCreateCart(user_id);
    if (!cart.cart_id)
        return [];
    return yield cartModel.getCartItemsDetails(cart.cart_id);
});
const addItemToCart = (user_id, product_id, size, quantity) => __awaiter(void 0, void 0, void 0, function* () {
    const cart = yield getOrCreateCart(user_id);
    const cart_id = cart.cart_id;
    const product_item_id = yield cartModel.findProductItemId(product_id, size);
    if (!product_item_id) {
        throw new ApiError(StatusCodes.NOT_FOUND, `Product variant with size ${size} not found`);
    }
    const productItem = yield productItemModel.findProductItemById(product_item_id);
    if (!productItem) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant details not found');
    }
    // Check stock limits
    const existItem = yield cartModel.getCartItem(cart_id, product_item_id);
    const currentQuantity = existItem ? existItem.quantity : 0;
    const targetQuantity = currentQuantity + quantity;
    if (targetQuantity > productItem.stock_quantity) {
        throw new ApiError(StatusCodes.BAD_REQUEST, `Số lượng trong giỏ hàng vượt quá tồn kho (tối đa là ${productItem.stock_quantity})`);
    }
    const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price);
    const price = unitPrice * quantity;
    return yield cartModel.addOrUpdateCartItem(cart_id, product_item_id, quantity, price);
});
const updateItemQuantity = (user_id, product_id, size, quantity) => __awaiter(void 0, void 0, void 0, function* () {
    const cart = yield cartModel.getCartByUserId(user_id);
    if (!cart || !cart.cart_id) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'Cart not found for this user');
    }
    const product_item_id = yield cartModel.findProductItemId(product_id, size);
    if (!product_item_id) {
        throw new ApiError(StatusCodes.NOT_FOUND, `Product variant with size ${size} not found`);
    }
    const productItem = yield productItemModel.findProductItemById(product_item_id);
    if (!productItem) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant details not found');
    }
    // Check stock limits
    if (quantity > productItem.stock_quantity) {
        throw new ApiError(StatusCodes.BAD_REQUEST, `Số lượng trong giỏ hàng vượt quá tồn kho (tối đa là ${productItem.stock_quantity})`);
    }
    const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price);
    const price = unitPrice * quantity;
    return yield cartModel.updateCartItemQuantity(cart.cart_id, product_item_id, quantity, price);
});
const removeItemFromCart = (user_id, product_id, size) => __awaiter(void 0, void 0, void 0, function* () {
    const cart = yield cartModel.getCartByUserId(user_id);
    if (!cart || !cart.cart_id) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'Cart not found for this user');
    }
    const product_item_id = yield cartModel.findProductItemId(product_id, size);
    if (!product_item_id) {
        throw new ApiError(StatusCodes.NOT_FOUND, `Product variant with size ${size} not found`);
    }
    return yield cartModel.deleteCartItem(cart.cart_id, product_item_id);
});
const syncCart = (user_id, clientItems) => __awaiter(void 0, void 0, void 0, function* () {
    const cart = yield getOrCreateCart(user_id);
    const cart_id = cart.cart_id;
    for (const item of clientItems) {
        try {
            const product_item_id = yield cartModel.findProductItemId(Number(item.id), item.size);
            if (!product_item_id)
                continue;
            const productItem = yield productItemModel.findProductItemById(product_item_id);
            if (!productItem)
                continue;
            const existItem = yield cartModel.getCartItem(cart_id, product_item_id);
            const currentQuantity = existItem ? existItem.quantity : 0;
            const allowedQuantity = Math.min(Number(item.quantity), productItem.stock_quantity - currentQuantity);
            if (allowedQuantity <= 0)
                continue;
            const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price);
            const price = unitPrice * allowedQuantity;
            yield cartModel.addOrUpdateCartItem(cart_id, product_item_id, allowedQuantity, price);
        }
        catch (err) {
            console.error('Failed to sync item:', item, err);
        }
    }
    return yield cartModel.getCartItemsDetails(cart_id);
});
const clearCart = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    const cart = yield cartModel.getCartByUserId(user_id);
    if (!cart || !cart.cart_id)
        return true;
    return yield cartModel.clearCartItems(cart.cart_id);
});
const updateItemSize = (user_id, product_id, oldSize, newSize) => __awaiter(void 0, void 0, void 0, function* () {
    const cart = yield cartModel.getCartByUserId(user_id);
    if (!cart || !cart.cart_id) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'Cart not found for this user');
    }
    const old_product_item_id = yield cartModel.findProductItemId(product_id, oldSize);
    const new_product_item_id = yield cartModel.findProductItemId(product_id, newSize);
    if (!old_product_item_id || !new_product_item_id) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant not found');
    }
    const productItem = yield productItemModel.findProductItemById(new_product_item_id);
    if (!productItem) {
        throw new ApiError(StatusCodes.NOT_FOUND, 'Product variant details not found');
    }
    const existNew = yield cartModel.getCartItem(cart.cart_id, new_product_item_id);
    if (existNew) {
        // Case: duplicate size exists. We merge the old item into the new item
        const existOld = yield cartModel.getCartItem(cart.cart_id, old_product_item_id);
        const oldQty = (existOld === null || existOld === void 0 ? void 0 : existOld.quantity) || 0;
        const newQty = existNew.quantity + oldQty;
        // Check stock limit for the new size
        if (newQty > productItem.stock_quantity) {
            throw new ApiError(StatusCodes.BAD_REQUEST, `Không thể thay đổi size. Tổng số lượng vượt quá tồn kho của size mới (tối đa là ${productItem.stock_quantity})`);
        }
        const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price);
        const price = unitPrice * newQty;
        // 1. Update quantity of the duplicate variant
        yield cartModel.updateCartItemQuantity(cart.cart_id, new_product_item_id, newQty, price);
        // 2. Delete the old variant record
        yield cartModel.deleteCartItem(cart.cart_id, old_product_item_id);
        return { hasDuplicate: true };
    }
    else {
        // Case: No duplicate size exists. Update size in-place (keeps created_at and maintains ordering)
        const existOld = yield cartModel.getCartItem(cart.cart_id, old_product_item_id);
        const oldQty = (existOld === null || existOld === void 0 ? void 0 : existOld.quantity) || 0;
        // Check stock limit for the new size
        if (oldQty > productItem.stock_quantity) {
            throw new ApiError(StatusCodes.BAD_REQUEST, `Không thể thay đổi size. Số lượng hiện có vượt quá tồn kho của size mới (tối đa là ${productItem.stock_quantity})`);
        }
        const unitPrice = Number(productItem.sale_price !== undefined ? productItem.sale_price : productItem.product_item_price);
        const price = unitPrice * oldQty;
        const updated = yield cartModel.updateCartItemSizeOnly(cart.cart_id, old_product_item_id, new_product_item_id, price);
        return { hasDuplicate: false, updated };
    }
});
export const cartService = {
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
//# sourceMappingURL=cart.service.js.map