-- Clear existing data
TRUNCATE TABLE product_collections,
collections,
product_configurations,
cart_items,
order_items,
product_items,
products,
variant_options,
variants,
categories,
discounts RESTART IDENTITY;

-- 1. Categories
INSERT INTO categories (category_name, category_slug) VALUES
('T-Shirt', 'tshirt'),
('Hoodie', 'hoodie'),
('Jacket', 'jacket'),
('Pants', 'pants'),
('Accessories', 'accessories'),
('Hat', 'hat'),
('Shoes', 'shoes'),
('Shirt', 'shirt'),
('Sweater', 'sweater');

-- 2. Root Collections
INSERT INTO collections (collection_name, collection_slug, description) VALUES
('TEAM KIT', 'team-kit', 'Official team jerseys and gear'),
('COLLECTION', 'collection', 'Main season collections'),
('COLLABORATION', 'collaboration', 'Limited edition collaborations with other brands'),
('LEGACY', 'legacy', 'Archive of past collections');

-- 3. Sub-collections for COLLECTION
DO $$
DECLARE
    parent_id INT;
BEGIN
    SELECT collection_id INTO parent_id FROM collections WHERE collection_slug = 'collection';
    
    INSERT INTO collections (collection_name, collection_slug, parent_collection_id) VALUES
    ('ESSENTIAL', 'essential', parent_id),
    ('LEAGUE OF LEGENDS', 'league-of-legends', parent_id),
    ('VALORANT', 'valorant', parent_id);
END $$;

-- 4. Sub-sub-collections (GIFT & ACCESSORY / APPAREL)
DO $$
DECLARE
    ess_id INT;
    lol_id INT;
    val_id INT;
BEGIN
    SELECT collection_id INTO ess_id FROM collections WHERE collection_slug = 'essential';
    SELECT collection_id INTO lol_id FROM collections WHERE collection_slug = 'league-of-legends';
    SELECT collection_id INTO val_id FROM collections WHERE collection_slug = 'valorant';
    
    INSERT INTO collections (collection_name, collection_slug, parent_collection_id) VALUES
    ('GIFT & ACCESSORY', 'essential-gift-and-accessory', ess_id),
    ('APPAREL', 'essential-apparel', ess_id),
    
    ('GIFT & ACCESSORY', 'lol-gift-and-accessory', lol_id),
    ('APPAREL', 'lol-apparel', lol_id),
    
    ('GIFT & ACCESSORY', 'valorant-gift-and-accessory', val_id),
    ('APPAREL', 'valorant-apparel', val_id);
END $$;

-- 5. Sub-collections for COLLABORATION
DO $$
DECLARE
    parent_id INT;
BEGIN
    SELECT collection_id INTO parent_id FROM collections WHERE collection_slug = 'collaboration';
    
    INSERT INTO collections (collection_name, collection_slug, parent_collection_id) VALUES
    ('DISNEY', 'disney', parent_id),
    ('RINSTORE X GOALSTUDIO', 'rinstore-x-goalstudio', parent_id),
    ('RINSTORE X SECRETLAB', 'rinstore-x-secretlab', parent_id),
    ('RINSTORE X RAZER', 'rinstore-x-razer', parent_id);
END $$;

-- 6. Sub-collections for LEGACY
DO $$
DECLARE
    parent_id INT;
BEGIN
    SELECT collection_id INTO parent_id FROM collections WHERE collection_slug = 'legacy';
    
    INSERT INTO collections (collection_name, collection_slug, parent_collection_id) VALUES
    ('T1 2025 WORLDS COLLECTION', 'worlds-2025', parent_id),
    ('T1 2024 WORLDS COLLECTION', 'worlds-2024', parent_id),
    ('T1 2023 WORLDS COLLECTION', 'worlds-2023', parent_id),
    ('APPAREL', 'legacy-apparel', parent_id),
    ('GIFTS & ACCESSORIES', 'legacy-gifts', parent_id);
END $$;

-- 7. Discounts
INSERT INTO discounts (name, discount_percent) VALUES
('20% Off', 20),
('23% Off', 23),
('28% Off', 28);

-- 8. Variants (Size for each category)
DO $$
DECLARE
    cat_rec RECORD;
    v_id INT;
