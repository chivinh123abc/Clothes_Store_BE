import { variantOptionCreateDto, variantOptionResponseDto, variantOptionUpdateDto } from '../types/variant_options.js';
export declare const variantOptionService: {
    createNew: (reqBody: variantOptionCreateDto) => Promise<variantOptionResponseDto>;
    getVariantOptionById: (variant_option_id: number) => Promise<variantOptionResponseDto>;
    update: (reqBody: variantOptionUpdateDto) => Promise<variantOptionResponseDto>;
};
