import { Redis } from 'ioredis'
import { env } from '../configs/environment.js'

const client = new Redis({
  host: env.REDIS_HOST || 'localhost',
  port: Number(env.REDIS_PORT) || 6379,
  lazyConnect: true,
  // Tự động retry khi mất kết nối
  retryStrategy: (times: number) => {
    if (times > 5) {
      // eslint-disable-next-line no-console
      console.error('[REDIS] Max retry attempts reached. Giving up.')
      return null // Dừng retry
    }
    const delay = Math.min(times * 500, 3000) // 500ms, 1s, 1.5s... tối đa 3s
    // eslint-disable-next-line no-console
    console.log(`[REDIS] Retrying connection in ${delay}ms (attempt ${times})...`)
    return delay
  }
})

client.on('error', (err: Error) => {
  // eslint-disable-next-line no-console
  console.error('[REDIS] Redis Client Error:', err.message)
})

client.on('connect', () => {
  // eslint-disable-next-line no-console
  console.log('[REDIS] Connected to Redis successfully')
})

client.on('reconnecting', () => {
  // eslint-disable-next-line no-console
  console.log('[REDIS] Reconnecting to Redis...')
})

const connect = async () => {
  try {
    await client.connect()
  } catch (err: any) {
    // eslint-disable-next-line no-console
    console.error('[REDIS] Failed to connect to Redis:', err.message)
    // Không throw - để server vẫn chạy được, chỉ thiếu tính năng OTP
  }
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
  try {
    await client.quit()
    // eslint-disable-next-line no-console
    console.log('[REDIS] Disconnected from Redis')
  } catch {
    // Bỏ qua lỗi khi disconnect
  }
}

export const RedisProvider = {
  connect,
  disconnect,
  setOTP,
  getOTP,
  deleteOTP,
  client
}
