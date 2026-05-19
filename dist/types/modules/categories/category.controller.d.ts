import { NextFunction, Request, Response } from 'express';
export declare const categoryController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getCategory: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    updateCategory: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getAll: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    deleteCategory: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
