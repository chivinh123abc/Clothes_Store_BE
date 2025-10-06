export interface VariationOptionCreateDto {
  variation_id: number,
  variation_option_value: string,
  variation_option_slug: string
}

export interface VariationOptionUpdateDto {
  variation_option_id: number,
  variation_id?: number,
  variation_option_value?: string
  variation_option_slug?: string
}

export interface VariationOptionResponseDto {
  variation_option_id?: number,
  variation_id?: number,
  variation_option_value?: string,
  variation_option_slug?: string,
  created_at?: Date,
  updated_at?: Date
}
