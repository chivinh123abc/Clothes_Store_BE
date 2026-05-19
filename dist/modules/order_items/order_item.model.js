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
    const indexs = createdEntries.map(([], index) => `$${index + 1}`);
    const values = createdEntries.map(([_, v]) => v);
    const queryData = `
    INSERT INTO order_items(${fields.join(', ')})
    VALUES(${indexs.join(', ')})
    RETURNING *
    `;
    const result = yield pool.query(queryData, values);
    return result.rows[0];
});
const getOrderItemById = (order_item_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT *
    FROM order_items
    WHERE order_item_id = $1
  `, [order_item_id]);
    return result.rows[0] || null;
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const updatedEntries = Object.entries(reqBody).filter(([k, v]) => v !== undefined && k !== 'order_item_id');
    const fields = updatedEntries.map(([k], index) => `${k} = $${index + 1}`);
    const values = updatedEntries.map(([_, v]) => v);
    fields.push('updated_at = NOW()');
    values.push(reqBody.order_item_id);
    const queryData = `
    UPDATE order_items
    SET ${fields.join(', ')}
    WHERE order_item_id = $${updatedEntries.length + 1}
    RETURNING *
  `;
    const result = yield pool.query(queryData, values);
    return result.rows[0] || null;
});
const findAllByOrderId = (order_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT 
      oi.*, 
      p.product_id as product_id,
      pi.product_item_image as image, 
      pi.product_item_image as product_item_image,
      p.product_name as name, 
      p.product_name as product_name,
      COALESCE(
        CASE 
          WHEN d.active = true AND d.discount_percent IS NOT NULL 
          THEN pi.product_item_price * (1 - d.discount_percent::float/100)
          ELSE NULL
        END,
        oi.unit_price,
        pi.product_item_price
      ) as unit_price,
      COALESCE(
        CASE 
          WHEN d.active = true AND d.discount_percent IS NOT NULL 
          THEN pi.product_item_price * (1 - d.discount_percent::float/100)
          ELSE NULL
        END,
        oi.unit_price,
        pi.product_item_price
      ) as price,
      COALESCE(
        CASE 
          WHEN d.active = true AND d.discount_percent IS NOT NULL 
          THEN pi.product_item_price * (1 - d.discount_percent::float/100)
          ELSE NULL
        END,
        oi.unit_price,
        pi.product_item_price
      ) as product_item_price,
      vo.variant_option_value as size
    FROM order_items oi
    JOIN product_items pi ON oi.product_item_id = pi.product_item_id
    JOIN products p ON pi.product_id = p.product_id
    LEFT JOIN discounts d ON pi.discount_id = d.discount_id
    LEFT JOIN product_configurations pc ON pi.product_item_id = pc.product_item_id
    LEFT JOIN variant_options vo ON pc.variant_option_id = vo.variant_option_id
    WHERE oi.order_id = $1
  `, [order_id]);
    return result.rows;
});
export const orderItemModel = {
    create,
    getOrderItemById,
    update,
    findAllByOrderId
};
//# sourceMappingURL=order_item.model.js.map