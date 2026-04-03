# Sử dụng image Node.js 20 Alpine (nhẹ, bảo mật) làm công đoạn build
FROM node:20-alpine AS builder

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy file cấu hình package và cài đặt dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy toàn bộ source code
COPY . .

# Build project TypeScript
RUN yarn build

# Công đoạn chạy (Runner)
FROM node:20-alpine AS runner

WORKDIR /app

# Thiết lập môi trường production
ENV NODE_ENV=production

# Copy package.json và cài đặt production dependencies để giảm kích thước image
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

# Copy folder dist (code đã build) từ công đoạn builder
COPY --from=builder /app/dist ./dist

# Copy file documentation (VD: swagger.yaml) không được build bởi `tsc`
COPY --from=builder /app/src/docs ./src/docs

# Expose port mặc định, có thể ghi đè qua biến môi trường
EXPOSE 8000

# Lệnh chạy ứng dụng
CMD ["node", "dist/index.js"]
