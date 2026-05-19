import { CartCreateDto, CartResponseDto } from '../types/carts.js';
export declare const cartService: {
    createNew: (reqBody: CartCreateDto) => Promise<CartResponseDto>;
    getCartById: (cart_id: number) => Promise<CartResponseDto>;
};
