import { Request, Response, NextFunction } from 'express';
export declare const createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
export declare const update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
export declare const verifyAccount: (req: Request, res: Response, next: NextFunction) => Promise<void>;
export declare const login: (req: Request, res: Response, next: NextFunction) => Promise<void>;
export declare const userValidation: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    verifyAccount: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    login: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
