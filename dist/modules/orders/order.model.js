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
    const indexs = createdEntries.map(([_], index) => `$${index + 1}`);
    const values = createdEntries.map(([_, v]) => v);
    const queryData = `
    INSERT INTO orders(${fields.join(', ')})
    VALUES (${indexs.join(', ')})
    RETURNING *
  `;
    const result = yield pool.query(queryData, values);
    return result.rows[0];
});
const findOrderById = (order_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT o.*, u.username as user_name, u.email as user_email, u.full_name, u.address as user_address, u.phone_number as user_phone
      FROM orders o
      LEFT JOIN users u ON o.user_id = u.user_id
      WHERE o.order_id = $1
    `, [order_id]);
    return result.rows[0] || null;
});
const findAllOrderByUserId = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT *
      FROM orders
      WHERE user_id = $1
      ORDER BY created_at DESC
    `, [user_id]);
    return result.rows;
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const updatedEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined && k !== 'order_id');
    if (updatedEntries.length === 0) {
        return null;
    }
    const fields = updatedEntries.map(([k], index) => `${k} = $${index + 1}`);
    const values = updatedEntries.map(([_, v]) => v);
    fields.push('updated_at = NOW()');
    values.push(reqBody.order_id);
    const querryData = `
    UPDATE orders
    SET ${fields.join(', ')}
    WHERE order_id = $${updatedEntries.length + 1}
    RETURNING *
  `;
    const result = yield pool.query(querryData, values);
    return result.rows[0];
});
const findAllOrders = () => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT o.*, u.username as user_name, u.email as user_email
      FROM orders o
      LEFT JOIN users u ON o.user_id = u.user_id
      ORDER BY o.created_at DESC
    `);
    return result.rows;
});
const deleteOrder = (order_id) => __awaiter(void 0, void 0, void 0, function* () {
    yield pool.query(`
    DELETE FROM orders
    WHERE order_id = $1
  `, [order_id]);
});
export const orderModel = {
    create,
    update,
    findOrderById,
    findAllOrderByUserId,
    findAllOrders,
    deleteOrder
};
//# sourceMappingURL=order.model.js.map