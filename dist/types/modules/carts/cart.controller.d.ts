import { NextFunction, Request, Response } from 'express';
export declare const cartController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getCartById: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getMyCart: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    addItemToCart: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    updateItemQuantity: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    removeItemFromCart: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    syncCart: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    clearCart: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    updateItemSize: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
