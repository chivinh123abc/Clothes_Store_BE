--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-05-15 18:57:11

SET statement_timeout = 0;

SET lock_timeout = 0;

SET idle_in_transaction_session_timeout = 0;

SET transaction_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = on;

SELECT pg_catalog.set_config ('search_path', '', false);

SET check_function_bodies = false;

SET xmloption = content;

SET client_min_messages = warning;

SET row_security = off;

DROP DATABASE clothes_store_db;
--
-- TOC entry 5076 (class 1262 OID 16587)
-- Name: clothes_store_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE clothes_store_db
WITH
    TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';

ALTER DATABASE clothes_store_db OWNER TO postgres;

\connect clothes_store_db

SET statement_timeout = 0;

SET lock_timeout = 0;

SET idle_in_transaction_session_timeout = 0;

SET transaction_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = on;

SELECT pg_catalog.set_config ('search_path', '', false);

SET check_function_bodies = false;

SET xmloption = content;

SET client_min_messages = warning;

SET row_security = off;

--
-- TOC entry 874 (class 1247 OID 16701)
-- Name: order_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status AS ENUM (
    'pending',
    'paid',
    'shipped',
    'shipping',
    'completed',
    'cancelled'
);

ALTER TYPE public.order_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 239 (class 1259 OID 17140)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    cart_item_id integer NOT NULL,
    cart_id integer NOT NULL,
    product_item_id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(10, 2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.cart_items OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17139)
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_cart_item_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 238
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNED BY public.cart_items.cart_item_id;

--
-- TOC entry 237 (class 1259 OID 17127)
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    cart_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.carts OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17126)
-- Name: carts_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_cart_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.carts_cart_id_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 236
-- Name: carts_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_cart_id_seq OWNED BY public.carts.cart_id;

--
-- TOC entry 220 (class 1259 OID 16981)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL,
    category_slug character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    category_description text
);

ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16980)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 219
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;

--
-- TOC entry 241 (class 1259 OID 17202)
-- Name: collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collections (
    collection_id integer NOT NULL,
    collection_name character varying(255) NOT NULL,
    collection_slug character varying(255) NOT NULL,
    parent_collection_id integer,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.collections OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17201)
-- Name: collections_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collections_collection_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.collections_collection_id_seq OWNER TO postgres;

--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 240
-- Name: collections_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collections_collection_id_seq OWNED BY public.collections.collection_id;

--
-- TOC entry 224 (class 1259 OID 17010)
-- Name: discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discounts (
    discount_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    discount_percent integer NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.discounts OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17009)
-- Name: discounts_discount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discounts_discount_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.discounts_discount_id_seq OWNER TO postgres;

--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 223
-- Name: discounts_discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discounts_discount_id_seq OWNED BY public.discounts.discount_id;

--
-- TOC entry 235 (class 1259 OID 17109)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    product_item_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10, 2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17108)
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_order_item_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.order_items_order_item_id_seq OWNER TO postgres;

--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 234
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;

--
-- TOC entry 233 (class 1259 OID 17093)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    status public.order_status DEFAULT 'pending'::public.order_status NOT NULL,
    total_amount numeric(10,2),
    comment text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    payment_method character varying(50) DEFAULT 'cod'::character varying,
    payment_status character varying(20) DEFAULT 'unpaid'::character varying
);

ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17092)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 232
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;

--
-- TOC entry 242 (class 1259 OID 17218)
-- Name: product_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_collections (
    product_id integer NOT NULL,
    collection_id integer NOT NULL
);

ALTER TABLE public.product_collections OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17076)
-- Name: product_configurations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_configurations (
    product_item_id integer NOT NULL,
    variant_option_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.product_configurations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17021)
-- Name: product_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_items (
    product_item_id integer NOT NULL,
    product_id integer NOT NULL,
    sku character varying(255),
    stock_quantity integer,
    product_item_image text,
    product_item_price numeric(10, 2),
    discount_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.product_items OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17020)
-- Name: product_items_product_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_items_product_item_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.product_items_product_item_id_seq OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 225
-- Name: product_items_product_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_items_product_item_id_seq OWNED BY public.product_items.product_item_id;

--
-- TOC entry 222 (class 1259 OID 16993)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    product_slug character varying(255) NOT NULL,
    category_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    product_description text,
    is_bestseller boolean DEFAULT false
);

ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16992)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 221
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;

--
-- TOC entry 218 (class 1259 OID 16589)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    phone_number character varying(20),
    role smallint DEFAULT 0,
    status smallint DEFAULT 0,
    avatar text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    verify_token character varying(255),
    is_active boolean DEFAULT false,
    is_destroy boolean DEFAULT false,
    address text,
    display_name character varying(255),
    full_name character varying(255)
);

ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16588)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;

--
-- TOC entry 230 (class 1259 OID 17060)
-- Name: variant_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variant_options (
    variant_option_id integer NOT NULL,
    variant_id integer NOT NULL,
    variant_option_value character varying(255) NOT NULL,
    variant_option_slug character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.variant_options OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17059)
-- Name: variant_options_variant_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variant_options_variant_option_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.variant_options_variant_option_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 229
-- Name: variant_options_variant_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variant_options_variant_option_id_seq OWNED BY public.variant_options.variant_option_id;

--
-- TOC entry 228 (class 1259 OID 17043)
-- Name: variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variants (
    variant_id integer NOT NULL,
    category_id integer NOT NULL,
    variant_name character varying(255) NOT NULL,
    variant_slug character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);

ALTER TABLE public.variants OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17042)
-- Name: variants_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variants_variant_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.variants_variant_id_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 227
-- Name: variants_variant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variants_variant_id_seq OWNED BY public.variants.variant_id;

--
-- TOC entry 4838 (class 2604 OID 17143)
-- Name: cart_items cart_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cart_items_cart_item_id_seq'::regclass);

--
-- TOC entry 4836 (class 2604 OID 17130)
-- Name: carts cart_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN cart_id SET DEFAULT nextval('public.carts_cart_id_seq'::regclass);

--
-- TOC entry 4814 (class 2604 OID 16984)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);

--
-- TOC entry 4840 (class 2604 OID 17205)
-- Name: collections collection_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections ALTER COLUMN collection_id SET DEFAULT nextval('public.collections_collection_id_seq'::regclass);

--
-- TOC entry 4819 (class 2604 OID 17013)
-- Name: discounts discount_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts ALTER COLUMN discount_id SET DEFAULT nextval('public.discounts_discount_id_seq'::regclass);

--
-- TOC entry 4834 (class 2604 OID 17112)
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);

--
-- TOC entry 4829 (class 2604 OID 17096)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);

--
-- TOC entry 4822 (class 2604 OID 17024)
-- Name: product_items product_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items ALTER COLUMN product_item_id SET DEFAULT nextval('public.product_items_product_item_id_seq'::regclass);

--
-- TOC entry 4816 (class 2604 OID 16996)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);

--
-- TOC entry 4808 (class 2604 OID 16592)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);

--
-- TOC entry 4826 (class 2604 OID 17063)
-- Name: variant_options variant_option_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options ALTER COLUMN variant_option_id SET DEFAULT nextval('public.variant_options_variant_option_id_seq'::regclass);

--
-- TOC entry 4824 (class 2604 OID 17046)
-- Name: variants variant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants ALTER COLUMN variant_id SET DEFAULT nextval('public.variants_variant_id_seq'::regclass);

