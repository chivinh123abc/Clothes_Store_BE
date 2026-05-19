import { variantCreateDto, variantResponseDto, variantUpdateDto } from '../types/variants.js';
export declare const variantService: {
    createNew: (reqBody: variantCreateDto) => Promise<variantResponseDto>;
    getVaration: (variant_id: number) => Promise<variantResponseDto>;
    update: (reqBody: variantUpdateDto) => Promise<variantResponseDto>;
};
