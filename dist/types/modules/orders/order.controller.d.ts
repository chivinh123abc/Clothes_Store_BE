import { NextFunction, Request, Response } from 'express';
export declare const orderController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getOrderById: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getAllOrders: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    deleteOrder: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getOrdersByUserId: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    cancelOrder: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
