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
// CREATE da xong
const create = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const updatedEntries = Object.entries(reqBody).filter(([_, v]) => v !== undefined);
    const columns = updatedEntries.map(([key]) => key);
    const placeholders = updatedEntries.map((_, index) => `$${index + 1}`);
    const values = updatedEntries.map(([_, value]) => value);
    const query = `
    INSERT INTO users (${columns.join(', ')})
    VALUES (${placeholders.join(', ')})
    RETURNING user_id, username, email, phone_number, role, status, avatar, created_at, updated_at, is_active, address, display_name, full_name
  `;
    const result = yield pool.query(query, values);
    return result.rows[0];
});
//Ham nay ok
const findUserByEmail = (email) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT user_id, username, password, email, phone_number, role, status, avatar, created_at, updated_at, is_active, is_destroy, verify_token, address, display_name, full_name
      FROM users
      WHERE email = $1 AND is_destroy = false
    `, [email]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
const findUserByIdentifier = (identifier) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT user_id, username, password, email, phone_number, role, status, avatar, created_at, updated_at, is_active, is_destroy, verify_token, address, display_name, full_name
      FROM users
      WHERE (email = $1 OR username = $1) AND is_destroy = false
    `, [identifier]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
//Ham nay ok not
const findUserById = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT user_id, username, password, email, phone_number, role, status, avatar, created_at, updated_at, is_active, is_destroy, verify_token, address, display_name, full_name
      FROM users
      WHERE user_id = $1 AND is_destroy = false
    `, [user_id]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
const update = (user_id, reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const updatedEntries = Object.entries(reqBody).filter(([_, v]) => v !== undefined);
    if (updatedEntries.length === 0) {
        return null;
    }
    const fields = updatedEntries.map(([key], index) => `${key} = $${index + 1}`);
    const values = updatedEntries.map(([_, value]) => value);
    fields.push('updated_at = NOW()');
    values.push(user_id);
    const queryData = `
    UPDATE users
    SET ${fields.join(', ')}
    WHERE user_id = $${updatedEntries.length + 1}
    RETURNING user_id, username, email, phone_number, avatar, created_at, updated_at, is_destroy, is_active, status, verify_token, address, display_name, full_name
    `;
    const result = yield pool.query(queryData, values);
    return result.rows[0] || null;
});
const softDelete = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    UPDATE users
    SET is_destroy = $1
    WHERE user_id = $2
    RETURNING user_id, is_destroy
    `, [true, user_id]);
    return result.rows[0] || false;
});
const findAll = () => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT user_id, username, email, phone_number, role, avatar, created_at, updated_at, is_active, is_destroy, status, verify_token, address, display_name, full_name
    FROM users
    ORDER BY created_at DESC
    `);
    return result.rows;
});
const adminDelete = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const result = yield pool.query(`
    DELETE FROM users
    WHERE user_id = $1
    `, [user_id]);
    return ((_a = result.rowCount) !== null && _a !== void 0 ? _a : 0) > 0;
});
export const userModel = {
    create,
    findUserById,
    findUserByEmail,
    findUserByIdentifier,
    update,
    softDelete,
    findAll,
    adminDelete
};
//# sourceMappingURL=user.model.js.map