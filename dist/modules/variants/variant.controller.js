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
import { variantService } from './variant.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const result = yield variantService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(result);
    }
    catch (error) {
        next(error);
    }
});
const getVariant = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const variant_id = req.body.variant_id;
        const result = yield variantService.getVaration(variant_id);
        res.status(StatusCodes.CREATED).json(result);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        req.body.variant_id = req.body.variant_id;
        const result = yield variantService.update(req.body);
        res.status(StatusCodes.CREATED).json(result);
    }
    catch (error) {
        next(error);
    }
});
export const variantController = {
    createNew,
    getVariant,
    update
};
//# sourceMappingURL=variant.controller.js.map