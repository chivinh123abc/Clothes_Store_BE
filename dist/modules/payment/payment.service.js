var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import crypto from 'crypto';
import axios from 'axios';
import { env } from '../../configs/environment.js';
export const createMoMoPaymentUrl = (orderId, amount, orderInfo) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b, _c, _d;
    const partnerCode = env.MOMO_PARTNER_CODE || 'MOMO';
    const accessKey = env.MOMO_ACCESS_KEY || 'F8BBA842ECF85';
    const secretKey = env.MOMO_SECRET_KEY || 'K951B6PE1waDMi640xX08PD3vg6EkVlz';
    const endpoint = env.MOMO_ENDPOINT || 'https://test-payment.momo.vn/v2/gateway/api/create';
    const requestId = partnerCode + new Date().getTime();
    const orderIdStr = 'T1-' + orderId + '-' + new Date().getTime(); // Ensure uniqueness in Sandbox
    const clientUrl = env.CLIENT_URL || 'http://localhost:5173';
    const redirectUrl = `${clientUrl}/checkout/momo-return`;
    const ipnUrl = `${clientUrl}/checkout/momo-return`; // Not used since localhost
    // Detect USD and convert to VND for MoMo's minimum 1000 VND limit
    let roundedAmount = Math.round(amount);
    if (roundedAmount < 1000) {
        roundedAmount = Math.round(amount * 25000);
    }
    const amountStr = roundedAmount.toString();
    const requestType = 'captureWallet';
    const extraData = Buffer.from(orderId.toString()).toString('base64'); // Pass actual DB orderId via extraData
    // Format signature string exactly as MoMo requires
    const rawSignature = `accessKey=${accessKey}&amount=${amountStr}&extraData=${extraData}&ipnUrl=${ipnUrl}&orderId=${orderIdStr}&orderInfo=${orderInfo}&partnerCode=${partnerCode}&redirectUrl=${redirectUrl}&requestId=${requestId}&requestType=${requestType}`;
    const signature = crypto.createHmac('sha256', secretKey).update(rawSignature).digest('hex');
    const requestBody = {
        partnerCode,
        partnerName: 'T1 E-SPORTS',
        storeId: 'T1 Store',
        requestId,
        amount: roundedAmount,
        orderId: orderIdStr,
        orderInfo,
        redirectUrl,
        ipnUrl,
        lang: 'vi',
        extraData,
        requestType,
        signature,
    };
    try {
        const response = yield axios.post(endpoint, requestBody);
        if (response.data && response.data.payUrl) {
            const testReturnUrl = `${redirectUrl}?resultCode=0&extraData=${extraData}`;
            // eslint-disable-next-line no-console
            console.log('\n==================================================');
            // eslint-disable-next-line no-console
            console.log(`[MOMO TEST CONFIRMATION LINK] 👇\n👉 ${testReturnUrl}`);
            // eslint-disable-next-line no-console
            console.log('==================================================\n');
            return response.data.payUrl;
        }
        else {
            throw new Error(((_a = response.data) === null || _a === void 0 ? void 0 : _a.message) || 'Cannot get MoMo payUrl');
        }
    }
    catch (error) {
        const detail = ((_c = (_b = error.response) === null || _b === void 0 ? void 0 : _b.data) === null || _c === void 0 ? void 0 : _c.message) || ((_d = error.response) === null || _d === void 0 ? void 0 : _d.data) || error.message;
        // eslint-disable-next-line no-console
        console.error('MoMo API Error:', detail);
        throw new Error(`Failed to create MoMo payment link: ${typeof detail === 'object' ? JSON.stringify(detail) : detail}`);
    }
});
//# sourceMappingURL=payment.service.js.map