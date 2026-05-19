import { CollectionCreateDto, CollectionUpdateDto } from '../types/collections.js';
export declare const collectionService: {
    createCollection: (data: CollectionCreateDto) => Promise<import("../types/collections.js").CollectionResponseDto>;
    getAllCollections: () => Promise<import("../types/collections.js").CollectionResponseDto[]>;
    getCollectionHierarchy: () => Promise<import("../types/collections.js").CollectionResponseDto[]>;
    getCollectionById: (id: number) => Promise<import("../types/collections.js").CollectionResponseDto | null>;
    getCollectionBySlug: (slug: string) => Promise<import("../types/collections.js").CollectionResponseDto | null>;
    updateCollection: (id: number, data: CollectionUpdateDto) => Promise<import("../types/collections.js").CollectionResponseDto | null>;
    deleteCollection: (id: number) => Promise<boolean>;
};