BEGIN
    FOR cat_rec IN SELECT category_id, category_slug FROM categories LOOP
        INSERT INTO variants (category_id, variant_name, variant_slug) 
        VALUES (cat_rec.category_id, 'Size', 'size-' || cat_rec.category_slug)
        RETURNING variant_id INTO v_id;

        INSERT INTO variant_options (variant_id, variant_option_value, variant_option_slug) VALUES 
        (v_id, 'S', 'size-' || cat_rec.category_slug || '-s'),
        (v_id, 'M', 'size-' || cat_rec.category_slug || '-m'),
        (v_id, 'L', 'size-' || cat_rec.category_slug || '-l'),
        (v_id, 'XL', 'size-' || cat_rec.category_slug || '-xl'),
        (v_id, 'XXL', 'size-' || cat_rec.category_slug || '-xxl');
    END LOOP;
END $$;

-- 9. Static Products (Products 1 - 13)

DO $$
DECLARE
    p_id INT;
BEGIN
    -- 1. Essential Black Hoodie
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Essential Black Hoodie', 'essential-black-hoodie', 'A must-have for any wardrobe. This heavyweight cotton hoodie offers a relaxed fit and clean T1 branding on the chest.', category_id 
    FROM categories WHERE category_slug = 'hoodie' RETURNING product_id INTO p_id;
    
    INSERT INTO product_collections (product_id, collection_id)
    SELECT p_id, collection_id FROM collections WHERE collection_slug IN ('essential', 'essential-apparel');
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'ES-BK-HO-M', 100, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&q=80&w=1080', 89.99);

    -- 2. Oversized White Shirt
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Oversized White Shirt', 'oversized-white-shirt', 'Crisp, clean, and perfectly oversized. This white shirt is designed with a modern silhouette and premium poplin fabric.', category_id 
    FROM categories WHERE category_slug = 'shirt' RETURNING product_id INTO p_id;
    
    INSERT INTO product_collections (product_id, collection_id)
    SELECT p_id, collection_id FROM collections WHERE collection_slug IN ('essential', 'essential-apparel');
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'OV-WH-SH-L', 0, 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?auto=format&fit=crop&q=80&w=1080', 69.99);

    -- 3. Beige Cargo Pants
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Beige Cargo Pants', 'beige-cargo-pants', 'Functional meets fashion. Multiple pockets and a tapered fit make these cargo pants the ultimate streetwear essential.', category_id 
    FROM categories WHERE category_slug = 'pants' RETURNING product_id INTO p_id;
    
    INSERT INTO product_collections (product_id, collection_id)
    SELECT p_id, collection_id FROM collections WHERE collection_slug IN ('valorant', 'valorant-apparel');
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price, discount_id)
    SELECT p_id, 'BE-CA-PA-M', 50, 'https://images.unsplash.com/photo-1605518216938-7c31b7b14ad0?auto=format&fit=crop&q=80&w=1080', 99.99, discount_id 
    FROM discounts WHERE discount_percent = 20;

    -- 4. Premium Leather Jacket
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Premium Leather Jacket', 'premium-leather-jacket', 'Forged from top-grain leather, this jacket features custom T1 embossed hardware and a quilted satin lining.', category_id 
    FROM categories WHERE category_slug = 'jacket' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'PR-LE-JA-L', 0, 'https://images.unsplash.com/photo-1591047139829-d91aec369a70?auto=format&fit=crop&q=80&w=1080', 299.99);

    -- 5. Minimal Gray Sweater
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Minimal Gray Sweater', 'minimal-gray-sweater', 'Subtle gray tones and a soft mohair blend. Ideal for layering during the colder seasons.', category_id 
    FROM categories WHERE category_slug = 'sweater' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'MI-GR-SW-M', 120, 'https://images.unsplash.com/photo-1578762560072-46ef14a5a7f9?auto=format&fit=crop&q=80&w=1080', 79.99);

    -- 6. Classic Denim Jacket
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Classic Denim Jacket', 'classic-denim-jacket', 'A timeless classic. Distressed details and a regular fit, perfect for any casual outfit.', category_id 
    FROM categories WHERE category_slug = 'jacket' RETURNING product_id INTO p_id;
    
    INSERT INTO product_collections (product_id, collection_id)
    SELECT p_id, collection_id FROM collections WHERE collection_slug = 'worlds-2024';
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price, discount_id)
    SELECT p_id, 'CL-DE-JA-XL', 40, 'https://images.unsplash.com/photo-1544022613-e87f17a784de?auto=format&fit=crop&q=80&w=1080', 129.99, discount_id 
    FROM discounts WHERE discount_percent = 23;

    -- 7. White Minimal Sneakers
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'White Minimal Sneakers', 'white-minimal-sneakers', 'Ultra-clean white sneakers with a vulcanized rubber sole and comfortable cushioned insole.', category_id 
    FROM categories WHERE category_slug = 'shoes' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'WH-MI-SN-42', 0, 'https://images.unsplash.com/photo-1542291026-7eec264c274f?auto=format&fit=crop&q=80&w=1080', 119.99);

    -- 8. Streetwear Collection Set
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Streetwear Collection Set', 'streetwear-collection-set', 'The ultimate combo. A matching hoodie and joggers set that balances comfort with a high-fashion look.', category_id 
    FROM categories WHERE category_slug = 'hoodie' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'ST-CO-SE-M', 15, 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&q=80&w=1080', 189.99);

    -- 9. Urban Black Tee
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Urban Black Tee', 'urban-black-tee', 'Your fundamental black tee, upgraded with a dense luxury cotton and a silver-threaded logo.', category_id 
    FROM categories WHERE category_slug = 'tshirt' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'UR-BK-TE-L', 200, 'https://images.unsplash.com/photo-1562157873-818bc0726f68?auto=format&fit=crop&q=80&w=1080', 49.99);

    -- 10. Premium White Polo
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Premium White Polo', 'premium-white-polo', 'Sophisticated yet sporty. This polo features a breathable mesh-knit and a customized T1 collar.', category_id 
    FROM categories WHERE category_slug = 'shirt' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'PR-WH-PO-M', 0, 'https://images.unsplash.com/photo-1576566588028-4147f342f27?auto=format&fit=crop&q=80&w=1080', 89.99);

    -- 11. Faker Unkillable Demon King Jacket
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'Faker Unkillable Demon King Jacket', 'faker-unkillable-demon-king-jacket', 'The official commemorative jacket for Lee "Faker" Sang-hyeok. Features embroidery inspired by his legendary plays.', category_id 
    FROM categories WHERE category_slug = 'jacket' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'FA-UD-JA-L', 300, 'https://images.unsplash.com/photo-1591047139829-d91aec369a70?auto=format&fit=crop&q=80&w=1080', 150.00);

    -- 12. T1 Logo Essential Socks
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'T1 Logo Essential Socks', 't1-logo-essential-socks', 'Premium combed cotton socks with embroidered T1 logos. Cushioned for all-day gaming sessions.', category_id 
    FROM categories WHERE category_slug = 'accessories' RETURNING product_id INTO p_id;
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'T1-LO-SO-ONE', 500, 'https://images.unsplash.com/photo-1582966772680-860e372bb558?auto=format&fit=crop&q=80&w=1080', 24.99);

    -- 13. T1 Official Team Jersey 2024
    INSERT INTO products (product_name, product_slug, product_description, category_id)
    SELECT 'T1 Official Team Jersey 2024', 't1-official-team-jersey-2024', 'The exact jersey worn by Faker and the team during the 2024 Season. Lightweight and aerodynamic.', category_id 
    FROM categories WHERE category_slug = 'tshirt' RETURNING product_id INTO p_id;
    
    INSERT INTO product_collections (product_id, collection_id)
    SELECT p_id, collection_id FROM collections WHERE collection_slug = 'team-kit';
    
    INSERT INTO product_items (product_id, sku, stock_quantity, product_item_image, product_item_price)
    VALUES (p_id, 'T1-JE-24-M', 800, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&q=80&w=1080', 110.00);

END $$;

-- 10. Link Product Configurations (Size) for all items
INSERT INTO product_configurations (product_item_id, variant_option_id)
SELECT pi.product_item_id, vo.variant_option_id
FROM product_items pi
JOIN products p ON pi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN variants v ON v.category_id = c.category_id AND v.variant_name = 'Size'
JOIN variant_options vo ON vo.variant_id = v.variant_id
WHERE (pi.sku LIKE '%-S' AND vo.variant_option_value = 'S')
   OR (pi.sku LIKE '%-M' AND vo.variant_option_value = 'M')
   OR (pi.sku LIKE '%-L' AND vo.variant_option_value = 'L')
   OR (pi.sku LIKE '%-XL' AND vo.variant_option_value = 'XL')
   OR (pi.sku LIKE '%-XXL' AND vo.variant_option_value = 'XXL')
   OR (pi.sku LIKE '%-ONE' AND vo.variant_option_value = 'M'); -- Fallback for accessories
