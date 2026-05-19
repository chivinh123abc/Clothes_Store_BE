import { CategoryCreateDto, CategoryResponseDto, CategoryUpdateDto } from '../types/categories.js';
export declare const categoryService: {
    createNew: (reqBody: CategoryCreateDto) => Promise<CategoryResponseDto>;
    getCategory: (category_id: number) => Promise<CategoryResponseDto | null>;
    updateCategory: (category_id: number, reqBody: CategoryUpdateDto) => Promise<CategoryResponseDto | null>;
    getAll: () => Promise<CategoryResponseDto[]>;
    deleteCategory: (category_id: number) => Promise<boolean>;
};
