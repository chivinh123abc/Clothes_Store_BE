import { NextFunction, Request, Response } from 'express';
export declare const userController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getUser: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    update: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    softDelete: (req: Request, res: Response, next: NextFunction) => Promise<Response<any, Record<string, any>> | undefined>;
    login: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    refreshToken: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    logout: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    verifyAccount: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    findAll: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    adminUpdate: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    adminDelete: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    adminCreate: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    resendVerification: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
