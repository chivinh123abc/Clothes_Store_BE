import { variantOptionCreateDto, variantOptionResponseDto, variantOptionUpdateDto } from '../types/variant_options.js';
export declare const variantOptionModel: {
    create: (reqBody: variantOptionCreateDto) => Promise<variantOptionResponseDto>;
    getVariantOptionById: (variant_option_id: number) => Promise<variantOptionResponseDto | null>;
    getVariantOptionBySlug: (variant_option_slug: string) => Promise<variantOptionResponseDto | null>;
    update: (reqBody: variantOptionUpdateDto) => Promise<variantOptionResponseDto | null>;
};
