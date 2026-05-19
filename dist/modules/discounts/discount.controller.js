var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { discountService } from './discount.service.js';
const create = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield discountService.createDiscount(req.body);
        res.status(201).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const getAll = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield discountService.getAllDiscounts();
        res.status(200).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const getById = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield discountService.getDiscountById(Number(req.params.id));
        if (!data)
            return res.status(404).json({ message: 'Discount not found' });
        res.status(200).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const update = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield discountService.updateDiscount(Number(req.params.id), req.body);
        if (!data)
            return res.status(404).json({ message: 'Discount not found' });
        res.status(200).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const deleteDiscount = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const success = yield discountService.deleteDiscount(Number(req.params.id));
        if (!success)
            return res.status(404).json({ message: 'Discount not found' });
        res.status(200).json({ message: 'Discount deleted' });
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
export const discountController = {
    create,
    getAll,
    getById,
    update,
    deleteDiscount
};
//# sourceMappingURL=discount.controller.js.map