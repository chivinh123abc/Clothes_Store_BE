import bcrypt from 'bcrypt'
import { StatusCodes } from 'http-status-codes'
import { v7 as uuidv7 } from 'uuid'
import { env } from '../../configs/environment.js'
import { JwtProvider } from '../../providers/JwtProvider.js'
import { MailProvider } from '../../providers/MailProvider.js'
import ApiError from '../../utils/ApiError.js'
import { pickUser } from '../../utils/formatters.js'
import {
  AuthResponseDto,
  UserEntity,
  UserLoginDto,
  UserRegisterDto,
  UserResponseDto,
  UserUpdateDto,
  UserVerifyAccountDTO
} from '../types/user.js'
import { userModel } from './user.model.js'

const createNew = async (reqBody: UserRegisterDto): Promise<UserResponseDto> => {
  try {
    if (!reqBody.email || !reqBody.password || !reqBody.username) {
      throw new ApiError(StatusCodes.BAD_REQUEST, 'Email and password are required')
    }
    const existUser = await userModel.findUserByEmail(reqBody.email)

    if (existUser) {
      if (!existUser.is_active) {
        // If user exists but is not active, update their info and resend verification
        const newToken = uuidv7()
        const updateData = {
          username: reqBody.username,
          password: bcrypt.hashSync(reqBody.password, 8),
          verify_token: newToken,
          phone_number: reqBody.phone_number?.replace(/\s/g, ''),
          avatar: reqBody.avatar
        }
        await userModel.update(existUser.user_id!, updateData)
        await MailProvider.sendVerificationEmail(reqBody.email, reqBody.username, newToken)
        
        return { 
          ...pickUser(existUser), 
          message: 'Account exists but was not activated. Information updated and new verification email sent.' 
        } as any
      }
      throw new ApiError(StatusCodes.CONFLICT, 'Email already exist')
    }
    //tao data de luu vao data base;
    const newUser = {
      username: reqBody.username,
      email: reqBody.email,
      phone_number: reqBody.phone_number?.replace(/\s/g, ''),
      avatar: reqBody.avatar,
      password: bcrypt.hashSync(reqBody.password, 8),
      verify_token: uuidv7()
    }

    const createdUser = await userModel.create(newUser)

    // Gui mail verify cho nguoi dung
    await MailProvider.sendVerificationEmail(createdUser.email!, createdUser.username!, newUser.verify_token)

    return createdUser

  } catch (error) {
    throw error
  }
}

const adminCreate = async (reqBody: any): Promise<UserResponseDto> => {
  try {
    const existUser = await userModel.findUserByEmail(reqBody.email)
    if (existUser) {
      throw new ApiError(StatusCodes.CONFLICT, 'Email already exists')
    }

    const newUser = {
      username: reqBody.username,
      email: reqBody.email,
      password: bcrypt.hashSync(reqBody.password || 'ClotheStore@15082005', 8), // Default password if not provided
      phone_number: reqBody.phone_number?.replace(/\s/g, ''),
      avatar: reqBody.avatar,
      role: reqBody.role || 0,
      is_active: reqBody.is_active !== undefined ? reqBody.is_active : true,
      verify_token: null // Admin created accounts are pre-verified
    }

    return await userModel.create(newUser)
  } catch (error) {
    throw error
  }
}

const getUser = async (reqBody: { user_id: number }): Promise<UserEntity> => {
  try {
    const userData = await userModel.findUserById(reqBody.user_id)

    if (!userData) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User is not exist')
    }

    return userData
  } catch (error) {
    throw (error)
  }
}

const update = async (user_id: number, reqBody: UserUpdateDto): Promise<UserResponseDto | null> => {

  try {
    const existUser = await userModel.findUserById(user_id)

    if (!existUser) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User is not exist')
    }

    const updateData = {
      username: reqBody.username,
      email: reqBody.email,
      phone_number: reqBody.phone_number?.replace(/\s/g, ''),
      avatar: reqBody.avatar
    }

    const updatedUser = await userModel.update(user_id, updateData)

    return updatedUser
  } catch (error) {
    throw (error)
  }
}

const softDelete = async (user_id: number): Promise<UserResponseDto> => {
  try {
    const existUser = await userModel.findUserById(user_id)
    if (!existUser) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User is not exist')
    }

    const deletedUser = await userModel.softDelete(user_id)
    return deletedUser
  } catch (error) {
    throw (error)
  }
}

