import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import { env } from '../configs/environment.js'
import { JwtProvider } from '../providers/JwtProvider.js'
import ApiError from '../utils/ApiError.js'


const isAuthorized = async (req: Request, res: Response, next: NextFunction) => {
  const clientAccessToken = req.cookies?.access_token

  if (!clientAccessToken) {
    next(new ApiError(StatusCodes.UNAUTHORIZED, 'Unauthorized (token not found)'))
    return
  }

  try {
    const accessTokenDecoded = await JwtProvider.verifyTokens(clientAccessToken, env.ACCESS_TOKEN_SECRET_SIGNATURE)

    req.jwtDecoded = accessTokenDecoded

    next()
  } catch (error: any) {

    if (error?.message?.includes('jwt expired')) {
      next(new ApiError(StatusCodes.GONE, 'Need to refresh token'))
    }
    next(new ApiError(StatusCodes.UNAUTHORIZED, 'Unauthorized'))
  }
}

const isAdmin = async (req: Request, res: Response, next: NextFunction) => {
  if (req.jwtDecoded?.role !== 1) {
    next(new ApiError(StatusCodes.FORBIDDEN, 'Forbidden (Admin only)'))
    return
  }
  next()
}

export const authMiddleware = {
  isAuthorized,
  isAdmin
}
