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
export const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const correctCondition = Joi.object({
        username: Joi.string().min(8).max(255).pattern(/^[^@]+$/).required().messages({
            'string.pattern.base': 'Username cannot contain the "@" symbol.'
        }),
        email: Joi.string().email().required(),
        password: Joi.string().min(6).required(),
        phone_number: Joi.string().pattern(/^[0-9\s]+$/).optional().messages({
            'string.pattern.base': 'Phone number can only contain digits and spaces.'
        }),
        avatar: Joi.string().uri().optional(),
        display_name: Joi.string().max(255).optional(),
        full_name: Joi.string().max(255).optional(),
        address: Joi.string().optional()
    });
    try {
        yield correctCondition.validateAsync(req.body, { abortEarly: false });
        next();
    }
    catch (error) {
        let errorMessage = 'Unaccepted Input';
        if (error instanceof Error) {
            errorMessage = error.message;
        }
        else if (typeof error === 'string') {
            errorMessage = error;
        }
        next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage));
    }
});
export const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const correctCondition = Joi.object({
        username: Joi.string().min(8).max(255).pattern(/^[^@]+$/).optional().messages({
            'string.pattern.base': 'Username cannot contain the "@" symbol.'
        }),
        email: Joi.string().email().optional(),
        password: Joi.string().min(6).optional(),
        phone_number: Joi.string().pattern(/^[0-9\s]+$/).optional().messages({
            'string.pattern.base': 'Phone number can only contain digits and spaces.'
        }),
        avatar: Joi.string().uri().optional(),
        display_name: Joi.string().max(255).allow('', null).optional(),
        full_name: Joi.string().max(255).allow('', null).optional(),
        address: Joi.string().allow('', null).optional()
    }).min(1);
    try {
        yield correctCondition.validateAsync(req.body, { abortEarly: false });
        next();
    }
    catch (error) {
        let errorMessage = 'Unaccepted Input';
        if (error instanceof Error) {
            errorMessage = error.message;
        }
        else if (typeof error == 'string') {
            errorMessage = error;
        }
        next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage));
    }
});
export const verifyAccount = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const correctCondition = Joi.object({
        email: Joi.string().email().required(),
        verify_token: Joi.string().required()
    });
    try {
        yield correctCondition.validateAsync(req.body, { abortEarly: false });
        next();
    }
    catch (error) {
        let errorMessage = 'Unaccepted Input';
        if (error instanceof Error) {
            errorMessage = error.message;
        }
        else if (typeof error == 'string') {
            errorMessage = error;
        }
        next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage));
    }
});
export const login = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const correctCondition = Joi.object({
        identifier: Joi.string().required(),
        password: Joi.string().min(6).required()
    });
    try {
        yield correctCondition.validateAsync(req.body, { abortEarly: false });
        next();
    }
    catch (error) {
        let errorMessage = 'Unaccepted Input';
        if (error instanceof Error) {
            errorMessage = error.message;
        }
        else if (typeof error == 'string') {
            errorMessage = error;
        }
        next(new ApiError(StatusCodes.UNPROCESSABLE_ENTITY, errorMessage));
    }
});
export const userValidation = {
    createNew,
    update,
    verifyAccount,
    login
};
//# sourceMappingURL=user.validation.js.map