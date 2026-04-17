import { Response, Request, NextFunction } from 'express'
import { StatusCodes } from 'http-status-codes'
import { env } from '../configs/environment.js'
import ApiError from '../utils/ApiError.js'


export const errorHandlingMiddleware = (err: ApiError, req: Request, res: Response, next: NextFunction) => {

  if (!err.statusCode) {
    err.statusCode = StatusCodes.INTERNAL_SERVER_ERROR
  }

  const responseError = {
    statusCode: err.statusCode,
    message: err.message || StatusCodes[err.statusCode],
    stack: err.stack
  }

  if (env.BUILD_MODE !== 'dev') {
    delete responseError.stack
  }

  // QUAN TRỌNG: Ngăn chặn trình duyệt (Chrome, Edge...) lưu cache các response lỗi (ví dụ: 410 Gone, 401 Unauthorized)
  // Theo chuẩn HTTP (RFC 7231), mã 410 (Gone) được trình duyệt coi là "Tài nguyên đã vĩnh viễn biến mất" 
  // do đó nó sẽ CỐ TÌNH CACHE lại mã lỗi này vào ổ cứng (disk cache) cho các lần hỏi sau để tối ưu hiệu năng.
  // Nếu không thiết lập `no-store` ở đây, frontend gọi API sẽ luôn bị kẹt ở lỗi 410 (từ disk cache) mà không thèm gọi lên Backend!
  res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate')
  res.setHeader('Pragma', 'no-cache')
  res.setHeader('Expires', '0')
  res.status(responseError.statusCode).json(responseError)

}
