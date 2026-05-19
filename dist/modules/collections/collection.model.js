var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { pool } from '../../configs/database.js';
const create = (data) => __awaiter(void 0, void 0, void 0, function* () {
    const { collection_name, collection_slug, parent_collection_id, description } = data;
    const result = yield pool.query(`
    INSERT INTO collections (collection_name, collection_slug, parent_collection_id, description)
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `, [collection_name, collection_slug, parent_collection_id, description]);
    return result.rows[0];
});
const findAll = () => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT * FROM collections ORDER BY created_at ASC
  `);
    return result.rows;
});
const findHierarchy = () => __awaiter(void 0, void 0, void 0, function* () {
    const { rows } = yield pool.query('SELECT * FROM collections ORDER BY parent_collection_id NULLS FIRST, created_at ASC');
    const map = {};
    const roots = [];
    rows.forEach((row) => {
        var _a;
        map[row.collection_id] = Object.assign(Object.assign({}, row), { children: [] });
        if (row.parent_collection_id === null) {
            roots.push(map[row.collection_id]);
        }
        else if (map[row.parent_collection_id]) {
            (_a = map[row.parent_collection_id].children) === null || _a === void 0 ? void 0 : _a.push(map[row.collection_id]);
        }
    });
    return roots;
});
const findById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query('SELECT * FROM collections WHERE collection_id = $1', [id]);
    return result.rows[0] || null;
});
const findBySlug = (slug) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query('SELECT * FROM collections WHERE collection_slug = $1', [slug]);
    return result.rows[0] || null;
});
const update = (id, data) => __awaiter(void 0, void 0, void 0, function* () {
    const entries = Object.entries(data).filter(([_, v]) => v !== undefined);
    if (entries.length === 0)
        return null;
    const fields = entries.map(([k], i) => `${k} = $${i + 1}`);
    const values = entries.map(([_, v]) => v);
    fields.push('updated_at = NOW()');
    values.push(id);
    const query = `
    UPDATE collections 
    SET ${fields.join(', ')}
    WHERE collection_id = $${values.length}
    RETURNING *
  `;
    const result = yield pool.query(query, values);
    return result.rows[0];
});
const deleteCollection = (id) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const result = yield pool.query('DELETE FROM collections WHERE collection_id = $1', [id]);
    return ((_a = result.rowCount) !== null && _a !== void 0 ? _a : 0) > 0;
});
export const collectionModel = {
    create,
    findAll,
    findHierarchy,
    findById,
    findBySlug,
    update,
    deleteCollection
};
//# sourceMappingURL=collection.model.js.map