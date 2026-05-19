var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { StatusCodes } from 'http-status-codes';
import OpenAI from 'openai';
export const analyzeFashion = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        const { userImageUrl, productImageUrl, productDescription } = req.body;
        if (!userImageUrl || !productImageUrl) {
            return res.status(StatusCodes.BAD_REQUEST).json({ message: 'Missing userImageUrl or productImageUrl' });
        }
        const apiKey = process.env.OPENAI_API_KEY;
        if (!apiKey) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ message: 'OPENAI_API_KEY is not configured in the backend' });
        }
        const openai = new OpenAI({ apiKey });
        const response = yield openai.chat.completions.create({
            model: 'gpt-4o',
            messages: [
                {
                    role: 'system',
                    content: `You are an expert AI fashion advisor. You will receive an image of the user and an image of a clothing product. Your task is to analyze the user's body type, skin tone, and overall vibe, and provide detailed, personalized fashion advice in Vietnamese. Explain how the item fits them, suggest the ideal size, and provide styling tips. Format your response beautifully in Markdown.`
                },
                {
                    role: 'user',
                    content: [
                        { type: 'text', text: `Here is the user's photo:` },
                        { type: 'image_url', image_url: { url: userImageUrl } },
                        { type: 'text', text: `Here is the product they want to try on. Product Description: ${productDescription || 'A stylish item'}` },
                        { type: 'image_url', image_url: { url: productImageUrl } }
                    ]
                }
            ],
            max_tokens: 1000
        });
        const advice = ((_b = (_a = response.choices[0]) === null || _a === void 0 ? void 0 : _a.message) === null || _b === void 0 ? void 0 : _b.content) || 'Xin lỗi, tôi không thể phân tích hình ảnh lúc này.';
        res.status(StatusCodes.OK).json({ advice });
    }
    catch (error) {
        // eslint-disable-next-line no-console
        console.error('Advisor controller error:', error);
        next(error);
    }
});
//# sourceMappingURL=advisor.controller.js.map