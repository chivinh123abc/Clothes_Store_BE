var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { collectionService } from './collection.service.js';
const create = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield collectionService.createCollection(req.body);
        res.status(201).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const getAll = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const hierarchy = req.query.hierarchy === 'true';
        const data = hierarchy
            ? yield collectionService.getCollectionHierarchy()
            : yield collectionService.getAllCollections();
        res.status(200).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const getById = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield collectionService.getCollectionById(Number(req.params.id));
        if (!data)
            return res.status(404).json({ message: 'Collection not found' });
        res.status(200).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const getBySlug = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield collectionService.getCollectionBySlug(req.params.slug);
        if (!data)
            return res.status(404).json({ message: 'Collection not found' });
        res.status(200).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const update = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const data = yield collectionService.updateCollection(Number(req.params.id), req.body);
        if (!data)
            return res.status(404).json({ message: 'Collection not found' });
        res.status(200).json(data);
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
const deleteCollection = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const success = yield collectionService.deleteCollection(Number(req.params.id));
        if (!success)
            return res.status(404).json({ message: 'Collection not found' });
        res.status(200).json({ message: 'Collection deleted' });
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }
});
export const collectionController = {
    create,
    getAll,
    getById,
    getBySlug,
    update,
    deleteCollection
};
//# sourceMappingURL=collection.controller.js.map