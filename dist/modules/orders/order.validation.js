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
import Joi from 'joi';
import ApiError from '../../utils/ApiError.js';
import { OrderStatus } from '../constants/orders.enum.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const correctCondition = Joi.object({
        user_id: Joi.number().integer().min(1).required(),
        status: Joi.string().valid(...Object.values(OrderStatus)).default(OrderStatus.PENDING),
        total_amount: Joi.number().precision(2).min(0).default(0),
        payment_method: Joi.string().min(2).max(50).default('cod'),
        payment_status: Joi.string().valid('unpaid', 'paid').default('unpaid'),
        comment: Joi.string().min(5).max(255).optional()
    });
    try {
        req.body = yield correctCondition.validateAsync(req.body);
        next();
    }
    catch (error) {
        let errorMessage = 'Unaccepted input';
        if (error instanceof Error) {
            errorMessage = error.message;
        }
        else if (typeof error === 'string') {
            errorMessage = error;
        }
        next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage));
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const correctCondition = Joi.object({
        order_id: Joi.number().integer().min(1).required(),
        user_id: Joi.number().integer().min(1).optional(),
        status: Joi.string().valid(...Object.values(OrderStatus)).optional(),
        total_amount: Joi.number().precision(2).min(0).optional(),
        payment_method: Joi.string().min(2).max(50).optional(),
        payment_status: Joi.string().valid('unpaid', 'paid').optional(),
        comment: Joi.string().min(5).max(255).optional()
    }).min(1);
    try {
        req.body = yield correctCondition.validateAsync(req.body);
        next();
    }
    catch (error) {
        let errorMessage = 'Unaccepted input';
        if (error instanceof Error) {
            errorMessage = error.message;
        }
        else if (typeof error === 'string') {
            errorMessage = error;
        }
        next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage));
    }
});
export const orderValidation = {
    createNew,
    update
};
//# sourceMappingURL=order.validation.js.map