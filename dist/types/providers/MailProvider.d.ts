export declare const MailProvider: {
    sendVerificationEmail: (to: string, username: string, token: string) => Promise<import("nodemailer/lib/smtp-transport/index.js").SentMessageInfo>;
    sendForgotPasswordEmail: (to: string, username: string, otpCode: string) => Promise<import("nodemailer/lib/smtp-transport/index.js").SentMessageInfo>;
};
