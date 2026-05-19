import { ProductConfigurationCreateDto, ProductConfigurationResponseDto, ProductConfigurationUpdateDto } from '../types/product_configurations.js';
export declare const productConfigurationService: {
    createNew: (reqBody: ProductConfigurationCreateDto) => Promise<ProductConfigurationResponseDto>;
    update: (reqBody: ProductConfigurationUpdateDto) => Promise<ProductConfigurationResponseDto | null>;
};
