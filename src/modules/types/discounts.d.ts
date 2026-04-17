export interface DiscountCreateDto {
  name: string;
  description?: string;
  discount_percent: number;
  active?: boolean;
}

export interface DiscountUpdateDto {
  name?: string;
  description?: string;
  discount_percent?: number;
  active?: boolean;
}

export interface DiscountResponseDto {
  discount_id: number;
  name: string;
  description: string;
  discount_percent: number;
  active: boolean;
  created_at: Date;
  updated_at?: Date;
}
