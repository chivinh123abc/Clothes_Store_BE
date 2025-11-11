export interface OrderItemCreateDto {
  order_id: number,
  product_item_id: number,
  quantity: number,
  unit_price: number
}

export interface OrderItemUpdateDto {
  order_item_id: number,
  // order_id?: number,
  // product_item_id?: number,
  quantity?: number,
  // unit_price?: number
}

export interface OrderItemGetDto {
  order_item_id: number
}

export interface OrderItemResponseDto {
  order_item_id?: number,
  order_id?: number,
  product_item_id?: number,
  quantity?: number,
  unit_price?: number,
  created_at?: Date,
  updated_at?: Date
}
