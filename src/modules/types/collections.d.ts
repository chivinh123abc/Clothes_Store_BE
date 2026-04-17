export interface CollectionCreateDto {
  collection_name: string;
  collection_slug: string;
  parent_collection_id?: number | null;
  description?: string;
}

export interface CollectionUpdateDto {
  collection_name?: string;
  collection_slug?: string;
  parent_collection_id?: number | null;
  description?: string;
}

export interface CollectionResponseDto {
  collection_id: number;
  collection_name: string;
  collection_slug: string;
  parent_collection_id: number | null;
  description: string;
  created_at: Date;
  updated_at?: Date;
  children?: CollectionResponseDto[];
}
