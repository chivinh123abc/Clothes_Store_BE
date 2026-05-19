var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { discountModel } from './discount.model.js';
const createDiscount = (data) => __awaiter(void 0, void 0, void 0, function* () {
    return yield discountModel.create(data);
});
const getAllDiscounts = () => __awaiter(void 0, void 0, void 0, function* () {
    return yield discountModel.findAll();
});
const getDiscountById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    return yield discountModel.findById(id);
});
const updateDiscount = (id, data) => __awaiter(void 0, void 0, void 0, function* () {
    return yield discountModel.update(id, data);
});
const deleteDiscount = (id) => __awaiter(void 0, void 0, void 0, function* () {
    return yield discountModel.deleteDiscount(id);
});
export const discountService = {
    createDiscount,
    getAllDiscounts,
    getDiscountById,
    updateDiscount,
    deleteDiscount
};
//# sourceMappingURL=discount.service.js.map