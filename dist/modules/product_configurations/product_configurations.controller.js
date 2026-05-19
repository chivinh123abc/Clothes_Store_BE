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
import { productConfigurationService } from './product_configurations.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdProductConfiguration = yield productConfigurationService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdProductConfiguration);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const updatedProductConfiguration = yield productConfigurationService.update(req.body);
        res.status(StatusCodes.CREATED).json(updatedProductConfiguration);
    }
    catch (error) {
        next(error);
    }
});
export const productConfigurationController = {
    createNew,
    update
};
//# sourceMappingURL=product_configurations.controller.js.map