--
-- TOC entry 5067 (class 0 OID 17140)
-- Dependencies: 239
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- TOC entry 5065 (class 0 OID 17127)
-- Dependencies: 237
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- TOC entry 5048 (class 0 OID 16981)
-- Dependencies: 220
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.categories
VALUES (
        1,
        'T-Shirt',
        'tshirt',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        2,
        'Hoodie',
        'hoodie',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        3,
        'Jacket',
        'jacket',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        4,
        'Pants',
        'pants',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        5,
        'Accessories',
        'accessories',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        6,
        'Hat',
        'hat',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        7,
        'Shoes',
        'shoes',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        8,
        'Shirt',
        'shirt',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

INSERT INTO
    public.categories
VALUES (
        9,
        'Sweater',
        'sweater',
        '2026-05-13 16:08:05.915208',
        NULL,
        NULL
    );

--
-- TOC entry 5069 (class 0 OID 17202)
-- Dependencies: 241
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.collections
VALUES (
        1,
        'TEAM KIT',
        'team-kit',
        NULL,
        'Official team jerseys and gear',
        '2026-05-13 16:08:05.917501',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        2,
        'COLLECTION',
        'collection',
        NULL,
        'Main season collections',
        '2026-05-13 16:08:05.917501',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        3,
        'COLLABORATION',
        'collaboration',
        NULL,
        'Limited edition collaborations with other brands',
        '2026-05-13 16:08:05.917501',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        4,
        'LEGACY',
        'legacy',
        NULL,
        'Archive of past collections',
        '2026-05-13 16:08:05.917501',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        5,
        'ESSENTIAL',
        'essential',
        2,
        NULL,
        '2026-05-13 16:08:05.919425',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        6,
        'LEAGUE OF LEGENDS',
        'league-of-legends',
        2,
        NULL,
        '2026-05-13 16:08:05.919425',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        7,
        'VALORANT',
        'valorant',
        2,
        NULL,
        '2026-05-13 16:08:05.919425',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        8,
        'GIFT & ACCESSORY',
        'essential-gift-and-accessory',
        5,
        NULL,
        '2026-05-13 16:08:05.921486',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        9,
        'APPAREL',
        'essential-apparel',
        5,
        NULL,
        '2026-05-13 16:08:05.921486',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        10,
        'GIFT & ACCESSORY',
        'lol-gift-and-accessory',
        6,
        NULL,
        '2026-05-13 16:08:05.921486',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        11,
        'APPAREL',
        'lol-apparel',
        6,
        NULL,
        '2026-05-13 16:08:05.921486',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        12,
        'GIFT & ACCESSORY',
        'valorant-gift-and-accessory',
        7,
        NULL,
        '2026-05-13 16:08:05.921486',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        13,
        'APPAREL',
        'valorant-apparel',
        7,
        NULL,
        '2026-05-13 16:08:05.921486',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        14,
        'DISNEY',
        'disney',
        3,
        NULL,
        '2026-05-13 16:08:05.922401',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        15,
        'RINSTORE X GOALSTUDIO',
        'rinstore-x-goalstudio',
        3,
        NULL,
        '2026-05-13 16:08:05.922401',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        16,
        'RINSTORE X SECRETLAB',
        'rinstore-x-secretlab',
        3,
        NULL,
        '2026-05-13 16:08:05.922401',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        17,
        'RINSTORE X RAZER',
        'rinstore-x-razer',
        3,
        NULL,
        '2026-05-13 16:08:05.922401',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        18,
        'T1 2025 WORLDS COLLECTION',
        'worlds-2025',
        4,
        NULL,
        '2026-05-13 16:08:05.923042',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        19,
        'T1 2024 WORLDS COLLECTION',
        'worlds-2024',
        4,
        NULL,
        '2026-05-13 16:08:05.923042',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        20,
        'T1 2023 WORLDS COLLECTION',
        'worlds-2023',
        4,
        NULL,
        '2026-05-13 16:08:05.923042',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        21,
        'APPAREL',
        'legacy-apparel',
        4,
        NULL,
        '2026-05-13 16:08:05.923042',
        NULL
    );

INSERT INTO
    public.collections
VALUES (
        22,
        'GIFTS & ACCESSORIES',
        'legacy-gifts',
        4,
        NULL,
        '2026-05-13 16:08:05.923042',
        NULL
    );

--
-- TOC entry 5052 (class 0 OID 17010)
-- Dependencies: 224
-- Data for Name: discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.discounts
VALUES (
        1,
        '20% Off',
        NULL,
        20,
        true,
        '2026-05-13 16:08:05.923613',
        NULL
    );

INSERT INTO
    public.discounts
VALUES (
        2,
        '23% Off',
        NULL,
        23,
        true,
        '2026-05-13 16:08:05.923613',
        NULL
    );

INSERT INTO
    public.discounts
VALUES (
        3,
        '28% Off',
        NULL,
        28,
        true,
        '2026-05-13 16:08:05.923613',
        NULL
    );

--
-- TOC entry 5063 (class 0 OID 17109)
-- Dependencies: 235
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.order_items
VALUES (
        1,
        1,
        9,
        2,
        49.99,
        '2026-05-14 20:49:28.234321',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        2,
        1,
        14,
        1,
        45.00,
        '2026-05-14 20:49:28.236127',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        3,
        1,
        15,
        2,
        95.00,
        '2026-05-14 20:49:28.236734',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        4,
        2,
        11,
        3,
        150.00,
        '2026-05-14 20:49:28.237939',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        5,
        2,
        17,
        3,
        35.00,
        '2026-05-14 20:49:28.238472',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        6,
        3,
        3,
        1,
        99.99,
        '2026-05-14 20:49:28.239697',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        7,
        3,
        16,
        2,
        75.00,
        '2026-05-14 20:49:28.240174',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        8,
        3,
        18,
        1,
        120.00,
        '2026-05-14 20:49:28.240583',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        9,
        3,
        5,
        2,
        79.99,
        '2026-05-14 20:49:28.240977',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        10,
        4,
        1,
        2,
        89.99,
        '2026-05-14 20:49:28.241679',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        11,
        4,
        3,
        1,
        99.99,
        '2026-05-14 20:49:28.241931',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        12,
        4,
        18,
        2,
        120.00,
        '2026-05-14 20:49:28.242343',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        13,
        5,
        18,
        2,
        120.00,
        '2026-05-14 20:49:28.242964',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        14,
        6,
        2,
        3,
        69.99,
        '2026-05-14 20:49:28.243694',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        15,
        6,
        9,
        1,
        49.99,
        '2026-05-14 20:49:28.244036',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        16,
        7,
        13,
        2,
        110.00,
        '2026-05-14 20:49:28.24482',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        17,
        7,
        8,
        3,
        189.99,
        '2026-05-14 20:49:28.245073',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        18,
        7,
        12,
        2,
        24.99,
        '2026-05-14 20:49:28.245313',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        19,
        7,
        13,
        2,
        110.00,
        '2026-05-14 20:49:28.245562',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        20,
        7,
        2,
        2,
        69.99,
        '2026-05-14 20:49:28.245879',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        21,
        8,
        2,
        2,
        69.99,
        '2026-05-14 20:49:28.246491',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        22,
        8,
        17,
        3,
        35.00,
        '2026-05-14 20:49:28.246712',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        23,
        8,
        4,
        3,
        299.99,
        '2026-05-14 20:49:28.247068',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        24,
        8,
        3,
        2,
        99.99,
        '2026-05-14 20:49:28.247392',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        25,
        8,
        5,
        1,
        79.99,
        '2026-05-14 20:49:28.247782',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        26,
        9,
        12,
        1,
        24.99,
        '2026-05-14 20:49:28.248388',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        27,
        10,
        9,
        2,
        49.99,
        '2026-05-14 20:49:28.248862',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        28,
        10,
        7,
        3,
        119.99,
        '2026-05-14 20:49:28.249053',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        29,
        10,
        5,
        2,
        79.99,
        '2026-05-14 20:49:28.249227',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        30,
        10,
        6,
        1,
        129.99,
        '2026-05-14 20:49:28.249413',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        31,
        11,
        11,
        2,
        150.00,
        '2026-05-14 20:49:28.249858',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        32,
        11,
        16,
        2,
        75.00,
        '2026-05-14 20:49:28.250234',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        33,
        11,
        17,
        3,
        35.00,
        '2026-05-14 20:49:28.250615',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        34,
        11,
        15,
        2,
        95.00,
        '2026-05-14 20:49:28.250922',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        35,
        11,
        10,
        1,
        89.99,
        '2026-05-14 20:49:28.251146',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        36,
        12,
        9,
        2,
        49.99,
        '2026-05-14 20:49:28.251709',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        37,
        12,
        3,
        2,
        99.99,
        '2026-05-14 20:49:28.251976',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        38,
        13,
        2,
        2,
        69.99,
        '2026-05-14 20:49:28.25277',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        39,
        13,
        17,
        3,
        35.00,
        '2026-05-14 20:49:28.253076',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        40,
        13,
        17,
        3,
        35.00,
        '2026-05-14 20:49:28.253431',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        41,
        13,
        14,
        3,
        45.00,
        '2026-05-14 20:49:28.253835',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        42,
        13,
        13,
        1,
        110.00,
        '2026-05-14 20:49:28.254165',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        43,
        14,
        17,
        1,
        35.00,
        '2026-05-14 20:49:28.254891',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        44,
        14,
        4,
        1,
        299.99,
        '2026-05-14 20:49:28.255223',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        45,
        14,
        18,
        2,
        120.00,
        '2026-05-14 20:49:28.255491',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        46,
        15,
        18,
        2,
        120.00,
        '2026-05-14 20:49:28.256109',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        47,
        15,
        13,
        1,
        110.00,
        '2026-05-14 20:49:28.256334',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        48,
        15,
        2,
        1,
        69.99,
        '2026-05-14 20:49:28.256671',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        49,
        16,
        13,
        1,
        110.00,
        '2026-05-14 20:49:28.257316',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        50,
        16,
        14,
        3,
        45.00,
        '2026-05-14 20:49:28.257556',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        51,
        16,
        8,
        1,
        189.99,
        '2026-05-14 20:49:28.257892',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        52,
        16,
        14,
        3,
        45.00,
        '2026-05-14 20:49:28.258208',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        53,
        16,
        6,
        2,
        129.99,
        '2026-05-14 20:49:28.258496',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        54,
        17,
        1,
        3,
        89.99,
        '2026-05-14 20:49:28.25944',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        55,
        17,
        1,
        2,
        89.99,
        '2026-05-14 20:49:28.259752',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        56,
        17,
        10,
        1,
        89.99,
        '2026-05-14 20:49:28.260098',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        57,
        18,
        10,
        1,
        89.99,
        '2026-05-14 20:49:28.260799',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        58,
        18,
        5,
        2,
        79.99,
        '2026-05-14 20:49:28.261156',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        59,
        19,
        17,
        1,
        35.00,
        '2026-05-14 20:49:28.26202',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        60,
        19,
        4,
        1,
        299.99,
        '2026-05-14 20:49:28.262315',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        61,
        20,
        3,
        1,
        99.99,
        '2026-05-14 20:49:28.26288',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        62,
        20,
        10,
        2,
        89.99,
        '2026-05-14 20:49:28.263206',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        63,
        20,
        2,
        3,
        69.99,
        '2026-05-14 20:49:28.263496',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        64,
        20,
        11,
        2,
        150.00,
        '2026-05-14 20:49:28.263768',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        65,
        20,
        8,
        3,
        189.99,
        '2026-05-14 20:49:28.264027',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        66,
        21,
        9,
        3,
        49.99,
        '2026-05-14 20:49:28.26475',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        67,
        22,
        9,
        2,
        49.99,
        '2026-05-14 20:49:28.265461',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        68,
        22,
        17,
        3,
        35.00,
        '2026-05-14 20:49:28.265784',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        69,
        22,
        15,
        2,
        95.00,
        '2026-05-14 20:49:28.266065',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        70,
        22,
        11,
        3,
        150.00,
        '2026-05-14 20:49:28.266326',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        71,
        22,
        5,
        1,
        79.99,
        '2026-05-14 20:49:28.26663',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        72,
        23,
        7,
        1,
        119.99,
        '2026-05-14 20:49:28.267234',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        73,
        23,
        15,
        2,
        95.00,
        '2026-05-14 20:49:28.267634',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        74,
        23,
        16,
        3,
        75.00,
        '2026-05-14 20:49:28.267978',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        75,
        23,
        9,
        3,
        49.99,
        '2026-05-14 20:49:28.268457',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        76,
        24,
        11,
        3,
        150.00,
        '2026-05-14 20:49:28.269304',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        77,
        25,
        8,
        1,
        189.99,
        '2026-05-14 20:49:28.269945',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        78,
        25,
        15,
        1,
        95.00,
        '2026-05-14 20:49:28.27023',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        79,
        26,
        1,
        1,
        89.99,
        '2026-05-14 20:49:28.270837',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        80,
        27,
        11,
        3,
        150.00,
        '2026-05-14 20:49:28.271536',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        81,
        27,
        17,
        2,
        35.00,
        '2026-05-14 20:49:28.271825',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        82,
        27,
        6,
        1,
        129.99,
        '2026-05-14 20:49:28.272128',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        83,
        27,
        12,
        3,
        24.99,
        '2026-05-14 20:49:28.272422',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        84,
        28,
        9,
        3,
        49.99,
        '2026-05-14 20:49:28.273097',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        85,
        28,
        6,
        2,
        129.99,
        '2026-05-14 20:49:28.273431',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        86,
        29,
        11,
        2,
        150.00,
        '2026-05-14 20:49:28.274239',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        87,
        30,
        15,
        1,
        95.00,
        '2026-05-14 20:49:28.275244',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        88,
        30,
        8,
        1,
        189.99,
        '2026-05-14 20:49:28.275698',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        89,
        30,
        15,
        2,
        95.00,
        '2026-05-14 20:49:28.276007',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        90,
        30,
        1,
        2,
        89.99,
        '2026-05-14 20:49:28.276272',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        91,
        31,
        17,
        1,
        35.00,
        '2026-05-14 20:49:28.277078',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        92,
        32,
        16,
        3,
        75.00,
        '2026-05-14 20:49:28.277945',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        93,
        32,
        15,
        3,
        95.00,
        '2026-05-14 20:49:28.278311',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        94,
        33,
        7,
        2,
        119.99,
        '2026-05-14 20:49:28.278958',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        95,
        33,
        10,
        1,
        89.99,
        '2026-05-14 20:49:28.279203',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        96,
        34,
        17,
        1,
        35.00,
        '2026-05-14 20:49:28.279838',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        97,
        34,
        12,
        3,
        24.99,
        '2026-05-14 20:49:28.280194',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        98,
        34,
        11,
        2,
        150.00,
        '2026-05-14 20:49:28.280597',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        99,
        34,
        17,
        3,
        35.00,
        '2026-05-14 20:49:28.280895',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        100,
        35,
        17,
        2,
        35.00,
        '2026-05-14 20:49:28.28202',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        101,
        35,
        3,
        3,
        99.99,
        '2026-05-14 20:49:28.282397',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        102,
        35,
        17,
        2,
        35.00,
        '2026-05-14 20:49:28.282962',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        103,
        36,
        10,
        2,
        89.99,
        '2026-05-14 20:49:28.283937',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        104,
        37,
        10,
        3,
        89.99,
        '2026-05-14 21:21:13.330428',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        105,
        37,
        11,
        2,
        150.00,
        '2026-05-14 21:21:13.33237',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        106,
        37,
        15,
        3,
        95.00,
        '2026-05-14 21:21:13.332969',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        107,
        37,
        8,
        3,
        189.99,
        '2026-05-14 21:21:13.333578',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        108,
        38,
        1,
        3,
        89.99,
        '2026-05-14 21:21:13.33484',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        109,
        38,
        15,
        1,
        95.00,
        '2026-05-14 21:21:13.33545',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        110,
        38,
        7,
        3,
        119.99,
        '2026-05-14 21:21:13.335903',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        111,
        39,
        17,
        1,
        35.00,
        '2026-05-14 21:21:13.336728',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        112,
        39,
        4,
        2,
        299.99,
        '2026-05-14 21:21:13.337123',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        113,
        39,
        9,
        1,
        49.99,
        '2026-05-14 21:21:13.337403',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        114,
        39,
        4,
        3,
        299.99,
        '2026-05-14 21:21:13.337696',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        115,
        40,
        6,
        1,
        129.99,
        '2026-05-14 21:21:13.338581',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        116,
        41,
        6,
        1,
        129.99,
        '2026-05-14 21:21:13.339505',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        117,
        41,
        12,
        1,
        24.99,
        '2026-05-14 21:21:13.339875',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        118,
        41,
        10,
        3,
        89.99,
        '2026-05-14 21:21:13.340197',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        119,
        42,
        18,
        3,
        120.00,
        '2026-05-14 21:21:13.341142',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        120,
        42,
        6,
        2,
        129.99,
        '2026-05-14 21:21:13.341469',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        121,
        42,
        15,
        1,
        95.00,
        '2026-05-14 21:21:13.341827',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        122,
        42,
        9,
        3,
        49.99,
        '2026-05-14 21:21:13.342185',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        123,
        42,
        7,
        1,
        119.99,
        '2026-05-14 21:21:13.342579',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        124,
        43,
        9,
        2,
        49.99,
        '2026-05-14 21:21:13.343539',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        125,
        43,
        11,
        2,
        150.00,
        '2026-05-14 21:21:13.343909',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        126,
        43,
        14,
        1,
        45.00,
        '2026-05-14 21:21:13.344184',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        127,
        43,
        13,
        2,
        110.00,
        '2026-05-14 21:21:13.344575',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        128,
        43,
        13,
        3,
        110.00,
        '2026-05-14 21:21:13.344905',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        129,
        44,
        16,
        1,
        75.00,
        '2026-05-14 21:21:13.345692',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        130,
        45,
        11,
        3,
        150.00,
        '2026-05-14 21:21:13.34644',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        131,
        45,
        3,
        2,
        99.99,
        '2026-05-14 21:21:13.346809',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        132,
        45,
        18,
        3,
        120.00,
        '2026-05-14 21:21:13.347101',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        133,
        45,
        6,
        3,
        129.99,
        '2026-05-14 21:21:13.347326',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        134,
        46,
        13,
        3,
        110.00,
        '2026-05-14 21:21:13.348014',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        135,
        46,
        8,
        2,
        189.99,
        '2026-05-14 21:21:13.348293',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        136,
        46,
        5,
        1,
        79.99,
        '2026-05-14 21:21:13.348607',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        137,
        46,
        7,
        2,
        119.99,
        '2026-05-14 21:21:13.348863',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        138,
        47,
        16,
        2,
        75.00,
        '2026-05-14 21:21:13.350378',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        139,
        47,
        15,
        3,
        95.00,
        '2026-05-14 21:21:13.350727',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        140,
        47,
        13,
        3,
        110.00,
        '2026-05-14 21:21:13.351042',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        141,
        47,
        17,
        2,
        35.00,
        '2026-05-14 21:21:13.351375',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        142,
        48,
        17,
        1,
        35.00,
        '2026-05-14 21:21:13.351981',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        143,
        48,
        14,
        1,
        45.00,
        '2026-05-14 21:21:13.352264',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        144,
        48,
        14,
        1,
        45.00,
        '2026-05-14 21:21:13.352677',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        145,
        48,
        6,
        2,
        129.99,
        '2026-05-14 21:21:13.353004',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        146,
        49,
        18,
        1,
        120.00,
        '2026-05-14 21:21:13.353519',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        147,
        49,
        4,
        2,
        299.99,
        '2026-05-14 21:21:13.353717',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        148,
        50,
        2,
        3,
        69.99,
        '2026-05-14 21:21:13.35412',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        149,
        51,
        3,
        1,
        99.99,
        '2026-05-14 21:21:13.354592',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        150,
        51,
        18,
        1,
        120.00,
        '2026-05-14 21:21:13.354936',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        151,
        52,
        11,
        3,
        150.00,
        '2026-05-14 21:21:13.355531',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        152,
        52,
        12,
        1,
        24.99,
        '2026-05-14 21:21:13.355861',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        153,
        52,
        3,
        2,
        99.99,
        '2026-05-14 21:21:13.356176',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        154,
        52,
        13,
        2,
        110.00,
        '2026-05-14 21:21:13.356539',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        155,
        52,
        12,
        1,
        24.99,
        '2026-05-14 21:21:13.356857',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        156,
        53,
        6,
        2,
        129.99,
        '2026-05-14 21:21:13.357435',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        157,
        53,
        18,
        3,
        120.00,
        '2026-05-14 21:21:13.357701',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        158,
        53,
        15,
        3,
        95.00,
        '2026-05-14 21:21:13.357993',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        159,
        53,
        17,
        1,
        35.00,
        '2026-05-14 21:21:13.35826',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        160,
        54,
        1,
        2,
        89.99,
        '2026-05-14 21:21:13.358916',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        161,
        54,
        8,
        1,
        189.99,
        '2026-05-14 21:21:13.359171',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        162,
        55,
        4,
        3,
        299.99,
        '2026-05-14 21:21:13.359777',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        163,
        55,
        5,
        2,
        79.99,
        '2026-05-14 21:21:13.360122',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        164,
        55,
        12,
        3,
        24.99,
        '2026-05-14 21:21:13.360465',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        165,
        56,
        10,
        2,
        89.99,
        '2026-05-14 21:21:13.361021',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        166,
        56,
        7,
        2,
        119.99,
        '2026-05-14 21:21:13.361212',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        167,
        56,
        17,
        3,
        35.00,
        '2026-05-14 21:21:13.361487',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        168,
        56,
        17,
        2,
        35.00,
        '2026-05-14 21:21:13.361816',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        169,
        57,
        4,
        3,
        299.99,
        '2026-05-14 21:21:13.362447',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        170,
        58,
        6,
        2,
        129.99,
        '2026-05-14 21:21:13.36318',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        171,
        58,
        4,
        2,
        299.99,
        '2026-05-14 21:21:13.363459',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        172,
        58,
        10,
        1,
        89.99,
        '2026-05-14 21:21:13.363685',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        173,
        59,
        12,
        3,
        24.99,
        '2026-05-14 21:21:13.36433',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        174,
        59,
        13,
        3,
        110.00,
        '2026-05-14 21:21:13.364554',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        175,
        59,
        17,
        2,
        35.00,
        '2026-05-14 21:21:13.36478',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        176,
        59,
        13,
        2,
        110.00,
        '2026-05-14 21:21:13.365006',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        177,
        60,
        8,
        1,
        189.99,
        '2026-05-14 21:21:13.365578',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        178,
        60,
        14,
        2,
        45.00,
        '2026-05-14 21:21:13.365785',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        179,
        60,
        3,
        3,
        99.99,
        '2026-05-14 21:21:13.365962',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        180,
        60,
        16,
        2,
        75.00,
        '2026-05-14 21:21:13.366135',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        181,
        60,
        18,
        1,
        120.00,
        '2026-05-14 21:21:13.366427',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        182,
        61,
        8,
        3,
        189.99,
        '2026-05-14 21:21:13.367087',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        183,
        62,
        10,
        3,
        89.99,
        '2026-05-14 21:21:13.367604',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        184,
        63,
        17,
        2,
        35.00,
        '2026-05-14 21:21:13.368068',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        185,
        64,
        8,
        2,
        189.99,
        '2026-05-14 21:35:16.870892',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        186,
        64,
        3,
        2,
        99.99,
        '2026-05-14 21:35:16.872416',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        187,
        65,
        2,
        1,
        69.99,
        '2026-05-14 21:35:16.873707',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        188,
        66,
        10,
        2,
        89.99,
        '2026-05-14 21:35:16.874698',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        189,
        66,
        11,
        1,
        150.00,
        '2026-05-14 21:35:16.875256',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        190,
        66,
        1,
        1,
        89.99,
        '2026-05-14 21:35:16.875711',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        191,
        67,
        1,
        2,
        89.99,
        '2026-05-14 21:35:16.876633',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        192,
        68,
        13,
        2,
        110.00,
        '2026-05-14 21:35:16.87755',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        193,
        68,
        2,
        1,
        69.99,
        '2026-05-14 21:35:16.877935',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        194,
        69,
        11,
        1,
        150.00,
        '2026-05-14 21:35:16.878659',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        195,
        69,
        7,
        1,
        119.99,
        '2026-05-14 21:35:16.879019',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        196,
        70,
        15,
        2,
        95.00,
        '2026-05-14 21:35:16.87978',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        197,
        71,
        10,
        2,
        89.99,
        '2026-05-14 21:35:16.880717',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        198,
        71,
        10,
        2,
        89.99,
        '2026-05-14 21:35:16.881071',
        NULL
    );

INSERT INTO
    public.order_items
VALUES (
        199,
        72,
        17,
        2,
        35.00,
        '2026-05-14 21:35:16.881668',
        NULL
    );

--
-- TOC entry 5061 (class 0 OID 17093)
-- Dependencies: 233
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.orders
VALUES (
        1,
        11,
        'pending',
        334.98,
        'Lần đầu mua ở shop, hy vọng ổn',
        '2026-05-08 20:49:28.227713',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        2,
        11,
        'pending',
        555.00,
        'Lần đầu mua ở shop, hy vọng ổn',
        '2026-05-07 20:49:28.237382',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        3,
        12,
        'pending',
        529.97,
        NULL,
        '2026-04-29 20:49:28.239102',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        4,
        12,
        'shipped',
        519.97,
        NULL,
        '2026-04-26 20:49:28.241307',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        5,
        12,
        'pending',
        240.00,
        'Giao hàng nhanh giúp mình nhé',
        '2026-04-24 20:49:28.242585',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        6,
        12,
        'shipped',
        259.96,
        'Giao hàng nhanh giúp mình nhé',
        '2026-05-09 20:49:28.243236',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        7,
        10,
        'pending',
        1199.93,
        'Đóng gói cẩn thận ạ',
        '2026-05-02 20:49:28.244448',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        8,
        10,
        'shipped',
        1424.92,
        'Hàng đẹp lắm shop ơi',
        '2026-05-05 20:49:28.24623',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        10,
        10,
        'pending',
        749.92,
        'Giao hàng nhanh giúp mình nhé',
        '2026-04-15 20:49:28.248628',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        11,
        2,
        'shipped',
        834.99,
        'Sản phẩm tuyệt vời',
        '2026-05-03 20:49:28.249639',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        14,
        1,
        'shipped',
        574.99,
        'Sản phẩm tuyệt vời',
        '2026-04-15 20:49:28.254505',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        15,
        1,
        'shipped',
        419.99,
        'Cho mình xem hàng trước khi nhận',
        '2026-04-18 20:49:28.255807',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        16,
        1,
        'shipped',
        829.97,
        'Hàng đẹp lắm shop ơi',
        '2026-04-18 20:49:28.257033',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        17,
        3,
        'shipped',
        539.94,
        NULL,
        '2026-05-01 20:49:28.258804',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        20,
        3,
        'pending',
        1359.91,
        'Đóng gói cẩn thận ạ',
        '2026-05-03 20:49:28.262586',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        21,
        5,
        'pending',
        149.97,
        'Sản phẩm tuyệt vời',
        '2026-05-01 20:49:28.264357',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        24,
        6,
        'shipped',
        450.00,
        'Hàng đẹp lắm shop ơi',
        '2026-05-14 20:49:28.268789',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        25,
        6,
        'shipped',
        284.99,
        'Hàng đẹp lắm shop ơi',
        '2026-05-05 20:49:28.269586',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        28,
        7,
        'pending',
        409.95,
        'Shop tư vấn nhiệt tình quá',
        '2026-04-27 20:49:28.272737',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        31,
        4,
        'pending',
        35.00,
        'Cho mình xem hàng trước khi nhận',
        '2026-04-16 20:49:28.276547',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        34,
        9,
        'pending',
        514.97,
        'Sản phẩm tuyệt vời',
        '2026-05-10 20:49:28.279478',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        36,
        9,
        'pending',
        179.98,
        'Giao giờ hành chính nhé',
        '2026-05-09 20:49:28.283416',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        64,
        11,
        'completed',
        579.96,
        'Chuyển khoản thành công',
        '2026-05-09 21:35:16.857874',
        NULL,
        'vnpay',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        30,
        4,
        'pending',
        654.97,
        'Mua tặng bạn trai',
        '2026-05-14 20:49:28.274861',
        '2026-05-14 21:15:04.267545',
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        29,
        4,
        'pending',
        300.00,
        'Giao giờ hành chính nhé',
        '2026-05-13 20:49:28.273872',
        '2026-05-14 21:15:07.877829',
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        9,
        10,
        'pending',
        24.99,
        'Giao hàng nhanh giúp mình nhé',
        '2026-05-13 20:49:28.248076',
        '2026-05-14 21:15:08.824479',
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        13,
        1,
        'pending',
        594.98,
        'Hàng đẹp lắm shop ơi',
        '2026-05-10 20:49:28.252425',
        '2026-05-14 21:15:09.678053',
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        65,
        11,
        'completed',
        69.99,
        'Đã thanh toán VNPAY',
        '2026-05-06 21:35:16.873118',
        NULL,
        'vnpay',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        66,
        12,
        'completed',
        419.97,
        'Chuyển khoản thành công',
        '2026-05-11 21:35:16.874206',
        NULL,
        'banking',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        67,
        10,
        'pending',
        179.98,
        'Đã thanh toán qua MoMo',
        '2026-05-06 21:35:16.876084',
        NULL,
        'vnpay',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        32,
        4,
        'pending',
        510.00,
        'Shop tư vấn nhiệt tình quá',
        '2026-05-09 20:49:28.277594',
        '2026-05-14 21:21:08.29361',
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        37,
        11,
        'shipping',
        1424.94,
        'Mua tặng bạn trai',
        '2026-05-03 21:21:13.316654',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        38,
        11,
        'completed',
        724.94,
        NULL,
        '2026-05-05 21:21:13.334059',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        39,
        12,
        'pending',
        1584.94,
        'Mua tặng bạn trai',
        '2026-05-03 21:21:13.336254',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        41,
        12,
        'cancelled',
        424.95,
        'Lần đầu mua ở shop, hy vọng ổn',
        '2026-05-04 21:21:13.339017',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        42,
        12,
        'pending',
        984.94,
        'Cho mình xem hàng trước khi nhận',
        '2026-04-18 21:21:13.340659',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        43,
        10,
        'shipping',
        994.98,
        'Shop tư vấn nhiệt tình quá',
        '2026-04-27 21:21:13.343105',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        44,
        2,
        'shipping',
        75.00,
        NULL,
        '2026-04-24 21:21:13.345335',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        45,
        2,
        'pending',
        1399.95,
        'Giao hàng nhanh giúp mình nhé',
        '2026-05-14 21:21:13.346037',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        46,
        2,
        'pending',
        1029.95,
        NULL,
        '2026-04-21 21:21:13.347608',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        47,
        1,
        'cancelled',
        835.00,
        'Giao hàng nhanh giúp mình nhé',
        '2026-04-18 21:21:13.350073',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        48,
        3,
        'shipping',
        384.98,
        NULL,
        '2026-04-22 21:21:13.351597',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        49,
        3,
        'shipping',
        719.98,
        'Giao hàng nhanh giúp mình nhé',
        '2026-04-18 21:21:13.353265',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        50,
        3,
        'cancelled',
        209.97,
        'Shop tư vấn nhiệt tình quá',
        '2026-05-07 21:21:13.353908',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        52,
        5,
        'shipping',
        919.96,
        'Giao giờ hành chính nhé',
        '2026-05-07 21:21:13.355184',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        54,
        6,
        'pending',
        369.97,
        'Đóng gói cẩn thận ạ',
        '2026-05-08 21:21:13.358605',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        55,
        6,
        'completed',
        1134.92,
        'Shop tư vấn nhiệt tình quá',
        '2026-04-16 21:21:13.359469',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        56,
        6,
        'shipping',
        594.96,
        'Giao giờ hành chính nhé',
        '2026-05-04 21:21:13.360773',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        57,
        6,
        'pending',
        899.97,
        'Hàng đẹp lắm shop ơi',
        '2026-05-07 21:21:13.362092',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        58,
        7,
        'completed',
        949.95,
        NULL,
        '2026-05-09 21:21:13.362826',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        59,
        4,
        'pending',
        694.97,
        NULL,
        '2026-05-03 21:21:13.364048',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        60,
        4,
        'cancelled',
        849.96,
        'Giao hàng nhanh giúp mình nhé',
        '2026-05-10 21:21:13.365338',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        61,
        4,
        'completed',
        569.97,
        'Giao hàng nhanh giúp mình nhé',
        '2026-05-02 21:21:13.366761',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        62,
        4,
        'shipping',
        269.97,
        'Mua tặng bạn trai',
        '2026-04-29 21:21:13.367332',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        63,
        9,
        'pending',
        70.00,
        'Sản phẩm tuyệt vời',
        '2026-04-20 21:21:13.367836',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        12,
        2,
        'pending',
        299.96,
        'Giao giờ hành chính nhé',
        '2026-04-21 20:49:28.251363',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        18,
        3,
        'pending',
        249.97,
        'Đóng gói cẩn thận ạ',
        '2026-04-29 20:49:28.260352',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        19,
        3,
        'pending',
        334.99,
        'Giao hàng nhanh giúp mình nhé',
        '2026-04-25 20:49:28.261665',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        22,
        6,
        'pending',
        924.97,
        'Mua tặng bạn trai',
        '2026-05-02 20:49:28.265122',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        23,
        6,
        'pending',
        684.96,
        'Cho mình xem hàng trước khi nhận',
        '2026-05-06 20:49:28.266902',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        26,
        7,
        'pending',
        89.99,
        'Giao hàng nhanh giúp mình nhé',
        '2026-04-22 20:49:28.270479',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        27,
        7,
        'pending',
        724.96,
        'Lần đầu mua ở shop, hy vọng ổn',
        '2026-05-05 20:49:28.271188',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        33,
        9,
        'pending',
        329.97,
        'Đóng gói cẩn thận ạ',
        '2026-04-29 20:49:28.278638',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        35,
        9,
        'pending',
        439.97,
        'Đóng gói cẩn thận ạ',
        '2026-04-19 20:49:28.281279',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        40,
        12,
        'pending',
        129.99,
        'Lần đầu mua ở shop, hy vọng ổn',
        '2026-04-21 21:21:13.338099',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        51,
        3,
        'pending',
        219.99,
        'Shop tư vấn nhiệt tình quá',
        '2026-05-13 21:21:13.354296',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        53,
        5,
        'pending',
        939.98,
        'Shop tư vấn nhiệt tình quá',
        '2026-05-13 21:21:13.357156',
        NULL,
        'cod',
        'unpaid'
    );

INSERT INTO
    public.orders
VALUES (
        68,
        10,
        'pending',
        289.99,
        'Đã thanh toán VNPAY',
        '2026-05-10 21:35:16.87702',
        NULL,
        'vnpay',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        69,
        2,
        'pending',
        269.99,
        'Chuyển khoản thành công',
        '2026-05-02 21:35:16.878294',
        NULL,
        'banking',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        70,
        2,
        'completed',
        190.00,
        'Check giúp mình đơn đã trả tiền nhé',
        '2026-05-13 21:35:16.879398',
        NULL,
        'momo',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        71,
        1,
        'pending',
        359.96,
        'Đã thanh toán trước',
        '2026-05-05 21:35:16.880293',
        NULL,
        'banking',
        'paid'
    );

INSERT INTO
    public.orders
VALUES (
        72,
        1,
        'pending',
        70.00,
        'Đã thanh toán trước',
        '2026-05-08 21:35:16.881355',
        NULL,
        'vnpay',
        'paid'
    );

--
-- TOC entry 5070 (class 0 OID 17218)
-- Dependencies: 242
-- Data for Name: product_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_collections VALUES (1, 5);

INSERT INTO public.product_collections VALUES (1, 9);

INSERT INTO public.product_collections VALUES (2, 5);

INSERT INTO public.product_collections VALUES (2, 9);

INSERT INTO public.product_collections VALUES (3, 7);

INSERT INTO public.product_collections VALUES (3, 13);

INSERT INTO public.product_collections VALUES (6, 19);

INSERT INTO public.product_collections VALUES (13, 1);

--
-- TOC entry 5059 (class 0 OID 17076)
-- Dependencies: 231
-- Data for Name: product_configurations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.product_configurations
VALUES (
        1,
        7,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        2,
        38,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        3,
        17,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        4,
        13,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        5,
        42,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        6,
        14,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        8,
        7,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        9,
        3,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        10,
        37,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        11,
        13,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        12,
        22,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        13,
        2,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        14,
        3,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        15,
        7,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        16,
        18,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        17,
        27,
        '2026-05-13 16:08:05.940102',
        NULL
    );

INSERT INTO
    public.product_configurations
VALUES (
        18,
        2,
        '2026-05-13 16:08:05.940102',
        NULL
    );

--
-- TOC entry 5054 (class 0 OID 17021)
-- Dependencies: 226
-- Data for Name: product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.product_items
VALUES (
        1,
        1,
        'ES-BK-HO-M',
        100,
        'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&q=80&w=1080',
        89.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        2,
        2,
        'OV-WH-SH-L',
        0,
        'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?auto=format&fit=crop&q=80&w=1080',
        69.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        3,
        3,
        'BE-CA-PA-M',
        50,
        'https://images.unsplash.com/photo-1605518216938-7c31b7b14ad0?auto=format&fit=crop&q=80&w=1080',
        99.99,
        1,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        4,
        4,
        'PR-LE-JA-L',
        0,
        'https://images.unsplash.com/photo-1591047139829-d91aec369a70?auto=format&fit=crop&q=80&w=1080',
        299.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        5,
        5,
        'MI-GR-SW-M',
        120,
        'https://images.unsplash.com/photo-1578762560072-46ef14a5a7f9?auto=format&fit=crop&q=80&w=1080',
        79.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        6,
        6,
        'CL-DE-JA-XL',
        40,
        'https://images.unsplash.com/photo-1544022613-e87f17a784de?auto=format&fit=crop&q=80&w=1080',
        129.99,
        2,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        7,
        7,
        'WH-MI-SN-42',
        0,
        'https://images.unsplash.com/photo-1542291026-7eec264c274f?auto=format&fit=crop&q=80&w=1080',
        119.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        8,
        8,
        'ST-CO-SE-M',
        15,
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&q=80&w=1080',
        189.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        9,
        9,
        'UR-BK-TE-L',
        200,
        'https://images.unsplash.com/photo-1562157873-818bc0726f68?auto=format&fit=crop&q=80&w=1080',
        49.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        10,
        10,
        'PR-WH-PO-M',
        0,
        'https://images.unsplash.com/photo-1576566588028-4147f342f27?auto=format&fit=crop&q=80&w=1080',
        89.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        11,
        11,
        'FA-UD-JA-L',
        300,
        'https://images.unsplash.com/photo-1591047139829-d91aec369a70?auto=format&fit=crop&q=80&w=1080',
        150.00,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        12,
        12,
        'T1-LO-SO-ONE',
        500,
        'https://images.unsplash.com/photo-1582966772680-860e372bb558?auto=format&fit=crop&q=80&w=1080',
        24.99,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        13,
        13,
        'T1-JE-24-M',
        800,
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&q=80&w=1080',
        110.00,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        14,
        14,
        'T1-CH-GO-L',
        150,
        'https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?auto=format&fit=crop&q=80&w=1080',
        45.00,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        15,
        15,
        'FA-SI-RE-M',
        200,
        'https://images.unsplash.com/photo-1556821840-ecc63f93428c?auto=format&fit=crop&q=80&w=1080',
        95.00,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        16,
        16,
        'T1-PR-JO-L',
        120,
        'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?auto=format&fit=crop&q=80&w=1080',
        75.00,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        17,
        17,
        'T1-ST-BL-ONE',
        300,
        'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?auto=format&fit=crop&q=80&w=1080',
        35.00,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

INSERT INTO
    public.product_items
VALUES (
        18,
        18,
        'T1-EL-GA-M',
        500,
        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=1080',
        120.00,
        NULL,
        '2026-05-13 16:08:05.930683',
        NULL
    );

--
-- TOC entry 5050 (class 0 OID 16993)
-- Dependencies: 222
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.products
VALUES (
        1,
        'Essential Black Hoodie',
        'essential-black-hoodie',
        2,
        '2026-05-13 16:08:05.930683',
        NULL,
        'A must-have for any wardrobe. This heavyweight cotton hoodie offers a relaxed fit and clean T1 branding on the chest.',
        true
    );

INSERT INTO
    public.products
VALUES (
        2,
        'Oversized White Shirt',
        'oversized-white-shirt',
        8,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Crisp, clean, and perfectly oversized. This white shirt is designed with a modern silhouette and premium poplin fabric.',
        false
    );

INSERT INTO
    public.products
VALUES (
        3,
        'Beige Cargo Pants',
        'beige-cargo-pants',
        4,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Functional meets fashion. Multiple pockets and a tapered fit make these cargo pants the ultimate streetwear essential.',
        false
    );

INSERT INTO
    public.products
VALUES (
        4,
        'Premium Leather Jacket',
        'premium-leather-jacket',
        3,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Forged from top-grain leather, this jacket features custom T1 embossed hardware and a quilted satin lining.',
        false
    );

INSERT INTO
    public.products
VALUES (
        5,
        'Minimal Gray Sweater',
        'minimal-gray-sweater',
        9,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Subtle gray tones and a soft mohair blend. Ideal for layering during the colder seasons.',
        false
    );

INSERT INTO
    public.products
VALUES (
        6,
        'Classic Denim Jacket',
        'classic-denim-jacket',
        3,
        '2026-05-13 16:08:05.930683',
        NULL,
        'A timeless classic. Distressed details and a regular fit, perfect for any casual outfit.',
        false
    );

INSERT INTO
    public.products
VALUES (
        7,
        'White Minimal Sneakers',
        'white-minimal-sneakers',
        7,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Ultra-clean white sneakers with a vulcanized rubber sole and comfortable cushioned insole.',
        true
    );

INSERT INTO
    public.products
VALUES (
        8,
        'Streetwear Collection Set',
        'streetwear-collection-set',
        2,
        '2026-05-13 16:08:05.930683',
        NULL,
        'The ultimate combo. A matching hoodie and joggers set that balances comfort with a high-fashion look.',
        false
    );

INSERT INTO
    public.products
VALUES (
        9,
        'Urban Black Tee',
        'urban-black-tee',
        1,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Your fundamental black tee, upgraded with a dense luxury cotton and a silver-threaded logo.',
        true
    );

INSERT INTO
    public.products
VALUES (
        10,
        'Premium White Polo',
        'premium-white-polo',
        8,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Sophisticated yet sporty. This polo features a breathable mesh-knit and a customized T1 collar.',
        false
    );

INSERT INTO
    public.products
VALUES (
        11,
        'Faker Unkillable Demon King Jacket',
        'faker-unkillable-demon-king-jacket',
        3,
        '2026-05-13 16:08:05.930683',
        NULL,
        'The official commemorative jacket for Lee "Faker" Sang-hyeok. Features embroidery inspired by his legendary plays.',
        true
    );

INSERT INTO
    public.products
VALUES (
        12,
        'T1 Logo Essential Socks',
        't1-logo-essential-socks',
        5,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Premium combed cotton socks with embroidered T1 logos. Cushioned for all-day gaming sessions.',
        false
    );

INSERT INTO
    public.products
VALUES (
        13,
        'T1 Official Team Jersey 2024',
        't1-official-team-jersey-2024',
        1,
        '2026-05-13 16:08:05.930683',
        NULL,
        'The exact jersey worn by Faker and the team during the 2024 Season. Lightweight and aerodynamic.',
        true
    );

INSERT INTO
    public.products
VALUES (
        14,
        'T1 Champion Gold T-Shirt',
        't1-champion-gold-tshirt',
        1,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Celebrate the victory with this limited edition gold-trimmed T-Shirt.',
        false
    );

INSERT INTO
    public.products
VALUES (
        15,
        'Faker Signature Red Hoodie',
        'faker-signature-red-hoodie',
        2,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Official signature hoodie of the Unkillable Demon King in iconic T1 Red.',
        true
    );

INSERT INTO
    public.products
VALUES (
        16,
        'T1 Pro Player Joggers',
        't1-pro-player-joggers',
        4,
        '2026-05-13 16:08:05.930683',
        NULL,
        'High-performance joggers designed for comfort during long gaming sessions.',
        false
    );

INSERT INTO
    public.products
VALUES (
        17,
        'T1 Stealth Black Cap',
        't1-stealth-black-cap',
        6,
        '2026-05-13 16:08:05.930683',
        NULL,
        'Minimalist black cap with a subtle T1 logo embroidery.',
        false
    );

INSERT INTO
    public.products
VALUES (
        18,
        'T1 Elite Gaming Jersey',
        't1-elite-gaming-jersey',
        1,
        '2026-05-13 16:08:05.930683',
        NULL,
        'The ultimate jersey for competitive play. Moisture-wicking and ultra-light.',
        false
    );

--
-- TOC entry 5046 (class 0 OID 16589)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.users
VALUES (
        11,
        'chivinh123abes',
        'mail.yuukimy1ne@gmail.com',
        '$2b$08$3y9RYP89mIuXzrXaxRG8qen6UDeA62o36dm0VoWTZ6qlIuDygpWJK',
        '0394442221',
        0,
        0,
        NULL,
        '2026-05-14 17:04:33.918977',
        NULL,
        '019e25f1-f2fd-732c-b94a-5fdd178c2e1c',
        false,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        12,
        'chivinh123abessa',
        'mail.yuukim1y1ne@gmail.com',
        '$2b$08$gWYAwojkXXPQfh9jb40ko.yku9oSxpanPFeiNPBJtttCL.A94Y7.O',
        '0394442221',
        0,
        0,
        NULL,
        '2026-05-14 17:07:16.29252',
        '2026-05-14 17:07:50.399303',
        NULL,
        true,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        10,
        'chivinh123abe',
        'mail.yuukimyne@gmail.com',
        '$2b$08$ndGkgJ0COQQE02KtYTFVFOuMguhnEmUGDmDuf9ldtYCL9xILT0x1O',
        '0394442221',
        0,
        2,
        NULL,
        '2026-05-14 17:03:15.983699',
        '2026-05-14 17:13:32.336315',
        '019e25fa-2a2f-7758-978a-f020c129542c',
        false,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        2,
        'user',
        'user1@gmail.com',
        '123456',
        NULL,
        0,
        1,
        NULL,
        '2026-04-15 21:20:13.481852',
        '2026-05-12 22:11:41.340714',
        NULL,
        true,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        1,
        'admin',
        'admin@gmail.com',
        '123456',
        '',
        1,
        1,
        NULL,
        '2026-04-15 21:20:13.481852',
        '2026-05-12 22:15:24.753527',
        NULL,
        true,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        3,
        'admin1',
        'ryanluong01@gmail.com',
        '$2b$08$imgjQLlITnHFhbpT6JNlnOXbrlBDet2mAcF4XcwahMLrhnGWPKata',
        '0839123123',
        1,
        0,
        NULL,
        '2026-04-15 21:52:04.785666',
        '2026-05-12 22:11:39.58524',
        '019d91a0-c130-72ce-aeb9-65f30428ad81',
        true,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        5,
        'chivinh123abc',
        'mail.lcvinh@gmail.com',
        '$2b$08$gKs1u4Q0KegIChPzacNAd.u/R2MpdCD5Tgi4NBNpbb2CKbXr204WC',
        '0394063999',
        0,
        0,
        NULL,
        '2026-05-13 16:28:10.718789',
        NULL,
        '019e20aa-4921-742c-802f-ddac653b71a7',
        false,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        6,
        'chivinh123abcd',
        'mail.lcvinh2@gmail.com',
        '$2b$08$tzGt1aPVH4HICO2DL7vsGu8le/tqkTXxVCeWi9iwJo6pcbYSq.DaG',
        '0908223312',
        0,
        0,
        NULL,
        '2026-05-13 16:42:26.386268',
        NULL,
        '019e20b7-5b85-73b8-9aaf-dd3c18989410',
        false,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        7,
        'chivinh123abcde',
        'mail.lcvinh3@gmail.com',
        '$2b$08$/b9VcrQ/jiUZK7WB8bAhS.myThG4ZacugSP208CZUKZHN/NW7ZEaa',
        '0394063997',
        0,
        0,
        NULL,
        '2026-05-13 16:45:43.883289',
        NULL,
        '019e20ba-5ffd-733d-b0a7-be1374a8974e',
        false,
        false,
        NULL,
        NULL,
        NULL
    );

INSERT INTO
    public.users
VALUES (
        4,
        'user123abc',
        'ryanluong02@gmail.com',
        '$2b$08$Jaq01J.MrftvQCYELTTsuO.UQLoZayZWe9Qh5BHT.wdameS9z0Xa.',
        '0839123124',
        0,
        0,
        NULL,
        '2026-04-15 21:52:20.593114',
        '2026-05-14 20:22:57.798382',
        '019d91a0-fef0-729c-8de2-1900d7c8be41',
        true,
        false,
        '123, Xã Bộc Bố, Huyện Pác Nặm, Tỉnh Bắc Kạn',
        'Ryanluong123',
        'Luong Chi Vinh'
    );

INSERT INTO
    public.users
VALUES (
        9,
        'chivinh123abv',
        'mail.yuukimyne2@gmail.com',
        '$2b$08$bxWOY6Yn8SSti3fnc0G4YO4NgX1WfyxiJR2SwA.dNWDocoXuPWax6',
        '0394442221',
        0,
        0,
        NULL,
        '2026-05-13 17:24:28.489511',
        '2026-05-13 17:46:22.135337',
        NULL,
        true,
        false,
        NULL,
        NULL,
        NULL
    );

--
-- TOC entry 5058 (class 0 OID 17060)
-- Dependencies: 230
-- Data for Name: variant_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.variant_options
VALUES (
        1,
        1,
        'S',
        'size-tshirt-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        2,
        1,
        'M',
        'size-tshirt-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        3,
        1,
        'L',
        'size-tshirt-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        4,
        1,
        'XL',
        'size-tshirt-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        5,
        1,
        'XXL',
        'size-tshirt-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        6,
        2,
        'S',
        'size-hoodie-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        7,
        2,
        'M',
        'size-hoodie-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        8,
        2,
        'L',
        'size-hoodie-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        9,
        2,
        'XL',
        'size-hoodie-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        10,
        2,
        'XXL',
        'size-hoodie-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        11,
        3,
        'S',
        'size-jacket-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        12,
        3,
        'M',
        'size-jacket-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        13,
        3,
        'L',
        'size-jacket-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        14,
        3,
        'XL',
        'size-jacket-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        15,
        3,
        'XXL',
        'size-jacket-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        16,
        4,
        'S',
        'size-pants-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        17,
        4,
        'M',
        'size-pants-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        18,
        4,
        'L',
        'size-pants-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        19,
        4,
        'XL',
        'size-pants-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        20,
        4,
        'XXL',
        'size-pants-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        21,
        5,
        'S',
        'size-accessories-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        22,
        5,
        'M',
        'size-accessories-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        23,
        5,
        'L',
        'size-accessories-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        24,
        5,
        'XL',
        'size-accessories-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        25,
        5,
        'XXL',
        'size-accessories-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        26,
        6,
        'S',
        'size-hat-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        27,
        6,
        'M',
        'size-hat-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        28,
        6,
        'L',
        'size-hat-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        29,
        6,
        'XL',
        'size-hat-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        30,
        6,
        'XXL',
        'size-hat-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        31,
        7,
        'S',
        'size-shoes-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        32,
        7,
        'M',
        'size-shoes-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        33,
        7,
        'L',
        'size-shoes-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        34,
        7,
        'XL',
        'size-shoes-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        35,
        7,
        'XXL',
        'size-shoes-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        36,
        8,
        'S',
        'size-shirt-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        37,
        8,
        'M',
        'size-shirt-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        38,
        8,
        'L',
        'size-shirt-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        39,
        8,
        'XL',
        'size-shirt-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        40,
        8,
        'XXL',
        'size-shirt-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        41,
        9,
        'S',
        'size-sweater-s',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        42,
        9,
        'M',
        'size-sweater-m',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        43,
        9,
        'L',
        'size-sweater-l',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        44,
        9,
        'XL',
        'size-sweater-xl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variant_options
VALUES (
        45,
        9,
        'XXL',
        'size-sweater-xxl',
        '2026-05-13 16:08:05.925763',
        NULL
    );

--
-- TOC entry 5056 (class 0 OID 17043)
-- Dependencies: 228
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO
    public.variants
VALUES (
        1,
        1,
        'Size',
        'size-tshirt',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        2,
        2,
        'Size',
        'size-hoodie',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        3,
        3,
        'Size',
        'size-jacket',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        4,
        4,
        'Size',
        'size-pants',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        5,
        5,
        'Size',
        'size-accessories',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        6,
        6,
        'Size',
        'size-hat',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        7,
        7,
        'Size',
        'size-shoes',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        8,
        8,
        'Size',
        'size-shirt',
        '2026-05-13 16:08:05.925763',
        NULL
    );

INSERT INTO
    public.variants
VALUES (
        9,
        9,
        'Size',
        'size-sweater',
        '2026-05-13 16:08:05.925763',
        NULL
    );

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 238
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval (
        'public.cart_items_cart_item_id_seq', 1, false
    );

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 236
-- Name: carts_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ( 'public.carts_cart_id_seq', 1, false );

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 219
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval (
        'public.categories_category_id_seq', 9, true
    );

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 240
-- Name: collections_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval (
        'public.collections_collection_id_seq', 22, true
    );

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 223
-- Name: discounts_discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval (
        'public.discounts_discount_id_seq', 3, true
    );

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 234
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval (
        'public.order_items_order_item_id_seq', 199, true
    );

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 232
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ( 'public.orders_order_id_seq', 72, true );

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 225
-- Name: product_items_product_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval (
        'public.product_items_product_item_id_seq', 18, true
    );

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 221
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ( 'public.products_product_id_seq', 18, true );

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ( 'public.users_user_id_seq', 12, true );

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 229
-- Name: variant_options_variant_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval (
        'public.variant_options_variant_option_id_seq', 45, true
    );

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 227
-- Name: variants_variant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ( 'public.variants_variant_id_seq', 9, true );

--
-- TOC entry 4877 (class 2606 OID 17146)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);

--
-- TOC entry 4875 (class 2606 OID 17133)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);

--
-- TOC entry 4847 (class 2606 OID 16991)
-- Name: categories categories_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
ADD CONSTRAINT categories_category_slug_key UNIQUE (category_slug);

--
-- TOC entry 4849 (class 2606 OID 16989)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);

