import { ProductItemCreateDto, ProductItemResponseDto, ProductItemUpdateDto } from '../types/product_items.js';
export declare const productItemService: {
    createNew: (reqBody: ProductItemCreateDto) => Promise<ProductItemResponseDto>;
    getProductItem: (product_item_id: number) => Promise<ProductItemResponseDto | null>;
    update: (reqBody: ProductItemUpdateDto) => Promise<ProductItemResponseDto | null>;
};
