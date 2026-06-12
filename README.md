# Clothes Store — Backend

A Node.js + PostgreSQL + Redis backend for the Clothes Store e-commerce project.

---

## Prerequisites

Make sure you have the following installed:

| Tool | Version | Notes |
|------|---------|-------|
| Node.js | v18+ | Required |
| PostgreSQL | v15 | Required (or use Docker) |
| Redis | any | Required (or use Docker) |
| Docker + Docker Compose | latest | Optional but recommended |

---

## Environment Setup

Copy the example env file and fill in the values:

```bash
cp .env.example .env
```

Key variables to configure:

| Variable | Description | Example |
|----------|-------------|---------|
| `DB_HOST` | PostgreSQL host | `localhost` |
| `DB_PORT` | PostgreSQL port | `5432` |
| `DB_USER` | PostgreSQL user | `postgres` |
| `DB_PASSWORD` | PostgreSQL password | `yourpassword` |
| `DB_NAME` | Database name | `clothes_store_db` |
| `PORT` | API server port | `3000` |
| `CLIENT_URL` | Frontend origin (CORS) | `http://localhost:5173` |
| `REDIS_HOST` | Redis host | `localhost` |
| `REDIS_PORT` | Redis port | `6379` |
| `MAIL_HOST` | SMTP host | `smtp.gmail.com` |
| `MAIL_USER` | Email address | `yourmail@gmail.com` |
| `MAIL_PASSWORD` | Gmail App Password | 16-char app password |
| `MOMO_PARTNER_CODE` | MoMo sandbox partner code | `MOMO` |
| `MOMO_ACCESS_KEY` | MoMo sandbox access key | provided by MoMo |
| `MOMO_SECRET_KEY` | MoMo sandbox secret key | provided by MoMo |
| `MOMO_ENDPOINT` | MoMo API endpoint | `https://test-payment.momo.vn/v2/gateway/api/create` |
| `CLOUDINARY_CLOUD_NAME` | Cloudinary cloud name | from cloudinary.com dashboard |
| `CLOUDINARY_API_KEY` | Cloudinary API key | from cloudinary.com dashboard |
| `CLOUDINARY_API_SECRET` | Cloudinary API secret | from cloudinary.com dashboard |

> **Gmail App Password**: Go to Google Account → Security → 2-Step Verification → App Passwords → Generate one for "Mail".

> **MoMo Sandbox**: Register at [developers.momo.vn](https://developers.momo.vn) to get sandbox credentials.

> **Cloudinary**: Register at [cloudinary.com](https://cloudinary.com) (free tier is sufficient).

---

## Option A — Run with Docker (Recommended)

Spins up PostgreSQL, Redis, and the API all at once. No manual DB setup needed.

```bash
# 1. Copy and fill in .env.docker (same fields as .env)
cp .env.example .env.docker

# 2. Build and start all services
docker-compose up -d --build

# 3. Import the database schema + data
#    Find your running DB container name:
docker ps

#    Then import (replace 'rinstore_db' with your container name if different):
docker exec -i rinstore_db psql -U postgres -f /dev/stdin < clothes_store.sql
```

### Stop

```bash
docker-compose down
```

### Stop and wipe all data

```bash
docker-compose down -v
```

---

## Option B — Run Locally (Manual Setup)

### 1. Create the database

Open pgAdmin or psql and run:

```sql
CREATE DATABASE clothes_store_db;
```

> **Note**: The `clothes_store.sql` file already includes a `DROP DATABASE` and `CREATE DATABASE` statement at the top,
> so if you import it directly via psql as the `postgres` superuser, it will handle creation automatically.
> However, if you use pgAdmin's restore tool, create the DB manually first and skip those first lines.

### 2. Import the schema and data

**Using psql (terminal):**

```bash
psql -U postgres -f clothes_store.sql
```

**Using pgAdmin:**
1. Right-click on `clothes_store_db` → **Query Tool**
2. Open `clothes_store.sql` and run it (skip lines 22–31 if DB already exists)

### 3. Install dependencies

```bash
yarn install
```

### 4. Start the dev server

```bash
yarn dev
```

The API will be available at `http://localhost:3000` (or whichever `PORT` you set).

---

## Payment Methods Supported

| Method | Value stored in DB | Notes |
|--------|--------------------|-------|
| Cash On Delivery | `cod` | Default method |
| MoMo E-Wallet | `momo` | Requires MoMo sandbox credentials in `.env` |

---

## Database Overview

The main tables are:

| Table | Description |
|-------|-------------|
| `users` | Customers and admins (`role`: 0 = customer, 1 = admin) |
| `products` | Product catalog |
| `product_items` | Variants (size / SKU) per product |
| `orders` | Customer orders (`payment_method`: `cod` or `momo`) |
| `order_items` | Line items per order |
| `categories` | Product categories |
| `collections` | Product collections |
| `discounts` | Discount campaigns |
| `carts` / `cart_items` | Shopping cart |
| `reviews` | Product reviews |