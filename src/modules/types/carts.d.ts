export interface CartCreateDto {
  user_id: number
}

export interface CartResponseDto {
  cart_id?: number,
  user_id?: number,
  created_at?: Date,
  updated_at?: Date
}