--
-- TOC entry 4879 (class 2606 OID 17212)
-- Name: collections collections_collection_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
ADD CONSTRAINT collections_collection_slug_key UNIQUE (collection_slug);

--
-- TOC entry 4881 (class 2606 OID 17210)
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
ADD CONSTRAINT collections_pkey PRIMARY KEY (collection_id);

--
-- TOC entry 4855 (class 2606 OID 17019)
-- Name: discounts discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts
ADD CONSTRAINT discounts_pkey PRIMARY KEY (discount_id);

--
-- TOC entry 4873 (class 2606 OID 17115)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);

--
-- TOC entry 4871 (class 2606 OID 17102)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);

--
-- TOC entry 4883 (class 2606 OID 17222)
-- Name: product_collections product_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collections
ADD CONSTRAINT product_collections_pkey PRIMARY KEY (product_id, collection_id);

--
-- TOC entry 4869 (class 2606 OID 17081)
-- Name: product_configurations product_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_configurations
ADD CONSTRAINT product_configurations_pkey PRIMARY KEY (
    product_item_id,
    variant_option_id
);

--
-- TOC entry 4857 (class 2606 OID 17029)
-- Name: product_items product_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
ADD CONSTRAINT product_items_pkey PRIMARY KEY (product_item_id);

