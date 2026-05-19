import { NextFunction, Request, Response } from 'express';
export declare const cartController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getCartById: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
