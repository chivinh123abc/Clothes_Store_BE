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
    category_description TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_slug VARCHAR(255) UNIQUE NOT NULL,
    product_description TEXT,
    is_featured BOOLEAN DEFAULT FALSE,
    is_bestseller BOOLEAN DEFAULT FALSE,
    category_id INT NOT NULL REFERENCES categories (category_id) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS discounts (
    discount_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    discount_percent INT NOT NULL,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_items (
    product_item_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products (product_id) ON DELETE RESTRICT,
    sku VARCHAR(255) UNIQUE,
    stock_quantity INT,
    product_item_image TEXT,
    product_item_price DECIMAL(10, 2),
    discount_id INT REFERENCES discounts (discount_id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS variants (
    variant_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL REFERENCES categories (category_id) ON DELETE RESTRICT,
    variant_name VARCHAR(255) NOT NULL,
    variant_slug VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS variant_options (
    variant_option_id SERIAL PRIMARY KEY,
    variant_id INT NOT NULL REFERENCES variants (variant_id) ON DELETE RESTRICT,
    variant_option_value VARCHAR(255) NOT NULL,
    variant_option_slug VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_configurations (
    product_item_id INT NOT NULL REFERENCES product_items (product_item_id) ON DELETE RESTRICT,
    variant_option_id INT NOT NULL REFERENCES variant_options (variant_option_id) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP,
    PRIMARY KEY (
        product_item_id,
        variant_option_id
    )
);
--order
DO $$ BEGIN IF NOT EXISTS (
  SELECT 1
  FROM pg_type
  WHERE typname = 'order_status'
) THEN CREATE TYPE order_status AS ENUM ('pending', 'paid', 'shipped');
END IF;
END $$;

CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users (user_id) ON DELETE RESTRICT,
    status order_status NOT NULL DEFAULT 'pending',
    total_amount DECIMAL(10, 2),
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders (order_id) ON DELETE RESTRICT,
    product_item_id INT NOT NULL REFERENCES product_items (product_item_id) ON DELETE RESTRICT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS carts (
    cart_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users (user_id) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cart_items (
    cart_item_id SERIAL PRIMARY KEY,
    cart_id INT NOT NULL REFERENCES carts (cart_id) ON DELETE RESTRICT,
    product_item_id INT NOT NULL REFERENCES product_items (product_item_id) ON DELETE RESTRICT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS collections (
    collection_id SERIAL PRIMARY KEY,
    collection_name VARCHAR(255) NOT NULL,
    collection_slug VARCHAR(255) UNIQUE NOT NULL,
    parent_collection_id INT REFERENCES collections (collection_id) ON DELETE SET NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_collections (
    product_id INT NOT NULL REFERENCES products (product_id) ON DELETE CASCADE,
    collection_id INT NOT NULL REFERENCES collections (collection_id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, collection_id)
);