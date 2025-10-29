import { OrderStatus } from '../constants/orders.enum.ts'

export interface OrderCreateDto {
  user_id: number,
  status: OrderStatus,
  total_amount: number,
  comment?: string
}

export interface OrderUpdateDto {
  order_id: number,
  user_id?: number,
  status?: OrderStatus,
  total_amount?: number,
  comment?: string
}

export interface OrderResponseDto {
  order_id?: number,
  user_id?: number,
  status?: OrderStatus,
  total_amount?: number,
  comment?: string,
  created_at?: Date,
  updated_at?: Date
}
