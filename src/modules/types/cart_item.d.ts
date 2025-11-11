export interface CartItemCreateDto {
  cart_item_id: number,
  cart_id: number,
  product_item_id: number,
  quantity: number,
  price: number
}

export interface CartItemReponseDto {
  cart_item_id?: number,
  cart_id?: number,
  product_item_id?: number,
  quantity?: number,
  price?: number,
  created_at?: Date,
  updated_at?: Date
}
