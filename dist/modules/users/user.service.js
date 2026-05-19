var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import bcrypt from 'bcrypt';
import { StatusCodes } from 'http-status-codes';
import { v7 as uuidv7 } from 'uuid';
import { env } from '../../configs/environment.js';
import { JwtProvider } from '../../providers/JwtProvider.js';
import { MailProvider } from '../../providers/MailProvider.js';
import ApiError from '../../utils/ApiError.js';
import { pickUser } from '../../utils/formatters.js';
import { userModel } from './user.model.js';
const createNew = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        if (!reqBody.email || !reqBody.password || !reqBody.username) {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'Email and password are required');
        }
        const existUser = yield userModel.findUserByEmail(reqBody.email);
        if (existUser) {
            if (!existUser.is_active) {
                // If user exists but is not active, update their info and resend verification
                const newToken = uuidv7();
                const updateData = {
                    username: reqBody.username,
                    password: bcrypt.hashSync(reqBody.password, 8),
                    verify_token: newToken,
                    phone_number: (_a = reqBody.phone_number) === null || _a === void 0 ? void 0 : _a.replace(/\s/g, ''),
                    avatar: reqBody.avatar
                };
                yield userModel.update(existUser.user_id, Object.assign(Object.assign({}, updateData), { status: 2 }));
                yield MailProvider.sendVerificationEmail(reqBody.email, reqBody.username, newToken);
                return Object.assign(Object.assign({}, pickUser(Object.assign(Object.assign(Object.assign({}, existUser), updateData), { status: 2 }))), { message: 'Account exists but was not activated. Information updated and new verification email sent.' });
            }
            throw new ApiError(StatusCodes.CONFLICT, 'Email already exist');
        }
        //tao data de luu vao data base;
        const newUser = {
            username: reqBody.username,
            email: reqBody.email,
            phone_number: (_b = reqBody.phone_number) === null || _b === void 0 ? void 0 : _b.replace(/\s/g, ''),
            avatar: reqBody.avatar,
            password: bcrypt.hashSync(reqBody.password, 8),
            verify_token: uuidv7(),
            status: 2
        };
        const createdUser = yield userModel.create(newUser);
        // Gui mail verify cho nguoi dung
        yield MailProvider.sendVerificationEmail(createdUser.email, createdUser.username, newUser.verify_token);
        return createdUser;
    }
    catch (error) {
        throw error;
    }
});
const adminCreate = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const existUser = yield userModel.findUserByEmail(reqBody.email);
        if (existUser) {
            throw new ApiError(StatusCodes.CONFLICT, 'Email already exists');
        }
        const newUser = {
            username: reqBody.username,
            email: reqBody.email,
            password: bcrypt.hashSync(reqBody.password || 'ClotheStore@15082005', 8),
            phone_number: (_a = reqBody.phone_number) === null || _a === void 0 ? void 0 : _a.replace(/\s/g, ''),
            avatar: reqBody.avatar,
            role: reqBody.role || 0,
            status: reqBody.status !== undefined ? Number(reqBody.status) : 0
        };
        // Set internal flags based on status
        if (newUser.status === 0) {
            newUser.is_active = true;
            newUser.verify_token = null;
        }
        else if (newUser.status === 2) {
            newUser.is_active = false;
            newUser.verify_token = uuidv7();
        }
        else {
            newUser.is_active = false;
            newUser.verify_token = null;
        }
        const createdUser = yield userModel.create(newUser);
        return pickUser(createdUser);
    }
    catch (error) {
        throw error;
    }
});
const getUser = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const userData = yield userModel.findUserById(reqBody.user_id);
        if (!userData) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User is not exist');
        }
        return userData;
    }
    catch (error) {
        throw (error);
    }
});
const update = (user_id, reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const existUser = yield userModel.findUserById(user_id);
        if (!existUser) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User does not exist');
        }
        const updateData = {
            username: reqBody.username,
            email: reqBody.email,
            phone_number: (_a = reqBody.phone_number) === null || _a === void 0 ? void 0 : _a.replace(/\s/g, ''),
            avatar: reqBody.avatar,
            address: reqBody.address,
            display_name: reqBody.display_name,
            full_name: reqBody.full_name
        };
        if (reqBody.password) {
            updateData.password = bcrypt.hashSync(reqBody.password, 8);
        }
        // Filter out undefined values
        Object.keys(updateData).forEach(key => updateData[key] === undefined && delete updateData[key]);
        const updatedUser = yield userModel.update(user_id, updateData);
        return pickUser(updatedUser);
    }
    catch (error) {
        throw error;
    }
});
const softDelete = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existUser = yield userModel.findUserById(user_id);
        if (!existUser) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User is not exist');
        }
        const deletedUser = yield userModel.softDelete(user_id);
        return deletedUser;
    }
    catch (error) {
        throw (error);
    }
});
const login = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existUser = yield userModel.findUserByIdentifier(reqBody.identifier);
        if (!existUser) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User is not exist');
        }
        const currentPassword = existUser.password;
        if (!bcrypt.compareSync(reqBody.password, currentPassword)) {
            throw new ApiError(StatusCodes.NOT_ACCEPTABLE, 'Password is not correct');
        }
        if (!existUser.is_active) {
            throw new ApiError(StatusCodes.NOT_ACCEPTABLE, 'Account is not active. Please check your email to activate your account.');
        }
        const access_token = yield JwtProvider.generateTokens(existUser, env.ACCESS_TOKEN_SECRET_SIGNATURE, env.ACCESS_TOKEN_LIFE);
        const refresh_token = yield JwtProvider.generateTokens(existUser, env.REFRESH_TOKEN_SECRET_SIGNATURE, env.REFRESH_TOKEN_LIFE);
        return Object.assign(Object.assign({}, pickUser(existUser)), { access_token: access_token, refresh_token: refresh_token });
    }
    catch (error) {
        throw (error);
    }
});
const verifyAccount = (reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        if (!reqBody.email) {
            throw new ApiError(StatusCodes.BAD_REQUEST, 'Email are required');
        }
        const existUser = yield userModel.findUserByEmail(reqBody.email);
        if (!existUser) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User not exist');
        }
        if (existUser.is_active) {
            throw new ApiError(StatusCodes.CONFLICT, 'User has been activated');
        }
        if (reqBody.verify_token !== existUser.verify_token) {
            throw new ApiError(StatusCodes.CONFLICT, 'Verify Failed');
        }
        const verifiedData = {
            verify_token: null,
            is_active: true,
            status: 0
        };
        const existUserId = existUser.user_id;
        const updatedData = yield userModel.update(existUserId, verifiedData);
        return updatedData;
    }
    catch (error) {
        throw error;
    }
});
const refreshToken = (clientRefreshToken) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const refreshTokenDecoded = yield JwtProvider.verifyTokens(clientRefreshToken, env.REFRESH_TOKEN_SECRET_SIGNATURE);
        const userInfo = {
            user_id: refreshTokenDecoded.user_id,
            email: refreshTokenDecoded.email
        };
        const accessToken = yield JwtProvider.generateTokens(userInfo, env.ACCESS_TOKEN_SECRET_SIGNATURE, env.ACCESS_TOKEN_LIFE);
        return { access_token: accessToken };
    }
    catch (error) {
        throw (error);
    }
});
const findAll = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const users = yield userModel.findAll();
        return users.map(user => pickUser(user));
    }
    catch (error) {
        throw error;
    }
});
const adminUpdate = (user_id, reqBody) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existUser = yield userModel.findUserById(user_id);
        if (!existUser) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User not found');
        }
        const updateData = Object.assign({}, reqBody);
        if (updateData.phone_number) {
            updateData.phone_number = updateData.phone_number.replace(/\s/g, '');
        }
        // Handle status changes internally
        if (updateData.status !== undefined) {
            const statusNum = Number(updateData.status);
            if (statusNum === 0) {
                updateData.is_active = true;
                updateData.verify_token = null;
            }
            else if (statusNum === 2) {
                updateData.is_active = false;
                if (!existUser.verify_token)
                    updateData.verify_token = uuidv7();
            }
            else {
                updateData.is_active = false;
                updateData.verify_token = null;
            }
        }
        const updatedUser = yield userModel.update(user_id, updateData);
        return pickUser(updatedUser);
    }
    catch (error) {
        throw error;
    }
});
const adminDelete = (user_id) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existUser = yield userModel.findUserById(user_id);
        if (!existUser) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User not found');
        }
        return yield userModel.adminDelete(user_id);
    }
    catch (error) {
        throw error;
    }
});
const resendVerification = (email) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const existUser = yield userModel.findUserByEmail(email);
        if (!existUser) {
            throw new ApiError(StatusCodes.NOT_FOUND, 'User not found');
        }
        if (existUser.is_active) {
            throw new ApiError(StatusCodes.CONFLICT, 'Account is already activated');
        }
        const newToken = uuidv7();
        yield userModel.update(existUser.user_id, { verify_token: newToken });
        yield MailProvider.sendVerificationEmail(existUser.email, existUser.username, newToken);
        return { message: 'Verification email resent successfully' };
    }
    catch (error) {
        throw error;
    }
});
export const userService = {
    createNew,
    getUser,
    update,
    softDelete,
    login,
    refreshToken,
    verifyAccount,
    findAll,
    adminUpdate,
    adminDelete,
    adminCreate,
    resendVerification
};
//# sourceMappingURL=user.service.js.map