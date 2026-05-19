import { ProductResponseDto } from '../types/products.js';
export declare const productModel: {
    create: (reqBody: any) => Promise<ProductResponseDto>;
    findProductById: (product_id: number) => Promise<ProductResponseDto | null>;
    findProductBySlug: (product_slug: string) => Promise<ProductResponseDto | null>;
    update: (product_id: number, reqBody: any) => Promise<ProductResponseDto | null>;
    findAll: () => Promise<ProductResponseDto[]>;
    getByCollectionSlug: (slug: string) => Promise<ProductResponseDto[]>;
    deleteProduct: (product_id: number) => Promise<boolean>;
};
