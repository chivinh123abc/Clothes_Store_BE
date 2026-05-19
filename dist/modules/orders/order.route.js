import express from 'express';
import { authMiddleware } from '../../middlewares/authMiddleware.js';
import { orderController } from './order.controller.js';
import { orderValidation } from './order.validation.js';
const Router = express.Router();
Router.route('/')
    .post(orderValidation.createNew, orderController.createNew)
    .put(authMiddleware.isAuthorized, authMiddleware.isAdmin, orderValidation.update, orderController.update)
    .get(orderController.getOrderById);
// User routes
Router.get('/user/:userId', authMiddleware.isAuthorized, orderController.getOrdersByUserId);
Router.put('/cancel/:orderId', authMiddleware.isAuthorized, orderController.cancelOrder);
// Admin routes
Router.get('/all', authMiddleware.isAuthorized, authMiddleware.isAdmin, orderController.getAllOrders);
Router.get('/:id', authMiddleware.isAuthorized, authMiddleware.isAdmin, orderController.getOrderById);
Router.delete('/:id', authMiddleware.isAuthorized, authMiddleware.isAdmin, orderController.deleteOrder);
export const orderRoute = Router;
//# sourceMappingURL=order.route.js.map