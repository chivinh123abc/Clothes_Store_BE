import { NextFunction, Request, Response } from 'express';
export declare const cartItemController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getCartItemById: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
