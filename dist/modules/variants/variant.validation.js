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
        category_id: Joi.number().integer().min(1).required(),
        variant_name: Joi.string().min(4).max(255).required()
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
        variant_id: Joi.number().integer().min(1).required(),
        category_id: Joi.number().integer().min(1).optional(),
        variant_name: Joi.string().min(4).max(255).optional()
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
export const variantValidation = {
    createNew,
    update
};
//# sourceMappingURL=variant.validation.js.map