--
-- TOC entry 4859 (class 2606 OID 17031)
-- Name: product_items product_items_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
ADD CONSTRAINT product_items_sku_key UNIQUE (sku);

--
-- TOC entry 4851 (class 2606 OID 17001)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);

--
-- TOC entry 4853 (class 2606 OID 17003)
-- Name: products products_product_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
ADD CONSTRAINT products_product_slug_key UNIQUE (product_slug);

--
-- TOC entry 4843 (class 2606 OID 16603)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
ADD CONSTRAINT users_email_key UNIQUE (email);

--
-- TOC entry 4845 (class 2606 OID 16601)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);

--
-- TOC entry 4865 (class 2606 OID 17068)
-- Name: variant_options variant_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
ADD CONSTRAINT variant_options_pkey PRIMARY KEY (variant_option_id);

--
-- TOC entry 4867 (class 2606 OID 17070)
-- Name: variant_options variant_options_variant_option_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
ADD CONSTRAINT variant_options_variant_option_slug_key UNIQUE (variant_option_slug);

--
-- TOC entry 4861 (class 2606 OID 17051)
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
ADD CONSTRAINT variants_pkey PRIMARY KEY (variant_id);

--
-- TOC entry 4863 (class 2606 OID 17053)
-- Name: variants variants_variant_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
ADD CONSTRAINT variants_variant_slug_key UNIQUE (variant_slug);

