import { OrderItemCreateDto, OrderItemResponseDto, OrderItemUpdateDto } from '../types/order_items.js';
export declare const orderItemModel: {
    create: (reqBody: OrderItemCreateDto) => Promise<OrderItemResponseDto>;
    createWithStockUpdate: (reqBody: OrderItemCreateDto) => Promise<OrderItemResponseDto>;
    getOrderItemById: (order_item_id: number) => Promise<OrderItemResponseDto | null>;
    update: (reqBody: OrderItemUpdateDto) => Promise<OrderItemResponseDto | null>;
    findAllByOrderId: (order_id: number) => Promise<any[]>;
};
