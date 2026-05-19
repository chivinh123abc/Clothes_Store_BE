import { JwtPayload } from 'jsonwebtoken';
import type { StringValue } from 'ms';
import { UserEntity } from '../modules/types/user.js';
export declare const JwtProvider: {
    generateTokens: (userInfo: UserEntity, secretSignature: string, tokenLife: StringValue | number) => Promise<string>;
    verifyTokens: (token: string, secretSignature: string) => Promise<JwtPayload>;
};
