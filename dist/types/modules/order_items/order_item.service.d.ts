import { OrderItemCreateDto, OrderItemResponseDto, OrderItemUpdateDto } from '../types/order_items.js';
export declare const orderItemService: {
    createNew: (reqBody: OrderItemCreateDto) => Promise<OrderItemResponseDto>;
    getOrderItemById: (order_item_id: number) => Promise<OrderItemResponseDto>;
    update: (reqBody: OrderItemUpdateDto) => Promise<OrderItemResponseDto | null>;
};
