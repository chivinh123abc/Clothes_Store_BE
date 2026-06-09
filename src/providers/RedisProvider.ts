import { Redis } from 'ioredis'
import { env } from '../configs/environment.js'

const client = new Redis({
  host: env.REDIS_HOST || 'localhost',
  port: Number(env.REDIS_PORT) || 6379,
  lazyConnect: true
})

client.on('error', (err: Error) => {
  // eslint-disable-next-line no-console
  console.error('[REDIS] Redis Client Error:', err)
})

client.on('connect', () => {
  // eslint-disable-next-line no-console
  console.log('[REDIS] Connected to Redis successfully')
})

const connect = async () => {
  await client.connect()
}

// Lưu OTP vào Redis với TTL (giây), mặc định 5 phút
const setOTP = async (email: string, otp: string, ttlSeconds: number = 300): Promise<void> => {
  const key = `otp:forgot_password:${email}`
  await client.set(key, otp, 'EX', ttlSeconds)
}

// Lấy OTP từ Redis
const getOTP = async (email: string): Promise<string | null> => {
  const key = `otp:forgot_password:${email}`
  return await client.get(key)
}

// Xoá OTP khỏi Redis (sau khi reset password thành công)
const deleteOTP = async (email: string): Promise<void> => {
  const key = `otp:forgot_password:${email}`
  await client.del(key)
}

const disconnect = async () => {
  await client.quit()
  // eslint-disable-next-line no-console
  console.log('[REDIS] Disconnected from Redis')
}

export const RedisProvider = {
  connect,
  disconnect,
  setOTP,
  getOTP,
  deleteOTP,
  client
}
