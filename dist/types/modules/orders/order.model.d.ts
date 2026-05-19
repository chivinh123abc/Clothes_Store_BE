import { OrderCreateDto, OrderResponseDto, OrderUpdateDto } from '../types/orders.js';
export declare const orderModel: {
    create: (reqBody: OrderCreateDto) => Promise<OrderResponseDto>;
    update: (reqBody: OrderUpdateDto) => Promise<OrderResponseDto | null>;
    findOrderById: (order_id: number) => Promise<any | null>;
    findAllOrderByUserId: (user_id: number) => Promise<OrderResponseDto[]>;
    findAllOrders: () => Promise<OrderResponseDto[]>;
    deleteOrder: (order_id: number) => Promise<void>;
};
