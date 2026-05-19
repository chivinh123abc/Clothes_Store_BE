import { NextFunction, Request, Response } from 'express';
export declare const productItemValidation: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
