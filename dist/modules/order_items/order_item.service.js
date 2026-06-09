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
import { orderModel } from '../orders/order.model.js';
import { orderItemModel } from './order_item.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // Kiem tra Order
        const existOrder = yield orderModel.findOrderById(reqBody.order_id);
        if (!existOrder) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not exist'));
        }
        const result = yield orderItemModel.createWithStockUpdate(reqBody);
        return result;
    }
    catch (error) {
        if (error.message.includes('không đủ số lượng') || error.message.includes('variant does not exist')) {
            throw new ApiError(StatusCodes.BAD_REQUEST, error.message);
        }
        throw error;
    }
});
const getOrderItemById = (order_item_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const result = yield orderItemModel.getOrderItemById(order_item_id);
        if (!result) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Order item not exist'));
        }
        return result;
    }
    catch (error) {
        throw error;
    }
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existOrderItem = yield orderItemModel.getOrderItemById(reqBody.order_item_id);
        if (!existOrderItem) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Order item not exist'));
        }
        const result = yield orderItemModel.update(reqBody);
        return result;
    }
    catch (error) {
        throw error;
    }
});
export const orderItemService = {
    createNew,
    getOrderItemById,
    update
};
//# sourceMappingURL=order_item.service.js.map