import { CartCreateDto, CartResponseDto } from '../types/carts.js';
export declare const cartModel: {
    create: (reqBody: CartCreateDto) => Promise<CartResponseDto>;
    getCartById: (cart_id: number) => Promise<CartResponseDto>;
    getCartByUserId: (user_id: number) => Promise<CartResponseDto | null>;
    getCartItemsDetails: (cart_id: number) => Promise<any[]>;
    findProductItemId: (product_id: number, size: string) => Promise<number | null>;
    addOrUpdateCartItem: (cart_id: number, product_item_id: number, quantity: number, price: number) => Promise<any>;
    updateCartItemQuantity: (cart_id: number, product_item_id: number, quantity: number, price: number) => Promise<any>;
    deleteCartItem: (cart_id: number, product_item_id: number) => Promise<boolean>;
    clearCartItems: (cart_id: number) => Promise<boolean>;
    getCartItem: (cart_id: number, product_item_id: number) => Promise<any>;
    updateCartItemSizeOnly: (cart_id: number, old_product_item_id: number, new_product_item_id: number, price: number) => Promise<any>;
};
