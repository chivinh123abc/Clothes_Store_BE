export interface variantCreateDto {
  category_id: number,
  variant_name: string,
  variant_slug: string
}

export interface variantUpdateDto {
  variant_id: number,
  category_id?: number,
  variant_name?: string,
  variant_slug?: string
}

export interface variantResponseDto {
  variant_id?: number,
  category_id?: number,
  variant_name?: string,
  variant_slug?: string,
  created_at?: Date,
  updated_at?: Date
}
