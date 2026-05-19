import { CartItemCreateDto, CartItemReponseDto } from '../types/cart_item.js';
export declare const cartItemModel: {
    create: (reqBody: CartItemCreateDto) => Promise<CartItemReponseDto>;
    getCartItemById: (cart_item_id: number) => Promise<CartItemReponseDto | null>;
};
