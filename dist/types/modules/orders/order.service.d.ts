import { OrderCreateDto, OrderResponseDto, OrderUpdateDto } from '../types/orders.js';
export declare const orderService: {
    createNew: (reqBody: OrderCreateDto) => Promise<OrderResponseDto>;
    update: (reqBody: OrderUpdateDto) => Promise<OrderResponseDto>;
    getOrder: (order_id: number) => Promise<any>;
    getAllOrders: () => Promise<OrderResponseDto[]>;
    deleteOrder: (order_id: number) => Promise<void>;
    getOrdersByUserId: (user_id: number) => Promise<any[]>;
    cancelOrder: (order_id: number, user_id: number, isAdmin: boolean) => Promise<OrderResponseDto>;
};
