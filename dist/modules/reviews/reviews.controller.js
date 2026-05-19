var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { StatusCodes } from 'http-status-codes';
import { reviewsModel } from './reviews.model.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const { product_id, rating, text, image_url } = req.body;
        if (!product_id || !rating || !text) {
            res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing product_id, rating or text' });
            return;
        }
        const newReview = yield reviewsModel.create(Number(userId), Number(product_id), Number(rating), text, image_url);
        res.status(StatusCodes.CREATED).json(newReview);
    }
    catch (error) {
        next(error);
    }
});
const getReviewsByProductId = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const productId = Number(req.params.productId);
        const reviews = yield reviewsModel.findByProductId(productId);
        res.status(StatusCodes.OK).json(reviews);
    }
    catch (error) {
        next(error);
    }
});
const getAllReviews = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const reviews = yield reviewsModel.findAllReviews();
        res.status(StatusCodes.OK).json(reviews);
    }
    catch (error) {
        next(error);
    }
});
const updateReview = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        const { id } = req.params;
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const { rating, text, image_url } = req.body;
        if (!rating || !text) {
            res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing rating or text' });
            return;
        }
        const isAdmin = Number((_b = req.jwtDecoded) === null || _b === void 0 ? void 0 : _b.role) === 1;
        const updatedReview = yield reviewsModel.update(Number(id), Number(userId), Number(rating), text, image_url, isAdmin);
        if (!updatedReview) {
            res.status(StatusCodes.NOT_FOUND).json({ message: 'Review not found or unauthorized' });
            return;
        }
        res.status(StatusCodes.OK).json(updatedReview);
    }
    catch (error) {
        next(error);
    }
});
const deleteReview = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        const { id } = req.params;
        const userId = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (!userId) {
            res.status(StatusCodes.UNAUTHORIZED).json({ message: 'User not authenticated' });
            return;
        }
        const isAdmin = Number((_b = req.jwtDecoded) === null || _b === void 0 ? void 0 : _b.role) === 1;
        const deleted = yield reviewsModel.remove(Number(id), Number(userId), isAdmin);
        if (!deleted) {
            res.status(StatusCodes.NOT_FOUND).json({ message: 'Review not found or unauthorized' });
            return;
        }
        res.status(StatusCodes.OK).json({ message: 'Review deleted successfully' });
    }
    catch (error) {
        next(error);
    }
});
export const reviewsController = {
    createNew,
    getReviewsByProductId,
    getAllReviews,
    updateReview,
    deleteReview
};
//# sourceMappingURL=reviews.controller.js.map