import { NextFunction, Request, Response } from 'express';
export declare const productItemController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getProductItem: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
