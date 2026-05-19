import { ProductCreateDto, ProductResponseDto, ProductUpdateDto } from '../types/products.js';
export declare const productService: {
    createNew: (reqBody: ProductCreateDto) => Promise<ProductResponseDto>;
    getProduct: (product_id: number) => Promise<ProductResponseDto>;
    update: (product_id: number, reqBody: ProductUpdateDto) => Promise<ProductResponseDto | null>;
    getAll: () => Promise<ProductResponseDto[]>;
    getByCollectionSlug: (slug: string) => Promise<ProductResponseDto[]>;
    deleteProduct: (product_id: number) => Promise<boolean>;
};
