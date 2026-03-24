export interface variantOptionCreateDto {
  variant_id: number,
  variant_option_value: string,
  variant_option_slug: string
}

export interface variantOptionUpdateDto {
  variant_option_id: number,
  variant_id?: number,
  variant_option_value?: string
  variant_option_slug?: string
}

export interface variantOptionResponseDto {
  variant_option_id?: number,
  variant_id?: number,
  variant_option_value?: string,
  variant_option_slug?: string,
  created_at?: Date,
  updated_at?: Date
}
