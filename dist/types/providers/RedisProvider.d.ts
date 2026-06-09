import { Redis } from 'ioredis';
export declare const RedisProvider: {
    connect: () => Promise<void>;
    disconnect: () => Promise<void>;
    setOTP: (email: string, otp: string, ttlSeconds?: number) => Promise<void>;
    getOTP: (email: string) => Promise<string | null>;
    deleteOTP: (email: string) => Promise<void>;
    client: Redis;
};
