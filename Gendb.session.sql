-- USERS (10)
INSERT INTO
    users (
        username,
        email,
        password,
        role,
        status
    )
VALUES (
        'user1',
        'user1@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user2',
        'user2@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user3',
        'user3@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user4',
        'user4@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user5',
        'user5@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user6',
        'user6@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user7',
        'user7@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user8',
        'user8@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'user9',
        'user9@gmail.com',
        '123456',
        0,
        1
    ),
    (
        'admin',
        'admin@gmail.com',
        '123456',
        1,
        1
    );

-- CATEGORIES (6)
INSERT INTO
    categories (category_name, category_slug)
VALUES ('Áo', 'ao'),
    ('Quần', 'quan'),
    ('Giày', 'giay'),
    ('Phụ kiện', 'phu-kien'),
    ('Áo khoác', 'ao-khoac'),
    ('Đồ thể thao', 'do-the-thao');

-- PRODUCTS (10)
INSERT INTO
    products (
        product_name,
        product_slug,
        category_id
    )
VALUES (
        'Áo thun basic',
        'ao-thun-basic',
        1
    ),
    ('Áo hoodie', 'ao-hoodie', 1),
    ('Áo polo', 'ao-polo', 1),
    (
        'Quần jean slim',
        'quan-jean-slim',
        2
    ),
    ('Quần short', 'quan-short', 2),
    (
        'Giày sneaker',
        'giay-sneaker',
        3
    ),
    (
        'Giày running',
        'giay-running',
        3
    ),
    (
        'Nón lưỡi trai',
        'non-luoi-trai',
        4
    ),
    (
        'Áo khoác gió',
        'ao-khoac-gio',
        5
    ),
    (
        'Bộ đồ thể thao',
        'bo-do-the-thao',
        6
    );

-- VARIANTS (2)
INSERT INTO
    variants (
        category_id,
        variant_name,
        variant_slug
    )
VALUES (1, 'Size', 'size'),
    (1, 'Màu', 'mau');

-- VARIANT OPTIONS (8)
INSERT INTO
    variant_options (
        variant_id,
        variant_option_value,
        variant_option_slug
    )
VALUES (1, 'size-s', 'size-s'),
    (1, 'size-m', 'size-m'),
    (1, 'size-l', 'size-l'),
    (1, 'size-xl', 'size-xl'),
    (2, 'mau-den', 'mau-den'),
    (2, 'mau-trang', 'mau-trang'),
    (2, 'mau-xanh', 'mau-xanh'),
    (2, 'mau-do', 'mau-do');

-- PRODUCT ITEMS (15)
INSERT INTO
    product_items (
        product_id,
        sku,
        stock_quantity,
        product_item_price
    )
VALUES (1, 'ATB-SS', 50, 199000),
    (1, 'ATB-SM', 60, 199000),
    (1, 'ATB-SL', 40, 199000),
    (1, 'ATB-SXL', 30, 199000),
    (1, 'ATB-MD', 50, 199000),
    (2, 'AH-SS', 30, 299000),
    (2, 'AH-SM', 30, 299000),
    (2, 'AH-SL', 30, 299000),
    (3, 'AP-SS', 40, 249000),
    (3, 'AP-SM', 40, 249000),
    (4, 'QJS-SS', 35, 399000),
    (4, 'QJS-SM', 35, 399000),
    (5, 'QS-SS', 25, 199000),
    (6, 'GS-SS', 20, 599000),
    (7, 'GR-SS', 20, 699000);

-- PRODUCT CONFIGURATIONS (15)
INSERT INTO
    product_configurations (
        product_item_id,
        variant_option_id
    )
VALUES (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 1),
    (7, 2),
    (8, 3),
    (9, 1),
    (10, 2),
    (11, 1),
    (12, 2),
    (13, 1),
    (14, 1),
    (15, 1);

-- ORDERS (10)
INSERT INTO
    orders (user_id, status, total_amount)
VALUES (1, 'pending', 200000),
    (2, 'paid', 300000),
    (3, 'shipped', 500000),
    (4, 'pending', 150000),
    (5, 'paid', 250000),
    (6, 'shipped', 600000),
    (7, 'pending', 180000),
    (8, 'paid', 320000),
    (9, 'shipped', 700000),
    (10, 'pending', 100000);

-- ORDER ITEMS (15)
INSERT INTO
    order_items (
        order_id,
        product_item_id,
        quantity,
        unit_price
    )
VALUES (1, 1, 1, 199000),
    (1, 2, 2, 199000),
    (2, 6, 1, 299000),
    (3, 11, 1, 399000),
    (4, 13, 1, 199000),
    (5, 14, 1, 599000),
    (6, 15, 1, 699000),
    (7, 3, 1, 199000),
    (8, 7, 2, 299000),
    (9, 9, 1, 249000),
    (10, 5, 1, 199000),
    (2, 4, 1, 199000),
    (3, 8, 1, 299000),
    (4, 10, 1, 249000),
    (5, 12, 1, 399000);

-- CARTS (10)
INSERT INTO
    carts (user_id)
VALUES (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10);

-- CART ITEMS (15)
INSERT INTO
    cart_items (
        cart_id,
        product_item_id,
        quantity,
        price
    )
VALUES (1, 1, 1, 199000),
    (1, 2, 2, 199000),
    (2, 6, 1, 299000),
    (3, 11, 1, 399000),
    (4, 13, 1, 199000),
    (5, 14, 1, 599000),
    (6, 15, 1, 699000),
    (7, 3, 1, 199000),
    (8, 7, 2, 299000),
    (9, 9, 1, 249000),
    (10, 5, 1, 199000),
    (2, 4, 1, 199000),
    (3, 8, 1, 299000),
    (4, 10, 1, 249000),
    (5, 12, 1, 399000);