var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import jwt from 'jsonwebtoken';
const generateTokens = (userInfo, secretSignature, tokenLife) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const generateUser = {
            user_id: userInfo.user_id,
            email: userInfo.email,
            role: userInfo.role
        };
        const options = {
            algorithm: 'HS256',
            expiresIn: tokenLife
        };
        return jwt.sign(generateUser, secretSignature, options);
    }
    catch (error) {
        throw error;
    }
});
const verifyTokens = (token, secretSignature) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        return jwt.verify(token, secretSignature);
    }
    catch (error) {
        throw error;
    }
});
export const JwtProvider = {
    generateTokens,
    verifyTokens
};
//# sourceMappingURL=JwtProvider.js.map