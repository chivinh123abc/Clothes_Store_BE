import { CategoryCreateDto, CategoryResponseDto, CategoryUpdateDto } from '../types/categories.js';
export declare const categoryModel: {
    create: (reqBody: CategoryCreateDto) => Promise<CategoryResponseDto>;
    findCategoryById: (category_id: number) => Promise<CategoryResponseDto | null>;
    findCategoryBySlugName: (category_slug: string) => Promise<CategoryResponseDto | null>;
    update: (category_id: number, reqBody: CategoryUpdateDto) => Promise<CategoryResponseDto | null>;
    findAll: () => Promise<CategoryResponseDto[]>;
    deleteCategory: (category_id: number) => Promise<boolean>;
};
