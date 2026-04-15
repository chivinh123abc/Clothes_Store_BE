-- Clear existing data
TRUNCATE TABLE product_configurations, cart_items, order_items, product_items, products, variant_options, variants, categories, discounts RESTART IDENTITY;

-- Categories
INSERT INTO categories (category_name, category_slug) VALUES 
('T-Shirt', 'tshirt'),
('Hoodie', 'hoodie'),
('Jacket', 'jacket'),
('Pants', 'pants'),
('Accessories', 'accessories'),
('Hat', 'hat'),
('Shoes', 'shoes'),
('Shirt', 'shirt'),
('Sweater', 'sweater'),
('Collection', 'collection');

-- Variants (Size for each category)
DO $$
DECLARE
    cat_rec RECORD;
    v_id INT;
BEGIN
    FOR cat_rec IN SELECT category_id, category_slug FROM categories LOOP
        INSERT INTO variants (category_id, variant_name, variant_slug) 
        VALUES (cat_rec.category_id, 'Size', 'size-' || cat_rec.category_slug)
        RETURNING variant_id INTO v_id;

        -- Variant Options
        INSERT INTO variant_options (variant_id, variant_option_value, variant_option_slug) VALUES 
        (v_id, 'S', 'size-' || cat_rec.category_slug || '-s'),
        (v_id, 'M', 'size-' || cat_rec.category_slug || '-m'),
        (v_id, 'L', 'size-' || cat_rec.category_slug || '-l'),
        (v_id, 'XL', 'size-' || cat_rec.category_slug || '-xl'),
        (v_id, 'XXL', 'size-' || cat_rec.category_slug || '-xxl');
    END LOOP;
END $$;

-- Discounts
INSERT INTO discounts (name, discount_percent) VALUES 
('20% Off', 20),
('23% Off', 23),
('28% Off', 28);

-- Products & Product Items
-- 1. Essential Black Hoodie
WITH p AS (
    INSERT INTO products (product_name, product_slug, category_id) 
    SELECT 'Essential Black Hoodie', 'essential-black-hoodie', category_id FROM categories WHERE category_slug = 'hoodie'
    RETURNING product_id
)
INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
SELECT product_id, 'ES-HO-S', 100, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&q=80&w=1080', 89.99 FROM p
UNION ALL
SELECT product_id, 'ES-HO-M', 100, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&q=80&w=1080', 89.99 FROM p
UNION ALL
SELECT product_id, 'ES-HO-L', 100, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&q=80&w=1080', 89.99 FROM p;

-- 2. Oversized White Shirt
WITH p AS (
    INSERT INTO products (product_name, product_slug, category_id) 
    SELECT 'Oversized White Shirt', 'oversized-white-shirt', category_id FROM categories WHERE category_slug = 'shirt'
    RETURNING product_id
)
INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
SELECT product_id, 'OV-SH-M', 100, 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?auto=format&fit=crop&q=80&w=1080', 69.99 FROM p
UNION ALL
SELECT product_id, 'OV-SH-L', 100, 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?auto=format&fit=crop&q=80&w=1080', 69.99 FROM p;

-- 3. Beige Cargo Pants (With 20% Discount)
WITH p AS (
    INSERT INTO products (product_name, product_slug, category_id) 
    SELECT 'Beige Cargo Pants', 'beige-cargo-pants', category_id FROM categories WHERE category_slug = 'pants'
    RETURNING product_id
), 
d AS (SELECT discount_id FROM discounts WHERE discount_percent = 20 LIMIT 1)
INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price, discount_id)
SELECT p.product_id, 'BE-CA-M', 100, 'https://images.unsplash.com/photo-1605518216938-7c31b7b14ad0?auto=format&fit=crop&q=80&w=1080', 99.99, d.discount_id FROM p, d
UNION ALL
SELECT p.product_id, 'BE-CA-L', 100, 'https://images.unsplash.com/photo-1605518216938-7c31b7b14ad0?auto=format&fit=crop&q=80&w=1080', 99.99, d.discount_id FROM p, d;

-- 4. Classic Denim Jacket (With 23% Discount)
WITH p AS (
    INSERT INTO products (product_name, product_slug, category_id) 
    SELECT 'Classic Denim Jacket', 'classic-denim-jacket', category_id FROM categories WHERE category_slug = 'jacket'
    RETURNING product_id
),
d AS (SELECT discount_id FROM discounts WHERE discount_percent = 23 LIMIT 1)
INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price, discount_id)
SELECT p.product_id, 'CL-DE-L', 100, 'https://images.unsplash.com/photo-1544022613-e87f17a784de?auto=format&fit=crop&q=80&w=1080', 129.99, d.discount_id FROM p, d
UNION ALL
SELECT p.product_id, 'CL-DE-XL', 100, 'https://images.unsplash.com/photo-1544022613-e87f17a784de?auto=format&fit=crop&q=80&w=1080', 129.99, d.discount_id FROM p, d;

-- 5. T1 Official Team Jersey 2024
WITH p AS (
    INSERT INTO products (product_name, product_slug, category_id) 
    SELECT 'T1 Official Team Jersey 2024', 't1-official-team-jersey-2024', category_id FROM categories WHERE category_slug = 'tshirt'
    RETURNING product_id
)
INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
SELECT product_id, 'T1-JE-M', 100, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&q=80&w=1080', 110.00 FROM p
UNION ALL
SELECT product_id, 'T1-JE-L', 100, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&q=80&w=1080', 110.00 FROM p;

-- Link Product Configurations (Size)
-- Linking based on SKU suffix and category_slug
INSERT INTO product_configurations (product_item_id, variant_option_id)
SELECT pi.product_item_id, vo.variant_option_id
FROM product_items pi
JOIN products p ON pi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN variants v ON v.category_id = c.category_id AND v.variant_name = 'Size'
JOIN variant_options vo ON vo.variant_id = v.variant_id
WHERE 
    (pi.sku LIKE '%-S' AND vo.variant_option_value = 'S') OR
    (pi.sku LIKE '%-M' AND vo.variant_option_value = 'M') OR
    (pi.sku LIKE '%-L' AND vo.variant_option_value = 'L') OR
    (pi.sku LIKE '%-XL' AND vo.variant_option_value = 'XL') OR
    (pi.sku LIKE '%-XXL' AND vo.variant_option_value = 'XXL');
