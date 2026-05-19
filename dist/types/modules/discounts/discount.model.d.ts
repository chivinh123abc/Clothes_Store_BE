import { DiscountCreateDto, DiscountResponseDto, DiscountUpdateDto } from '../types/discounts.js';
export declare const discountModel: {
    create: (data: DiscountCreateDto) => Promise<DiscountResponseDto>;
    findAll: () => Promise<DiscountResponseDto[]>;
    findById: (id: number) => Promise<DiscountResponseDto | null>;
    update: (id: number, data: DiscountUpdateDto) => Promise<DiscountResponseDto | null>;
    deleteDiscount: (id: number) => Promise<boolean>;
};
