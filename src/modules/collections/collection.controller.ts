import { Request, Response } from 'express'
import { collectionService } from './collection.service.js'

const create = async (req: Request, res: Response) => {
  try {
    const data = await collectionService.createCollection(req.body)
    res.status(201).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const getAll = async (req: Request, res: Response) => {
  try {
    const hierarchy = req.query.hierarchy === 'true'
    const data = hierarchy
      ? await collectionService.getCollectionHierarchy()
      : await collectionService.getAllCollections()
    res.status(200).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const getById = async (req: Request, res: Response) => {
  try {
    const data = await collectionService.getCollectionById(Number(req.params.id))
    if (!data) return res.status(404).json({ message: 'Collection not found' })
    res.status(200).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const getBySlug = async (req: Request, res: Response) => {
  try {
    const data = await collectionService.getCollectionBySlug(req.params.slug)
    if (!data) return res.status(404).json({ message: 'Collection not found' })
    res.status(200).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const update = async (req: Request, res: Response) => {
  try {
    const data = await collectionService.updateCollection(Number(req.params.id), req.body)
    if (!data) return res.status(404).json({ message: 'Collection not found' })
    res.status(200).json(data)
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

const deleteCollection = async (req: Request, res: Response) => {
  try {
    const success = await collectionService.deleteCollection(Number(req.params.id))
    if (!success) return res.status(404).json({ message: 'Collection not found' })
    res.status(200).json({ message: 'Collection deleted' })
  } catch (error: any) {
    res.status(500).json({ message: error.message })
  }
}

export const collectionController = {
  create,
  getAll,
  getById,
  getBySlug,
  update,
  deleteCollection
}