const login = async (reqBody: UserLoginDto): Promise<AuthResponseDto> => {
  try {
    const existUser = await userModel.findUserByIdentifier(reqBody.identifier)

    if (!existUser) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User is not exist')
    }
    const currentPassword = existUser.password as string

    if (!bcrypt.compareSync(reqBody.password, currentPassword)) {
      throw new ApiError(StatusCodes.NOT_ACCEPTABLE, 'Password is not correct')
    }

    if (!existUser.is_active) {
      throw new ApiError(StatusCodes.NOT_ACCEPTABLE, 'Account is not active. Please check your email to activate your account.')
    }

    const access_token = await JwtProvider.generateTokens(existUser, env.ACCESS_TOKEN_SECRET_SIGNATURE, env.ACCESS_TOKEN_LIFE)
    const refresh_token = await JwtProvider.generateTokens(existUser, env.REFRESH_TOKEN_SECRET_SIGNATURE, env.REFRESH_TOKEN_LIFE)

    return {
      ...pickUser(existUser),
      access_token: access_token,
      refresh_token: refresh_token
    }
  } catch (error) {
    throw (error)
  }
}

const verifyAccount = async (reqBody: UserVerifyAccountDTO) => {
  try {
    if (!reqBody.email) {
      throw new ApiError(StatusCodes.BAD_REQUEST, 'Email are required')
    }

    const existUser = await userModel.findUserByEmail(reqBody.email)
    if (!existUser) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User not exist')
    }
    if (existUser.is_active) {
      throw new ApiError(StatusCodes.CONFLICT, 'User has been activated')
    }

    if (reqBody.verify_token !== existUser.verify_token) {
      throw new ApiError(StatusCodes.CONFLICT, 'Verify Failed')
    }

    const verifiedData: UserUpdateDto = {
      verify_token: null,
      is_active: true
    }

    const existUserId = existUser.user_id as number

    const updatedData = await userModel.update(existUserId, verifiedData)

    return updatedData
  } catch (error) {
    throw error
  }
}

const refreshToken = async (clientRefreshToken: string) => {
  try {
    const refreshTokenDecoded = await JwtProvider.verifyTokens(
      clientRefreshToken,
      env.REFRESH_TOKEN_SECRET_SIGNATURE
    )

    const userInfo = {
      user_id: refreshTokenDecoded.user_id as number,
      email: refreshTokenDecoded.email as string
    }

    const accessToken = await JwtProvider.generateTokens(
      userInfo,
      env.ACCESS_TOKEN_SECRET_SIGNATURE,
      env.ACCESS_TOKEN_LIFE
    )

    return { access_token: accessToken }
  } catch (error) {
    throw (error)
  }
}

const findAll = async () => {
  try {
    return await userModel.findAll()
  } catch (error) {
    throw error
  }
}

const adminUpdate = async (user_id: number, reqBody: any) => {
  try {
    const existUser = await userModel.findUserById(user_id)
    if (!existUser) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User not found')
    }
    const updateData = { ...reqBody }
    if (updateData.phone_number) {
      updateData.phone_number = updateData.phone_number.replace(/\s/g, '')
    }
    return await userModel.update(user_id, updateData)
  } catch (error) {
    throw error
  }
}

const adminDelete = async (user_id: number) => {
  try {
    const existUser = await userModel.findUserById(user_id)
    if (!existUser) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User not found')
    }
    return await userModel.adminDelete(user_id)
  } catch (error) {
    throw error
  }
}

const resendVerification = async (email: string) => {
  try {
    const existUser = await userModel.findUserByEmail(email)
    if (!existUser) {
      throw new ApiError(StatusCodes.NOT_FOUND, 'User not found')
    }
    if (existUser.is_active) {
      throw new ApiError(StatusCodes.CONFLICT, 'Account is already activated')
    }

    const newToken = uuidv7()
    await userModel.update(existUser.user_id!, { verify_token: newToken })
    await MailProvider.sendVerificationEmail(existUser.email!, existUser.username!, newToken)

    return { message: 'Verification email resent successfully' }
  } catch (error) {
    throw error
  }
}

export const userService = {
  createNew,
  getUser,
  update,
  softDelete,
  login,
  refreshToken,
  verifyAccount,
  findAll,
  adminUpdate,
  adminDelete,
  adminCreate,
  resendVerification
}
