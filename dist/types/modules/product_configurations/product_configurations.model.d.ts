import { ProductConfigurationCheckPrimaryKeyDto, ProductConfigurationCreateDto, ProductConfigurationResponseDto, ProductConfigurationUpdateDto } from '../types/product_configurations.js';
export declare const productConfigurationModel: {
    create: (reqBody: ProductConfigurationCreateDto) => Promise<ProductConfigurationResponseDto>;
    isExistPrimaryKey: (reqBody: ProductConfigurationCheckPrimaryKeyDto) => Promise<boolean>;
    update: (reqBody: ProductConfigurationUpdateDto) => Promise<ProductConfigurationResponseDto | null>;
};
