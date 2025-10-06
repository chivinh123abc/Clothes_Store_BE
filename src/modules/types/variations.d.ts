export interface VariationCreateDto {
  category_id: number,
  variation_name: string,
  variation_slug: string
}

export interface VariationUpdateDto {
  variation_id: number,
  category_id?: number,
  variation_name?: string,
  variation_slug?: string
}

export interface VariationResponseDto {
  variation_id?: number,
  category_id?: number,
  variation_name?: string,
  variation_slug?: string,
  created_at?: Date,
  updated_at?: Date
}
