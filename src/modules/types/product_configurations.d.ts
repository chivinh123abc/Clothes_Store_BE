export interface ProductConfigurationCreateDto {
  product_item_id: number,
  variation_option_id: number,
}

export interface ProductConfigurationCheckPrimaryKeyDto {
  product_item_id: number,
  variation_option_id: number,
}
export interface ProductConfigurationResponseDto {
  product_item_id: number,
  variation_option_id: number,
}
export interface ProductConfigurationUpdateDto {
  old_product_item_id: number,
  old_variation_option_id: number,
  new_product_item_id: number,
  new_variation_option_id: number
}
