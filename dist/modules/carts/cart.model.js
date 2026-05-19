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
    const createdEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined);
    const fields = createdEntries.map(([k]) => k);
    const indexs = createdEntries.map((_, index) => `$${index + 1}`);
    const values = createdEntries.map(([_, v]) => v);
    const queryData = `
    INSERT INTO carts(${fields.join(', ')})
    VALUES (${indexs.join(', ')})
    RETURNING *
  `;
    const result = yield pool.query(queryData, values);
    return result.rows[0];
});
const getCartById = (cart_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT *
      FROM carts
      WHERE cart_id = $1
    `, [cart_id]);
    return result.rows[0] || null;
});
export const cartModel = {
    create,
    getCartById
};
//# sourceMappingURL=cart.model.js.map