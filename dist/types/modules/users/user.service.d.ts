import { AuthResponseDto, UserEntity, UserLoginDto, UserRegisterDto, UserResponseDto, UserUpdateDto, UserVerifyAccountDTO } from '../types/user.js';
export declare const userService: {
    createNew: (reqBody: UserRegisterDto) => Promise<UserResponseDto>;
    getUser: (reqBody: {
        user_id: number;
    }) => Promise<UserEntity>;
    update: (user_id: number, reqBody: UserUpdateDto) => Promise<UserResponseDto | null>;
    softDelete: (user_id: number) => Promise<UserResponseDto>;
    login: (reqBody: UserLoginDto) => Promise<AuthResponseDto>;
    refreshToken: (clientRefreshToken: string) => Promise<{
        access_token: string;
    }>;
    verifyAccount: (reqBody: UserVerifyAccountDTO) => Promise<UserResponseDto | null>;
    findAll: () => Promise<(UserResponseDto | null)[]>;
    adminUpdate: (user_id: number, reqBody: any) => Promise<UserResponseDto>;
    adminDelete: (user_id: number) => Promise<boolean>;
    adminCreate: (reqBody: any) => Promise<UserResponseDto>;
    resendVerification: (email: string) => Promise<{
        message: string;
    }>;
    forgotPassword: (email: string) => Promise<{
        message: string;
    }>;
    resetPassword: (reqBody: any) => Promise<{
        message: string;
    }>;
};
