import { variantCreateDto, variantResponseDto, variantUpdateDto } from '../types/variants.js';
export declare const variantModel: {
    create: (reqBody: variantCreateDto) => Promise<variantResponseDto>;
    update: (reqBody: variantUpdateDto) => Promise<variantResponseDto | null>;
    getVariantById: (variant_id: number) => Promise<variantResponseDto | null>;
    getVariantBySlug: (variant_slug: string) => Promise<variantResponseDto | null>;
};
