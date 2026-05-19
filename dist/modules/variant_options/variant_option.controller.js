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
import { variantOptionService } from './variant_option.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdVariantOption = yield variantOptionService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdVariantOption);
    }
    catch (error) {
        next(error);
    }
});
const getVariantOptionById = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const variant_option_id = req.body.variant_option_id;
        const foundVariantOption = yield variantOptionService.getVariantOptionById(variant_option_id);
        res.status(StatusCodes.CREATED).json(foundVariantOption);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        req.body.variant_option_id = req.body.variant_option_id;
        const updatedVariantOption = yield variantOptionService.update(req.body);
        res.status(StatusCodes.ACCEPTED).json(updatedVariantOption);
    }
    catch (error) {
        next(error);
    }
});
export const variantOptionController = {
    createNew,
    getVariantOptionById,
    update
};
//# sourceMappingURL=variant_option.controller.js.map