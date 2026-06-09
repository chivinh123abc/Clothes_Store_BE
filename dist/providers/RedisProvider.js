var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { Redis } from 'ioredis';
import { env } from '../configs/environment.js';
const client = new Redis({
    host: env.REDIS_HOST || 'localhost',
    port: Number(env.REDIS_PORT) || 6379,
    lazyConnect: true
});
client.on('error', (err) => {
    // eslint-disable-next-line no-console
    console.error('[REDIS] Redis Client Error:', err);
});
client.on('connect', () => {
    // eslint-disable-next-line no-console
    console.log('[REDIS] Connected to Redis successfully');
});
const connect = () => __awaiter(void 0, void 0, void 0, function* () {
    yield client.connect();
});
// Lưu OTP vào Redis với TTL (giây), mặc định 5 phút
const setOTP = (email_1, otp_1, ...args_1) => __awaiter(void 0, [email_1, otp_1, ...args_1], void 0, function* (email, otp, ttlSeconds = 300) {
    const key = `otp:forgot_password:${email}`;
    yield client.set(key, otp, 'EX', ttlSeconds);
});
// Lấy OTP từ Redis
const getOTP = (email) => __awaiter(void 0, void 0, void 0, function* () {
    const key = `otp:forgot_password:${email}`;
    return yield client.get(key);
});
// Xoá OTP khỏi Redis (sau khi reset password thành công)
const deleteOTP = (email) => __awaiter(void 0, void 0, void 0, function* () {
    const key = `otp:forgot_password:${email}`;
    yield client.del(key);
});
const disconnect = () => __awaiter(void 0, void 0, void 0, function* () {
    yield client.quit();
    // eslint-disable-next-line no-console
    console.log('[REDIS] Disconnected from Redis');
});
export const RedisProvider = {
    connect,
    disconnect,
    setOTP,
    getOTP,
    deleteOTP,
    client
};
//# sourceMappingURL=RedisProvider.js.map