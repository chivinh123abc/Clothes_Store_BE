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
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const correctCondition = Joi.object({
        product_id: Joi.number().min(1).required(),
        sku: Joi.string().min(4).max(255).optional(),
        stock_quantity: Joi.number().integer().min(0).required(),
        product_item_image: Joi.string().uri().optional(),
        product_item_price: Joi.number().min(0).required()
    });
    try {
        yield correctCondition.validateAsync(req.body, { abortEarly: false });
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
        product_id: Joi.number().min(1).optional(),
        sku: Joi.string().min(4).max(255).optional(),
        stock_quantity: Joi.number().integer().min(0).optional(),
        product_item_image: Joi.string().uri().optional(),
        product_item_price: Joi.number().min(0).optional()
    }).min(1);
    try {
        yield correctCondition.validateAsync(req.body, { abortEarly: false });
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
export const productItemValidation = {
    createNew
};
//# sourceMappingURL=product_item.validation.js.map