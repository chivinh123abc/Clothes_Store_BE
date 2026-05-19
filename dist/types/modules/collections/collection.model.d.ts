import { CollectionCreateDto, CollectionResponseDto, CollectionUpdateDto } from '../types/collections.js';
export declare const collectionModel: {
    create: (data: CollectionCreateDto) => Promise<CollectionResponseDto>;
    findAll: () => Promise<CollectionResponseDto[]>;
    findHierarchy: () => Promise<CollectionResponseDto[]>;
    findById: (id: number) => Promise<CollectionResponseDto | null>;
    findBySlug: (slug: string) => Promise<CollectionResponseDto | null>;
    update: (id: number, data: CollectionUpdateDto) => Promise<CollectionResponseDto | null>;
    deleteCollection: (id: number) => Promise<boolean>;
};
