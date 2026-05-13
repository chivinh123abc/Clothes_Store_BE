import nodemailer from 'nodemailer'
import { env } from '../configs/environment.js'

const transporter = nodemailer.createTransport({
  host: env.MAIL_HOST,
  port: Number(env.MAIL_PORT),
  secure: Number(env.MAIL_PORT) === 465, // true for port 465, false for other ports
  auth: {
    user: env.MAIL_USER,
    pass: env.MAIL_PASSWORD
  }
})

const sendVerificationEmail = async (to: string, username: string, token: string) => {
  const verificationUrl = `${env.CLIENT_URL}/verify-account?email=${to}&token=${token}`

  const mailOptions = {
    from: env.MAIL_FROM_ADDRESS,
    to: to,
    subject: 'Activate your account',
    html: `
      <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;">
        <h2 style="color: #333;">Welcome to Rinstore, ${username}!</h2>
        <p>Thank you for registering. Please click the button below to activate your account:</p>
        <div style="text-align: center; margin: 30px 0;">
          <a href="${verificationUrl}" style="background-color: #007bff; color: white; padding: 12px 24px; text-decoration: none; border-radius: 5px; font-weight: bold;">Activate Account</a>
        </div>
        <p>If the button doesn't work, you can also copy and paste the following link into your browser:</p>
        <p style="word-break: break-all;"><a href="${verificationUrl}">${verificationUrl}</a></p>
        <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
        <p style="font-size: 12px; color: #777;">If you didn't create an account, you can safely ignore this email.</p>
      </div>
    `
  }

  return await transporter.sendMail(mailOptions)
}

export const MailProvider = {
  sendVerificationEmail
}
