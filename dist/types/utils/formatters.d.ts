import { UserResponseDto, UserEntity } from '../modules/types/user.js';
export declare const slugify: (value: string) => string;
export declare const pickUser: (user: UserEntity) => UserResponseDto | null;
export declare const generateSKUwithSlug: (slug: string, charsFromFirstWord?: number) => string | null;
