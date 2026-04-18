export interface ProductCreateDto {
  product_name: string,
  product_slug: string,
  product_description?: string,
  is_featured?: boolean,
  is_bestseller?: boolean,
  category_id: number
}

export interface ProductUpdateDto {
  product_id: number
  product_name?: string,
  product_slug?: string,
  product_description?: string,
  is_featured?: boolean,
  is_bestseller?: boolean,
  category_id?: number
}

export interface ProductResponseDto {
  product_id?: number,
  product_name?: string,
  product_slug?: string,
  product_description?: string,
  is_featured?: boolean,
  is_bestseller?: boolean,
  category_id?: number,
  category_name?: string,
  created_at?: Date,
  updated_at?: Date,
  items?: any[]
}
