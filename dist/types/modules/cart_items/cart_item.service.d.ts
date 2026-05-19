import { CartItemCreateDto, CartItemReponseDto } from '../types/cart_item.js';
export declare const cartItemService: {
    createNew: (reqBody: CartItemCreateDto) => Promise<CartItemReponseDto>;
    getCartItemById: (cart_item_id: number) => Promise<CartItemReponseDto>;
};
