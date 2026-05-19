import { ProductItemCreateDto, ProductItemResponseDto, ProductItemUpdateDto } from '../types/product_items.js';
export declare const productItemModel: {
    create: (reqBody: ProductItemCreateDto) => Promise<ProductItemResponseDto>;
    findProductItemById: (product_item_id: number) => Promise<ProductItemResponseDto | null>;
    update: (reqBody: ProductItemUpdateDto) => Promise<ProductItemResponseDto | null>;
    findProductItemBySKU: (sku: string) => Promise<ProductItemResponseDto | null>;
};
