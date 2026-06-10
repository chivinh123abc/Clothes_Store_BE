var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import fs from 'fs';
import { StatusCodes } from 'http-status-codes';
import { OrderStatus } from '../constants/orders.enum.js';
import { orderModel } from '../orders/order.model.js';
import { createMoMoPaymentUrl } from './payment.service.js';
export const createMoMo = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { order_id, orderInfo } = req.body;
        if (!order_id) {
            return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing order_id' });
        }
        const order = yield orderModel.findOrderById(Number(order_id));
        if (!order) {
            return res.status(StatusCodes.NOT_FOUND).json({ message: 'Order not found' });
        }
        const dbAmount = Number(order.total_amount);
        if (!dbAmount || dbAmount <= 0) {
            return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Invalid order amount' });
        }
        const payUrl = yield createMoMoPaymentUrl(Number(order_id), dbAmount, orderInfo || 'Thanh toan don hang T1');
        res.status(StatusCodes.OK).json({ payUrl });
    }
    catch (error) {
        // eslint-disable-next-line no-console
        console.error('Payment controller error:', error);
        try {
            fs.writeFileSync('logs/payment_error.log', error.stack || error.message || String(error));
        }
        catch (e) {
            // ignore log error
        }
        next(error);
    }
});
export const confirmMoMo = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { order_id } = req.body;
        if (!order_id) {
            return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing order_id' });
        }
        // Update the overall order status to 'paid', payment status to 'paid', and payment method to 'momo'
        const updatedOrder = yield orderModel.update({
            order_id: Number(order_id),
            status: OrderStatus.PAID,
            payment_status: 'paid',
            payment_method: 'momo'
        });
        if (!updatedOrder) {
            return res.status(StatusCodes.NOT_FOUND).json({ message: 'Order not found' });
        }
        res.status(StatusCodes.OK).json({ message: 'Payment confirmed successfully', order: updatedOrder });
    }
    catch (error) {
        next(error);
    }
});
//# sourceMappingURL=payment.controller.js.map