import { NextFunction, Request, Response } from 'express';
export declare const authMiddleware: {
    isAuthorized: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    isAdmin: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
