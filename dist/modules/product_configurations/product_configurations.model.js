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
    INSERT INTO product_configurations(product_item_id, variant_option_id)
    VALUES ($1, $2)
    RETURNING *
    `, [reqBody.product_item_id, reqBody.variant_option_id]);
    return result.rows[0];
});
const isExistPrimaryKey = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      SELECT *
      FROM product_configurations
      WHERE product_item_id = $1 AND variant_option_id = $2
    `, [reqBody.product_item_id, reqBody.variant_option_id]);
    return result.rows.length > 0;
});
const update = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield pool.query(`
      UPDATE product_configurations
      SET product_item_id = $1, variant_option_id = $2
      WHERE product_item_id = $3 AND variant_option_id = $4
      RETURNING *
    `, [reqBody.new_product_item_id, reqBody.new_variant_option_id, reqBody.old_product_item_id, reqBody.old_variant_option_id]);
    return result.rows.length > 0 ? result.rows[0] : null;
});
export const productConfigurationModel = {
    create,
    isExistPrimaryKey,
    update
};
//# sourceMappingURL=product_configurations.model.js.map