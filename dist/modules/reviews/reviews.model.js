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
const create = (userId, productId, rating, text, imageUrl) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      INSERT INTO reviews (user_id, product_id, rating, text, image_url)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `, [userId, productId, rating, text, imageUrl || null]);
    return result.rows[0];
});
const findByProductId = (productId) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT r.*, u.username, u.avatar, u.display_name
      FROM reviews r
      JOIN users u ON r.user_id = u.user_id
      WHERE r.product_id = $1
      ORDER BY r.created_at DESC
    `, [productId]);
    return result.rows;
});
const findAllReviews = () => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT r.*, u.username, u.avatar, u.display_name, p.product_name as product
      FROM reviews r
      JOIN users u ON r.user_id = u.user_id
      JOIN products p ON r.product_id = p.product_id
      ORDER BY r.created_at DESC
    `);
    return result.rows;
});
const update = (reviewId, userId, rating, text, imageUrl, isAdmin) => __awaiter(void 0, void 0, void 0, function* () {
    let result;
    if (isAdmin) {
        result = yield pool.query(`
        UPDATE reviews
        SET rating = $1, text = $2, image_url = $3
        WHERE review_id = $4
        RETURNING *
      `, [rating, text, imageUrl || null, reviewId]);
    }
    else {
        result = yield pool.query(`
        UPDATE reviews
        SET rating = $1, text = $2, image_url = $3
        WHERE review_id = $4 AND user_id = $5
        RETURNING *
      `, [rating, text, imageUrl || null, reviewId, userId]);
    }
    return result.rows[0];
});
const remove = (reviewId, userId, isAdmin) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    let result;
    if (isAdmin) {
        result = yield pool.query(`
        DELETE FROM reviews
        WHERE review_id = $1
        RETURNING *
      `, [reviewId]);
    }
    else {
        result = yield pool.query(`
        DELETE FROM reviews
        WHERE review_id = $1 AND user_id = $2
        RETURNING *
      `, [reviewId, userId]);
    }
    return ((_a = result.rowCount) !== null && _a !== void 0 ? _a : 0) > 0;
});
export const reviewsModel = {
    create,
    findByProductId,
    findAllReviews,
    update,
    remove
};
//# sourceMappingURL=reviews.model.js.map