import { pool } from '../../configs/database.js'
import { CollectionCreateDto, CollectionResponseDto, CollectionUpdateDto } from '../types/collections.js'

const create = async (data: CollectionCreateDto): Promise<CollectionResponseDto> => {
  const { collection_name, collection_slug, parent_collection_id, description } = data
  const result = await pool.query(`
    INSERT INTO collections (collection_name, collection_slug, parent_collection_id, description)
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `, [collection_name, collection_slug, parent_collection_id, description])
  return result.rows[0]
}

const findAll = async (): Promise<CollectionResponseDto[]> => {
  const result = await pool.query(`
    SELECT * FROM collections ORDER BY created_at ASC
  `)
  return result.rows
}

const findHierarchy = async (): Promise<CollectionResponseDto[]> => {
  const { rows } = await pool.query('SELECT * FROM collections ORDER BY parent_collection_id NULLS FIRST, created_at ASC')

  const map: { [key: number]: CollectionResponseDto } = {}
  const roots: CollectionResponseDto[] = []

  rows.forEach((row: any) => {
    map[row.collection_id] = { ...row, children: [] }
    if (row.parent_collection_id === null) {
      roots.push(map[row.collection_id])
    } else if (map[row.parent_collection_id]) {
      map[row.parent_collection_id].children?.push(map[row.collection_id])
    }
  })

  return roots
}

const findById = async (id: number): Promise<CollectionResponseDto | null> => {
  const result = await pool.query('SELECT * FROM collections WHERE collection_id = $1', [id])
  return result.rows[0] || null
}

const findBySlug = async (slug: string): Promise<CollectionResponseDto | null> => {
  const result = await pool.query('SELECT * FROM collections WHERE collection_slug = $1', [slug])
  return result.rows[0] || null
}

const update = async (id: number, data: CollectionUpdateDto): Promise<CollectionResponseDto | null> => {
  const entries = Object.entries(data).filter(([_, v]) => v !== undefined)
  if (entries.length === 0) return null

  const fields = entries.map(([k], i) => `${k} = $${i + 1}`)
  const values = entries.map(([_, v]) => v)

  fields.push('updated_at = NOW()')
  values.push(id)

  const query = `
    UPDATE collections 
    SET ${fields.join(', ')}
    WHERE collection_id = $${values.length}
    RETURNING *
  `
  const result = await pool.query(query, values)
  return result.rows[0]
}

const deleteCollection = async (id: number): Promise<boolean> => {
  const result = await pool.query('DELETE FROM collections WHERE collection_id = $1', [id])
  return (result.rowCount ?? 0) > 0
}

export const collectionModel = {
  create,
  findAll,
  findHierarchy,
  findById,
  findBySlug,
  update,
  deleteCollection
}
