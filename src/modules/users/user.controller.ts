import { NextFunction, Request, Response } from 'express'
import { StatusCodes } from 'http-status-codes'
import ms from 'ms'
import { env } from '../../configs/environment.js'
import ApiError from '../../utils/ApiError.js'
import { UserLoginDto } from '../types/user.js'
import { userService } from './user.service.js'

const createNew = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const createdUser = await userService.createNew(req.body)
    res.status(StatusCodes.CREATED).json(createdUser)
  } catch (error) {
    next(error)
  }
}

const getUser = async (req: Request, res: Response, next: NextFunction) => {
  try {

    const user_id = req.jwtDecoded?.user_id

    const userInfo = await userService.getUser({ user_id: user_id })

    res.status(StatusCodes.ACCEPTED).json(userInfo)
  } catch (error) {
    next(error)
  }
}

const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const user_id = req.jwtDecoded?.user_id
    const updateData = req.body
    const updatedInfo = await userService.update(user_id, updateData)
    res.status(StatusCodes.ACCEPTED).json(updatedInfo)
  } catch (error) {
    next(error)
  }
}

const softDelete = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const user_id = req.jwtDecoded?.user_id

    if (isNaN(user_id)) {
      return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Invalid user ID' })
    }

    const deletedUser = await userService.softDelete(user_id)
    res.status(StatusCodes.ACCEPTED).json(deletedUser)

  } catch (error) {
    next(error)
  }
}

const login = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const reqBody: UserLoginDto = req.body
    const loginedUser = await userService.login(reqBody)

    res.cookie('access_token', loginedUser.access_token, {
      httpOnly: true,
      secure: false,//temp
      sameSite: 'none',
      maxAge: ms(env.ACCESS_TOKEN_LIFE as any) as unknown as number
    })

    res.cookie('refresh_token', loginedUser.refresh_token, {
      httpOnly: true,
      secure: false,//temp
      sameSite: 'none',
      maxAge: ms(env.REFRESH_TOKEN_LIFE as any) as unknown as number
    })

    res.status(StatusCodes.OK).json(loginedUser)
  } catch (error) {
    next(error)
  }
}

const logout = async (req: Request, res: Response, next: NextFunction) => {
  try {

    res.clearCookie('access_token')
    res.clearCookie('refresh_token')

    res.status(StatusCodes.OK).json({ loggedout: true })
  } catch (error) {
    next(error)
  }
}

const refreshToken = async (req: Request, res: Response, next: NextFunction) => {
  try {

    const result = await userService.refreshToken(req.cookies?.refresh_token)

    res.cookie('access_token', result.access_token, {
      httpOnly: true,
      secure: false,//temp
      sameSite: 'none',
      maxAge: ms(env.ACCESS_TOKEN_LIFE as any) as unknown as number
    })

    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(new ApiError(StatusCodes.FORBIDDEN, 'Please Sign In! (Error from refresh token)'))
  }
}

const verifyAccount = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await userService.verifyAccount(req.body)

    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

const findAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
    // eslint-disable-next-line no-console
    console.log('[DEBUG] Admin findAll hit')
    const users = await userService.findAll()
    res.status(StatusCodes.OK).json(users)
  } catch (error) {
    // eslint-disable-next-line no-console
    console.error('[DEBUG] Admin findAll error:', error)
    next(error)
  }
}

const adminUpdate = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params
    const result = await userService.adminUpdate(Number(id), req.body)
    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

const adminDelete = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params
    const result = await userService.adminDelete(Number(id))
    res.status(StatusCodes.OK).json({ success: result })
  } catch (error) {
    next(error)
  }
}

const adminCreate = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const user = await userService.adminCreate(req.body)
    res.status(StatusCodes.CREATED).json(user)
  } catch (error) {
    next(error)
  }
}

const resendVerification = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { email } = req.body
    const result = await userService.resendVerification(email)
    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

const forgotPassword = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { email } = req.body
    const result = await userService.forgotPassword(email)
    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

const resetPassword = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await userService.resetPassword(req.body)
    res.status(StatusCodes.OK).json(result)
  } catch (error) {
    next(error)
  }
}

export const userController = {
  createNew,
  getUser,
  update,
  softDelete,
  login,
  refreshToken,
  logout,
  verifyAccount,
  findAll,
  adminUpdate,
  adminDelete,
  adminCreate,
  resendVerification,
  forgotPassword,
  resetPassword
}
