import { NextFunction, Request, Response } from 'express';
export declare const createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
export declare const updateCategory: (req: Request, res: Response, next: NextFunction) => Promise<void>;
export declare const deleteCategory: (req: Request, res: Response, next: NextFunction) => Promise<void>;
export declare const categoryValidation: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    updateCategory: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    deleteCategory: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
