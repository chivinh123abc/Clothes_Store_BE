import fs from 'fs'
import { Request, Response, NextFunction } from 'express'
import { StatusCodes } from 'http-status-codes'
import { OrderStatus } from '../constants/orders.enum.js'
import { orderModel } from '../orders/order.model.js'
import { createMoMoPaymentUrl } from './payment.service.js'

export const createMoMo = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { order_id, amount, orderInfo } = req.body

    if (!order_id || !amount) {
      return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing order_id or amount' })
    }

    const payUrl = await createMoMoPaymentUrl(order_id, amount, orderInfo || 'Thanh toan don hang T1')
    res.status(StatusCodes.OK).json({ payUrl })
  } catch (error: any) {
    // eslint-disable-next-line no-console
    console.error('Payment controller error:', error)
    try {
      fs.writeFileSync('logs/payment_error.log', error.stack || error.message || String(error))
    } catch (e) {
      // ignore log error
    }
    next(error)
  }
}

export const confirmMoMo = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { order_id } = req.body

    if (!order_id) {
      return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing order_id' })
    }

    // Update the overall order status to 'paid', payment status to 'paid', and payment method to 'momo'
    const updatedOrder = await orderModel.update({
      order_id: Number(order_id),
      status: OrderStatus.PAID,
      payment_status: 'paid',
      payment_method: 'momo'
    })

    if (!updatedOrder) {
      return res.status(StatusCodes.NOT_FOUND).json({ message: 'Order not found' })
    }

    res.status(StatusCodes.OK).json({ message: 'Payment confirmed successfully', order: updatedOrder })
  } catch (error) {
    next(error)
  }
}
