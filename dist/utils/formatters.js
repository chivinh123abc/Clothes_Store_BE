import _ from 'lodash';
export const slugify = (value) => {
    if (!value) {
        return '';
    }
    return value
        .normalize('NFKD') // Xoa dau
        .replace(/[\u0300-\u036f]/g, '') //Xoa toan bo thanh dau
        .trim()
        .toLowerCase()
        .replace(/[^a-z0-9 -]/g, '') //giu lai cac so tu 0-9 a-z va xoa cau ky tu khac
        .replace(/\s+/g, '-') //thay 1 hoac nhieu khoang trang lien tiep thanh thanh mot dau gach
        .replace(/-+/g, '-'); //thay nhieu dau gach thanh 1 gach
};
export const pickUser = (user) => {
    if (!user)
        return null;
    const result = _.pick(user, [
        'user_id',
        'email',
        'username',
        'phone_number',
        'role',
        'avatar',
        'is_active',
        'created_at',
        'updated_at',
        'is_destroy',
        'address',
        'display_name',
        'full_name'
    ]);
    // Calculate status from the numeric 'status' column
    if (user.status === 0) {
        result.status = 0;
    }
    else if (user.status === 1) {
        result.status = 1;
    }
    else if (user.status === 2) {
        result.status = 2;
    }
    else if (user.is_active) {
        // Fallback to old logic
        result.status = 0;
    }
    else if (user.verify_token) {
        result.status = 2;
    }
    else {
        result.status = 1;
    }
    return result;
};
export const generateSKUwithSlug = (slug, charsFromFirstWord = 2) => {
    var _a;
    if (!slug)
        return null;
    //Tach thanh cac tu
    const parts = slug.split('-');
    if (parts.length === 0) {
        return '';
    }
    let sku = '';
    //Lay n ky tu tu dau tien va viet hoa 
    for (let i = 0; i < Math.min(parts.length); i++) {
        sku += parts[i].slice(0, charsFromFirstWord).toUpperCase();
    }
    const numbers = ((_a = parts.join('').match(/\d+/g)) === null || _a === void 0 ? void 0 : _a.join('')) || '';
    sku += numbers;
    return sku;
};
//# sourceMappingURL=formatters.js.map