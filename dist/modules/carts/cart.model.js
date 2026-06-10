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
const getCartByUserId = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT *
      FROM carts
      WHERE user_id = $1
    `, [user_id]);
    return result.rows[0] || null;
});
const getCartItemsDetails = (cart_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT 
      ci.cart_item_id,
      pi.product_id as id,
      p.product_name as name,
      pi.product_item_image as "imageUrl",
      vo.variant_option_value as size,
      ci.quantity,
      pi.product_item_price as "originalPrice",
      CASE 
        WHEN d.active = true AND d.discount_percent IS NOT NULL 
        THEN pi.product_item_price * (1 - d.discount_percent::float/100)
        ELSE pi.product_item_price
      END as price
    FROM cart_items ci
    JOIN product_items pi ON ci.product_item_id = pi.product_item_id
    JOIN products p ON pi.product_id = p.product_id
    LEFT JOIN discounts d ON pi.discount_id = d.discount_id
    LEFT JOIN product_configurations pc ON pi.product_item_id = pc.product_item_id
    LEFT JOIN variant_options vo ON pc.variant_option_id = vo.variant_option_id
    WHERE ci.cart_id = $1
    ORDER BY MAX(ci.created_at) OVER(PARTITION BY pi.product_id) DESC, ci.created_at ASC
  `, [cart_id]);
    return result.rows;
});
const findProductItemId = (product_id, size) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const result = yield pool.query(`
    SELECT pi.product_item_id
    FROM product_items pi
    JOIN product_configurations pc ON pi.product_item_id = pc.product_item_id
    JOIN variant_options vo ON pc.variant_option_id = vo.variant_option_id
    WHERE pi.product_id = $1 AND UPPER(vo.variant_option_value) = UPPER($2)
    LIMIT 1
  `, [product_id, size]);
    return ((_a = result.rows[0]) === null || _a === void 0 ? void 0 : _a.product_item_id) || null;
});
const addOrUpdateCartItem = (cart_id, product_item_id, quantity, price) => __awaiter(void 0, void 0, void 0, function* () {
    const exist = yield pool.query(`
    SELECT cart_item_id, quantity FROM cart_items
    WHERE cart_id = $1 AND product_item_id = $2
  `, [cart_id, product_item_id]);
    if (exist.rows.length > 0) {
        const newQty = exist.rows[0].quantity + quantity;
        const newPrice = (price / quantity) * newQty;
        const result = yield pool.query(`
      UPDATE cart_items
      SET quantity = $3, price = $4, updated_at = NOW()
      WHERE cart_item_id = $1
      RETURNING *
    `, [exist.rows[0].cart_item_id, cart_id, newQty, newPrice]);
        return result.rows[0];
    }
    else {
        const result = yield pool.query(`
      INSERT INTO cart_items(cart_id, product_item_id, quantity, price)
      VALUES ($1, $2, $3, $4)
      RETURNING *
    `, [cart_id, product_item_id, quantity, price]);
        return result.rows[0];
    }
});
const updateCartItemQuantity = (cart_id, product_item_id, quantity, price) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    UPDATE cart_items
    SET quantity = $3, price = $4, updated_at = NOW()
    WHERE cart_id = $1 AND product_item_id = $2
    RETURNING *
  `, [cart_id, product_item_id, quantity, price]);
    return result.rows[0];
});
const deleteCartItem = (cart_id, product_item_id) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const result = yield pool.query(`
    DELETE FROM cart_items
    WHERE cart_id = $1 AND product_item_id = $2
  `, [cart_id, product_item_id]);
    return ((_a = result.rowCount) !== null && _a !== void 0 ? _a : 0) > 0;
});
const clearCartItems = (cart_id) => __awaiter(void 0, void 0, void 0, function* () {
    yield pool.query(`
    DELETE FROM cart_items
    WHERE cart_id = $1
  `, [cart_id]);
    return true;
});
const getCartItem = (cart_id, product_item_id) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    SELECT cart_item_id, quantity FROM cart_items
    WHERE cart_id = $1 AND product_item_id = $2
  `, [cart_id, product_item_id]);
    return result.rows[0] || null;
});
const updateCartItemSizeOnly = (cart_id, old_product_item_id, new_product_item_id, price) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
    UPDATE cart_items
    SET product_item_id = $3, price = $4, updated_at = NOW()
    WHERE cart_id = $1 AND product_item_id = $2
    RETURNING *
  `, [cart_id, old_product_item_id, new_product_item_id, price]);
    return result.rows[0];
});
export const cartModel = {
    create,
    getCartById,
    getCartByUserId,
    getCartItemsDetails,
    findProductItemId,
    addOrUpdateCartItem,
    updateCartItemQuantity,
    deleteCartItem,
    clearCartItems,
    getCartItem,
    updateCartItemSizeOnly
};
//# sourceMappingURL=cart.model.js.map