import { Request, Response } from 'express';
export declare const discountController: {
    create: (req: Request, res: Response) => Promise<void>;
    getAll: (req: Request, res: Response) => Promise<void>;
    getById: (req: Request, res: Response) => Promise<Response<any, Record<string, any>> | undefined>;
    update: (req: Request, res: Response) => Promise<Response<any, Record<string, any>> | undefined>;
    deleteDiscount: (req: Request, res: Response) => Promise<Response<any, Record<string, any>> | undefined>;
};
