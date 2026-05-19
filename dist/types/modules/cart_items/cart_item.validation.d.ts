import { NextFunction, Request, Response } from 'express';
export declare const cartItemValidation: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