--
-- TOC entry 4895 (class 2606 OID 17147)
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts (cart_id) ON DELETE RESTRICT;

--
-- TOC entry 4896 (class 2606 OID 17152)
-- Name: cart_items cart_items_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
ADD CONSTRAINT cart_items_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items (product_item_id) ON DELETE RESTRICT;

--
-- TOC entry 4894 (class 2606 OID 17134)
-- Name: carts carts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (user_id) ON DELETE RESTRICT;

--
-- TOC entry 4897 (class 2606 OID 17213)
-- Name: collections collections_parent_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
ADD CONSTRAINT collections_parent_collection_id_fkey FOREIGN KEY (parent_collection_id) REFERENCES public.collections (collection_id) ON DELETE SET NULL;

--
-- TOC entry 4892 (class 2606 OID 17116)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders (order_id) ON DELETE RESTRICT;

--
-- TOC entry 4893 (class 2606 OID 17121)
-- Name: order_items order_items_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
ADD CONSTRAINT order_items_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items (product_item_id) ON DELETE RESTRICT;

--
-- TOC entry 4891 (class 2606 OID 17103)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (user_id) ON DELETE RESTRICT;

--
-- TOC entry 4898 (class 2606 OID 17228)
-- Name: product_collections product_collections_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collections
ADD CONSTRAINT product_collections_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections (collection_id) ON DELETE CASCADE;

