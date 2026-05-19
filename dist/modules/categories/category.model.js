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
const create = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      INSERT INTO categories (category_name, category_slug, category_description)
      VALUES ($1, $2, $3)
      RETURNING category_id, category_name, category_slug, category_description, created_at, updated_at
    `, [reqBody.category_name, reqBody.category_slug, reqBody.category_description || '']);
    return result.rows[0];
});
const findCategoryById = (category_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT *
    FROM categories
    WHERE category_id = $1
    `, [category_id]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
const findCategoryBySlugName = (category_slug) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT *
    FROM categories
    WHERE category_slug = $1
    `, [category_slug]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
const update = (category_id, reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const updatedEntries = Object.entries(reqBody).filter(([_, value]) => value !== undefined);
    if (updatedEntries.length === 0) {
        return null;
    }
    const fields = updatedEntries.map(([key, _], index) => `${key} = $${index + 1}`);
    const values = updatedEntries.map(([_, value]) => value);
    fields.push('updated_at = NOW()');
    values.push(category_id);
    const queryData = `
    UPDATE categories
    SET ${fields.join(', ')}
    WHERE category_id = $${updatedEntries.length + 1}
    RETURNING category_id, category_name, category_slug, category_description, created_at, updated_at
  `;
    const result = yield pool.query(queryData, values);
    return result.rows[0];
});
const findAll = () => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT *
    FROM categories
    ORDER BY created_at ASC
  `);
    return result.rows;
});
const deleteCategory = (category_id) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const result = yield pool.query(`
    DELETE FROM categories
    WHERE category_id = $1
    `, [category_id]);
    return ((_a = result.rowCount) !== null && _a !== void 0 ? _a : 0) > 0;
});
export const categoryModel = {
    create,
    findCategoryById,
    findCategoryBySlugName,
    update,
    findAll,
    deleteCategory
};
//# sourceMappingURL=category.model.js.map