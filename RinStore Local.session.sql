-- user
CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  role SMALLINT DEFAULT(0),
  status SMALLINT DEFAULT(0),
  avatar TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  verify_token VARCHAR(255),
  is_active BOOLEAN DEFAULT false,
  is_destroy BOOLEAN DEFAULT false
);
CREATE TABLE IF NOT EXISTS categories (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  category_slug VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS products(
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  product_slug VARCHAR(255) UNIQUE NOT NULL,
  category_id INT NOT NULL REFERENCES categories(category_id) ON DELETE RESTRICT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS product_items(
  product_item_id SERIAL PRIMARY KEY,
  product_id INT NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
  sku VARCHAR(255) UNIQUE,
  stock_quantity INT,
  product_item_image TEXT,
  product_item_price DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS variations(
  variation_id SERIAL PRIMARY KEY,
  category_id INT NOT NULL REFERENCES categories(category_id) ON DELETE RESTRICT,
  variation_name VARCHAR(255) NOT NULL,
  variation_slug VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS variation_options(
  variation_option_id SERIAL PRIMARY KEY,
  variation_id INT NOT NULL REFERENCES variations(variation_id) ON DELETE RESTRICT,
  variation_option_value VARCHAR(255) NOT NULL,
  variation_option_slug VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS product_configurations(
  product_item_id INT NOT NULL REFERENCES product_items(product_item_id) ON DELETE RESTRICT,
  variation_option_id INT NOT NULL REFERENCES variation_options(variation_option_id) ON DELETE RESTRICT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  PRIMARY KEY (product_item_id, variation_option_id)
);
--order
DO $$ BEGIN IF NOT EXISTS (
  SELECT 1
  FROM pg_type
  WHERE typname = 'order_status'
) THEN CREATE TYPE order_status AS ENUM ('pending', 'paid', 'shipped');
END IF;
END $$;
CREATE TABLE IF NOT EXISTS orders(
  order_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT,
  status order_status NOT NULL DEFAULT 'pending',
  total_amount DECIMAL(10, 2),
  comment TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS order_items(
  order_item_id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE RESTRICT,
  product_item_id INT NOT NULL REFERENCES product_items(product_item_id) ON DELETE RESTRICT,
  quantity INT NOT NULL,
  unit_price DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP
);