--
-- TOC entry 4899 (class 2606 OID 17223)
-- Name: product_collections product_collections_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collections
ADD CONSTRAINT product_collections_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products (product_id) ON DELETE CASCADE;

--
-- TOC entry 4889 (class 2606 OID 17082)
-- Name: product_configurations product_configurations_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_configurations
ADD CONSTRAINT product_configurations_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items (product_item_id) ON DELETE RESTRICT;

--
-- TOC entry 4890 (class 2606 OID 17087)
-- Name: product_configurations product_configurations_variant_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_configurations
ADD CONSTRAINT product_configurations_variant_option_id_fkey FOREIGN KEY (variant_option_id) REFERENCES public.variant_options (variant_option_id) ON DELETE RESTRICT;

--
-- TOC entry 4885 (class 2606 OID 17037)
-- Name: product_items product_items_discount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
ADD CONSTRAINT product_items_discount_id_fkey FOREIGN KEY (discount_id) REFERENCES public.discounts (discount_id) ON DELETE SET NULL;

--
-- TOC entry 4886 (class 2606 OID 17032)
-- Name: product_items product_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
ADD CONSTRAINT product_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products (product_id) ON DELETE RESTRICT;

--
-- TOC entry 4884 (class 2606 OID 17004)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories (category_id) ON DELETE RESTRICT;

--
-- TOC entry 4888 (class 2606 OID 17071)
-- Name: variant_options variant_options_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
ADD CONSTRAINT variant_options_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variants (variant_id) ON DELETE RESTRICT;

--
-- TOC entry 4887 (class 2606 OID 17054)
-- Name: variants variants_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
ADD CONSTRAINT variants_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories (category_id) ON DELETE RESTRICT;

-- Completed on 2026-05-15 18:57:11

--
-- PostgreSQL database dump complete
--