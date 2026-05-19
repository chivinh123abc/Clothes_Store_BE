import { NextFunction, Request, Response } from 'express';
export declare const reviewsController: {
    createNew: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getReviewsByProductId: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    getAllReviews: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    updateReview: (req: Request, res: Response, next: NextFunction) => Promise<void>;
    deleteReview: (req: Request, res: Response, next: NextFunction) => Promise<void>;
};
