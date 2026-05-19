import { NextFunction, Request, Response } from 'express';
export declare const cartValidation: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
