import { NextFunction, Request, Response } from 'express';
export declare const productConfigurationController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
