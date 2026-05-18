import crypto from 'crypto'
import express from 'express'
import { StatusCodes } from 'http-status-codes'
import { env } from '../configs/environment.js'
import { authMiddleware } from '../middlewares/authMiddleware.js'
import ApiError from '../utils/ApiError.js'

const router = express.Router()

router.post(
  '/',
  authMiddleware.isAuthorized,
  authMiddleware.isAdmin,
  async (req, res, next) => {
    try {
      const { file, public_id } = req.body
      if (!file) {
        throw new ApiError(StatusCodes.BAD_REQUEST, 'Missing file data')
      }

      const cloudName = env.CLOUDINARY_CLOUD_NAME || 'dlwd564av'
      const apiKey = env.CLOUDINARY_API_KEY || '879482939989524'
      const apiSecret = env.CLOUDINARY_API_SECRET || 'eRkGgLqA-Y53X7jK5_pM3b89eBc'

      const timestamp = Math.round(new Date().getTime() / 1000).toString()
      const folder = 'products'

      const formData = new URLSearchParams()
      formData.append('file', file)
      formData.append('api_key', apiKey)
      formData.append('timestamp', timestamp)
      formData.append('folder', folder)

      let stringToSign = ''
      if (public_id) {
        // Sorted alphabetically: folder, overwrite, public_id, timestamp
        stringToSign = `folder=${folder}&overwrite=true&public_id=${public_id}&timestamp=${timestamp}${apiSecret}`
        formData.append('public_id', public_id)
        formData.append('overwrite', 'true')
      } else {
        // Sorted alphabetically: folder, timestamp
        stringToSign = `folder=${folder}&timestamp=${timestamp}${apiSecret}`
      }

      const signature = crypto
        .createHash('sha1')
        .update(stringToSign)
        .digest('hex')

      formData.append('signature', signature)

      const response = await fetch(`https://api.cloudinary.com/v1_1/${cloudName}/image/upload`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData
      })

      if (!response.ok) {
        const errorText = await response.text()
        throw new ApiError(StatusCodes.BAD_GATEWAY, `Cloudinary upload failed: ${errorText}`)
      }

      const data = await response.json()
      res.status(StatusCodes.OK).json({
        secure_url: data.secure_url
      })
    } catch (error) {
      next(error)
    }
  }
)

export const uploadRoute = router
