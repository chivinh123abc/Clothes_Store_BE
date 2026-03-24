export interface ProductConfigurationCreateDto {
  product_item_id: number,
  variant_option_id: number,
}

export interface ProductConfigurationCheckPrimaryKeyDto {
  product_item_id: number,
  variant_option_id: number,
}
export interface ProductConfigurationResponseDto {
  product_item_id: number,
  variant_option_id: number,
}
export interface ProductConfigurationUpdateDto {
  old_product_item_id: number,
  old_variant_option_id: number,
  new_product_item_id: number,
  new_variant_option_id: number
}
