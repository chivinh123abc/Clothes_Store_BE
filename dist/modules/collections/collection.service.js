var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { slugify } from '../../utils/formatters.js';
import { collectionModel } from './collection.model.js';
const createCollection = (data) => __awaiter(void 0, void 0, void 0, function* () {
    const reqBody = Object.assign({}, data);
    reqBody.collection_slug = slugify(reqBody.collection_name);
    return yield collectionModel.create(reqBody);
});
const getAllCollections = () => __awaiter(void 0, void 0, void 0, function* () {
    return yield collectionModel.findAll();
});
const getCollectionHierarchy = () => __awaiter(void 0, void 0, void 0, function* () {
    return yield collectionModel.findHierarchy();
});
const getCollectionById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    return yield collectionModel.findById(id);
});
const getCollectionBySlug = (slug) => __awaiter(void 0, void 0, void 0, function* () {
    return yield collectionModel.findBySlug(slug);
});
const updateCollection = (id, data) => __awaiter(void 0, void 0, void 0, function* () {
    const reqBody = Object.assign({}, data);
    if (reqBody.collection_name) {
        reqBody.collection_slug = slugify(reqBody.collection_name);
    }
    return yield collectionModel.update(id, reqBody);
});
const deleteCollection = (id) => __awaiter(void 0, void 0, void 0, function* () {
    return yield collectionModel.deleteCollection(id);
});
export const collectionService = {
    createCollection,
    getAllCollections,
    getCollectionHierarchy,
    getCollectionById,
    getCollectionBySlug,
    updateCollection,
    deleteCollection
};
//# sourceMappingURL=collection.service.js.map