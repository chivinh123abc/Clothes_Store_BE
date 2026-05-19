import { NextFunction, Request, Response } from 'express';
export declare const productController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getProduct: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getAll: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getByCollectionSlug: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    deleteProduct: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
