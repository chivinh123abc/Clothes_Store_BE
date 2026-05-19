import express from 'express';
import { authMiddleware } from '../../middlewares/authMiddleware.js';
import * as paymentController from './payment.controller.js';
const Router = express.Router();
// Create MoMo payment URL
Router.post('/momo/create', authMiddleware.isAuthorized, paymentController.createMoMo);
// Confirm MoMo payment (used by FE redirect handler)
Router.post('/momo/confirm', authMiddleware.isAuthorized, paymentController.confirmMoMo);
export const paymentRoute = Router;
//# sourceMappingURL=payment.route.js.map