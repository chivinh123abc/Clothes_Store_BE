import { DiscountCreateDto, DiscountUpdateDto } from '../types/discounts.js';
export declare const discountService: {
    createDiscount: (data: DiscountCreateDto) => Promise<import("../types/discounts.js").DiscountResponseDto>;
    getAllDiscounts: () => Promise<import("../types/discounts.js").DiscountResponseDto[]>;
    getDiscountById: (id: number) => Promise<import("../types/discounts.js").DiscountResponseDto | null>;
    updateDiscount: (id: number, data: DiscountUpdateDto) => Promise<import("../types/discounts.js").DiscountResponseDto | null>;
    deleteDiscount: (id: number) => Promise<boolean>;
};
