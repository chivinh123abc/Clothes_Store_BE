import { NextFunction, Request, Response } from 'express';
export declare const orderItemController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getOrderItemById: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
