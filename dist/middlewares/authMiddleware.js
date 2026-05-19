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
import { env } from '../configs/environment.js';
import { JwtProvider } from '../providers/JwtProvider.js';
import ApiError from '../utils/ApiError.js';
const isAuthorized = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b, _c;
    const clientAccessToken = ((_a = req.cookies) === null || _a === void 0 ? void 0 : _a.access_token) || ((_b = req.headers.authorization) === null || _b === void 0 ? void 0 : _b.split(' ')[1]);
    if (!clientAccessToken) {
        next(new ApiError(StatusCodes.UNAUTHORIZED, 'Unauthorized (token not found)'));
        return;
    }
    try {
        const accessTokenDecoded = yield JwtProvider.verifyTokens(clientAccessToken, env.ACCESS_TOKEN_SECRET_SIGNATURE);
        req.jwtDecoded = accessTokenDecoded;
        next();
    }
    catch (error) {
        if ((_c = error === null || error === void 0 ? void 0 : error.message) === null || _c === void 0 ? void 0 : _c.includes('jwt expired')) {
            next(new ApiError(StatusCodes.GONE, 'Need to refresh token'));
        }
        next(new ApiError(StatusCodes.UNAUTHORIZED, 'Unauthorized'));
    }
});
const isAdmin = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    if (((_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.role) !== 1) {
        next(new ApiError(StatusCodes.FORBIDDEN, 'Forbidden (Admin only)'));
        return;
    }
    next();
});
export const authMiddleware = {
    isAuthorized,
    isAdmin
};
//# sourceMappingURL=authMiddleware.js.map