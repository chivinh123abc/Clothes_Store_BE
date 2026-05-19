import { Request, Response } from 'express';
export declare const collectionController: {
    create: (req: Request, res: Response) => Promise<void>;
    getAll: (req: Request, res: Response) => Promise<void>;
    getById: (req: Request, res: Response) => Promise<Response<any, Record<string, any>> | undefined>;
    getBySlug: (req: Request, res: Response) => Promise<Response<any, Record<string, any>> | undefined>;
    update: (req: Request, res: Response) => Promise<Response<any, Record<string, any>> | undefined>;
    deleteCollection: (req: Request, res: Response) => Promise<Response<any, Record<string, any>> | undefined>;
};
