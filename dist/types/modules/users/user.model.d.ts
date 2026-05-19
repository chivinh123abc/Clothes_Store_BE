import { UserResponseDto, UserUpdateDto, UserEntity } from '../types/user.js';
export declare const userModel: {
    create: (reqBody: any) => Promise<UserResponseDto>;
    findUserById: (user_id: number) => Promise<UserEntity | null>;
    findUserByEmail: (email: string) => Promise<UserEntity | null>;
    findUserByIdentifier: (identifier: string) => Promise<UserEntity | null>;
    update: (user_id: number, reqBody: UserUpdateDto) => Promise<UserResponseDto | null>;
    softDelete: (user_id: number) => Promise<UserResponseDto>;
    findAll: () => Promise<UserResponseDto[]>;
    adminDelete: (user_id: number) => Promise<boolean>;
};
