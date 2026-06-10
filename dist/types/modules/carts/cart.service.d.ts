import { CartCreateDto, CartResponseDto } from '../types/carts.js';
export declare const cartService: {
    createNew: (reqBody: CartCreateDto) => Promise<CartResponseDto>;
    getCartById: (cart_id: number) => Promise<CartResponseDto>;
    getMyCart: (user_id: number) => Promise<any[]>;
    addItemToCart: (user_id: number, product_id: number, size: string, quantity: number) => Promise<any>;
    updateItemQuantity: (user_id: number, product_id: number, size: string, quantity: number) => Promise<any>;
    removeItemFromCart: (user_id: number, product_id: number, size: string) => Promise<boolean>;
    syncCart: (user_id: number, clientItems: any[]) => Promise<any[]>;
    clearCart: (user_id: number) => Promise<boolean>;
    updateItemSize: (user_id: number, product_id: number, oldSize: string, newSize: string) => Promise<any>;
};
