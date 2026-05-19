import { NextFunction, Request, Response } from 'express';
export declare const productConfigurationValidation: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
