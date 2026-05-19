var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
import { pool } from '../../configs/database.js';
const create = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const { product_id, stock_quantity, product_item_price, sku, product_item_image, discount_id } = reqBody;
    const result = yield pool.query(`
    INSERT INTO product_items (product_id, stock_quantity, product_item_price, sku, product_item_image, discount_id)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING *
    `, [product_id, stock_quantity, product_item_price, sku, product_item_image, discount_id]);
    return result.rows[0];
});
const findProductItemById = (product_item_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT 
      pi.*,
      d.discount_percent,
      CASE 
        WHEN d.active = true AND d.discount_percent IS NOT NULL 
        THEN pi.product_item_price * (1 - d.discount_percent::float/100)
        ELSE pi.product_item_price
      END as sale_price,
      vo.variant_option_value as size
    FROM product_items pi
    LEFT JOIN discounts d ON pi.discount_id = d.discount_id
    LEFT JOIN product_configurations pc ON pi.product_item_id = pc.product_item_id
    LEFT JOIN variant_options vo ON pc.variant_option_id = vo.variant_option_id
    WHERE pi.product_item_id = $1 
    `, [product_item_id]);
    return result.rows[0] || null;
});
const findProductItemBySKU = (sku) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT 
      pi.*,
      d.discount_percent,
      CASE 
        WHEN d.active = true AND d.discount_percent IS NOT NULL 
        THEN pi.product_item_price * (1 - d.discount_percent::float/100)
        ELSE pi.product_item_price
      END as sale_price
    FROM product_items pi
    LEFT JOIN discounts d ON pi.discount_id = d.discount_id
    WHERE pi.sku = $1 
    `, [sku]);
    return result.rows[0] || null;
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const { product_item_id } = reqBody, data = __rest(reqBody, ["product_item_id"]);
    const entries = Object.entries(data).filter(([_, v]) => v !== undefined);
    if (entries.length === 0)
        return null;
    const fields = entries.map(([k], i) => `${k} = $${i + 1}`);
    const values = entries.map(([_, v]) => v);
    fields.push('updated_at = NOW()');
    values.push(product_item_id);
    const query = `
    UPDATE product_items 
    SET ${fields.join(', ')} 
    WHERE product_item_id = $${values.length} 
    RETURNING *
  `;
    const result = yield pool.query(query, values);
    return result.rows[0];
});
export const productItemModel = {
    create,
    findProductItemById,
    update,
    findProductItemBySKU
};
//# sourceMappingURL=product_item.model.js.map