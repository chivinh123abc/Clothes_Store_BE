import { CollectionCreateDto, CollectionUpdateDto } from '../types/collections.js'
import { collectionModel } from './collection.model.js'

const createCollection = async (data: CollectionCreateDto) => {
  return await collectionModel.create(data)
}

const getAllCollections = async () => {
  return await collectionModel.findAll()
}

const getCollectionHierarchy = async () => {
  return await collectionModel.findHierarchy()
}

const getCollectionById = async (id: number) => {
  return await collectionModel.findById(id)
}

const getCollectionBySlug = async (slug: string) => {
  return await collectionModel.findBySlug(slug)
}

const updateCollection = async (id: number, data: CollectionUpdateDto) => {
  return await collectionModel.update(id, data)
}

const deleteCollection = async (id: number) => {
  return await collectionModel.deleteCollection(id)
}

export const collectionService = {
  createCollection,
  getAllCollections,
  getCollectionHierarchy,
  getCollectionById,
  getCollectionBySlug,
  updateCollection,
  deleteCollection
}
