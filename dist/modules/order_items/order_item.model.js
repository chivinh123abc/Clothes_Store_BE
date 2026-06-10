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
const createWithStockUpdate = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b, _c;
    const client = yield pool.connect();
    try {
        yield client.query('BEGIN');
        // 1. SELECT ... FOR UPDATE to lock the product item row and get current stock
        const lockRes = yield client.query(`SELECT stock_quantity, product_item_price, discount_id, product_id
       FROM product_items
       WHERE product_item_id = $1
       FOR UPDATE`, [reqBody.product_item_id]);
        if (lockRes.rows.length === 0) {
            throw new Error('Product variant does not exist');
        }
        const { stock_quantity, product_item_price, discount_id, product_id } = lockRes.rows[0];
        // 2. Validate stock
        // Fetch product name and discount percentage (no lock needed since these are lookup values that don't change during checkout)
        const detailsRes = yield client.query(`SELECT p.product_name, d.discount_percent, d.active
       FROM products p
       LEFT JOIN discounts d ON d.discount_id = $1
       WHERE p.product_id = $2`, [discount_id, product_id]);
        const productName = ((_a = detailsRes.rows[0]) === null || _a === void 0 ? void 0 : _a.product_name) || 'Product';
        const discountPercent = ((_b = detailsRes.rows[0]) === null || _b === void 0 ? void 0 : _b.active) ? (_c = detailsRes.rows[0]) === null || _c === void 0 ? void 0 : _c.discount_percent : null;
        if (stock_quantity < reqBody.quantity) {
            throw new Error(`Sản phẩm "${productName}" không đủ số lượng trong kho (chỉ còn ${stock_quantity} sản phẩm)`);
        }
        // 3. Decrement stock
        yield client.query(`UPDATE product_items 
       SET stock_quantity = stock_quantity - $1, updated_at = NOW() 
       WHERE product_item_id = $2`, [reqBody.quantity, reqBody.product_item_id]);
        // 4. Calculate unit price
        const unitPrice = Number(discountPercent !== null && discountPercent !== undefined
            ? product_item_price * (1 - discountPercent / 100)
            : product_item_price);
        const orderItemPayload = Object.assign(Object.assign({}, reqBody), { unit_price: unitPrice });
        const createdEntries = Object.entries(orderItemPayload).filter(([k, v]) => v !== undefined);
        const fields = createdEntries.map(([k]) => k);
        const indexs = createdEntries.map(([], index) => `$${index + 1}`);
        const values = createdEntries.map(([_, v]) => v);
        const insertQuery = `
      INSERT INTO order_items(${fields.join(', ')})
      VALUES(${indexs.join(', ')})
      RETURNING *
    `;
        const insertRes = yield client.query(insertQuery, values);
        // Recalculate and update the total_amount of the parent order
        const orderId = insertRes.rows[0].order_id;
        yield client.query(`UPDATE orders 
       SET total_amount = (
         SELECT COALESCE(
           CASE 
             WHEN SUM(unit_price * quantity) > 100 
             THEN SUM(unit_price * quantity) 
             ELSE SUM(unit_price * quantity) + 5.0 
           END, 
           0.0
         )
         FROM order_items 
         WHERE order_id = $1
       )
       WHERE order_id = $1`, [orderId]);
        yield client.query('COMMIT');
        return insertRes.rows[0];
    }
    catch (error) {
        yield client.query('ROLLBACK');
        throw error;
    }
    finally {
        client.release();
    }
});
export const orderItemModel = {
    create,
    createWithStockUpdate,
    getOrderItemById,
    update,
    findAllByOrderId
};
//# sourceMappingURL=order_item.model.js.map