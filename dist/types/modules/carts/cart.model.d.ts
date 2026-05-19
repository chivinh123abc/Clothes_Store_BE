import { CartCreateDto, CartResponseDto } from '../types/carts.js';
export declare const cartModel: {
    create: (reqBody: CartCreateDto) => Promise<CartResponseDto>;
    getCartById: (cart_id: number) => Promise<CartResponseDto>;
};
