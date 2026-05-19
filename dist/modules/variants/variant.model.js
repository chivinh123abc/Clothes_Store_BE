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
    INSERT INTO variants (category_id, variant_name, variant_slug)
    VALUES ($1, $2, $3)
    RETURNING *
    `, [reqBody.category_id, reqBody.variant_name, reqBody.variant_slug]);
    return result.rows[0];
});
const getVariantById = (variant_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT *
      FROM variants
      WHERE variant_id = $1
    `, [variant_id]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
const getVariantBySlug = (variant_slug) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT *
      FROM variants
      WHERE variant_slug = $1
    `, [variant_slug]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const updatedEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined && k !== 'variant_id');
    if (updatedEntries.length === 0) {
        return null;
    }
    const fields = updatedEntries.map(([key, _], index) => `${key} = $${index + 1}`);
    const values = updatedEntries.map(([_, value]) => value);
    fields.push('updated_at = NOW()');
    values.push(reqBody.variant_id);
    const queryData = `
    UPDATE variants
    SET ${fields.join(', ')}
    WHERE variant_id = $${updatedEntries.length + 1}
    RETURNING *
  `;
    const result = yield pool.query(queryData, values);
    return result.rows.length > 0 ? result.rows[0] : null;
});
export const variantModel = {
    create,
    update,
    getVariantById,
    getVariantBySlug
};
//# sourceMappingURL=variant.model.js.map