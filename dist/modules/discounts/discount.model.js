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
    const { name, description, discount_percent, active } = data;
    const result = yield pool.query(`
    INSERT INTO discounts (name, description, discount_percent, active)
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `, [name, description, discount_percent, active !== null && active !== void 0 ? active : true]);
    return result.rows[0];
});
const findAll = () => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query('SELECT * FROM discounts ORDER BY created_at DESC');
    return result.rows;
});
const findById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query('SELECT * FROM discounts WHERE discount_id = $1', [id]);
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
    UPDATE discounts SET ${fields.join(', ')} WHERE discount_id = $${values.length} RETURNING *
  `;
    const result = yield pool.query(query, values);
    return result.rows[0];
});
const deleteDiscount = (id) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const result = yield pool.query('DELETE FROM discounts WHERE discount_id = $1', [id]);
    return ((_a = result.rowCount) !== null && _a !== void 0 ? _a : 0) > 0;
});
export const discountModel = {
    create,
    findAll,
    findById,
    update,
    deleteDiscount
};
//# sourceMappingURL=discount.model.js.map