import { Response, Request, NextFunction } from 'express';
import ApiError from '../utils/ApiError.js';
export declare const errorHandlingMiddleware: (err: ApiError, req: Request, res: Response, next: NextFunction) => void;
