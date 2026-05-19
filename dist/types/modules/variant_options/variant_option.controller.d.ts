import { NextFunction, Request, Response } from 'express';
export declare const variantOptionController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getVariantOptionById: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
