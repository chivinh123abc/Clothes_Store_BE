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
import { orderItemService } from './order_item.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdOrderItem = yield orderItemService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdOrderItem);
    }
    catch (error) {
        next(error);
    }
});
const getOrderItemById = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const orderItemId = req.body.order_item_id;
        const gotOrderItem = yield orderItemService.getOrderItemById(orderItemId);
        res.status(StatusCodes.ACCEPTED).json(gotOrderItem);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const updatedOrderItem = yield orderItemService.update(req.body);
        res.status(StatusCodes.ACCEPTED).json(updatedOrderItem);
    }
    catch (error) {
        next(error);
    }
});
export const orderItemController = {
    createNew,
    getOrderItemById,
    update
};
//# sourceMappingURL=order_item.controller.js.map