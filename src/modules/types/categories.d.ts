export interface CategoryResponseDto {
  category_id?: number
  category_name?: string
  category_slug?: string
  category_description?: string
  created_at?: Date
  updated_at?: Date
}

export interface CategoryCreateDto {
  category_name: string
  category_slug: string
  category_description?: string
}

export interface CategoryUpdateDto {
  category_id: number
  category_name: string
  category_slug: string
  category_description?: string
}
