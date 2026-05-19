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
import { OrderStatus } from '../constants/orders.enum.js';
import { orderItemModel } from '../order_items/order_item.model.js';
import { userModel } from '../users/user.model.js';
import { orderModel } from './order.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existUser = yield userModel.findUserById(reqBody.user_id);
        if (!existUser) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'User not found'));
        }
        const createdOrder = yield orderModel.create(reqBody);
        return createdOrder;
    }
    catch (error) {
        throw (error);
    }
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existOrder = yield orderModel.findOrderById(reqBody.order_id);
        if (!existOrder) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not found'));
        }
        if (reqBody.user_id) {
            const existUser = yield userModel.findUserById(reqBody.user_id);
            if (!existUser) {
                throw (new ApiError(StatusCodes.NOT_FOUND, 'User not found'));
            }
        }
        const updatedOrder = yield orderModel.update(reqBody);
        if (!updatedOrder) {
            throw (new ApiError(StatusCodes.CONFLICT, 'Updated Failed'));
        }
        return updatedOrder;
    }
    catch (error) {
        throw (error);
    }
});
const getOrder = (order_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existOrder = yield orderModel.findOrderById(order_id);
        if (!existOrder) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not found'));
        }
        const items = yield orderItemModel.findAllByOrderId(order_id);
        return Object.assign(Object.assign({}, existOrder), { items });
    }
    catch (error) {
        throw error;
    }
});
const getAllOrders = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        return yield orderModel.findAllOrders();
    }
    catch (error) {
        throw error;
    }
});
const deleteOrder = (order_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existOrder = yield orderModel.findOrderById(order_id);
        if (!existOrder) {
            throw (new ApiError(StatusCodes.NOT_FOUND, 'Order not found'));
        }
        yield orderModel.deleteOrder(order_id);
    }
    catch (error) {
        throw error;
    }
});
const getOrdersByUserId = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const orders = yield orderModel.findAllOrderByUserId(user_id);
        const ordersWithItems = yield Promise.all(orders.map((order) => __awaiter(void 0, void 0, void 0, function* () {
            const items = yield orderItemModel.findAllByOrderId(order.order_id);
            return Object.assign(Object.assign({}, order), { items });
        })));
        return ordersWithItems;
    }
    catch (error) {
        throw error;
    }
});
const cancelOrder = (order_id, user_id, isAdmin) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const order = yield orderModel.findOrderById(order_id);
        if (!order) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'Order not found');
        }
        // Security: Must be owner or admin
        if (order.user_id !== user_id && !isAdmin) {
            throw new ApiError(StatusCodes.FORBIDDEN, 'Forbidden (You can only cancel your own orders)');
        }
        // Business Logic: Can only cancel if still pending
        if (order.status !== 'pending') {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'Only pending orders can be cancelled');
        }
        const updatedOrder = yield orderModel.update({
            order_id,
            status: OrderStatus.CANCELLED
        });
        if (!updatedOrder) {
            throw new ApiError(StatusCodes.CONFLICT, 'Cancel order failed');
        }
        return updatedOrder;
    }
    catch (error) {
        throw error;
    }
});
export const orderService = {
    createNew,
    update,
    getOrder,
    getAllOrders,
    deleteOrder,
    getOrdersByUserId,
    cancelOrder
};
//# sourceMappingURL=order.service.js.map