var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import crypto from 'crypto';
import express from 'express';
import { StatusCodes } from 'http-status-codes';
import { env } from '../configs/environment.js';
import { authMiddleware } from '../middlewares/authMiddleware.js';
import ApiError from '../utils/ApiError.js';
const router = express.Router();
router.post('/', authMiddleware.isAuthorized, authMiddleware.isAdmin, (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { file, public_id } = req.body;
        if (!file) {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'Missing file data');
        }
        const cloudName = env.CLOUDINARY_CLOUD_NAME || 'dlwd564av';
        const apiKey = env.CLOUDINARY_API_KEY || '879482939989524';
        const apiSecret = env.CLOUDINARY_API_SECRET || 'eRkGgLqA-Y53X7jK5_pM3b89eBc';
        const timestamp = Math.round(new Date().getTime() / 1000).toString();
        const folder = 'products';
        const formData = new URLSearchParams();
        formData.append('file', file);
        formData.append('api_key', apiKey);
        formData.append('timestamp', timestamp);
        formData.append('folder', folder);
        let stringToSign = '';
        if (public_id) {
            // Sorted alphabetically: folder, overwrite, public_id, timestamp
            stringToSign = `folder=${folder}&overwrite=true&public_id=${public_id}&timestamp=${timestamp}${apiSecret}`;
            formData.append('public_id', public_id);
            formData.append('overwrite', 'true');
        }
        else {
            // Sorted alphabetically: folder, timestamp
            stringToSign = `folder=${folder}&timestamp=${timestamp}${apiSecret}`;
        }
        const signature = crypto
            .createHash('sha1')
            .update(stringToSign)
            .digest('hex');
        formData.append('signature', signature);
        const response = yield fetch(`https://api.cloudinary.com/v1_1/${cloudName}/image/upload`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        });
        if (!response.ok) {
            const errorText = yield response.text();
            throw new ApiError(StatusCodes.BAD_GATEWAY, `Cloudinary upload failed: ${errorText}`);
        }
        const data = yield response.json();
        res.status(StatusCodes.OK).json({
            secure_url: data.secure_url
        });
    }
    catch (error) {
        next(error);
    }
}));
const userRouter = express.Router();
userRouter.post('/', authMiddleware.isAuthorized, (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { file } = req.body;
        if (!file) {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'Missing file data');
        }
        const cloudName = env.CLOUDINARY_CLOUD_NAME || 'dlwd564av';
        const apiKey = env.CLOUDINARY_API_KEY || '879482939989524';
        const apiSecret = env.CLOUDINARY_API_SECRET || 'eRkGgLqA-Y53X7jK5_pM3b89eBc';
        const timestamp = Math.round(new Date().getTime() / 1000).toString();
        const folder = 'avatars';
        const formData = new URLSearchParams();
        formData.append('file', file);
        formData.append('api_key', apiKey);
        formData.append('timestamp', timestamp);
        formData.append('folder', folder);
        const stringToSign = `folder=${folder}&timestamp=${timestamp}${apiSecret}`;
        const signature = crypto
            .createHash('sha1')
            .update(stringToSign)
            .digest('hex');
        formData.append('signature', signature);
        const response = yield fetch(`https://api.cloudinary.com/v1_1/${cloudName}/image/upload`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        });
        if (!response.ok) {
            const errorText = yield response.text();
            throw new ApiError(StatusCodes.BAD_GATEWAY, `Cloudinary upload failed: ${errorText}`);
        }
        const data = yield response.json();
        res.status(StatusCodes.OK).json({
            secure_url: data.secure_url
        });
    }
    catch (error) {
        next(error);
    }
}));
const reviewRouter = express.Router();
reviewRouter.post('/', authMiddleware.isAuthorized, (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { file } = req.body;
        if (!file) {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'Missing file data');
        }
        const cloudName = env.CLOUDINARY_CLOUD_NAME || 'dlwd564av';
        const apiKey = env.CLOUDINARY_API_KEY || '879482939989524';
        const apiSecret = env.CLOUDINARY_API_SECRET || 'eRkGgLqA-Y53X7jK5_pM3b89eBc';
        const timestamp = Math.round(new Date().getTime() / 1000).toString();
        const folder = 'reviews';
        const formData = new URLSearchParams();
        formData.append('file', file);
        formData.append('api_key', apiKey);
        formData.append('timestamp', timestamp);
        formData.append('folder', folder);
        const stringToSign = `folder=${folder}&timestamp=${timestamp}${apiSecret}`;
        const signature = crypto
            .createHash('sha1')
            .update(stringToSign)
            .digest('hex');
        formData.append('signature', signature);
        const response = yield fetch(`https://api.cloudinary.com/v1_1/${cloudName}/image/upload`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        });
        if (!response.ok) {
            const errorText = yield response.text();
            throw new ApiError(StatusCodes.BAD_GATEWAY, `Cloudinary upload failed: ${errorText}`);
        }
        const data = yield response.json();
        res.status(StatusCodes.OK).json({
            secure_url: data.secure_url
        });
    }
    catch (error) {
        next(error);
    }
}));
export const uploadRoute = router;
export const userUploadRoute = userRouter;
export const reviewUploadRoute = reviewRouter;
//# sourceMappingURL=upload.route.js.map