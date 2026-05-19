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
import { orderService } from './order.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdOrder = yield orderService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdOrder);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const n_order_id = req.body.order_id;
        const reqBody = Object.assign({ order_id: n_order_id }, req.body);
        const updatedOrder = yield orderService.update(reqBody);
        res.status(StatusCodes.ACCEPTED).json(updatedOrder);
    }
    catch (error) {
        next(error);
    }
});
const getOrderById = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const gotOrder = yield orderService.getOrder(Number(id));
        res.status(StatusCodes.OK).json(gotOrder);
    }
    catch (error) {
        next(error);
    }
});
const getAllOrders = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const orders = yield orderService.getAllOrders();
        res.status(StatusCodes.OK).json(orders);
    }
    catch (error) {
        next(error);
    }
});
const deleteOrder = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        yield orderService.deleteOrder(Number(id));
        res.status(StatusCodes.NO_CONTENT).send();
    }
    catch (error) {
        next(error);
    }
});
const getOrdersByUserId = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        const { userId } = req.params;
        // Security: Only allow the logged-in user to see their own orders, or Admin to see anyone's orders
        if (((_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id) !== Number(userId) && ((_b = req.jwtDecoded) === null || _b === void 0 ? void 0 : _b.role) !== 1) {
            throw new ApiError(StatusCodes.FORBIDDEN, 'Forbidden (You can only access your own orders)');
        }
        const orders = yield orderService.getOrdersByUserId(Number(userId));
        res.status(StatusCodes.OK).json(orders);
    }
    catch (error) {
        next(error);
    }
});
const cancelOrder = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        const { orderId } = req.params;
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        const isAdmin = ((_b = req.jwtDecoded) === null || _b === void 0 ? void 0 : _b.role) === 1;
        if (!userId) {
            throw new ApiError(StatusCodes.UNAUTHORIZED, 'Unauthorized');
        }
        const updatedOrder = yield orderService.cancelOrder(Number(orderId), userId, isAdmin);
        res.status(StatusCodes.OK).json(updatedOrder);
    }
    catch (error) {
        next(error);
    }
});
export const orderController = {
    createNew,
    update,
    getOrderById,
    getAllOrders,
    deleteOrder,
    getOrdersByUserId,
    cancelOrder
};
//# sourceMappingURL=order.controller.js.map