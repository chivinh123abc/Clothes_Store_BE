import 'dotenv/config'
import { StringValue } from 'ms'

export const env = {
  BUILD_MODE: process.env.BUILD_MODE,
  HOST: process.env.HOST,
  PORT: process.env.PORT,
  //DB
  DB_HOST: process.env.DB_HOST,
  DB_PORT: process.env.DB_PORT,
  DB_USER: process.env.DB_USER,
  DB_PASSWORD: process.env.DB_PASSWORD,
  DB_NAME: process.env.DB_NAME,

  CLIENT_URL: process.env.CLIENT_URL as string,

  ACCESS_TOKEN_SECRET_SIGNATURE: process.env.ACCESS_TOKEN_SECRET_SIGNATURE as string,
  ACCESS_TOKEN_LIFE: process.env.ACCESS_TOKEN_LIFE as StringValue | number,
  REFRESH_TOKEN_SECRET_SIGNATURE: process.env.REFRESH_TOKEN_SECRET_SIGNATURE as string,
  REFRESH_TOKEN_LIFE: process.env.REFRESH_TOKEN_LIFE as StringValue | number,

  MAIL_HOST: process.env.MAIL_HOST as string,
  MAIL_PORT: process.env.MAIL_PORT as string,
  MAIL_USER: process.env.MAIL_USER as string,
  MAIL_PASSWORD: process.env.MAIL_PASSWORD as string,
  MAIL_FROM_ADDRESS: process.env.MAIL_FROM_ADDRESS as string,
  CLOUDINARY_CLOUD_NAME: process.env.CLOUDINARY_CLOUD_NAME as string,
  CLOUDINARY_API_KEY: process.env.CLOUDINARY_API_KEY as string,
  CLOUDINARY_API_SECRET: process.env.CLOUDINARY_API_SECRET as string,

  // MOMO
  MOMO_PARTNER_CODE: process.env.MOMO_PARTNER_CODE as string,
  MOMO_ACCESS_KEY: process.env.MOMO_ACCESS_KEY as string,
  MOMO_SECRET_KEY: process.env.MOMO_SECRET_KEY as string,
  MOMO_ENDPOINT: process.env.MOMO_ENDPOINT as string,

  // REDIS
  REDIS_HOST: process.env.REDIS_HOST as string,
  REDIS_PORT: process.env.REDIS_PORT as string
}
