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
import ms from 'ms';
import { env } from '../../configs/environment.js';
import ApiError from '../../utils/ApiError.js';
import { userService } from './user.service.js';
const createNew = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const createdUser = yield userService.createNew(req.body);
        res.status(StatusCodes.CREATED).json(createdUser);
    }
    catch (error) {
        next(error);
    }
});
const getUser = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const user_id = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        const userInfo = yield userService.getUser({ user_id: user_id });
        res.status(StatusCodes.ACCEPTED).json(userInfo);
    }
    catch (error) {
        next(error);
    }
});
const update = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const user_id = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        const updateData = req.body;
        const updatedInfo = yield userService.update(user_id, updateData);
        res.status(StatusCodes.ACCEPTED).json(updatedInfo);
    }
    catch (error) {
        next(error);
    }
});
const softDelete = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const user_id = (_a = req.jwtDecoded) === null || _a === void 0 ? void 0 : _a.user_id;
        if (isNaN(user_id)) {
            return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Invalid user ID' });
        }
        const deletedUser = yield userService.softDelete(user_id);
        res.status(StatusCodes.ACCEPTED).json(deletedUser);
    }
    catch (error) {
        next(error);
    }
});
const login = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const reqBody = req.body;
        const loginedUser = yield userService.login(reqBody);
        res.cookie('access_token', loginedUser.access_token, {
            httpOnly: true,
            secure: false, //temp
            sameSite: 'none',
            maxAge: ms(env.ACCESS_TOKEN_LIFE)
        });
        res.cookie('refresh_token', loginedUser.refresh_token, {
            httpOnly: true,
            secure: false, //temp
            sameSite: 'none',
            maxAge: ms(env.REFRESH_TOKEN_LIFE)
        });
        res.status(StatusCodes.OK).json(loginedUser);
    }
    catch (error) {
        next(error);
    }
});
const logout = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        res.clearCookie('access_token');
        res.clearCookie('refresh_token');
        res.status(StatusCodes.OK).json({ loggedout: true });
    }
    catch (error) {
        next(error);
    }
});
const refreshToken = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const result = yield userService.refreshToken((_a = req.cookies) === null || _a === void 0 ? void 0 : _a.refresh_token);
        res.cookie('access_token', result.access_token, {
            httpOnly: true,
            secure: false, //temp
            sameSite: 'none',
            maxAge: ms(env.ACCESS_TOKEN_LIFE)
        });
        res.status(StatusCodes.OK).json(result);
    }
    catch (error) {
        next(new ApiError(StatusCodes.FORBIDDEN, 'Please Sign In! (Error from refresh token)'));
    }
});
const verifyAccount = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const result = yield userService.verifyAccount(req.body);
        res.status(StatusCodes.OK).json(result);
    }
    catch (error) {
        next(error);
    }
});
const findAll = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // eslint-disable-next-line no-console
        console.log('[DEBUG] Admin findAll hit');
        const users = yield userService.findAll();
        res.status(StatusCodes.OK).json(users);
    }
    catch (error) {
        // eslint-disable-next-line no-console
        console.error('[DEBUG] Admin findAll error:', error);
        next(error);
    }
});
const adminUpdate = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const result = yield userService.adminUpdate(Number(id), req.body);
        res.status(StatusCodes.OK).json(result);
    }
    catch (error) {
        next(error);
    }
});
const adminDelete = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const result = yield userService.adminDelete(Number(id));
        res.status(StatusCodes.OK).json({ success: result });
    }
    catch (error) {
        next(error);
    }
});
const adminCreate = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const user = yield userService.adminCreate(req.body);
        res.status(StatusCodes.CREATED).json(user);
    }
    catch (error) {
        next(error);
    }
});
const resendVerification = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { email } = req.body;
        const result = yield userService.resendVerification(email);
        res.status(StatusCodes.OK).json(result);
    }
    catch (error) {
        next(error);
    }
});
export const userController = {
    createNew,
    getUser,
    update,
    softDelete,
    login,
    refreshToken,
    logout,
    verifyAccount,
    findAll,
    adminUpdate,
    adminDelete,
    adminCreate,
    resendVerification
};
//# sourceMappingURL=user.controller.js.map