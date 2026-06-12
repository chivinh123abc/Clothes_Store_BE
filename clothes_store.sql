--
-- PostgreSQL database dump
--

-- Dumped from database version 15.18
-- Dumped by pg_dump version 17.0

-- Started on 2026-06-10 18:48:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE clothes_store_db;
--
-- TOC entry 3606 (class 1262 OID 16384)
-- Name: clothes_store_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE clothes_store_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE clothes_store_db OWNER TO postgres;

\connect clothes_store_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 864 (class 1247 OID 16390)
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
-- TOC entry 214 (class 1259 OID 16403)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    cart_item_id integer NOT NULL,
    cart_id integer NOT NULL,
    product_item_id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16407)
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNER TO postgres;

--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 215
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNED BY public.cart_items.cart_item_id;


--
-- TOC entry 216 (class 1259 OID 16408)
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
-- TOC entry 217 (class 1259 OID 16412)
-- Name: carts_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_cart_id_seq OWNER TO postgres;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 217
-- Name: carts_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_cart_id_seq OWNED BY public.carts.cart_id;


--
-- TOC entry 218 (class 1259 OID 16413)
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
-- TOC entry 219 (class 1259 OID 16419)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 219
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 220 (class 1259 OID 16420)
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
-- TOC entry 221 (class 1259 OID 16426)
-- Name: collections_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collections_collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collections_collection_id_seq OWNER TO postgres;

--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 221
-- Name: collections_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collections_collection_id_seq OWNED BY public.collections.collection_id;


--
-- TOC entry 222 (class 1259 OID 16427)
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
-- TOC entry 223 (class 1259 OID 16434)
-- Name: discounts_discount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discounts_discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discounts_discount_id_seq OWNER TO postgres;

--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 223
-- Name: discounts_discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discounts_discount_id_seq OWNED BY public.discounts.discount_id;


--
-- TOC entry 224 (class 1259 OID 16435)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    product_item_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16439)
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_order_item_id_seq OWNER TO postgres;

--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 225
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;


--
-- TOC entry 226 (class 1259 OID 16440)
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
    payment_status character varying(20) DEFAULT 'unpaid'::character varying,
    CONSTRAINT orders_payment_method_check CHECK ((payment_method::text = ANY (ARRAY['cod'::text, 'momo'::text])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16449)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 228 (class 1259 OID 16450)
-- Name: product_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_collections (
    product_id integer NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE public.product_collections OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16453)
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
-- TOC entry 230 (class 1259 OID 16457)
-- Name: product_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_items (
    product_item_id integer NOT NULL,
    product_id integer NOT NULL,
    sku character varying(255),
    stock_quantity integer,
    product_item_image text,
    product_item_price numeric(10,2),
    discount_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.product_items OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16463)
-- Name: product_items_product_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_items_product_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_items_product_item_id_seq OWNER TO postgres;

--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_items_product_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_items_product_item_id_seq OWNED BY public.product_items.product_item_id;


--
-- TOC entry 232 (class 1259 OID 16464)
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
-- TOC entry 233 (class 1259 OID 16471)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 233
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 234 (class 1259 OID 16472)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    user_id integer,
    product_id integer,
    rating integer NOT NULL,
    text text,
    image_url character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16480)
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_review_id_seq OWNER TO postgres;

--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 235
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- TOC entry 236 (class 1259 OID 16481)
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
    full_name character varying(255),
    reset_token character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16491)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 237
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 238 (class 1259 OID 16492)
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
-- TOC entry 239 (class 1259 OID 16498)
-- Name: variant_options_variant_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variant_options_variant_option_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.variant_options_variant_option_id_seq OWNER TO postgres;

--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 239
-- Name: variant_options_variant_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variant_options_variant_option_id_seq OWNED BY public.variant_options.variant_option_id;


--
-- TOC entry 240 (class 1259 OID 16499)
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
-- TOC entry 241 (class 1259 OID 16505)
-- Name: variants_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variants_variant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.variants_variant_id_seq OWNER TO postgres;

--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 241
-- Name: variants_variant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variants_variant_id_seq OWNED BY public.variants.variant_id;


--
-- TOC entry 3331 (class 2604 OID 16506)
-- Name: cart_items cart_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cart_items_cart_item_id_seq'::regclass);


--
-- TOC entry 3333 (class 2604 OID 16507)
-- Name: carts cart_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN cart_id SET DEFAULT nextval('public.carts_cart_id_seq'::regclass);


--
-- TOC entry 3335 (class 2604 OID 16508)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 3337 (class 2604 OID 16509)
-- Name: collections collection_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections ALTER COLUMN collection_id SET DEFAULT nextval('public.collections_collection_id_seq'::regclass);


--
-- TOC entry 3339 (class 2604 OID 16510)
-- Name: discounts discount_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts ALTER COLUMN discount_id SET DEFAULT nextval('public.discounts_discount_id_seq'::regclass);


--
-- TOC entry 3342 (class 2604 OID 16511)
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- TOC entry 3344 (class 2604 OID 16512)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 3350 (class 2604 OID 16513)
-- Name: product_items product_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items ALTER COLUMN product_item_id SET DEFAULT nextval('public.product_items_product_item_id_seq'::regclass);


--
-- TOC entry 3352 (class 2604 OID 16514)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 3355 (class 2604 OID 16515)
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- TOC entry 3358 (class 2604 OID 16516)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3364 (class 2604 OID 16517)
-- Name: variant_options variant_option_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options ALTER COLUMN variant_option_id SET DEFAULT nextval('public.variant_options_variant_option_id_seq'::regclass);


--
-- TOC entry 3366 (class 2604 OID 16518)
-- Name: variants variant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants ALTER COLUMN variant_id SET DEFAULT nextval('public.variants_variant_id_seq'::regclass);


--
-- TOC entry 3573 (class 0 OID 16403)
-- Dependencies: 214
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cart_items VALUES (5, 1, 614, 1, 76.00, '2026-06-10 06:20:44.70029', NULL);
INSERT INTO public.cart_items VALUES (6, 1, 611, 1, 95.00, '2026-06-10 06:20:53.371589', '2026-06-10 07:25:21.595567');
INSERT INTO public.cart_items VALUES (10, 1, 623, 1, 73.15, '2026-06-10 07:41:22.056425', '2026-06-10 07:49:55.880453');


--
-- TOC entry 3575 (class 0 OID 16408)
-- Dependencies: 216
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.carts VALUES (1, 3, '2026-06-10 06:14:34.163478', NULL);


--
-- TOC entry 3577 (class 0 OID 16413)
-- Dependencies: 218
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (1, 'T-Shirt', 'tshirt', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (2, 'Hoodie', 'hoodie', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (3, 'Jacket', 'jacket', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (4, 'Pants', 'pants', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (5, 'Accessories', 'accessories', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (6, 'Hat', 'hat', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (7, 'Shoes', 'shoes', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (8, 'Shirt', 'shirt', '2026-05-13 16:08:05.915208', NULL, NULL);
INSERT INTO public.categories VALUES (9, 'Sweater', 'sweater', '2026-05-13 16:08:05.915208', NULL, NULL);


--
-- TOC entry 3579 (class 0 OID 16420)
-- Dependencies: 220
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.collections VALUES (1, 'TEAM KIT', 'team-kit', NULL, 'Official team jerseys and gear', '2026-05-13 16:08:05.917501', NULL);
INSERT INTO public.collections VALUES (2, 'COLLECTION', 'collection', NULL, 'Main season collections', '2026-05-13 16:08:05.917501', NULL);
INSERT INTO public.collections VALUES (3, 'COLLABORATION', 'collaboration', NULL, 'Limited edition collaborations with other brands', '2026-05-13 16:08:05.917501', NULL);
INSERT INTO public.collections VALUES (4, 'LEGACY', 'legacy', NULL, 'Archive of past collections', '2026-05-13 16:08:05.917501', NULL);
INSERT INTO public.collections VALUES (5, 'ESSENTIAL', 'essential', 2, NULL, '2026-05-13 16:08:05.919425', NULL);
INSERT INTO public.collections VALUES (6, 'LEAGUE OF LEGENDS', 'league-of-legends', 2, NULL, '2026-05-13 16:08:05.919425', NULL);
INSERT INTO public.collections VALUES (7, 'VALORANT', 'valorant', 2, NULL, '2026-05-13 16:08:05.919425', NULL);
INSERT INTO public.collections VALUES (8, 'GIFT & ACCESSORY', 'essential-gift-and-accessory', 5, NULL, '2026-05-13 16:08:05.921486', NULL);
INSERT INTO public.collections VALUES (9, 'APPAREL', 'essential-apparel', 5, NULL, '2026-05-13 16:08:05.921486', NULL);
INSERT INTO public.collections VALUES (10, 'GIFT & ACCESSORY', 'lol-gift-and-accessory', 6, NULL, '2026-05-13 16:08:05.921486', NULL);
INSERT INTO public.collections VALUES (11, 'APPAREL', 'lol-apparel', 6, NULL, '2026-05-13 16:08:05.921486', NULL);
INSERT INTO public.collections VALUES (12, 'GIFT & ACCESSORY', 'valorant-gift-and-accessory', 7, NULL, '2026-05-13 16:08:05.921486', NULL);
INSERT INTO public.collections VALUES (13, 'APPAREL', 'valorant-apparel', 7, NULL, '2026-05-13 16:08:05.921486', NULL);
INSERT INTO public.collections VALUES (14, 'DISNEY', 'disney', 3, NULL, '2026-05-13 16:08:05.922401', NULL);
INSERT INTO public.collections VALUES (15, 'RINSTORE X GOALSTUDIO', 'rinstore-x-goalstudio', 3, NULL, '2026-05-13 16:08:05.922401', NULL);
INSERT INTO public.collections VALUES (16, 'RINSTORE X SECRETLAB', 'rinstore-x-secretlab', 3, NULL, '2026-05-13 16:08:05.922401', NULL);
INSERT INTO public.collections VALUES (17, 'RINSTORE X RAZER', 'rinstore-x-razer', 3, NULL, '2026-05-13 16:08:05.922401', NULL);
INSERT INTO public.collections VALUES (18, 'T1 2025 WORLDS COLLECTION', 'worlds-2025', 4, NULL, '2026-05-13 16:08:05.923042', NULL);
INSERT INTO public.collections VALUES (19, 'T1 2024 WORLDS COLLECTION', 'worlds-2024', 4, NULL, '2026-05-13 16:08:05.923042', NULL);
INSERT INTO public.collections VALUES (20, 'T1 2023 WORLDS COLLECTION', 'worlds-2023', 4, NULL, '2026-05-13 16:08:05.923042', NULL);
INSERT INTO public.collections VALUES (21, 'APPAREL', 'legacy-apparel', 4, NULL, '2026-05-13 16:08:05.923042', NULL);
INSERT INTO public.collections VALUES (22, 'GIFTS & ACCESSORIES', 'legacy-gifts', 4, NULL, '2026-05-13 16:08:05.923042', NULL);


--
-- TOC entry 3581 (class 0 OID 16427)
-- Dependencies: 222
-- Data for Name: discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.discounts VALUES (1, '20% Off', NULL, 20, true, '2026-05-13 16:08:05.923613', NULL);
INSERT INTO public.discounts VALUES (2, '23% Off', NULL, 23, true, '2026-05-13 16:08:05.923613', NULL);
INSERT INTO public.discounts VALUES (3, '28% Off', NULL, 28, true, '2026-05-13 16:08:05.923613', NULL);


--
-- TOC entry 3583 (class 0 OID 16435)
-- Dependencies: 224
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_items VALUES (200, 73, 41, 3, 25.00, '2026-05-01 14:07:33.336', '2026-05-01 14:07:33.336');
INSERT INTO public.order_items VALUES (201, 73, 312, 3, 45.00, '2026-05-01 14:07:33.336', '2026-05-01 14:07:33.336');
INSERT INTO public.order_items VALUES (202, 74, 471, 1, 15.00, '2026-05-15 14:07:33.355', '2026-05-15 14:07:33.355');
INSERT INTO public.order_items VALUES (203, 74, 95, 1, 65.00, '2026-05-15 14:07:33.355', '2026-05-15 14:07:33.355');
INSERT INTO public.order_items VALUES (204, 74, 556, 2, 95.00, '2026-05-15 14:07:33.355', '2026-05-15 14:07:33.355');
INSERT INTO public.order_items VALUES (205, 74, 58, 2, 25.00, '2026-05-15 14:07:33.355', '2026-05-15 14:07:33.355');
INSERT INTO public.order_items VALUES (206, 75, 263, 2, 55.00, '2026-05-23 14:07:33.366', '2026-05-23 14:07:33.366');
INSERT INTO public.order_items VALUES (207, 75, 57, 3, 25.00, '2026-05-23 14:07:33.366', '2026-05-23 14:07:33.366');
INSERT INTO public.order_items VALUES (208, 76, 270, 2, 55.00, '2026-03-29 14:07:33.376', '2026-03-29 14:07:33.376');
INSERT INTO public.order_items VALUES (209, 76, 571, 2, 95.00, '2026-03-29 14:07:33.376', '2026-03-29 14:07:33.376');
INSERT INTO public.order_items VALUES (210, 77, 83, 3, 25.00, '2026-03-31 14:07:33.383', '2026-03-31 14:07:33.383');
INSERT INTO public.order_items VALUES (211, 77, 120, 2, 65.00, '2026-03-31 14:07:33.383', '2026-03-31 14:07:33.383');
INSERT INTO public.order_items VALUES (212, 77, 99, 1, 65.00, '2026-03-31 14:07:33.383', '2026-03-31 14:07:33.383');
INSERT INTO public.order_items VALUES (213, 77, 262, 2, 55.00, '2026-03-31 14:07:33.383', '2026-03-31 14:07:33.383');
INSERT INTO public.order_items VALUES (214, 78, 285, 2, 45.00, '2026-05-11 14:07:33.393', '2026-05-11 14:07:33.393');
INSERT INTO public.order_items VALUES (215, 78, 137, 2, 85.00, '2026-05-11 14:07:33.393', '2026-05-11 14:07:33.393');
INSERT INTO public.order_items VALUES (216, 79, 437, 3, 15.00, '2026-04-10 14:07:33.4', '2026-04-10 14:07:33.4');
INSERT INTO public.order_items VALUES (217, 79, 288, 3, 45.00, '2026-04-10 14:07:33.4', '2026-04-10 14:07:33.4');
INSERT INTO public.order_items VALUES (218, 79, 213, 2, 55.00, '2026-04-10 14:07:33.4', '2026-04-10 14:07:33.4');
INSERT INTO public.order_items VALUES (219, 79, 341, 3, 59.00, '2026-04-10 14:07:33.4', '2026-04-10 14:07:33.4');
INSERT INTO public.order_items VALUES (220, 80, 540, 2, 95.00, '2026-04-13 14:07:33.411', '2026-04-13 14:07:33.411');
INSERT INTO public.order_items VALUES (221, 81, 600, 2, 95.00, '2026-04-17 14:07:33.414', '2026-04-17 14:07:33.414');
INSERT INTO public.order_items VALUES (222, 81, 307, 1, 45.00, '2026-04-17 14:07:33.414', '2026-04-17 14:07:33.414');
INSERT INTO public.order_items VALUES (223, 82, 540, 2, 95.00, '2026-04-06 14:07:33.421', '2026-04-06 14:07:33.421');
INSERT INTO public.order_items VALUES (224, 82, 292, 3, 45.00, '2026-04-06 14:07:33.421', '2026-04-06 14:07:33.421');
INSERT INTO public.order_items VALUES (225, 83, 517, 1, 25.00, '2026-05-03 14:07:33.427', '2026-05-03 14:07:33.427');
INSERT INTO public.order_items VALUES (226, 84, 568, 1, 95.00, '2026-05-05 14:07:33.431', '2026-05-05 14:07:33.431');
INSERT INTO public.order_items VALUES (227, 84, 359, 3, 59.00, '2026-05-05 14:07:33.431', '2026-05-05 14:07:33.431');
INSERT INTO public.order_items VALUES (228, 84, 566, 2, 95.00, '2026-05-05 14:07:33.431', '2026-05-05 14:07:33.431');
INSERT INTO public.order_items VALUES (229, 84, 492, 2, 15.00, '2026-05-05 14:07:33.431', '2026-05-05 14:07:33.431');
INSERT INTO public.order_items VALUES (230, 85, 581, 3, 95.00, '2026-05-04 14:07:33.443', '2026-05-04 14:07:33.443');
INSERT INTO public.order_items VALUES (231, 85, 529, 3, 95.00, '2026-05-04 14:07:33.443', '2026-05-04 14:07:33.443');
INSERT INTO public.order_items VALUES (232, 86, 522, 2, 95.00, '2026-05-26 14:07:33.449', '2026-05-26 14:07:33.449');
INSERT INTO public.order_items VALUES (233, 86, 39, 3, 25.00, '2026-05-26 14:07:33.449', '2026-05-26 14:07:33.449');
INSERT INTO public.order_items VALUES (234, 86, 131, 2, 65.00, '2026-05-26 14:07:33.449', '2026-05-26 14:07:33.449');
INSERT INTO public.order_items VALUES (235, 87, 61, 3, 25.00, '2026-05-11 14:07:33.456', '2026-05-11 14:07:33.456');
INSERT INTO public.order_items VALUES (236, 87, 413, 1, 35.00, '2026-05-11 14:07:33.456', '2026-05-11 14:07:33.456');
INSERT INTO public.order_items VALUES (237, 87, 85, 3, 25.00, '2026-05-11 14:07:33.456', '2026-05-11 14:07:33.456');
INSERT INTO public.order_items VALUES (238, 88, 297, 3, 45.00, '2026-04-30 14:07:33.465', '2026-04-30 14:07:33.465');
INSERT INTO public.order_items VALUES (239, 88, 432, 3, 35.00, '2026-04-30 14:07:33.465', '2026-04-30 14:07:33.465');
INSERT INTO public.order_items VALUES (240, 88, 316, 1, 59.00, '2026-04-30 14:07:33.465', '2026-04-30 14:07:33.465');
INSERT INTO public.order_items VALUES (241, 88, 231, 1, 55.00, '2026-04-30 14:07:33.465', '2026-04-30 14:07:33.465');
INSERT INTO public.order_items VALUES (242, 89, 450, 3, 15.00, '2026-05-05 14:07:33.476', '2026-05-05 14:07:33.476');
INSERT INTO public.order_items VALUES (243, 89, 352, 2, 59.00, '2026-05-05 14:07:33.476', '2026-05-05 14:07:33.476');
INSERT INTO public.order_items VALUES (244, 90, 298, 2, 45.00, '2026-05-15 14:07:33.482', '2026-05-15 14:07:33.482');
INSERT INTO public.order_items VALUES (245, 90, 109, 1, 65.00, '2026-05-15 14:07:33.482', '2026-05-15 14:07:33.482');
INSERT INTO public.order_items VALUES (246, 90, 264, 1, 55.00, '2026-05-15 14:07:33.482', '2026-05-15 14:07:33.482');
INSERT INTO public.order_items VALUES (247, 91, 70, 3, 25.00, '2026-04-11 14:07:33.492', '2026-04-11 14:07:33.492');
INSERT INTO public.order_items VALUES (248, 92, 519, 1, 95.00, '2026-05-11 14:07:33.496', '2026-05-11 14:07:33.496');
INSERT INTO public.order_items VALUES (249, 93, 415, 3, 35.00, '2026-03-30 14:07:33.5', '2026-03-30 14:07:33.5');
INSERT INTO public.order_items VALUES (250, 93, 301, 3, 45.00, '2026-03-30 14:07:33.5', '2026-03-30 14:07:33.5');
INSERT INTO public.order_items VALUES (251, 94, 457, 1, 15.00, '2026-05-19 14:07:33.507', '2026-05-19 14:07:33.507');
INSERT INTO public.order_items VALUES (252, 95, 224, 1, 55.00, '2026-04-05 14:07:33.511', '2026-04-05 14:07:33.511');
INSERT INTO public.order_items VALUES (253, 96, 295, 3, 45.00, '2026-04-18 14:07:33.515', '2026-04-18 14:07:33.515');
INSERT INTO public.order_items VALUES (254, 96, 515, 2, 25.00, '2026-04-18 14:07:33.515', '2026-04-18 14:07:33.515');
INSERT INTO public.order_items VALUES (255, 96, 345, 3, 59.00, '2026-04-18 14:07:33.515', '2026-04-18 14:07:33.515');
INSERT INTO public.order_items VALUES (256, 97, 587, 2, 95.00, '2026-05-19 14:07:33.523', '2026-05-19 14:07:33.523');
INSERT INTO public.order_items VALUES (257, 97, 268, 3, 55.00, '2026-05-19 14:07:33.523', '2026-05-19 14:07:33.523');
INSERT INTO public.order_items VALUES (258, 97, 501, 1, 15.00, '2026-05-19 14:07:33.523', '2026-05-19 14:07:33.523');
INSERT INTO public.order_items VALUES (259, 97, 413, 3, 35.00, '2026-05-19 14:07:33.523', '2026-05-19 14:07:33.523');
INSERT INTO public.order_items VALUES (260, 98, 126, 2, 65.00, '2026-05-04 14:07:33.534', '2026-05-04 14:07:33.534');
INSERT INTO public.order_items VALUES (261, 99, 98, 1, 65.00, '2026-05-05 14:07:33.538', '2026-05-05 14:07:33.538');
INSERT INTO public.order_items VALUES (262, 99, 600, 1, 95.00, '2026-05-05 14:07:33.538', '2026-05-05 14:07:33.538');
INSERT INTO public.order_items VALUES (263, 99, 490, 2, 15.00, '2026-05-05 14:07:33.538', '2026-05-05 14:07:33.538');
INSERT INTO public.order_items VALUES (264, 100, 496, 2, 15.00, '2026-04-09 14:07:33.546', '2026-04-09 14:07:33.546');
INSERT INTO public.order_items VALUES (265, 100, 496, 2, 15.00, '2026-04-09 14:07:33.546', '2026-04-09 14:07:33.546');
INSERT INTO public.order_items VALUES (266, 100, 503, 2, 15.00, '2026-04-09 14:07:33.546', '2026-04-09 14:07:33.546');
INSERT INTO public.order_items VALUES (267, 100, 180, 2, 85.00, '2026-04-09 14:07:33.546', '2026-04-09 14:07:33.546');
INSERT INTO public.order_items VALUES (268, 101, 277, 3, 55.00, '2026-05-17 14:07:33.556', '2026-05-17 14:07:33.556');
INSERT INTO public.order_items VALUES (269, 102, 331, 1, 59.00, '2026-04-16 14:07:33.56', '2026-04-16 14:07:33.56');
INSERT INTO public.order_items VALUES (270, 102, 266, 1, 55.00, '2026-04-16 14:07:33.56', '2026-04-16 14:07:33.56');
INSERT INTO public.order_items VALUES (271, 102, 125, 3, 65.00, '2026-04-16 14:07:33.56', '2026-04-16 14:07:33.56');
INSERT INTO public.order_items VALUES (272, 103, 423, 1, 35.00, '2026-03-31 14:07:33.568', '2026-03-31 14:07:33.568');
INSERT INTO public.order_items VALUES (273, 104, 585, 3, 95.00, '2026-05-15 14:07:33.572', '2026-05-15 14:07:33.572');
INSERT INTO public.order_items VALUES (274, 104, 69, 1, 25.00, '2026-05-15 14:07:33.572', '2026-05-15 14:07:33.572');
INSERT INTO public.order_items VALUES (275, 105, 89, 2, 65.00, '2026-05-06 14:07:33.578', '2026-05-06 14:07:33.578');
INSERT INTO public.order_items VALUES (276, 105, 405, 2, 35.00, '2026-05-06 14:07:33.578', '2026-05-06 14:07:33.578');
INSERT INTO public.order_items VALUES (277, 105, 38, 2, 25.00, '2026-05-06 14:07:33.578', '2026-05-06 14:07:33.578');
INSERT INTO public.order_items VALUES (278, 105, 336, 3, 59.00, '2026-05-06 14:07:33.578', '2026-05-06 14:07:33.578');
INSERT INTO public.order_items VALUES (279, 106, 230, 1, 55.00, '2026-04-10 14:07:33.587', '2026-04-10 14:07:33.587');
INSERT INTO public.order_items VALUES (280, 106, 297, 1, 45.00, '2026-04-10 14:07:33.587', '2026-04-10 14:07:33.587');
INSERT INTO public.order_items VALUES (281, 107, 154, 1, 85.00, '2026-04-11 14:07:33.591', '2026-04-11 14:07:33.591');
INSERT INTO public.order_items VALUES (282, 108, 491, 1, 15.00, '2026-05-19 14:07:33.596', '2026-05-19 14:07:33.596');
INSERT INTO public.order_items VALUES (283, 108, 295, 3, 45.00, '2026-05-19 14:07:33.596', '2026-05-19 14:07:33.596');
INSERT INTO public.order_items VALUES (284, 108, 76, 3, 25.00, '2026-05-19 14:07:33.596', '2026-05-19 14:07:33.596');
INSERT INTO public.order_items VALUES (285, 108, 467, 1, 15.00, '2026-05-19 14:07:33.596', '2026-05-19 14:07:33.596');
INSERT INTO public.order_items VALUES (286, 109, 183, 3, 85.00, '2026-05-16 14:07:33.604', '2026-05-16 14:07:33.604');
INSERT INTO public.order_items VALUES (287, 110, 293, 1, 45.00, '2026-04-17 14:07:33.608', '2026-04-17 14:07:33.608');
INSERT INTO public.order_items VALUES (288, 110, 374, 1, 59.00, '2026-04-17 14:07:33.608', '2026-04-17 14:07:33.608');
INSERT INTO public.order_items VALUES (289, 110, 21, 1, 25.00, '2026-04-17 14:07:33.608', '2026-04-17 14:07:33.608');
INSERT INTO public.order_items VALUES (290, 111, 601, 1, 95.00, '2026-04-18 14:07:33.613', '2026-04-18 14:07:33.613');
INSERT INTO public.order_items VALUES (291, 111, 597, 1, 95.00, '2026-04-18 14:07:33.613', '2026-04-18 14:07:33.613');
INSERT INTO public.order_items VALUES (292, 111, 261, 2, 55.00, '2026-04-18 14:07:33.613', '2026-04-18 14:07:33.613');
INSERT INTO public.order_items VALUES (293, 112, 310, 3, 45.00, '2026-04-25 14:07:33.622', '2026-04-25 14:07:33.622');
INSERT INTO public.order_items VALUES (294, 112, 442, 1, 15.00, '2026-04-25 14:07:33.622', '2026-04-25 14:07:33.622');
INSERT INTO public.order_items VALUES (295, 112, 121, 1, 65.00, '2026-04-25 14:07:33.622', '2026-04-25 14:07:33.622');
INSERT INTO public.order_items VALUES (296, 113, 351, 3, 59.00, '2026-05-01 14:07:33.629', '2026-05-01 14:07:33.629');
INSERT INTO public.order_items VALUES (297, 114, 231, 1, 55.00, '2026-04-05 14:07:33.633', '2026-04-05 14:07:33.633');
INSERT INTO public.order_items VALUES (298, 114, 131, 2, 65.00, '2026-04-05 14:07:33.633', '2026-04-05 14:07:33.633');
INSERT INTO public.order_items VALUES (299, 114, 27, 2, 25.00, '2026-04-05 14:07:33.633', '2026-04-05 14:07:33.633');
INSERT INTO public.order_items VALUES (300, 115, 328, 1, 59.00, '2026-05-16 14:07:33.641', '2026-05-16 14:07:33.641');
INSERT INTO public.order_items VALUES (301, 115, 254, 3, 55.00, '2026-05-16 14:07:33.641', '2026-05-16 14:07:33.641');
INSERT INTO public.order_items VALUES (302, 116, 176, 2, 85.00, '2026-04-07 14:07:33.646', '2026-04-07 14:07:33.646');
INSERT INTO public.order_items VALUES (303, 116, 208, 2, 55.00, '2026-04-07 14:07:33.646', '2026-04-07 14:07:33.646');
INSERT INTO public.order_items VALUES (304, 117, 353, 1, 59.00, '2026-04-30 14:07:33.652', '2026-04-30 14:07:33.652');
INSERT INTO public.order_items VALUES (305, 117, 292, 1, 45.00, '2026-04-30 14:07:33.652', '2026-04-30 14:07:33.652');
INSERT INTO public.order_items VALUES (306, 118, 329, 1, 59.00, '2026-05-17 14:07:33.657', '2026-05-17 14:07:33.657');
INSERT INTO public.order_items VALUES (307, 118, 88, 3, 25.00, '2026-05-17 14:07:33.657', '2026-05-17 14:07:33.657');
INSERT INTO public.order_items VALUES (308, 118, 519, 3, 95.00, '2026-05-17 14:07:33.657', '2026-05-17 14:07:33.657');
INSERT INTO public.order_items VALUES (309, 119, 607, 1, 95.00, '2026-04-10 14:07:33.665', '2026-04-10 14:07:33.665');
INSERT INTO public.order_items VALUES (310, 119, 94, 2, 65.00, '2026-04-10 14:07:33.665', '2026-04-10 14:07:33.665');
INSERT INTO public.order_items VALUES (311, 119, 439, 3, 15.00, '2026-04-10 14:07:33.665', '2026-04-10 14:07:33.665');
INSERT INTO public.order_items VALUES (312, 120, 93, 2, 65.00, '2026-05-08 14:07:33.673', '2026-05-08 14:07:33.673');
INSERT INTO public.order_items VALUES (313, 121, 259, 3, 55.00, '2026-04-04 14:07:33.677', '2026-04-04 14:07:33.677');
INSERT INTO public.order_items VALUES (314, 121, 122, 2, 65.00, '2026-04-04 14:07:33.677', '2026-04-04 14:07:33.677');
INSERT INTO public.order_items VALUES (315, 121, 475, 1, 15.00, '2026-04-04 14:07:33.677', '2026-04-04 14:07:33.677');
INSERT INTO public.order_items VALUES (316, 121, 581, 1, 95.00, '2026-04-04 14:07:33.677', '2026-04-04 14:07:33.677');
INSERT INTO public.order_items VALUES (317, 122, 96, 2, 65.00, '2026-03-31 14:07:33.687', '2026-03-31 14:07:33.687');
INSERT INTO public.order_items VALUES (318, 122, 173, 2, 85.00, '2026-03-31 14:07:33.687', '2026-03-31 14:07:33.687');
INSERT INTO public.order_items VALUES (319, 122, 600, 2, 95.00, '2026-03-31 14:07:33.687', '2026-03-31 14:07:33.687');
INSERT INTO public.order_items VALUES (320, 123, 454, 1, 15.00, '2026-05-17 14:07:33.694', '2026-05-17 14:07:33.694');
INSERT INTO public.order_items VALUES (321, 123, 601, 3, 95.00, '2026-05-17 14:07:33.694', '2026-05-17 14:07:33.694');
INSERT INTO public.order_items VALUES (322, 124, 224, 1, 55.00, '2026-04-01 14:07:33.7', '2026-04-01 14:07:33.7');
INSERT INTO public.order_items VALUES (323, 124, 405, 2, 35.00, '2026-04-01 14:07:33.7', '2026-04-01 14:07:33.7');
INSERT INTO public.order_items VALUES (324, 124, 369, 3, 59.00, '2026-04-01 14:07:33.7', '2026-04-01 14:07:33.7');
INSERT INTO public.order_items VALUES (325, 125, 121, 2, 65.00, '2026-04-22 14:07:33.708', '2026-04-22 14:07:33.708');
INSERT INTO public.order_items VALUES (326, 125, 24, 2, 25.00, '2026-04-22 14:07:33.708', '2026-04-22 14:07:33.708');
INSERT INTO public.order_items VALUES (327, 125, 72, 3, 25.00, '2026-04-22 14:07:33.708', '2026-04-22 14:07:33.708');
INSERT INTO public.order_items VALUES (328, 125, 319, 1, 59.00, '2026-04-22 14:07:33.708', '2026-04-22 14:07:33.708');
INSERT INTO public.order_items VALUES (329, 126, 363, 3, 59.00, '2026-04-14 14:07:33.718', '2026-04-14 14:07:33.718');
INSERT INTO public.order_items VALUES (330, 126, 72, 3, 25.00, '2026-04-14 14:07:33.718', '2026-04-14 14:07:33.718');
INSERT INTO public.order_items VALUES (331, 127, 509, 3, 15.00, '2026-04-18 14:07:33.723', '2026-04-18 14:07:33.723');
INSERT INTO public.order_items VALUES (332, 127, 589, 3, 95.00, '2026-04-18 14:07:33.723', '2026-04-18 14:07:33.723');
INSERT INTO public.order_items VALUES (333, 128, 161, 2, 85.00, '2026-03-30 14:07:33.729', '2026-03-30 14:07:33.729');
INSERT INTO public.order_items VALUES (334, 129, 146, 1, 85.00, '2026-04-02 14:07:33.732', '2026-04-02 14:07:33.732');
INSERT INTO public.order_items VALUES (335, 129, 379, 1, 35.00, '2026-04-02 14:07:33.732', '2026-04-02 14:07:33.732');
INSERT INTO public.order_items VALUES (336, 129, 618, 2, 95.00, '2026-04-02 14:07:33.732', '2026-04-02 14:07:33.732');
INSERT INTO public.order_items VALUES (337, 130, 223, 1, 55.00, '2026-05-20 14:07:33.74', '2026-05-20 14:07:33.74');
INSERT INTO public.order_items VALUES (338, 130, 445, 1, 15.00, '2026-05-20 14:07:33.74', '2026-05-20 14:07:33.74');
INSERT INTO public.order_items VALUES (339, 130, 586, 1, 95.00, '2026-05-20 14:07:33.74', '2026-05-20 14:07:33.74');
INSERT INTO public.order_items VALUES (340, 131, 474, 1, 15.00, '2026-04-24 14:07:33.745', '2026-04-24 14:07:33.745');
INSERT INTO public.order_items VALUES (341, 131, 291, 2, 45.00, '2026-04-24 14:07:33.745', '2026-04-24 14:07:33.745');
INSERT INTO public.order_items VALUES (342, 131, 559, 1, 95.00, '2026-04-24 14:07:33.745', '2026-04-24 14:07:33.745');
INSERT INTO public.order_items VALUES (343, 132, 563, 3, 95.00, '2026-04-25 14:07:33.753', '2026-04-25 14:07:33.753');
INSERT INTO public.order_items VALUES (344, 132, 442, 2, 15.00, '2026-04-25 14:07:33.753', '2026-04-25 14:07:33.753');
INSERT INTO public.order_items VALUES (345, 133, 24, 2, 25.00, '2026-05-26 14:07:33.757', '2026-05-26 14:07:33.757');
INSERT INTO public.order_items VALUES (346, 134, 455, 2, 15.00, '2026-05-04 14:07:33.76', '2026-05-04 14:07:33.76');
INSERT INTO public.order_items VALUES (347, 134, 61, 2, 25.00, '2026-05-04 14:07:33.76', '2026-05-04 14:07:33.76');
INSERT INTO public.order_items VALUES (348, 135, 584, 3, 95.00, '2026-05-17 14:07:33.766', '2026-05-17 14:07:33.766');
INSERT INTO public.order_items VALUES (349, 135, 193, 1, 85.00, '2026-05-17 14:07:33.766', '2026-05-17 14:07:33.766');
INSERT INTO public.order_items VALUES (350, 136, 122, 1, 65.00, '2026-04-10 14:07:33.771', '2026-04-10 14:07:33.771');
INSERT INTO public.order_items VALUES (351, 137, 592, 1, 95.00, '2026-05-04 14:07:33.775', '2026-05-04 14:07:33.775');
INSERT INTO public.order_items VALUES (352, 138, 374, 1, 59.00, '2026-05-02 14:07:33.778', '2026-05-02 14:07:33.778');
INSERT INTO public.order_items VALUES (353, 138, 511, 1, 15.00, '2026-05-02 14:07:33.778', '2026-05-02 14:07:33.778');
INSERT INTO public.order_items VALUES (354, 139, 501, 1, 15.00, '2026-04-02 14:07:33.782', '2026-04-02 14:07:33.782');
INSERT INTO public.order_items VALUES (355, 139, 346, 3, 59.00, '2026-04-02 14:07:33.782', '2026-04-02 14:07:33.782');
INSERT INTO public.order_items VALUES (356, 139, 435, 2, 15.00, '2026-04-02 14:07:33.782', '2026-04-02 14:07:33.782');
INSERT INTO public.order_items VALUES (357, 139, 87, 2, 25.00, '2026-04-02 14:07:33.782', '2026-04-02 14:07:33.782');
INSERT INTO public.order_items VALUES (358, 140, 144, 1, 85.00, '2026-05-11 14:07:33.791', '2026-05-11 14:07:33.791');
INSERT INTO public.order_items VALUES (359, 140, 71, 1, 25.00, '2026-05-11 14:07:33.791', '2026-05-11 14:07:33.791');
INSERT INTO public.order_items VALUES (360, 140, 81, 2, 25.00, '2026-05-11 14:07:33.791', '2026-05-11 14:07:33.791');
INSERT INTO public.order_items VALUES (361, 141, 292, 1, 45.00, '2026-05-17 14:07:33.799', '2026-05-17 14:07:33.799');
INSERT INTO public.order_items VALUES (362, 141, 92, 3, 65.00, '2026-05-17 14:07:33.799', '2026-05-17 14:07:33.799');
INSERT INTO public.order_items VALUES (363, 141, 56, 3, 25.00, '2026-05-17 14:07:33.799', '2026-05-17 14:07:33.799');
INSERT INTO public.order_items VALUES (364, 142, 402, 2, 35.00, '2026-05-05 14:07:33.805', '2026-05-05 14:07:33.805');
INSERT INTO public.order_items VALUES (365, 142, 377, 2, 59.00, '2026-05-05 14:07:33.805', '2026-05-05 14:07:33.805');
INSERT INTO public.order_items VALUES (366, 142, 301, 1, 45.00, '2026-05-05 14:07:33.805', '2026-05-05 14:07:33.805');
INSERT INTO public.order_items VALUES (367, 143, 201, 3, 55.00, '2026-04-07 14:07:33.811', '2026-04-07 14:07:33.811');
INSERT INTO public.order_items VALUES (368, 143, 588, 1, 95.00, '2026-04-07 14:07:33.811', '2026-04-07 14:07:33.811');
INSERT INTO public.order_items VALUES (369, 144, 612, 3, 95.00, '2026-05-23 14:07:33.817', '2026-05-23 14:07:33.817');
INSERT INTO public.order_items VALUES (370, 144, 388, 1, 35.00, '2026-05-23 14:07:33.817', '2026-05-23 14:07:33.817');
INSERT INTO public.order_items VALUES (371, 144, 57, 3, 25.00, '2026-05-23 14:07:33.817', '2026-05-23 14:07:33.817');
INSERT INTO public.order_items VALUES (372, 144, 591, 2, 95.00, '2026-05-23 14:07:33.817', '2026-05-23 14:07:33.817');
INSERT INTO public.order_items VALUES (373, 145, 246, 3, 55.00, '2026-04-03 14:07:33.827', '2026-04-03 14:07:33.827');
INSERT INTO public.order_items VALUES (374, 146, 226, 3, 55.00, '2026-04-13 14:07:33.831', '2026-04-13 14:07:33.831');
INSERT INTO public.order_items VALUES (375, 146, 537, 3, 95.00, '2026-04-13 14:07:33.831', '2026-04-13 14:07:33.831');
INSERT INTO public.order_items VALUES (376, 146, 123, 1, 65.00, '2026-04-13 14:07:33.831', '2026-04-13 14:07:33.831');
INSERT INTO public.order_items VALUES (377, 147, 31, 1, 25.00, '2026-04-19 14:07:33.838', '2026-04-19 14:07:33.838');
INSERT INTO public.order_items VALUES (378, 147, 286, 1, 45.00, '2026-04-19 14:07:33.838', '2026-04-19 14:07:33.838');
INSERT INTO public.order_items VALUES (379, 148, 56, 3, 25.00, '2026-05-03 14:07:33.844', '2026-05-03 14:07:33.844');
INSERT INTO public.order_items VALUES (380, 148, 272, 2, 55.00, '2026-05-03 14:07:33.844', '2026-05-03 14:07:33.844');
INSERT INTO public.order_items VALUES (381, 149, 82, 1, 25.00, '2026-04-14 14:07:33.849', '2026-04-14 14:07:33.849');
INSERT INTO public.order_items VALUES (382, 149, 76, 2, 25.00, '2026-04-14 14:07:33.849', '2026-04-14 14:07:33.849');
INSERT INTO public.order_items VALUES (383, 150, 535, 2, 95.00, '2026-03-29 14:07:33.855', '2026-03-29 14:07:33.855');
INSERT INTO public.order_items VALUES (384, 150, 46, 3, 25.00, '2026-03-29 14:07:33.855', '2026-03-29 14:07:33.855');
INSERT INTO public.order_items VALUES (385, 151, 56, 3, 25.00, '2026-05-11 14:07:33.859', '2026-05-11 14:07:33.859');
INSERT INTO public.order_items VALUES (386, 152, 229, 3, 55.00, '2026-05-08 14:07:33.863', '2026-05-08 14:07:33.863');
INSERT INTO public.order_items VALUES (387, 152, 182, 2, 85.00, '2026-05-08 14:07:33.863', '2026-05-08 14:07:33.863');
INSERT INTO public.order_items VALUES (388, 152, 387, 1, 35.00, '2026-05-08 14:07:33.863', '2026-05-08 14:07:33.863');
INSERT INTO public.order_items VALUES (389, 153, 153, 3, 85.00, '2026-04-21 14:07:33.868', '2026-04-21 14:07:33.868');
INSERT INTO public.order_items VALUES (390, 153, 561, 2, 95.00, '2026-04-21 14:07:33.868', '2026-04-21 14:07:33.868');
INSERT INTO public.order_items VALUES (391, 154, 102, 3, 65.00, '2026-05-10 14:07:33.873', '2026-05-10 14:07:33.873');
INSERT INTO public.order_items VALUES (392, 154, 119, 1, 65.00, '2026-05-10 14:07:33.873', '2026-05-10 14:07:33.873');
INSERT INTO public.order_items VALUES (393, 154, 163, 3, 85.00, '2026-05-10 14:07:33.873', '2026-05-10 14:07:33.873');
INSERT INTO public.order_items VALUES (394, 155, 50, 2, 25.00, '2026-04-17 14:07:33.879', '2026-04-17 14:07:33.879');
INSERT INTO public.order_items VALUES (395, 155, 184, 2, 85.00, '2026-04-17 14:07:33.879', '2026-04-17 14:07:33.879');
INSERT INTO public.order_items VALUES (396, 156, 586, 2, 95.00, '2026-04-05 14:07:33.885', '2026-04-05 14:07:33.885');
INSERT INTO public.order_items VALUES (397, 157, 431, 3, 35.00, '2026-04-20 14:07:33.889', '2026-04-20 14:07:33.889');
INSERT INTO public.order_items VALUES (398, 157, 398, 3, 35.00, '2026-04-20 14:07:33.889', '2026-04-20 14:07:33.889');
INSERT INTO public.order_items VALUES (399, 157, 198, 1, 55.00, '2026-04-20 14:07:33.889', '2026-04-20 14:07:33.889');
INSERT INTO public.order_items VALUES (400, 158, 205, 2, 55.00, '2026-05-20 14:07:33.896', '2026-05-20 14:07:33.896');
INSERT INTO public.order_items VALUES (401, 159, 457, 3, 15.00, '2026-04-23 14:07:33.899', '2026-04-23 14:07:33.899');
INSERT INTO public.order_items VALUES (402, 159, 459, 2, 15.00, '2026-04-23 14:07:33.899', '2026-04-23 14:07:33.899');
INSERT INTO public.order_items VALUES (403, 159, 226, 3, 55.00, '2026-04-23 14:07:33.899', '2026-04-23 14:07:33.899');
INSERT INTO public.order_items VALUES (404, 159, 168, 1, 85.00, '2026-04-23 14:07:33.899', '2026-04-23 14:07:33.899');
INSERT INTO public.order_items VALUES (405, 160, 478, 2, 15.00, '2026-05-19 14:07:33.909', '2026-05-19 14:07:33.909');
INSERT INTO public.order_items VALUES (406, 160, 441, 1, 15.00, '2026-05-19 14:07:33.909', '2026-05-19 14:07:33.909');
INSERT INTO public.order_items VALUES (407, 160, 231, 3, 55.00, '2026-05-19 14:07:33.909', '2026-05-19 14:07:33.909');
INSERT INTO public.order_items VALUES (408, 160, 309, 3, 45.00, '2026-05-19 14:07:33.909', '2026-05-19 14:07:33.909');
INSERT INTO public.order_items VALUES (409, 161, 188, 1, 85.00, '2026-05-15 14:07:33.918', '2026-05-15 14:07:33.918');
INSERT INTO public.order_items VALUES (410, 161, 320, 1, 59.00, '2026-05-15 14:07:33.918', '2026-05-15 14:07:33.918');
INSERT INTO public.order_items VALUES (411, 161, 350, 2, 59.00, '2026-05-15 14:07:33.918', '2026-05-15 14:07:33.918');
INSERT INTO public.order_items VALUES (412, 162, 557, 2, 95.00, '2026-04-06 14:07:33.924', '2026-04-06 14:07:33.924');
INSERT INTO public.order_items VALUES (413, 162, 90, 3, 65.00, '2026-04-06 14:07:33.924', '2026-04-06 14:07:33.924');
INSERT INTO public.order_items VALUES (414, 162, 167, 2, 85.00, '2026-04-06 14:07:33.924', '2026-04-06 14:07:33.924');
INSERT INTO public.order_items VALUES (415, 162, 407, 3, 35.00, '2026-04-06 14:07:33.924', '2026-04-06 14:07:33.924');
INSERT INTO public.order_items VALUES (416, 166, 615, 1, 76.00, '2026-06-09 11:27:54.361148', NULL);
INSERT INTO public.order_items VALUES (417, 167, 619, 1, 73.15, '2026-06-09 11:44:54.396075', NULL);
INSERT INTO public.order_items VALUES (418, 169, 619, 1, 73.15, '2026-06-09 11:47:10.659461', NULL);
INSERT INTO public.order_items VALUES (419, 170, 619, 1, 73.15, '2026-06-09 11:56:12.944204', NULL);
INSERT INTO public.order_items VALUES (420, 171, 619, 1, 73.15, '2026-06-09 11:57:14.161689', NULL);


--
-- TOC entry 3585 (class 0 OID 16440)
-- Dependencies: 226
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (73, 1, 'paid', 210.00, NULL, '2026-05-01 14:07:33.336', '2026-05-01 14:07:33.336', 'cod', 'failed');
INSERT INTO public.orders VALUES (74, 12, 'completed', 320.00, NULL, '2026-05-15 14:07:33.355', '2026-05-15 14:07:33.355', 'cod', 'pending');
INSERT INTO public.orders VALUES (75, 2, 'cancelled', 185.00, NULL, '2026-05-23 14:07:33.366', '2026-05-23 14:07:33.366', 'momo', 'failed');
INSERT INTO public.orders VALUES (76, 3, 'completed', 300.00, NULL, '2026-03-29 14:07:33.376', '2026-03-29 14:07:33.376', 'cod', 'pending');
INSERT INTO public.orders VALUES (77, 1, 'shipping', 380.00, NULL, '2026-03-31 14:07:33.383', '2026-03-31 14:07:33.383', 'cod', 'pending');
INSERT INTO public.orders VALUES (78, 12, 'paid', 260.00, NULL, '2026-05-11 14:07:33.393', '2026-05-11 14:07:33.393', 'cod', 'pending');
INSERT INTO public.orders VALUES (79, 1, 'shipping', 467.00, NULL, '2026-04-10 14:07:33.4', '2026-04-10 14:07:33.4', 'cod', 'pending');
INSERT INTO public.orders VALUES (80, 3, 'cancelled', 190.00, NULL, '2026-04-13 14:07:33.411', '2026-04-13 14:07:33.411', 'momo', 'failed');
INSERT INTO public.orders VALUES (81, 6, 'completed', 235.00, NULL, '2026-04-17 14:07:33.414', '2026-04-17 14:07:33.414', 'cod', 'completed');
INSERT INTO public.orders VALUES (82, 2, 'paid', 325.00, NULL, '2026-04-06 14:07:33.421', '2026-04-06 14:07:33.421', 'cod', 'pending');
INSERT INTO public.orders VALUES (83, 6, 'pending', 25.00, NULL, '2026-05-03 14:07:33.427', '2026-05-03 14:07:33.427', 'cod', 'completed');
INSERT INTO public.orders VALUES (84, 12, 'completed', 492.00, NULL, '2026-05-05 14:07:33.431', '2026-05-05 14:07:33.431', 'cod', 'completed');
INSERT INTO public.orders VALUES (85, 4, 'pending', 570.00, NULL, '2026-05-04 14:07:33.443', '2026-05-04 14:07:33.443', 'cod', 'pending');
INSERT INTO public.orders VALUES (86, 6, 'completed', 395.00, NULL, '2026-05-26 14:07:33.449', '2026-05-26 14:07:33.449', 'cod', 'completed');
INSERT INTO public.orders VALUES (87, 12, 'cancelled', 185.00, NULL, '2026-05-11 14:07:33.456', '2026-05-11 14:07:33.456', 'cod', 'failed');
INSERT INTO public.orders VALUES (88, 10, 'pending', 354.00, NULL, '2026-04-30 14:07:33.465', '2026-04-30 14:07:33.465', 'momo', 'completed');
INSERT INTO public.orders VALUES (89, 1, 'cancelled', 163.00, NULL, '2026-05-05 14:07:33.476', '2026-05-05 14:07:33.476', 'cod', 'failed');
INSERT INTO public.orders VALUES (90, 7, 'shipping', 210.00, NULL, '2026-05-15 14:07:33.482', '2026-05-15 14:07:33.482', 'momo', 'completed');
INSERT INTO public.orders VALUES (91, 7, 'completed', 75.00, NULL, '2026-04-11 14:07:33.492', '2026-04-11 14:07:33.492', 'cod', 'completed');
INSERT INTO public.orders VALUES (92, 2, 'pending', 95.00, NULL, '2026-05-11 14:07:33.496', '2026-05-11 14:07:33.496', 'cod', 'completed');
INSERT INTO public.orders VALUES (93, 1, 'pending', 240.00, NULL, '2026-03-30 14:07:33.5', '2026-03-30 14:07:33.5', 'cod', 'pending');
INSERT INTO public.orders VALUES (94, 6, 'cancelled', 15.00, NULL, '2026-05-19 14:07:33.507', '2026-05-19 14:07:33.507', 'cod', 'failed');
INSERT INTO public.orders VALUES (95, 6, 'cancelled', 55.00, NULL, '2026-04-05 14:07:33.511', '2026-04-05 14:07:33.511', 'cod', 'pending');
INSERT INTO public.orders VALUES (96, 1, 'cancelled', 362.00, NULL, '2026-04-18 14:07:33.515', '2026-04-18 14:07:33.515', 'cod', 'failed');
INSERT INTO public.orders VALUES (97, 11, 'pending', 475.00, NULL, '2026-05-19 14:07:33.523', '2026-05-19 14:07:33.523', 'cod', 'failed');
INSERT INTO public.orders VALUES (98, 9, 'cancelled', 130.00, NULL, '2026-05-04 14:07:33.534', '2026-05-04 14:07:33.534', 'cod', 'pending');
INSERT INTO public.orders VALUES (99, 2, 'pending', 190.00, NULL, '2026-05-05 14:07:33.538', '2026-05-05 14:07:33.538', 'cod', 'completed');
INSERT INTO public.orders VALUES (100, 5, 'completed', 260.00, NULL, '2026-04-09 14:07:33.546', '2026-04-09 14:07:33.546', 'cod', 'completed');
INSERT INTO public.orders VALUES (101, 11, 'cancelled', 165.00, NULL, '2026-05-17 14:07:33.556', '2026-05-17 14:07:33.556', 'momo', 'pending');
INSERT INTO public.orders VALUES (102, 9, 'pending', 309.00, NULL, '2026-04-16 14:07:33.56', '2026-04-16 14:07:33.56', 'cod', 'pending');
INSERT INTO public.orders VALUES (103, 10, 'cancelled', 35.00, NULL, '2026-03-31 14:07:33.568', '2026-03-31 14:07:33.568', 'momo', 'pending');
INSERT INTO public.orders VALUES (104, 11, 'cancelled', 310.00, NULL, '2026-05-15 14:07:33.572', '2026-05-15 14:07:33.572', 'momo', 'failed');
INSERT INTO public.orders VALUES (105, 11, 'shipping', 427.00, NULL, '2026-05-06 14:07:33.578', '2026-05-06 14:07:33.578', 'cod', 'pending');
INSERT INTO public.orders VALUES (106, 9, 'pending', 100.00, NULL, '2026-04-10 14:07:33.587', '2026-04-10 14:07:33.587', 'cod', 'completed');
INSERT INTO public.orders VALUES (107, 4, 'paid', 85.00, NULL, '2026-04-11 14:07:33.591', '2026-04-11 14:07:33.591', 'momo', 'failed');
INSERT INTO public.orders VALUES (108, 3, 'shipping', 240.00, NULL, '2026-05-19 14:07:33.596', '2026-05-19 14:07:33.596', 'momo', 'failed');
INSERT INTO public.orders VALUES (109, 5, 'shipping', 255.00, NULL, '2026-05-16 14:07:33.604', '2026-05-16 14:07:33.604', 'momo', 'failed');
INSERT INTO public.orders VALUES (110, 9, 'shipping', 129.00, NULL, '2026-04-17 14:07:33.608', '2026-04-17 14:07:33.608', 'cod', 'failed');
INSERT INTO public.orders VALUES (111, 4, 'shipping', 300.00, NULL, '2026-04-18 14:07:33.613', '2026-04-18 14:07:33.613', 'momo', 'pending');
INSERT INTO public.orders VALUES (112, 1, 'paid', 215.00, NULL, '2026-04-25 14:07:33.622', '2026-04-25 14:07:33.622', 'cod', 'completed');
INSERT INTO public.orders VALUES (113, 4, 'paid', 177.00, NULL, '2026-05-01 14:07:33.629', '2026-05-01 14:07:33.629', 'cod', 'pending');
INSERT INTO public.orders VALUES (114, 6, 'completed', 235.00, NULL, '2026-04-05 14:07:33.633', '2026-04-05 14:07:33.633', 'cod', 'pending');
INSERT INTO public.orders VALUES (115, 10, 'completed', 224.00, NULL, '2026-05-16 14:07:33.641', '2026-05-16 14:07:33.641', 'cod', 'completed');
INSERT INTO public.orders VALUES (116, 3, 'cancelled', 280.00, NULL, '2026-04-07 14:07:33.646', '2026-04-07 14:07:33.646', 'momo', 'failed');
INSERT INTO public.orders VALUES (117, 3, 'completed', 104.00, NULL, '2026-04-30 14:07:33.652', '2026-04-30 14:07:33.652', 'momo', 'pending');
INSERT INTO public.orders VALUES (118, 9, 'paid', 419.00, NULL, '2026-05-17 14:07:33.657', '2026-05-17 14:07:33.657', 'cod', 'completed');
INSERT INTO public.orders VALUES (119, 6, 'pending', 270.00, NULL, '2026-04-10 14:07:33.665', '2026-04-10 14:07:33.665', 'cod', 'failed');
INSERT INTO public.orders VALUES (120, 11, 'shipping', 130.00, NULL, '2026-05-08 14:07:33.673', '2026-05-08 14:07:33.673', 'momo', 'pending');
INSERT INTO public.orders VALUES (121, 7, 'completed', 405.00, NULL, '2026-04-04 14:07:33.677', '2026-04-04 14:07:33.677', 'momo', 'completed');
INSERT INTO public.orders VALUES (122, 1, 'pending', 490.00, NULL, '2026-03-31 14:07:33.687', '2026-03-31 14:07:33.687', 'cod', 'failed');
INSERT INTO public.orders VALUES (123, 4, 'paid', 300.00, NULL, '2026-05-17 14:07:33.694', '2026-05-17 14:07:33.694', 'momo', 'completed');
INSERT INTO public.orders VALUES (124, 1, 'paid', 302.00, NULL, '2026-04-01 14:07:33.7', '2026-04-01 14:07:33.7', 'cod', 'pending');
INSERT INTO public.orders VALUES (125, 4, 'shipping', 314.00, NULL, '2026-04-22 14:07:33.708', '2026-04-22 14:07:33.708', 'momo', 'failed');
INSERT INTO public.orders VALUES (126, 2, 'pending', 252.00, NULL, '2026-04-14 14:07:33.718', '2026-04-14 14:07:33.718', 'cod', 'pending');
INSERT INTO public.orders VALUES (127, 7, 'shipping', 330.00, NULL, '2026-04-18 14:07:33.723', '2026-04-18 14:07:33.723', 'cod', 'failed');
INSERT INTO public.orders VALUES (128, 3, 'pending', 170.00, NULL, '2026-03-30 14:07:33.729', '2026-03-30 14:07:33.729', 'cod', 'failed');
INSERT INTO public.orders VALUES (129, 11, 'cancelled', 310.00, NULL, '2026-04-02 14:07:33.732', '2026-04-02 14:07:33.732', 'cod', 'failed');
INSERT INTO public.orders VALUES (130, 3, 'completed', 165.00, NULL, '2026-05-20 14:07:33.74', '2026-05-20 14:07:33.74', 'momo', 'failed');
INSERT INTO public.orders VALUES (131, 5, 'cancelled', 200.00, NULL, '2026-04-24 14:07:33.745', '2026-04-24 14:07:33.745', 'momo', 'failed');
INSERT INTO public.orders VALUES (132, 2, 'shipping', 315.00, NULL, '2026-04-25 14:07:33.753', '2026-04-25 14:07:33.753', 'cod', 'failed');
INSERT INTO public.orders VALUES (133, 3, 'completed', 50.00, NULL, '2026-05-26 14:07:33.757', '2026-05-26 14:07:33.757', 'momo', 'pending');
INSERT INTO public.orders VALUES (134, 7, 'cancelled', 80.00, NULL, '2026-05-04 14:07:33.76', '2026-05-04 14:07:33.76', 'cod', 'pending');
INSERT INTO public.orders VALUES (135, 1, 'shipping', 370.00, NULL, '2026-05-17 14:07:33.766', '2026-05-17 14:07:33.766', 'cod', 'completed');
INSERT INTO public.orders VALUES (136, 1, 'shipping', 65.00, NULL, '2026-04-10 14:07:33.771', '2026-04-10 14:07:33.771', 'cod', 'completed');
INSERT INTO public.orders VALUES (137, 9, 'pending', 95.00, NULL, '2026-05-04 14:07:33.775', '2026-05-04 14:07:33.775', 'cod', 'failed');
INSERT INTO public.orders VALUES (138, 5, 'cancelled', 74.00, NULL, '2026-05-02 14:07:33.778', '2026-05-02 14:07:33.778', 'cod', 'completed');
INSERT INTO public.orders VALUES (139, 1, 'paid', 272.00, NULL, '2026-04-02 14:07:33.782', '2026-04-02 14:07:33.782', 'cod', 'completed');
INSERT INTO public.orders VALUES (140, 6, 'pending', 160.00, NULL, '2026-05-11 14:07:33.791', '2026-05-11 14:07:33.791', 'cod', 'completed');
INSERT INTO public.orders VALUES (141, 6, 'paid', 315.00, NULL, '2026-05-17 14:07:33.799', '2026-05-17 14:07:33.799', 'momo', 'failed');
INSERT INTO public.orders VALUES (142, 12, 'pending', 233.00, NULL, '2026-05-05 14:07:33.805', '2026-05-05 14:07:33.805', 'cod', 'pending');
INSERT INTO public.orders VALUES (143, 9, 'paid', 260.00, NULL, '2026-04-07 14:07:33.811', '2026-04-07 14:07:33.811', 'cod', 'completed');
INSERT INTO public.orders VALUES (144, 2, 'paid', 585.00, NULL, '2026-05-23 14:07:33.817', '2026-05-23 14:07:33.817', 'cod', 'completed');
INSERT INTO public.orders VALUES (145, 2, 'cancelled', 165.00, NULL, '2026-04-03 14:07:33.827', '2026-04-03 14:07:33.827', 'cod', 'pending');
INSERT INTO public.orders VALUES (146, 6, 'paid', 515.00, NULL, '2026-04-13 14:07:33.831', '2026-04-13 14:07:33.831', 'cod', 'failed');
INSERT INTO public.orders VALUES (147, 9, 'pending', 70.00, NULL, '2026-04-19 14:07:33.838', '2026-04-19 14:07:33.838', 'cod', 'pending');
INSERT INTO public.orders VALUES (148, 6, 'shipping', 185.00, NULL, '2026-05-03 14:07:33.844', '2026-05-03 14:07:33.844', 'cod', 'pending');
INSERT INTO public.orders VALUES (149, 5, 'shipping', 75.00, NULL, '2026-04-14 14:07:33.849', '2026-04-14 14:07:33.849', 'cod', 'completed');
INSERT INTO public.orders VALUES (150, 5, 'pending', 265.00, NULL, '2026-03-29 14:07:33.855', '2026-03-29 14:07:33.855', 'cod', 'pending');
INSERT INTO public.orders VALUES (151, 1, 'cancelled', 75.00, NULL, '2026-05-11 14:07:33.859', '2026-05-11 14:07:33.859', 'cod', 'failed');
INSERT INTO public.orders VALUES (152, 6, 'paid', 370.00, NULL, '2026-05-08 14:07:33.863', '2026-05-08 14:07:33.863', 'cod', 'completed');
INSERT INTO public.orders VALUES (153, 11, 'completed', 445.00, NULL, '2026-04-21 14:07:33.868', '2026-04-21 14:07:33.868', 'momo', 'failed');
INSERT INTO public.orders VALUES (154, 3, 'pending', 515.00, NULL, '2026-05-10 14:07:33.873', '2026-05-10 14:07:33.873', 'cod', 'pending');
INSERT INTO public.orders VALUES (155, 12, 'paid', 220.00, NULL, '2026-04-17 14:07:33.879', '2026-04-17 14:07:33.879', 'momo', 'pending');
INSERT INTO public.orders VALUES (156, 10, 'pending', 190.00, NULL, '2026-04-05 14:07:33.885', '2026-04-05 14:07:33.885', 'momo', 'pending');
INSERT INTO public.orders VALUES (157, 3, 'pending', 265.00, NULL, '2026-04-20 14:07:33.889', '2026-04-20 14:07:33.889', 'momo', 'failed');
INSERT INTO public.orders VALUES (158, 1, 'completed', 110.00, NULL, '2026-05-20 14:07:33.896', '2026-05-20 14:07:33.896', 'cod', 'failed');
INSERT INTO public.orders VALUES (159, 10, 'completed', 325.00, NULL, '2026-04-23 14:07:33.899', '2026-04-23 14:07:33.899', 'momo', 'completed');
INSERT INTO public.orders VALUES (160, 2, 'cancelled', 345.00, NULL, '2026-05-19 14:07:33.909', '2026-05-19 14:07:33.909', 'cod', 'failed');
INSERT INTO public.orders VALUES (161, 11, 'pending', 262.00, NULL, '2026-05-15 14:07:33.918', '2026-05-15 14:07:33.918', 'cod', 'pending');
INSERT INTO public.orders VALUES (162, 6, 'paid', 660.00, NULL, '2026-04-06 14:07:33.924', '2026-04-06 14:07:33.924', 'cod', 'failed');
INSERT INTO public.orders VALUES (163, 3, 'pending', 78.15, 'Deliver to: admin1 - Phone: 0839123123 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:26:23.147439', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (164, 3, 'pending', 78.15, 'Deliver to: admin1 - Phone: 0839123123 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:26:26.908614', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (165, 3, 'pending', 78.15, 'Deliver to: admin1 - Phone: 0839123123 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:26:27.518706', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (166, 3, 'pending', 81.00, 'Deliver to: admin1 - Phone: 0839123123 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:27:54.346765', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (167, 2, 'pending', 78.15, 'Deliver to: user - Phone: 0394063967 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:44:54.369773', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (168, 3, 'pending', 78.15, 'Deliver to: admin1 - Phone: 0839123123 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:44:54.839265', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (169, 3, 'pending', 78.15, 'Deliver to: admin1 - Phone: 0839123123 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:47:10.643865', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (170, 2, 'pending', 78.15, 'Deliver to: user - Phone: 0919808992 - Address: Vietnam, tphcm', '2026-06-09 11:56:12.914515', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (172, 2, 'pending', 78.15, 'Deliver to: user - Phone: 0918229112 - Address: Vietnam, hochiminhcity', '2026-06-09 11:57:14.178756', NULL, 'cod', 'unpaid');
INSERT INTO public.orders VALUES (171, 3, 'paid', 78.15, 'Deliver to: admin1 - Phone: 0839123123 - Address: Tổ 10, tuyến dân cư Vĩnh Thạnh 2', '2026-06-09 11:57:14.14527', '2026-06-10 05:42:48.458281', 'momo', 'paid');


--
-- TOC entry 3587 (class 0 OID 16450)
-- Dependencies: 228
-- Data for Name: product_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_collections VALUES (33, 1);
INSERT INTO public.product_collections VALUES (34, 9);
INSERT INTO public.product_collections VALUES (35, 11);
INSERT INTO public.product_collections VALUES (36, 13);
INSERT INTO public.product_collections VALUES (37, 15);
INSERT INTO public.product_collections VALUES (38, 18);
INSERT INTO public.product_collections VALUES (39, 19);
INSERT INTO public.product_collections VALUES (40, 20);
INSERT INTO public.product_collections VALUES (41, 21);
INSERT INTO public.product_collections VALUES (42, 1);
INSERT INTO public.product_collections VALUES (43, 9);
INSERT INTO public.product_collections VALUES (44, 11);
INSERT INTO public.product_collections VALUES (45, 13);
INSERT INTO public.product_collections VALUES (46, 15);
INSERT INTO public.product_collections VALUES (47, 18);
INSERT INTO public.product_collections VALUES (48, 19);
INSERT INTO public.product_collections VALUES (49, 20);
INSERT INTO public.product_collections VALUES (50, 21);
INSERT INTO public.product_collections VALUES (51, 1);
INSERT INTO public.product_collections VALUES (52, 9);
INSERT INTO public.product_collections VALUES (53, 11);
INSERT INTO public.product_collections VALUES (54, 13);
INSERT INTO public.product_collections VALUES (55, 15);
INSERT INTO public.product_collections VALUES (56, 18);
INSERT INTO public.product_collections VALUES (57, 19);
INSERT INTO public.product_collections VALUES (58, 20);
INSERT INTO public.product_collections VALUES (59, 21);
INSERT INTO public.product_collections VALUES (60, 1);
INSERT INTO public.product_collections VALUES (61, 9);
INSERT INTO public.product_collections VALUES (62, 11);
INSERT INTO public.product_collections VALUES (63, 13);
INSERT INTO public.product_collections VALUES (64, 15);
INSERT INTO public.product_collections VALUES (65, 18);
INSERT INTO public.product_collections VALUES (66, 19);
INSERT INTO public.product_collections VALUES (67, 20);
INSERT INTO public.product_collections VALUES (68, 21);
INSERT INTO public.product_collections VALUES (69, 1);
INSERT INTO public.product_collections VALUES (70, 9);
INSERT INTO public.product_collections VALUES (71, 11);
INSERT INTO public.product_collections VALUES (72, 13);
INSERT INTO public.product_collections VALUES (73, 15);
INSERT INTO public.product_collections VALUES (74, 18);
INSERT INTO public.product_collections VALUES (75, 19);
INSERT INTO public.product_collections VALUES (76, 20);
INSERT INTO public.product_collections VALUES (77, 21);
INSERT INTO public.product_collections VALUES (78, 1);
INSERT INTO public.product_collections VALUES (79, 9);
INSERT INTO public.product_collections VALUES (80, 11);
INSERT INTO public.product_collections VALUES (81, 13);
INSERT INTO public.product_collections VALUES (82, 15);
INSERT INTO public.product_collections VALUES (83, 18);
INSERT INTO public.product_collections VALUES (84, 19);
INSERT INTO public.product_collections VALUES (85, 20);
INSERT INTO public.product_collections VALUES (86, 21);
INSERT INTO public.product_collections VALUES (87, 1);
INSERT INTO public.product_collections VALUES (88, 9);
INSERT INTO public.product_collections VALUES (89, 11);
INSERT INTO public.product_collections VALUES (90, 13);
INSERT INTO public.product_collections VALUES (91, 15);
INSERT INTO public.product_collections VALUES (92, 18);
INSERT INTO public.product_collections VALUES (93, 19);
INSERT INTO public.product_collections VALUES (94, 20);
INSERT INTO public.product_collections VALUES (95, 21);
INSERT INTO public.product_collections VALUES (96, 1);
INSERT INTO public.product_collections VALUES (97, 9);
INSERT INTO public.product_collections VALUES (98, 11);
INSERT INTO public.product_collections VALUES (99, 13);
INSERT INTO public.product_collections VALUES (100, 15);
INSERT INTO public.product_collections VALUES (101, 18);
INSERT INTO public.product_collections VALUES (102, 19);
INSERT INTO public.product_collections VALUES (103, 20);
INSERT INTO public.product_collections VALUES (104, 21);
INSERT INTO public.product_collections VALUES (105, 1);
INSERT INTO public.product_collections VALUES (106, 9);
INSERT INTO public.product_collections VALUES (19, 8);
INSERT INTO public.product_collections VALUES (20, 10);
INSERT INTO public.product_collections VALUES (21, 12);
INSERT INTO public.product_collections VALUES (22, 14);
INSERT INTO public.product_collections VALUES (23, 16);
INSERT INTO public.product_collections VALUES (24, 17);
INSERT INTO public.product_collections VALUES (25, 22);
INSERT INTO public.product_collections VALUES (26, 8);
INSERT INTO public.product_collections VALUES (27, 10);
INSERT INTO public.product_collections VALUES (28, 12);
INSERT INTO public.product_collections VALUES (29, 14);
INSERT INTO public.product_collections VALUES (30, 16);
INSERT INTO public.product_collections VALUES (31, 17);
INSERT INTO public.product_collections VALUES (32, 22);
INSERT INTO public.product_collections VALUES (107, 8);
INSERT INTO public.product_collections VALUES (108, 10);
INSERT INTO public.product_collections VALUES (109, 12);
INSERT INTO public.product_collections VALUES (110, 14);
INSERT INTO public.product_collections VALUES (111, 16);
INSERT INTO public.product_collections VALUES (112, 17);
INSERT INTO public.product_collections VALUES (113, 22);
INSERT INTO public.product_collections VALUES (114, 8);
INSERT INTO public.product_collections VALUES (115, 10);
INSERT INTO public.product_collections VALUES (116, 12);
INSERT INTO public.product_collections VALUES (117, 14);
INSERT INTO public.product_collections VALUES (118, 16);
INSERT INTO public.product_collections VALUES (119, 17);
INSERT INTO public.product_collections VALUES (120, 22);
INSERT INTO public.product_collections VALUES (121, 8);
INSERT INTO public.product_collections VALUES (122, 10);
INSERT INTO public.product_collections VALUES (123, 12);
INSERT INTO public.product_collections VALUES (124, 14);
INSERT INTO public.product_collections VALUES (125, 16);
INSERT INTO public.product_collections VALUES (126, 17);
INSERT INTO public.product_collections VALUES (127, 22);
INSERT INTO public.product_collections VALUES (128, 8);
INSERT INTO public.product_collections VALUES (129, 10);
INSERT INTO public.product_collections VALUES (130, 12);
INSERT INTO public.product_collections VALUES (131, 14);
INSERT INTO public.product_collections VALUES (132, 16);
INSERT INTO public.product_collections VALUES (133, 17);
INSERT INTO public.product_collections VALUES (134, 22);
INSERT INTO public.product_collections VALUES (135, 8);
INSERT INTO public.product_collections VALUES (136, 10);
INSERT INTO public.product_collections VALUES (137, 12);
INSERT INTO public.product_collections VALUES (138, 14);
INSERT INTO public.product_collections VALUES (139, 16);
INSERT INTO public.product_collections VALUES (140, 17);
INSERT INTO public.product_collections VALUES (141, 22);
INSERT INTO public.product_collections VALUES (142, 8);
INSERT INTO public.product_collections VALUES (143, 10);
INSERT INTO public.product_collections VALUES (144, 12);


--
-- TOC entry 3588 (class 0 OID 16453)
-- Dependencies: 229
-- Data for Name: product_configurations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_configurations VALUES (379, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (384, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (389, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (394, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (399, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (404, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (409, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (414, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (419, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (424, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (429, 1, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (380, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (385, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (390, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (395, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (400, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (405, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (410, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (415, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (420, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (425, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (430, 2, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (381, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (386, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (391, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (396, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (401, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (406, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (411, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (416, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (421, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (426, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (431, 3, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (382, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (387, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (392, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (397, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (402, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (407, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (412, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (417, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (422, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (427, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (432, 4, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (383, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (388, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (393, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (398, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (403, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (408, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (413, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (418, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (423, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (428, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (433, 5, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (89, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (94, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (99, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (104, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (109, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (114, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (119, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (124, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (129, 6, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (90, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (95, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (100, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (105, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (110, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (115, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (120, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (125, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (130, 7, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (91, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (96, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (101, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (106, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (111, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (116, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (121, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (126, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (131, 8, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (92, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (97, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (102, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (107, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (112, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (117, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (122, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (127, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (132, 9, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (93, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (98, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (103, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (108, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (113, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (118, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (123, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (128, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (133, 10, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (134, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (139, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (144, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (149, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (154, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (159, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (164, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (169, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (174, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (179, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (184, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (189, 11, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (135, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (140, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (145, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (150, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (155, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (160, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (165, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (170, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (175, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (180, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (185, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (190, 12, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (136, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (141, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (146, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (151, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (156, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (161, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (166, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (171, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (176, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (181, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (186, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (191, 13, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (137, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (142, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (147, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (152, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (157, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (162, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (167, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (172, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (177, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (182, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (187, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (192, 14, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (138, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (143, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (148, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (153, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (158, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (163, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (168, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (173, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (178, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (183, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (188, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (193, 15, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (199, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (194, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (204, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (209, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (214, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (219, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (224, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (229, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (234, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (239, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (244, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (249, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (254, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (259, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (264, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (269, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (274, 16, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (195, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (200, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (205, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (210, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (215, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (220, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (225, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (230, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (235, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (240, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (245, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (250, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (255, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (260, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (265, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (270, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (275, 17, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (196, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (201, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (206, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (211, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (216, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (221, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (226, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (231, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (236, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (241, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (246, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (251, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (256, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (261, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (266, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (271, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (276, 18, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (197, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (202, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (207, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (212, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (217, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (222, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (227, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (232, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (237, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (242, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (247, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (252, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (257, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (262, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (267, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (272, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (277, 19, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (198, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (203, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (208, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (213, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (218, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (223, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (228, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (233, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (238, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (243, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (248, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (253, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (258, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (263, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (268, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (273, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (278, 20, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (19, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (24, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (29, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (34, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (39, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (44, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (49, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (54, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (59, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (64, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (69, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (74, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (79, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (84, 26, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (20, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (25, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (30, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (35, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (40, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (45, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (50, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (55, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (60, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (65, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (70, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (75, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (80, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (85, 27, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (21, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (26, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (31, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (36, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (41, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (46, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (51, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (56, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (61, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (66, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (71, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (76, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (81, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (86, 28, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (22, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (27, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (32, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (37, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (42, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (47, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (52, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (57, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (62, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (67, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (72, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (77, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (82, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (87, 29, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (23, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (28, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (33, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (38, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (43, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (48, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (53, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (58, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (63, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (68, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (73, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (78, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (83, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (88, 30, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (279, 36, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (284, 36, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (289, 36, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (294, 36, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (299, 36, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (304, 36, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (309, 36, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (280, 37, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (285, 37, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (290, 37, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (295, 37, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (300, 37, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (305, 37, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (310, 37, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (281, 38, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (286, 38, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (291, 38, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (296, 38, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (301, 38, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (306, 38, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (311, 38, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (282, 39, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (287, 39, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (292, 39, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (297, 39, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (302, 39, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (307, 39, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (312, 39, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (283, 40, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (288, 40, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (293, 40, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (298, 40, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (303, 40, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (308, 40, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (313, 40, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (314, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (319, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (324, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (329, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (334, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (339, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (344, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (349, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (354, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (359, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (364, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (369, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (374, 41, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (315, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (320, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (325, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (330, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (335, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (340, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (345, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (350, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (355, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (360, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (365, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (370, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (375, 42, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (316, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (321, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (326, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (331, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (336, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (341, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (346, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (351, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (356, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (361, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (366, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (371, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (376, 43, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (317, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (322, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (327, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (332, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (337, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (342, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (347, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (352, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (357, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (362, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (367, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (372, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (377, 44, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (318, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (323, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (328, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (333, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (338, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (343, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (348, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (353, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (358, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (363, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (368, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (373, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (378, 45, '2026-05-26 12:22:22.696506', NULL);
INSERT INTO public.product_configurations VALUES (434, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (435, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (436, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (437, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (438, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (439, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (440, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (441, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (442, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (443, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (444, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (445, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (446, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (447, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (448, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (449, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (450, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (451, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (452, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (453, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (454, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (455, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (456, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (457, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (458, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (459, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (460, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (461, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (462, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (463, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (464, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (465, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (466, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (467, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (468, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (469, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (470, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (471, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (472, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (473, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (474, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (475, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (476, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (477, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (478, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (479, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (480, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (481, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (482, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (483, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (484, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (485, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (486, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (487, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (488, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (489, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (490, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (491, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (492, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (493, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (494, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (495, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (496, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (497, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (498, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (499, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (500, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (501, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (502, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (503, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (504, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (505, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (506, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (507, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (508, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (509, 21, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (510, 22, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (511, 23, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (512, 24, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (513, 25, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (514, 26, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (515, 27, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (516, 28, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (517, 29, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (518, 30, '2026-05-27 06:10:10.660893', NULL);
INSERT INTO public.product_configurations VALUES (519, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (520, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (521, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (522, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (523, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (524, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (525, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (526, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (527, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (528, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (529, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (530, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (531, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (532, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (533, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (534, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (535, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (536, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (537, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (538, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (539, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (540, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (541, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (542, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (543, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (544, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (545, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (546, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (547, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (548, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (549, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (550, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (551, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (552, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (553, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (554, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (555, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (556, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (557, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (558, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (559, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (560, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (561, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (562, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (563, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (564, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (565, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (566, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (567, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (568, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (569, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (570, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (571, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (572, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (573, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (574, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (575, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (576, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (577, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (578, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (579, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (580, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (581, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (582, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (583, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (584, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (585, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (586, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (587, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (588, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (589, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (590, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (591, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (592, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (593, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (594, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (595, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (596, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (597, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (598, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (599, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (600, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (601, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (602, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (603, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (604, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (605, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (606, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (607, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (608, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (609, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (610, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (611, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (612, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (613, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (614, 31, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (615, 32, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (616, 33, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (617, 34, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (618, 35, '2026-05-27 06:18:16.079249', NULL);
INSERT INTO public.product_configurations VALUES (624, 36, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (625, 37, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (626, 38, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (627, 39, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (628, 40, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (629, 36, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (630, 37, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (631, 38, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (632, 39, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (633, 40, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (634, 36, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (635, 37, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (636, 38, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (637, 39, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (638, 40, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (639, 36, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (640, 37, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (641, 38, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (642, 39, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (643, 40, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (644, 36, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (645, 37, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (646, 38, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (647, 39, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (648, 40, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_configurations VALUES (619, 31, '2026-06-10 07:20:20.643951', NULL);
INSERT INTO public.product_configurations VALUES (620, 32, '2026-06-10 07:20:20.643951', NULL);
INSERT INTO public.product_configurations VALUES (621, 33, '2026-06-10 07:20:20.643951', NULL);
INSERT INTO public.product_configurations VALUES (622, 34, '2026-06-10 07:20:20.643951', NULL);
INSERT INTO public.product_configurations VALUES (623, 35, '2026-06-10 07:20:20.643951', NULL);


--
-- TOC entry 3589 (class 0 OID 16457)
-- Dependencies: 230
-- Data for Name: product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_items VALUES (434, 107, '202-T1-PLA-PLU-S', 134, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862194/products/xf6spqo5x0d6mvew3tlp.jpg', 15.00, NULL, '2026-05-27 06:09:54.6805', NULL);
INSERT INTO public.product_items VALUES (435, 107, '202-T1-PLA-PLU-M', 90, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862194/products/xf6spqo5x0d6mvew3tlp.jpg', 15.00, NULL, '2026-05-27 06:09:54.688191', NULL);
INSERT INTO public.product_items VALUES (436, 107, '202-T1-PLA-PLU-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862194/products/xf6spqo5x0d6mvew3tlp.jpg', 15.00, NULL, '2026-05-27 06:09:54.692714', NULL);
INSERT INTO public.product_items VALUES (24, 20, 'COR-BUC-HAT-BRO-S', 139, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798911/products/hskkpmuizhxzv1hxxg5s.webp', 25.00, NULL, '2026-05-26 12:22:19.563257', NULL);
INSERT INTO public.product_items VALUES (25, 20, 'COR-BUC-HAT-BRO-M', 97, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798911/products/hskkpmuizhxzv1hxxg5s.webp', 25.00, NULL, '2026-05-26 12:22:19.570447', NULL);
INSERT INTO public.product_items VALUES (26, 20, 'COR-BUC-HAT-BRO-L', 146, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798911/products/hskkpmuizhxzv1hxxg5s.webp', 25.00, NULL, '2026-05-26 12:22:19.576193', NULL);
INSERT INTO public.product_items VALUES (29, 21, 'COR-BUC-HAT-PIN-S', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798912/products/fyfacj7uvgfmwqaokhbh.webp', 25.00, NULL, '2026-05-26 12:22:19.604504', NULL);
INSERT INTO public.product_items VALUES (30, 21, 'COR-BUC-HAT-PIN-M', 121, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798912/products/fyfacj7uvgfmwqaokhbh.webp', 25.00, NULL, '2026-05-26 12:22:19.611501', NULL);
INSERT INTO public.product_items VALUES (31, 21, 'COR-BUC-HAT-PIN-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798912/products/fyfacj7uvgfmwqaokhbh.webp', 25.00, NULL, '2026-05-26 12:22:19.619308', NULL);
INSERT INTO public.product_items VALUES (32, 21, 'COR-BUC-HAT-PIN-XL', 87, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798912/products/fyfacj7uvgfmwqaokhbh.webp', 25.00, NULL, '2026-05-26 12:22:19.62668', NULL);
INSERT INTO public.product_items VALUES (39, 23, 'KHA-FIT-CAP-BLU-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798914/products/zgux2tir1qvhklvzandq.webp', 25.00, NULL, '2026-05-26 12:22:19.688179', NULL);
INSERT INTO public.product_items VALUES (40, 23, 'KHA-FIT-CAP-BLU-M', 21, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798914/products/zgux2tir1qvhklvzandq.webp', 25.00, NULL, '2026-05-26 12:22:19.695379', NULL);
INSERT INTO public.product_items VALUES (41, 23, 'KHA-FIT-CAP-BLU-L', 40, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798914/products/zgux2tir1qvhklvzandq.webp', 25.00, NULL, '2026-05-26 12:22:19.702651', NULL);
INSERT INTO public.product_items VALUES (42, 23, 'KHA-FIT-CAP-BLU-XL', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798914/products/zgux2tir1qvhklvzandq.webp', 25.00, NULL, '2026-05-26 12:22:19.711367', NULL);
INSERT INTO public.product_items VALUES (44, 24, 'KHA-FIT-CAP-GRE-S', 20, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/w8twfyggeboarzb1ktip.webp', 25.00, NULL, '2026-05-26 12:22:19.734792', NULL);
INSERT INTO public.product_items VALUES (45, 24, 'KHA-FIT-CAP-GRE-M', 115, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/w8twfyggeboarzb1ktip.webp', 25.00, NULL, '2026-05-26 12:22:19.741948', NULL);
INSERT INTO public.product_items VALUES (46, 24, 'KHA-FIT-CAP-GRE-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/w8twfyggeboarzb1ktip.webp', 25.00, NULL, '2026-05-26 12:22:19.748859', NULL);
INSERT INTO public.product_items VALUES (49, 25, 'KHA-FIT-CAP-RED-S', 112, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/oa7tdsgygrw8bfmveblu.webp', 25.00, NULL, '2026-05-26 12:22:19.775746', NULL);
INSERT INTO public.product_items VALUES (50, 25, 'KHA-FIT-CAP-RED-M', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/oa7tdsgygrw8bfmveblu.webp', 25.00, NULL, '2026-05-26 12:22:19.782471', NULL);
INSERT INTO public.product_items VALUES (51, 25, 'KHA-FIT-CAP-RED-L', 142, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/oa7tdsgygrw8bfmveblu.webp', 25.00, NULL, '2026-05-26 12:22:19.789309', NULL);
INSERT INTO public.product_items VALUES (54, 26, 'MES-TRU-CAP-BLA-S', 82, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798916/products/o73emae6hrgjpndjaz9j.webp', 25.00, NULL, '2026-05-26 12:22:19.816186', NULL);
INSERT INTO public.product_items VALUES (55, 26, 'MES-TRU-CAP-BLA-M', 47, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798916/products/o73emae6hrgjpndjaz9j.webp', 25.00, NULL, '2026-05-26 12:22:19.823924', NULL);
INSERT INTO public.product_items VALUES (56, 26, 'MES-TRU-CAP-BLA-L', 29, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798916/products/o73emae6hrgjpndjaz9j.webp', 25.00, NULL, '2026-05-26 12:22:19.830918', NULL);
INSERT INTO public.product_items VALUES (57, 26, 'MES-TRU-CAP-BLA-XL', 149, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798916/products/o73emae6hrgjpndjaz9j.webp', 25.00, NULL, '2026-05-26 12:22:19.838568', NULL);
INSERT INTO public.product_items VALUES (59, 27, 'MES-TRU-CAP-BLU-S', 103, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798917/products/cdaoe5mgkbj20d0ajq7a.webp', 25.00, NULL, '2026-05-26 12:22:19.860434', NULL);
INSERT INTO public.product_items VALUES (60, 27, 'MES-TRU-CAP-BLU-M', 53, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798917/products/cdaoe5mgkbj20d0ajq7a.webp', 25.00, NULL, '2026-05-26 12:22:19.869027', NULL);
INSERT INTO public.product_items VALUES (61, 27, 'MES-TRU-CAP-BLU-L', 68, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798917/products/cdaoe5mgkbj20d0ajq7a.webp', 25.00, NULL, '2026-05-26 12:22:19.875092', NULL);
INSERT INTO public.product_items VALUES (64, 28, 'MES-TRU-CAP-BRO-S', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/zntuzwfc1elf8kuarjxp.webp', 25.00, NULL, '2026-05-26 12:22:19.905228', NULL);
INSERT INTO public.product_items VALUES (65, 28, 'MES-TRU-CAP-BRO-M', 47, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/zntuzwfc1elf8kuarjxp.webp', 25.00, NULL, '2026-05-26 12:22:19.912639', NULL);
INSERT INTO public.product_items VALUES (66, 28, 'MES-TRU-CAP-BRO-L', 127, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/zntuzwfc1elf8kuarjxp.webp', 25.00, NULL, '2026-05-26 12:22:19.919584', NULL);
INSERT INTO public.product_items VALUES (69, 29, 'MES-TRU-CAP-ORA-S', 130, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/vflsz6gnhp7jc5mlun28.webp', 25.00, NULL, '2026-05-26 12:22:19.947495', NULL);
INSERT INTO public.product_items VALUES (70, 29, 'MES-TRU-CAP-ORA-M', 50, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/vflsz6gnhp7jc5mlun28.webp', 25.00, NULL, '2026-05-26 12:22:19.955191', NULL);
INSERT INTO public.product_items VALUES (71, 29, 'MES-TRU-CAP-ORA-L', 57, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/vflsz6gnhp7jc5mlun28.webp', 25.00, NULL, '2026-05-26 12:22:19.961571', NULL);
INSERT INTO public.product_items VALUES (72, 29, 'MES-TRU-CAP-ORA-XL', 82, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/vflsz6gnhp7jc5mlun28.webp', 25.00, NULL, '2026-05-26 12:22:19.969325', NULL);
INSERT INTO public.product_items VALUES (437, 107, '202-T1-PLA-PLU-XL', 149, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862194/products/xf6spqo5x0d6mvew3tlp.jpg', 15.00, NULL, '2026-05-27 06:09:54.696039', NULL);
INSERT INTO public.product_items VALUES (438, 107, '202-T1-PLA-PLU-XXL', 140, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862194/products/xf6spqo5x0d6mvew3tlp.jpg', 15.00, NULL, '2026-05-27 06:09:54.699162', NULL);
INSERT INTO public.product_items VALUES (439, 108, 'DIS-MIC-KEY-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862195/products/ryldpg2aumur6axp0vmw.jpg', 15.00, NULL, '2026-05-27 06:09:55.778551', NULL);
INSERT INTO public.product_items VALUES (94, 34, 'AIR-ZIP-UP-HOO-BLU-S', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/mazy3ixm0zep7gimwxsh.webp', 65.00, NULL, '2026-05-26 12:22:20.208808', NULL);
INSERT INTO public.product_items VALUES (95, 34, 'AIR-ZIP-UP-HOO-BLU-M', 131, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/mazy3ixm0zep7gimwxsh.webp', 65.00, NULL, '2026-05-26 12:22:20.216193', NULL);
INSERT INTO public.product_items VALUES (96, 34, 'AIR-ZIP-UP-HOO-BLU-L', 23, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/mazy3ixm0zep7gimwxsh.webp', 65.00, NULL, '2026-05-26 12:22:20.223281', NULL);
INSERT INTO public.product_items VALUES (99, 35, 'AIR-ZIP-UP-HOO-GRA-S', 142, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/zit0zdnboemtlgcikwt3.webp', 65.00, NULL, '2026-05-26 12:22:20.25215', NULL);
INSERT INTO public.product_items VALUES (100, 35, 'AIR-ZIP-UP-HOO-GRA-M', 51, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/zit0zdnboemtlgcikwt3.webp', 65.00, NULL, '2026-05-26 12:22:20.259486', NULL);
INSERT INTO public.product_items VALUES (101, 35, 'AIR-ZIP-UP-HOO-GRA-L', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/zit0zdnboemtlgcikwt3.webp', 65.00, NULL, '2026-05-26 12:22:20.266265', NULL);
INSERT INTO public.product_items VALUES (102, 35, 'AIR-ZIP-UP-HOO-GRA-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/zit0zdnboemtlgcikwt3.webp', 65.00, NULL, '2026-05-26 12:22:20.272209', NULL);
INSERT INTO public.product_items VALUES (104, 36, 'EAS-HOO-BEI-S', 77, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798924/products/dfitoxxptytvmvvkbnnt.webp', 65.00, NULL, '2026-05-26 12:22:20.292554', NULL);
INSERT INTO public.product_items VALUES (105, 36, 'EAS-HOO-BEI-M', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798924/products/dfitoxxptytvmvvkbnnt.webp', 65.00, NULL, '2026-05-26 12:22:20.298503', NULL);
INSERT INTO public.product_items VALUES (106, 36, 'EAS-HOO-BEI-L', 92, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798924/products/dfitoxxptytvmvvkbnnt.webp', 65.00, NULL, '2026-05-26 12:22:20.306454', NULL);
INSERT INTO public.product_items VALUES (107, 36, 'EAS-HOO-BEI-XL', 106, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798924/products/dfitoxxptytvmvvkbnnt.webp', 65.00, NULL, '2026-05-26 12:22:20.312014', NULL);
INSERT INTO public.product_items VALUES (109, 37, 'EAS-HOO-BLU-S', 113, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798925/products/nn58d4b3fuslxkny5gy6.webp', 65.00, NULL, '2026-05-26 12:22:20.331238', NULL);
INSERT INTO public.product_items VALUES (110, 37, 'EAS-HOO-BLU-M', 15, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798925/products/nn58d4b3fuslxkny5gy6.webp', 65.00, NULL, '2026-05-26 12:22:20.338594', NULL);
INSERT INTO public.product_items VALUES (111, 37, 'EAS-HOO-BLU-L', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798925/products/nn58d4b3fuslxkny5gy6.webp', 65.00, NULL, '2026-05-26 12:22:20.34504', NULL);
INSERT INTO public.product_items VALUES (114, 38, 'EAS-HOO-BRO-S', 137, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/s3rxnpuri8jnk3thcmfj.webp', 65.00, NULL, '2026-05-26 12:22:20.3717', NULL);
INSERT INTO public.product_items VALUES (115, 38, 'EAS-HOO-BRO-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/s3rxnpuri8jnk3thcmfj.webp', 65.00, NULL, '2026-05-26 12:22:20.376872', NULL);
INSERT INTO public.product_items VALUES (116, 38, 'EAS-HOO-BRO-L', 37, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/s3rxnpuri8jnk3thcmfj.webp', 65.00, NULL, '2026-05-26 12:22:20.383018', NULL);
INSERT INTO public.product_items VALUES (124, 40, 'SLE-HOO-BEI-S', 41, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798927/products/zndsvewaqjkvtjqubbox.webp', 65.00, NULL, '2026-05-26 12:22:20.451233', NULL);
INSERT INTO public.product_items VALUES (125, 40, 'SLE-HOO-BEI-M', 108, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798927/products/zndsvewaqjkvtjqubbox.webp', 65.00, NULL, '2026-05-26 12:22:20.458539', NULL);
INSERT INTO public.product_items VALUES (126, 40, 'SLE-HOO-BEI-L', 43, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798927/products/zndsvewaqjkvtjqubbox.webp', 65.00, NULL, '2026-05-26 12:22:20.465265', NULL);
INSERT INTO public.product_items VALUES (129, 41, 'SLE-HOO-BLA-S', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798928/products/qdilacpfdxjcdkilxafp.webp', 65.00, NULL, '2026-05-26 12:22:20.491617', NULL);
INSERT INTO public.product_items VALUES (130, 41, 'SLE-HOO-BLA-M', 21, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798928/products/qdilacpfdxjcdkilxafp.webp', 65.00, NULL, '2026-05-26 12:22:20.498072', NULL);
INSERT INTO public.product_items VALUES (131, 41, 'SLE-HOO-BLA-L', 49, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798928/products/qdilacpfdxjcdkilxafp.webp', 65.00, NULL, '2026-05-26 12:22:20.50608', NULL);
INSERT INTO public.product_items VALUES (134, 42, 'DUR-COR-BOM-JAC-BLU-S', 133, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/dmu7bz7kxk17wcpy4avf.webp', 85.00, NULL, '2026-05-26 12:22:20.53612', NULL);
INSERT INTO public.product_items VALUES (135, 42, 'DUR-COR-BOM-JAC-BLU-M', 127, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/dmu7bz7kxk17wcpy4avf.webp', 85.00, NULL, '2026-05-26 12:22:20.542837', NULL);
INSERT INTO public.product_items VALUES (136, 42, 'DUR-COR-BOM-JAC-BLU-L', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/dmu7bz7kxk17wcpy4avf.webp', 85.00, NULL, '2026-05-26 12:22:20.550433', NULL);
INSERT INTO public.product_items VALUES (137, 42, 'DUR-COR-BOM-JAC-BLU-XL', 22, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/dmu7bz7kxk17wcpy4avf.webp', 85.00, NULL, '2026-05-26 12:22:20.558592', NULL);
INSERT INTO public.product_items VALUES (440, 108, 'DIS-MIC-KEY-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862195/products/ryldpg2aumur6axp0vmw.jpg', 15.00, NULL, '2026-05-27 06:09:55.782901', NULL);
INSERT INTO public.product_items VALUES (441, 108, 'DIS-MIC-KEY-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862195/products/ryldpg2aumur6axp0vmw.jpg', 15.00, NULL, '2026-05-27 06:09:55.785712', NULL);
INSERT INTO public.product_items VALUES (442, 108, 'DIS-MIC-KEY-XL', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862195/products/ryldpg2aumur6axp0vmw.jpg', 15.00, NULL, '2026-05-27 06:09:55.79077', NULL);
INSERT INTO public.product_items VALUES (443, 108, 'DIS-MIC-KEY-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862195/products/ryldpg2aumur6axp0vmw.jpg', 15.00, NULL, '2026-05-27 06:09:55.794141', NULL);
INSERT INTO public.product_items VALUES (144, 44, 'DUR-KHA-JAC-BLA-S', 55, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798930/products/jthth4rmzcafj7iwdsyi.webp', 85.00, NULL, '2026-05-26 12:22:20.62488', NULL);
INSERT INTO public.product_items VALUES (149, 45, 'DUR-KHA-JAC-BLU-S', 75, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798931/products/k6g5uu4o8bjedsfib6e8.webp', 85.00, NULL, '2026-05-26 12:22:20.667517', NULL);
INSERT INTO public.product_items VALUES (150, 45, 'DUR-KHA-JAC-BLU-M', 76, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798931/products/k6g5uu4o8bjedsfib6e8.webp', 85.00, NULL, '2026-05-26 12:22:20.673157', NULL);
INSERT INTO public.product_items VALUES (151, 45, 'DUR-KHA-JAC-BLU-L', 45, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798931/products/k6g5uu4o8bjedsfib6e8.webp', 85.00, NULL, '2026-05-26 12:22:20.680417', NULL);
INSERT INTO public.product_items VALUES (152, 45, 'DUR-KHA-JAC-BLU-XL', 45, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798931/products/k6g5uu4o8bjedsfib6e8.webp', 85.00, NULL, '2026-05-26 12:22:20.688009', NULL);
INSERT INTO public.product_items VALUES (154, 46, 'DUR-KHA-JAC-WHI-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798932/products/qxppcw9zu90j7xrxslpm.webp', 85.00, NULL, '2026-05-26 12:22:20.709222', NULL);
INSERT INTO public.product_items VALUES (155, 46, 'DUR-KHA-JAC-WHI-M', 93, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798932/products/qxppcw9zu90j7xrxslpm.webp', 85.00, NULL, '2026-05-26 12:22:20.714923', NULL);
INSERT INTO public.product_items VALUES (156, 46, 'DUR-KHA-JAC-WHI-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798932/products/qxppcw9zu90j7xrxslpm.webp', 85.00, NULL, '2026-05-26 12:22:20.722311', NULL);
INSERT INTO public.product_items VALUES (157, 46, 'DUR-KHA-JAC-WHI-XL', 70, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798932/products/qxppcw9zu90j7xrxslpm.webp', 85.00, NULL, '2026-05-26 12:22:20.729177', NULL);
INSERT INTO public.product_items VALUES (159, 47, 'DUR-KHA-JAC-YEL-S', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798933/products/jxiziia6lga5pxtxb3r2.webp', 85.00, NULL, '2026-05-26 12:22:20.749279', NULL);
INSERT INTO public.product_items VALUES (160, 47, 'DUR-KHA-JAC-YEL-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798933/products/jxiziia6lga5pxtxb3r2.webp', 85.00, NULL, '2026-05-26 12:22:20.75575', NULL);
INSERT INTO public.product_items VALUES (161, 47, 'DUR-KHA-JAC-YEL-L', 21, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798933/products/jxiziia6lga5pxtxb3r2.webp', 85.00, NULL, '2026-05-26 12:22:20.761046', NULL);
INSERT INTO public.product_items VALUES (164, 48, 'DUR-SUN-PRO-PAR-BEI-S', 141, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/ky6fyrhpee50qjbmpo8m.webp', 85.00, NULL, '2026-05-26 12:22:20.786557', NULL);
INSERT INTO public.product_items VALUES (165, 48, 'DUR-SUN-PRO-PAR-BEI-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/ky6fyrhpee50qjbmpo8m.webp', 85.00, NULL, '2026-05-26 12:22:20.79285', NULL);
INSERT INTO public.product_items VALUES (166, 48, 'DUR-SUN-PRO-PAR-BEI-L', 17, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/ky6fyrhpee50qjbmpo8m.webp', 85.00, NULL, '2026-05-26 12:22:20.798182', NULL);
INSERT INTO public.product_items VALUES (167, 48, 'DUR-SUN-PRO-PAR-BEI-XL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/ky6fyrhpee50qjbmpo8m.webp', 85.00, NULL, '2026-05-26 12:22:20.803042', NULL);
INSERT INTO public.product_items VALUES (169, 49, 'DUR-SUN-PRO-PAR-BLA-S', 62, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/nha4nvzpvhoaamusk5ep.webp', 85.00, NULL, '2026-05-26 12:22:20.821454', NULL);
INSERT INTO public.product_items VALUES (170, 49, 'DUR-SUN-PRO-PAR-BLA-M', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/nha4nvzpvhoaamusk5ep.webp', 85.00, NULL, '2026-05-26 12:22:20.826668', NULL);
INSERT INTO public.product_items VALUES (171, 49, 'DUR-SUN-PRO-PAR-BLA-L', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/nha4nvzpvhoaamusk5ep.webp', 85.00, NULL, '2026-05-26 12:22:20.832749', NULL);
INSERT INTO public.product_items VALUES (172, 49, 'DUR-SUN-PRO-PAR-BLA-XL', 109, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/nha4nvzpvhoaamusk5ep.webp', 85.00, NULL, '2026-05-26 12:22:20.839611', NULL);
INSERT INTO public.product_items VALUES (174, 50, 'DUR-SUN-PRO-PAR-BRO-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798935/products/ufb6wmelogqn7hgxvfus.webp', 85.00, NULL, '2026-05-26 12:22:20.856442', NULL);
INSERT INTO public.product_items VALUES (175, 50, 'DUR-SUN-PRO-PAR-BRO-M', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798935/products/ufb6wmelogqn7hgxvfus.webp', 85.00, NULL, '2026-05-26 12:22:20.863208', NULL);
INSERT INTO public.product_items VALUES (176, 50, 'DUR-SUN-PRO-PAR-BRO-L', 124, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798935/products/ufb6wmelogqn7hgxvfus.webp', 85.00, NULL, '2026-05-26 12:22:20.868706', NULL);
INSERT INTO public.product_items VALUES (177, 50, 'DUR-SUN-PRO-PAR-BRO-XL', 100, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798935/products/ufb6wmelogqn7hgxvfus.webp', 85.00, NULL, '2026-05-26 12:22:20.874614', NULL);
INSERT INTO public.product_items VALUES (179, 51, 'EAS-COL-BLO-PAR-BLA-S', 58, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798936/products/rvoqbrdxbbgkjdwnpx5f.webp', 85.00, NULL, '2026-05-26 12:22:20.892771', NULL);
INSERT INTO public.product_items VALUES (180, 51, 'EAS-COL-BLO-PAR-BLA-M', 34, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798936/products/rvoqbrdxbbgkjdwnpx5f.webp', 85.00, NULL, '2026-05-26 12:22:20.898591', NULL);
INSERT INTO public.product_items VALUES (181, 51, 'EAS-COL-BLO-PAR-BLA-L', 5, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798936/products/rvoqbrdxbbgkjdwnpx5f.webp', 85.00, NULL, '2026-05-26 12:22:20.904128', NULL);
INSERT INTO public.product_items VALUES (184, 52, 'EAS-COL-BLO-PAR-BRO--S', 56, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/vialy5narx02elliyapr.webp', 85.00, NULL, '2026-05-26 12:22:20.926986', NULL);
INSERT INTO public.product_items VALUES (185, 52, 'EAS-COL-BLO-PAR-BRO--M', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/vialy5narx02elliyapr.webp', 85.00, NULL, '2026-05-26 12:22:20.931647', NULL);
INSERT INTO public.product_items VALUES (186, 52, 'EAS-COL-BLO-PAR-BRO--L', 43, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/vialy5narx02elliyapr.webp', 85.00, NULL, '2026-05-26 12:22:20.936711', NULL);
INSERT INTO public.product_items VALUES (187, 52, 'EAS-COL-BLO-PAR-BRO--XL', 20, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/vialy5narx02elliyapr.webp', 85.00, NULL, '2026-05-26 12:22:20.94233', NULL);
INSERT INTO public.product_items VALUES (194, 54, 'AIR-PAN-BLA-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798939/products/x4jw2gsuqc9tlra0r54c.webp', 55.00, NULL, '2026-05-26 12:22:20.991837', NULL);
INSERT INTO public.product_items VALUES (195, 54, 'AIR-PAN-BLA-M', 130, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798939/products/x4jw2gsuqc9tlra0r54c.webp', 55.00, NULL, '2026-05-26 12:22:20.996785', NULL);
INSERT INTO public.product_items VALUES (196, 54, 'AIR-PAN-BLA-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798939/products/x4jw2gsuqc9tlra0r54c.webp', 55.00, NULL, '2026-05-26 12:22:21.001581', NULL);
INSERT INTO public.product_items VALUES (197, 54, 'AIR-PAN-BLA-XL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798939/products/x4jw2gsuqc9tlra0r54c.webp', 55.00, NULL, '2026-05-26 12:22:21.007285', NULL);
INSERT INTO public.product_items VALUES (444, 109, 'DIS-MIC-MUG-S', 112, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862196/products/atutcdh9yyhanhdwsttc.jpg', 15.00, NULL, '2026-05-27 06:09:56.627513', NULL);
INSERT INTO public.product_items VALUES (445, 109, 'DIS-MIC-MUG-M', 136, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862196/products/atutcdh9yyhanhdwsttc.jpg', 15.00, NULL, '2026-05-27 06:09:56.631739', NULL);
INSERT INTO public.product_items VALUES (204, 56, 'BEG-PAR-JOG-GRE-S', 139, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ax4vsno4etyflwv4vlqw.webp', 55.00, NULL, '2026-05-26 12:22:21.05506', NULL);
INSERT INTO public.product_items VALUES (205, 56, 'BEG-PAR-JOG-GRE-M', 137, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ax4vsno4etyflwv4vlqw.webp', 55.00, NULL, '2026-05-26 12:22:21.060755', NULL);
INSERT INTO public.product_items VALUES (219, 59, 'DUR-BAG-JEA-NAV-S', 36, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798943/products/e5caoxoibsbyth3wop6v.webp', 55.00, NULL, '2026-05-26 12:22:21.153316', NULL);
INSERT INTO public.product_items VALUES (220, 59, 'DUR-BAG-JEA-NAV-M', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798943/products/e5caoxoibsbyth3wop6v.webp', 55.00, NULL, '2026-05-26 12:22:21.158246', NULL);
INSERT INTO public.product_items VALUES (221, 59, 'DUR-BAG-JEA-NAV-L', 55, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798943/products/e5caoxoibsbyth3wop6v.webp', 55.00, NULL, '2026-05-26 12:22:21.163141', NULL);
INSERT INTO public.product_items VALUES (222, 59, 'DUR-BAG-JEA-NAV-XL', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798943/products/e5caoxoibsbyth3wop6v.webp', 55.00, NULL, '2026-05-26 12:22:21.168872', NULL);
INSERT INTO public.product_items VALUES (229, 61, 'DUR-ELE-TRO-BRO-S', 68, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/vbqsixu3syfbncypntc3.webp', 55.00, NULL, '2026-05-26 12:22:21.220849', NULL);
INSERT INTO public.product_items VALUES (230, 61, 'DUR-ELE-TRO-BRO-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/vbqsixu3syfbncypntc3.webp', 55.00, NULL, '2026-05-26 12:22:21.22971', NULL);
INSERT INTO public.product_items VALUES (231, 61, 'DUR-ELE-TRO-BRO-L', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/vbqsixu3syfbncypntc3.webp', 55.00, NULL, '2026-05-26 12:22:21.239262', NULL);
INSERT INTO public.product_items VALUES (232, 61, 'DUR-ELE-TRO-BRO-XL', 33, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/vbqsixu3syfbncypntc3.webp', 55.00, NULL, '2026-05-26 12:22:21.244081', NULL);
INSERT INTO public.product_items VALUES (234, 62, 'DUR-WID-LEG-KHA-PAN--S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/jwpx6e4vdbyvmaatnbbx.webp', 55.00, NULL, '2026-05-26 12:22:21.261438', NULL);
INSERT INTO public.product_items VALUES (235, 62, 'DUR-WID-LEG-KHA-PAN--M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/jwpx6e4vdbyvmaatnbbx.webp', 55.00, NULL, '2026-05-26 12:22:21.2652', NULL);
INSERT INTO public.product_items VALUES (236, 62, 'DUR-WID-LEG-KHA-PAN--L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/jwpx6e4vdbyvmaatnbbx.webp', 55.00, NULL, '2026-05-26 12:22:21.274222', NULL);
INSERT INTO public.product_items VALUES (239, 63, 'FLE-JEA-BLU-S', 39, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798946/products/p3cguvd5n6tbvs4kemh8.webp', 55.00, NULL, '2026-05-26 12:22:21.297515', NULL);
INSERT INTO public.product_items VALUES (240, 63, 'FLE-JEA-BLU-M', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798946/products/p3cguvd5n6tbvs4kemh8.webp', 55.00, NULL, '2026-05-26 12:22:21.303651', NULL);
INSERT INTO public.product_items VALUES (241, 63, 'FLE-JEA-BLU-L', 78, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798946/products/p3cguvd5n6tbvs4kemh8.webp', 55.00, NULL, '2026-05-26 12:22:21.308102', NULL);
INSERT INTO public.product_items VALUES (242, 63, 'FLE-JEA-BLU-XL', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798946/products/p3cguvd5n6tbvs4kemh8.webp', 55.00, NULL, '2026-05-26 12:22:21.31265', NULL);
INSERT INTO public.product_items VALUES (243, 63, 'FLE-JEA-BLU-XXL', 51, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798946/products/p3cguvd5n6tbvs4kemh8.webp', 55.00, NULL, '2026-05-26 12:22:21.318838', NULL);
INSERT INTO public.product_items VALUES (244, 64, 'FLE-JEA-BRO-S', 116, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798947/products/nragfjefaig4kofmybik.webp', 55.00, NULL, '2026-05-26 12:22:21.32908', NULL);
INSERT INTO public.product_items VALUES (245, 64, 'FLE-JEA-BRO-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798947/products/nragfjefaig4kofmybik.webp', 55.00, NULL, '2026-05-26 12:22:21.33318', NULL);
INSERT INTO public.product_items VALUES (246, 64, 'FLE-JEA-BRO-L', 140, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798947/products/nragfjefaig4kofmybik.webp', 55.00, NULL, '2026-05-26 12:22:21.339303', NULL);
INSERT INTO public.product_items VALUES (249, 65, 'FLE-JEA-DAR-BRO-S', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798948/products/iessav8wxdcww4yteyv2.webp', 55.00, NULL, '2026-05-26 12:22:21.360958', NULL);
INSERT INTO public.product_items VALUES (250, 65, 'FLE-JEA-DAR-BRO-M', 123, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798948/products/iessav8wxdcww4yteyv2.webp', 55.00, NULL, '2026-05-26 12:22:21.365659', NULL);
INSERT INTO public.product_items VALUES (251, 65, 'FLE-JEA-DAR-BRO-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798948/products/iessav8wxdcww4yteyv2.webp', 55.00, NULL, '2026-05-26 12:22:21.371801', NULL);
INSERT INTO public.product_items VALUES (259, 67, 'FLE-JEA-WHI-S', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/muxa6kvmrri6dnodmkny.webp', 55.00, NULL, '2026-05-26 12:22:21.424376', NULL);
INSERT INTO public.product_items VALUES (260, 67, 'FLE-JEA-WHI-M', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/muxa6kvmrri6dnodmkny.webp', 55.00, NULL, '2026-05-26 12:22:21.429075', NULL);
INSERT INTO public.product_items VALUES (446, 109, 'DIS-MIC-MUG-L', 100, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862196/products/atutcdh9yyhanhdwsttc.jpg', 15.00, NULL, '2026-05-27 06:09:56.635159', NULL);
INSERT INTO public.product_items VALUES (447, 109, 'DIS-MIC-MUG-XL', 87, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862196/products/atutcdh9yyhanhdwsttc.jpg', 15.00, NULL, '2026-05-27 06:09:56.640115', NULL);
INSERT INTO public.product_items VALUES (448, 109, 'DIS-MIC-MUG-XXL', 93, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862196/products/atutcdh9yyhanhdwsttc.jpg', 15.00, NULL, '2026-05-27 06:09:56.64379', NULL);
INSERT INTO public.product_items VALUES (449, 110, 'DIS-MIN-KEY-S', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/de4fstph2bytryl8dkci.jpg', 15.00, NULL, '2026-05-27 06:09:57.415931', NULL);
INSERT INTO public.product_items VALUES (264, 68, 'SCU-CLO-JOG-GRA-S', 147, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/ydqihzjhovmqipkfl8ea.webp', 55.00, NULL, '2026-05-26 12:22:21.455462', NULL);
INSERT INTO public.product_items VALUES (265, 68, 'SCU-CLO-JOG-GRA-M', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/ydqihzjhovmqipkfl8ea.webp', 55.00, NULL, '2026-05-26 12:22:21.46036', NULL);
INSERT INTO public.product_items VALUES (274, 70, 'THE-MIN-KHA-PAN-BLA-S', 19, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798952/products/hferrn1i4r4umjqhsf0i.webp', 55.00, NULL, '2026-05-26 12:22:21.517345', NULL);
INSERT INTO public.product_items VALUES (275, 70, 'THE-MIN-KHA-PAN-BLA-M', 95, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798952/products/hferrn1i4r4umjqhsf0i.webp', 55.00, NULL, '2026-05-26 12:22:21.523222', NULL);
INSERT INTO public.product_items VALUES (276, 70, 'THE-MIN-KHA-PAN-BLA-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798952/products/hferrn1i4r4umjqhsf0i.webp', 55.00, NULL, '2026-05-26 12:22:21.527585', NULL);
INSERT INTO public.product_items VALUES (279, 71, 'DUR-CLA-COR-SHO-SLE--S', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-05-26 12:22:21.551043', NULL);
INSERT INTO public.product_items VALUES (280, 71, 'DUR-CLA-COR-SHO-SLE--M', 137, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-05-26 12:22:21.556241', NULL);
INSERT INTO public.product_items VALUES (254, 66, 'FLE-JEA-GRA-S', 129, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798949/products/fuzyij9v5un61jaskdon.webp', 55.00, 1, '2026-05-26 12:22:21.393682', NULL);
INSERT INTO public.product_items VALUES (281, 71, 'DUR-CLA-COR-SHO-SLE--L', 66, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-05-26 12:22:21.562032', NULL);
INSERT INTO public.product_items VALUES (282, 71, 'DUR-CLA-COR-SHO-SLE--XL', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-05-26 12:22:21.566645', NULL);
INSERT INTO public.product_items VALUES (289, 75, 'DUR-DEN-OVE-DAR-BLU-S', 49, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798954/products/zl5mlbfovjnys3u0oh6s.webp', 45.00, NULL, '2026-05-26 12:22:21.654252', NULL);
INSERT INTO public.product_items VALUES (290, 75, 'DUR-DEN-OVE-DAR-BLU-M', 84, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798954/products/zl5mlbfovjnys3u0oh6s.webp', 45.00, NULL, '2026-05-26 12:22:21.660304', NULL);
INSERT INTO public.product_items VALUES (291, 75, 'DUR-DEN-OVE-DAR-BLU-L', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798954/products/zl5mlbfovjnys3u0oh6s.webp', 45.00, NULL, '2026-05-26 12:22:21.664049', NULL);
INSERT INTO public.product_items VALUES (292, 75, 'DUR-DEN-OVE-DAR-BLU-XL', 144, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798954/products/zl5mlbfovjnys3u0oh6s.webp', 45.00, NULL, '2026-05-26 12:22:21.669715', NULL);
INSERT INTO public.product_items VALUES (294, 76, 'DUR-DEN-OVE-LIG-BLU-S', 41, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798955/products/t2asqixho9lmniilxkzi.webp', 45.00, NULL, '2026-05-26 12:22:21.687141', NULL);
INSERT INTO public.product_items VALUES (295, 76, 'DUR-DEN-OVE-LIG-BLU-M', 70, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798955/products/t2asqixho9lmniilxkzi.webp', 45.00, NULL, '2026-05-26 12:22:21.693063', NULL);
INSERT INTO public.product_items VALUES (296, 76, 'DUR-DEN-OVE-LIG-BLU-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798955/products/t2asqixho9lmniilxkzi.webp', 45.00, NULL, '2026-05-26 12:22:21.699141', NULL);
INSERT INTO public.product_items VALUES (297, 76, 'DUR-DEN-OVE-LIG-BLU-XL', 27, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798955/products/t2asqixho9lmniilxkzi.webp', 45.00, NULL, '2026-05-26 12:22:21.705378', NULL);
INSERT INTO public.product_items VALUES (299, 77, 'DUR-WAS-KHA-OVE-BEI-S', 61, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798956/products/rzuvlcdohzsg3us7apw5.webp', 45.00, NULL, '2026-05-26 12:22:21.722566', NULL);
INSERT INTO public.product_items VALUES (300, 77, 'DUR-WAS-KHA-OVE-BEI-M', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798956/products/rzuvlcdohzsg3us7apw5.webp', 45.00, NULL, '2026-05-26 12:22:21.727061', NULL);
INSERT INTO public.product_items VALUES (301, 77, 'DUR-WAS-KHA-OVE-BEI-L', 106, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798956/products/rzuvlcdohzsg3us7apw5.webp', 45.00, NULL, '2026-05-26 12:22:21.731778', NULL);
INSERT INTO public.product_items VALUES (302, 77, 'DUR-WAS-KHA-OVE-BEI-XL', 89, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798956/products/rzuvlcdohzsg3us7apw5.webp', 45.00, NULL, '2026-05-26 12:22:21.738602', NULL);
INSERT INTO public.product_items VALUES (304, 78, 'DUR-WAS-KHA-OVE-GRA-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798958/products/sk18gwvbswto50hygrs1.webp', 45.00, NULL, '2026-05-26 12:22:21.75568', NULL);
INSERT INTO public.product_items VALUES (305, 78, 'DUR-WAS-KHA-OVE-GRA-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798958/products/sk18gwvbswto50hygrs1.webp', 45.00, NULL, '2026-05-26 12:22:21.761835', NULL);
INSERT INTO public.product_items VALUES (306, 78, 'DUR-WAS-KHA-OVE-GRA-L', 66, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798958/products/sk18gwvbswto50hygrs1.webp', 45.00, NULL, '2026-05-26 12:22:21.767984', NULL);
INSERT INTO public.product_items VALUES (307, 78, 'DUR-WAS-KHA-OVE-GRA-XL', 79, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798958/products/sk18gwvbswto50hygrs1.webp', 45.00, NULL, '2026-05-26 12:22:21.772691', NULL);
INSERT INTO public.product_items VALUES (309, 79, 'EAS-BOX-SHO-SLE-OXF--S', 116, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-05-26 12:22:21.790226', NULL);
INSERT INTO public.product_items VALUES (310, 79, 'EAS-BOX-SHO-SLE-OXF--M', 71, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-05-26 12:22:21.794439', NULL);
INSERT INTO public.product_items VALUES (311, 79, 'EAS-BOX-SHO-SLE-OXF--L', 131, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-05-26 12:22:21.799737', NULL);
INSERT INTO public.product_items VALUES (312, 79, 'EAS-BOX-SHO-SLE-OXF--XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-05-26 12:22:21.80644', NULL);
INSERT INTO public.product_items VALUES (314, 83, 'CLO-MIC-SWE-BEI-S', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798960/products/ptwwrlzcp8el4yj1qp1l.webp', 59.00, NULL, '2026-05-26 12:22:21.872536', NULL);
INSERT INTO public.product_items VALUES (315, 83, 'CLO-MIC-SWE-BEI-M', 22, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798960/products/ptwwrlzcp8el4yj1qp1l.webp', 59.00, NULL, '2026-05-26 12:22:21.87918', NULL);
INSERT INTO public.product_items VALUES (450, 110, 'DIS-MIN-KEY-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/de4fstph2bytryl8dkci.jpg', 15.00, NULL, '2026-05-27 06:09:57.42377', NULL);
INSERT INTO public.product_items VALUES (451, 110, 'DIS-MIN-KEY-L', 74, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/de4fstph2bytryl8dkci.jpg', 15.00, NULL, '2026-05-27 06:09:57.432322', NULL);
INSERT INTO public.product_items VALUES (452, 110, 'DIS-MIN-KEY-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/de4fstph2bytryl8dkci.jpg', 15.00, NULL, '2026-05-27 06:09:57.438529', NULL);
INSERT INTO public.product_items VALUES (324, 85, 'CLO-MIC-SWE-BRO-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/utq9t6jbxnvtdvava5hf.webp', 59.00, NULL, '2026-05-26 12:22:21.944117', NULL);
INSERT INTO public.product_items VALUES (325, 85, 'CLO-MIC-SWE-BRO-M', 97, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/utq9t6jbxnvtdvava5hf.webp', 59.00, NULL, '2026-05-26 12:22:21.949539', NULL);
INSERT INTO public.product_items VALUES (326, 85, 'CLO-MIC-SWE-BRO-L', 76, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/utq9t6jbxnvtdvava5hf.webp', 59.00, NULL, '2026-05-26 12:22:21.95566', NULL);
INSERT INTO public.product_items VALUES (327, 85, 'CLO-MIC-SWE-BRO-XL', 120, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/utq9t6jbxnvtdvava5hf.webp', 59.00, NULL, '2026-05-26 12:22:21.960933', NULL);
INSERT INTO public.product_items VALUES (334, 87, 'COT-POL-SWE-BLA-WHI-S', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798963/products/xd3axi8tnf9znfoiu9jm.webp', 59.00, NULL, '2026-05-26 12:22:22.013058', NULL);
INSERT INTO public.product_items VALUES (335, 87, 'COT-POL-SWE-BLA-WHI-M', 80, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798963/products/xd3axi8tnf9znfoiu9jm.webp', 59.00, NULL, '2026-05-26 12:22:22.017821', NULL);
INSERT INTO public.product_items VALUES (336, 87, 'COT-POL-SWE-BLA-WHI-L', 93, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798963/products/xd3axi8tnf9znfoiu9jm.webp', 59.00, NULL, '2026-05-26 12:22:22.024312', NULL);
INSERT INTO public.product_items VALUES (337, 87, 'COT-POL-SWE-BLA-WHI-XL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798963/products/xd3axi8tnf9znfoiu9jm.webp', 59.00, NULL, '2026-05-26 12:22:22.030274', NULL);
INSERT INTO public.product_items VALUES (339, 88, 'COT-POL-SWE-BRO-BEI-S', 88, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798964/products/fwiaa8b1nwnvqjs3acba.webp', 59.00, NULL, '2026-05-26 12:22:22.051176', NULL);
INSERT INTO public.product_items VALUES (340, 88, 'COT-POL-SWE-BRO-BEI-M', 75, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798964/products/fwiaa8b1nwnvqjs3acba.webp', 59.00, NULL, '2026-05-26 12:22:22.05806', NULL);
INSERT INTO public.product_items VALUES (341, 88, 'COT-POL-SWE-BRO-BEI-L', 115, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798964/products/fwiaa8b1nwnvqjs3acba.webp', 59.00, NULL, '2026-05-26 12:22:22.063511', NULL);
INSERT INTO public.product_items VALUES (342, 88, 'COT-POL-SWE-BRO-BEI-XL', 34, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798964/products/fwiaa8b1nwnvqjs3acba.webp', 59.00, NULL, '2026-05-26 12:22:22.07078', NULL);
INSERT INTO public.product_items VALUES (344, 89, 'COT-POL-SWE-RED-BEI-S', 119, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798965/products/pjcnlmkamcshjzco1zsf.webp', 59.00, NULL, '2026-05-26 12:22:22.08957', NULL);
INSERT INTO public.product_items VALUES (345, 89, 'COT-POL-SWE-RED-BEI-M', 58, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798965/products/pjcnlmkamcshjzco1zsf.webp', 59.00, NULL, '2026-05-26 12:22:22.096255', NULL);
INSERT INTO public.product_items VALUES (346, 89, 'COT-POL-SWE-RED-BEI-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798965/products/pjcnlmkamcshjzco1zsf.webp', 59.00, NULL, '2026-05-26 12:22:22.104109', NULL);
INSERT INTO public.product_items VALUES (354, 91, 'COT-SWE-BRO-S', 80, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/bjqxi12bqkdcsb0w9iyp.webp', 59.00, NULL, '2026-05-26 12:22:22.173912', NULL);
INSERT INTO public.product_items VALUES (355, 91, 'COT-SWE-BRO-M', 127, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/bjqxi12bqkdcsb0w9iyp.webp', 59.00, NULL, '2026-05-26 12:22:22.179808', NULL);
INSERT INTO public.product_items VALUES (356, 91, 'COT-SWE-BRO-L', 78, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/bjqxi12bqkdcsb0w9iyp.webp', 59.00, NULL, '2026-05-26 12:22:22.187391', NULL);
INSERT INTO public.product_items VALUES (359, 92, 'LON-SLE-SWE-BLA-S', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798967/products/swxd44aygxkhlzsby27o.webp', 59.00, NULL, '2026-05-26 12:22:22.209963', NULL);
INSERT INTO public.product_items VALUES (360, 92, 'LON-SLE-SWE-BLA-M', 135, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798967/products/swxd44aygxkhlzsby27o.webp', 59.00, NULL, '2026-05-26 12:22:22.215213', NULL);
INSERT INTO public.product_items VALUES (361, 92, 'LON-SLE-SWE-BLA-L', 121, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798967/products/swxd44aygxkhlzsby27o.webp', 59.00, NULL, '2026-05-26 12:22:22.220781', NULL);
INSERT INTO public.product_items VALUES (362, 92, 'LON-SLE-SWE-BLA-XL', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798967/products/swxd44aygxkhlzsby27o.webp', 59.00, NULL, '2026-05-26 12:22:22.22702', NULL);
INSERT INTO public.product_items VALUES (364, 93, 'LON-SLE-SWE-BLU-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798968/products/t7b9mr7gahxb5cbwvxve.webp', 59.00, NULL, '2026-05-26 12:22:22.243543', NULL);
INSERT INTO public.product_items VALUES (365, 93, 'LON-SLE-SWE-BLU-M', 31, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798968/products/t7b9mr7gahxb5cbwvxve.webp', 59.00, NULL, '2026-05-26 12:22:22.249702', NULL);
INSERT INTO public.product_items VALUES (366, 93, 'LON-SLE-SWE-BLU-L', 25, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798968/products/t7b9mr7gahxb5cbwvxve.webp', 59.00, NULL, '2026-05-26 12:22:22.256043', NULL);
INSERT INTO public.product_items VALUES (369, 94, 'LON-SLE-SWE-WHI-S', 5, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/wclyfsganpq5mrbauogd.webp', 59.00, NULL, '2026-05-26 12:22:22.277351', NULL);
INSERT INTO public.product_items VALUES (370, 94, 'LON-SLE-SWE-WHI-M', 120, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/wclyfsganpq5mrbauogd.webp', 59.00, NULL, '2026-05-26 12:22:22.282098', NULL);
INSERT INTO public.product_items VALUES (371, 94, 'LON-SLE-SWE-WHI-L', 109, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/wclyfsganpq5mrbauogd.webp', 59.00, NULL, '2026-05-26 12:22:22.287958', NULL);
INSERT INTO public.product_items VALUES (372, 94, 'LON-SLE-SWE-WHI-XL', 24, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/wclyfsganpq5mrbauogd.webp', 59.00, NULL, '2026-05-26 12:22:22.294523', NULL);
INSERT INTO public.product_items VALUES (374, 95, 'ZIP-NEC-POL-SWE-GRA-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/f2kwurkl5jo7uwinbblg.webp', 59.00, NULL, '2026-05-26 12:22:22.313062', NULL);
INSERT INTO public.product_items VALUES (453, 110, 'DIS-MIN-KEY-XXL', 148, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/de4fstph2bytryl8dkci.jpg', 15.00, NULL, '2026-05-27 06:09:57.445876', NULL);
INSERT INTO public.product_items VALUES (454, 111, 'DIS-FRI-ROU-KEY-S', 114, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/vewf3eic9eatga1dufvn.jpg', 15.00, NULL, '2026-05-27 06:09:58.411375', NULL);
INSERT INTO public.product_items VALUES (455, 111, 'DIS-FRI-ROU-KEY-M', 133, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/vewf3eic9eatga1dufvn.jpg', 15.00, NULL, '2026-05-27 06:09:58.416609', NULL);
INSERT INTO public.product_items VALUES (456, 111, 'DIS-FRI-ROU-KEY-L', 121, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/vewf3eic9eatga1dufvn.jpg', 15.00, NULL, '2026-05-27 06:09:58.421508', NULL);
INSERT INTO public.product_items VALUES (19, 19, 'COR-BUC-HAT-BLA-S', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798910/products/a3zt1loexlkxgwfzjhyf.webp', 25.00, NULL, '2026-05-26 12:22:19.518048', NULL);
INSERT INTO public.product_items VALUES (20, 19, 'COR-BUC-HAT-BLA-M', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798910/products/a3zt1loexlkxgwfzjhyf.webp', 25.00, NULL, '2026-05-26 12:22:19.527944', NULL);
INSERT INTO public.product_items VALUES (379, 96, 'BOX-RAG-T-SHI-BEI-S', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798970/products/knamwsasogb8ocpyjlpa.webp', 35.00, NULL, '2026-05-26 12:22:22.347626', NULL);
INSERT INTO public.product_items VALUES (380, 96, 'BOX-RAG-T-SHI-BEI-M', 59, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798970/products/knamwsasogb8ocpyjlpa.webp', 35.00, NULL, '2026-05-26 12:22:22.353045', NULL);
INSERT INTO public.product_items VALUES (381, 96, 'BOX-RAG-T-SHI-BEI-L', 132, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798970/products/knamwsasogb8ocpyjlpa.webp', 35.00, NULL, '2026-05-26 12:22:22.358883', NULL);
INSERT INTO public.product_items VALUES (384, 97, 'BOX-RAG-T-SHI-BRO-S', 79, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798971/products/pdeaj2jpxnapeae1tg1j.webp', 35.00, NULL, '2026-05-26 12:22:22.38063', NULL);
INSERT INTO public.product_items VALUES (385, 97, 'BOX-RAG-T-SHI-BRO-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798971/products/pdeaj2jpxnapeae1tg1j.webp', 35.00, NULL, '2026-05-26 12:22:22.386861', NULL);
INSERT INTO public.product_items VALUES (386, 97, 'BOX-RAG-T-SHI-BRO-L', 149, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798971/products/pdeaj2jpxnapeae1tg1j.webp', 35.00, NULL, '2026-05-26 12:22:22.391624', NULL);
INSERT INTO public.product_items VALUES (389, 98, 'BOX-RAG-T-SHI-GRA-S', 87, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798972/products/karaxe9ybvoafbqcxvfb.webp', 35.00, NULL, '2026-05-26 12:22:22.412929', NULL);
INSERT INTO public.product_items VALUES (390, 98, 'BOX-RAG-T-SHI-GRA-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798972/products/karaxe9ybvoafbqcxvfb.webp', 35.00, NULL, '2026-05-26 12:22:22.419052', NULL);
INSERT INTO public.product_items VALUES (391, 98, 'BOX-RAG-T-SHI-GRA-L', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798972/products/karaxe9ybvoafbqcxvfb.webp', 35.00, NULL, '2026-05-26 12:22:22.424602', NULL);
INSERT INTO public.product_items VALUES (392, 98, 'BOX-RAG-T-SHI-GRA-XL', 47, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798972/products/karaxe9ybvoafbqcxvfb.webp', 35.00, NULL, '2026-05-26 12:22:22.429958', NULL);
INSERT INTO public.product_items VALUES (394, 99, 'BOX-RAG-T-SHI-GRE-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798973/products/ckx1qh2bgy22lxrdficy.webp', 35.00, NULL, '2026-05-26 12:22:22.445684', NULL);
INSERT INTO public.product_items VALUES (395, 99, 'BOX-RAG-T-SHI-GRE-M', 16, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798973/products/ckx1qh2bgy22lxrdficy.webp', 35.00, NULL, '2026-05-26 12:22:22.450451', NULL);
INSERT INTO public.product_items VALUES (396, 99, 'BOX-RAG-T-SHI-GRE-L', 97, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798973/products/ckx1qh2bgy22lxrdficy.webp', 35.00, NULL, '2026-05-26 12:22:22.455623', NULL);
INSERT INTO public.product_items VALUES (399, 100, 'EAS-T-SHI-BEI-S', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/jr5lnpsx5yicncaa3rhn.webp', 35.00, NULL, '2026-05-26 12:22:22.474605', NULL);
INSERT INTO public.product_items VALUES (400, 100, 'EAS-T-SHI-BEI-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/jr5lnpsx5yicncaa3rhn.webp', 35.00, NULL, '2026-05-26 12:22:22.479038', NULL);
INSERT INTO public.product_items VALUES (401, 100, 'EAS-T-SHI-BEI-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/jr5lnpsx5yicncaa3rhn.webp', 35.00, NULL, '2026-05-26 12:22:22.482872', NULL);
INSERT INTO public.product_items VALUES (402, 100, 'EAS-T-SHI-BEI-XL', 52, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/jr5lnpsx5yicncaa3rhn.webp', 35.00, NULL, '2026-05-26 12:22:22.489279', NULL);
INSERT INTO public.product_items VALUES (404, 101, 'EAS-T-SHI-BLA-S', 126, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/fb4z3qipg6gwvj47hbeo.webp', 35.00, NULL, '2026-05-26 12:22:22.50615', NULL);
INSERT INTO public.product_items VALUES (405, 101, 'EAS-T-SHI-BLA-M', 57, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/fb4z3qipg6gwvj47hbeo.webp', 35.00, NULL, '2026-05-26 12:22:22.511362', NULL);
INSERT INTO public.product_items VALUES (406, 101, 'EAS-T-SHI-BLA-L', 80, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/fb4z3qipg6gwvj47hbeo.webp', 35.00, NULL, '2026-05-26 12:22:22.516238', NULL);
INSERT INTO public.product_items VALUES (407, 101, 'EAS-T-SHI-BLA-XL', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/fb4z3qipg6gwvj47hbeo.webp', 35.00, NULL, '2026-05-26 12:22:22.522394', NULL);
INSERT INTO public.product_items VALUES (409, 102, 'EAS-T-SHI-WHI-S', 67, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798975/products/pzcavlsnvtdf3titpm4x.webp', 35.00, NULL, '2026-05-26 12:22:22.536877', NULL);
INSERT INTO public.product_items VALUES (410, 102, 'EAS-T-SHI-WHI-M', 35, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798975/products/pzcavlsnvtdf3titpm4x.webp', 35.00, NULL, '2026-05-26 12:22:22.543043', NULL);
INSERT INTO public.product_items VALUES (411, 102, 'EAS-T-SHI-WHI-L', 18, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798975/products/pzcavlsnvtdf3titpm4x.webp', 35.00, NULL, '2026-05-26 12:22:22.547308', NULL);
INSERT INTO public.product_items VALUES (414, 103, 'FLE-T-SHI-BLA-S', 143, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798976/products/xbtfsh6vnw7zxnk1pqtk.webp', 35.00, NULL, '2026-05-26 12:22:22.568292', NULL);
INSERT INTO public.product_items VALUES (415, 103, 'FLE-T-SHI-BLA-M', 108, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798976/products/xbtfsh6vnw7zxnk1pqtk.webp', 35.00, NULL, '2026-05-26 12:22:22.573431', NULL);
INSERT INTO public.product_items VALUES (416, 103, 'FLE-T-SHI-BLA-L', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798976/products/xbtfsh6vnw7zxnk1pqtk.webp', 35.00, NULL, '2026-05-26 12:22:22.578538', NULL);
INSERT INTO public.product_items VALUES (417, 103, 'FLE-T-SHI-BLA-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798976/products/xbtfsh6vnw7zxnk1pqtk.webp', 35.00, NULL, '2026-05-26 12:22:22.583753', NULL);
INSERT INTO public.product_items VALUES (419, 104, 'FLE-T-SHI-BLU-S', 55, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798977/products/agalabg30250pym1owe9.webp', 35.00, NULL, '2026-05-26 12:22:22.59841', NULL);
INSERT INTO public.product_items VALUES (420, 104, 'FLE-T-SHI-BLU-M', 39, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798977/products/agalabg30250pym1owe9.webp', 35.00, NULL, '2026-05-26 12:22:22.603922', NULL);
INSERT INTO public.product_items VALUES (421, 104, 'FLE-T-SHI-BLU-L', 58, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798977/products/agalabg30250pym1owe9.webp', 35.00, NULL, '2026-05-26 12:22:22.609274', NULL);
INSERT INTO public.product_items VALUES (424, 105, 'FLE-T-SHI-GRA-S', 31, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/gibiswuhhsmptss91tab.webp', 35.00, NULL, '2026-05-26 12:22:22.633876', NULL);
INSERT INTO public.product_items VALUES (425, 105, 'FLE-T-SHI-GRA-M', 54, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/gibiswuhhsmptss91tab.webp', 35.00, NULL, '2026-05-26 12:22:22.639112', NULL);
INSERT INTO public.product_items VALUES (426, 105, 'FLE-T-SHI-GRA-L', 73, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/gibiswuhhsmptss91tab.webp', 35.00, NULL, '2026-05-26 12:22:22.644292', NULL);
INSERT INTO public.product_items VALUES (427, 105, 'FLE-T-SHI-GRA-XL', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/gibiswuhhsmptss91tab.webp', 35.00, NULL, '2026-05-26 12:22:22.651505', NULL);
INSERT INTO public.product_items VALUES (429, 106, 'FLE-T-SHI-WHI-S', 49, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/e8ofmgh2civfenhjxqvv.webp', 35.00, NULL, '2026-05-26 12:22:22.669873', NULL);
INSERT INTO public.product_items VALUES (430, 106, 'FLE-T-SHI-WHI-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/e8ofmgh2civfenhjxqvv.webp', 35.00, NULL, '2026-05-26 12:22:22.67555', NULL);
INSERT INTO public.product_items VALUES (431, 106, 'FLE-T-SHI-WHI-L', 117, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/e8ofmgh2civfenhjxqvv.webp', 35.00, NULL, '2026-05-26 12:22:22.680615', NULL);
INSERT INTO public.product_items VALUES (21, 19, 'COR-BUC-HAT-BLA-L', 72, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798910/products/a3zt1loexlkxgwfzjhyf.webp', 25.00, NULL, '2026-05-26 12:22:19.535529', NULL);
INSERT INTO public.product_items VALUES (22, 19, 'COR-BUC-HAT-BLA-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798910/products/a3zt1loexlkxgwfzjhyf.webp', 25.00, NULL, '2026-05-26 12:22:19.541649', NULL);
INSERT INTO public.product_items VALUES (23, 19, 'COR-BUC-HAT-BLA-XXL', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798910/products/a3zt1loexlkxgwfzjhyf.webp', 25.00, NULL, '2026-05-26 12:22:19.548597', NULL);
INSERT INTO public.product_items VALUES (27, 20, 'COR-BUC-HAT-BRO-XL', 102, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798911/products/hskkpmuizhxzv1hxxg5s.webp', 25.00, NULL, '2026-05-26 12:22:19.582771', NULL);
INSERT INTO public.product_items VALUES (28, 20, 'COR-BUC-HAT-BRO-XXL', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798911/products/hskkpmuizhxzv1hxxg5s.webp', 25.00, NULL, '2026-05-26 12:22:19.589221', NULL);
INSERT INTO public.product_items VALUES (33, 21, 'COR-BUC-HAT-PIN-XXL', 125, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798912/products/fyfacj7uvgfmwqaokhbh.webp', 25.00, NULL, '2026-05-26 12:22:19.632526', NULL);
INSERT INTO public.product_items VALUES (43, 23, 'KHA-FIT-CAP-BLU-XXL', 31, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798914/products/zgux2tir1qvhklvzandq.webp', 25.00, NULL, '2026-05-26 12:22:19.71853', NULL);
INSERT INTO public.product_items VALUES (47, 24, 'KHA-FIT-CAP-GRE-XL', 118, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/w8twfyggeboarzb1ktip.webp', 25.00, NULL, '2026-05-26 12:22:19.755716', NULL);
INSERT INTO public.product_items VALUES (48, 24, 'KHA-FIT-CAP-GRE-XXL', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/w8twfyggeboarzb1ktip.webp', 25.00, NULL, '2026-05-26 12:22:19.762056', NULL);
INSERT INTO public.product_items VALUES (52, 25, 'KHA-FIT-CAP-RED-XL', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/oa7tdsgygrw8bfmveblu.webp', 25.00, NULL, '2026-05-26 12:22:19.796713', NULL);
INSERT INTO public.product_items VALUES (53, 25, 'KHA-FIT-CAP-RED-XXL', 62, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798915/products/oa7tdsgygrw8bfmveblu.webp', 25.00, NULL, '2026-05-26 12:22:19.80342', NULL);
INSERT INTO public.product_items VALUES (58, 26, 'MES-TRU-CAP-BLA-XXL', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798916/products/o73emae6hrgjpndjaz9j.webp', 25.00, NULL, '2026-05-26 12:22:19.84557', NULL);
INSERT INTO public.product_items VALUES (62, 27, 'MES-TRU-CAP-BLU-XL', 145, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798917/products/cdaoe5mgkbj20d0ajq7a.webp', 25.00, NULL, '2026-05-26 12:22:19.882062', NULL);
INSERT INTO public.product_items VALUES (63, 27, 'MES-TRU-CAP-BLU-XXL', 93, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798917/products/cdaoe5mgkbj20d0ajq7a.webp', 25.00, NULL, '2026-05-26 12:22:19.890361', NULL);
INSERT INTO public.product_items VALUES (67, 28, 'MES-TRU-CAP-BRO-XL', 83, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/zntuzwfc1elf8kuarjxp.webp', 25.00, NULL, '2026-05-26 12:22:19.926622', NULL);
INSERT INTO public.product_items VALUES (68, 28, 'MES-TRU-CAP-BRO-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/zntuzwfc1elf8kuarjxp.webp', 25.00, NULL, '2026-05-26 12:22:19.934381', NULL);
INSERT INTO public.product_items VALUES (73, 29, 'MES-TRU-CAP-ORA-XXL', 120, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798918/products/vflsz6gnhp7jc5mlun28.webp', 25.00, NULL, '2026-05-26 12:22:19.976761', NULL);
INSERT INTO public.product_items VALUES (84, 32, 'PAC-BUC-HAT-GRA-S', 100, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798921/products/xgn10fhaqurgmit9mbx4.webp', 25.00, NULL, '2026-05-26 12:22:20.099773', NULL);
INSERT INTO public.product_items VALUES (85, 32, 'PAC-BUC-HAT-GRA-M', 138, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798921/products/xgn10fhaqurgmit9mbx4.webp', 25.00, NULL, '2026-05-26 12:22:20.108738', NULL);
INSERT INTO public.product_items VALUES (86, 32, 'PAC-BUC-HAT-GRA-L', 138, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798921/products/xgn10fhaqurgmit9mbx4.webp', 25.00, NULL, '2026-05-26 12:22:20.123841', NULL);
INSERT INTO public.product_items VALUES (87, 32, 'PAC-BUC-HAT-GRA-XL', 43, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798921/products/xgn10fhaqurgmit9mbx4.webp', 25.00, NULL, '2026-05-26 12:22:20.131606', NULL);
INSERT INTO public.product_items VALUES (88, 32, 'PAC-BUC-HAT-GRA-XXL', 101, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798921/products/xgn10fhaqurgmit9mbx4.webp', 25.00, NULL, '2026-05-26 12:22:20.14155', NULL);
INSERT INTO public.product_items VALUES (97, 34, 'AIR-ZIP-UP-HOO-BLU-XL', 80, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/mazy3ixm0zep7gimwxsh.webp', 65.00, NULL, '2026-05-26 12:22:20.230918', NULL);
INSERT INTO public.product_items VALUES (98, 34, 'AIR-ZIP-UP-HOO-BLU-XXL', 128, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/mazy3ixm0zep7gimwxsh.webp', 65.00, NULL, '2026-05-26 12:22:20.238037', NULL);
INSERT INTO public.product_items VALUES (103, 35, 'AIR-ZIP-UP-HOO-GRA-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798923/products/zit0zdnboemtlgcikwt3.webp', 65.00, NULL, '2026-05-26 12:22:20.279828', NULL);
INSERT INTO public.product_items VALUES (108, 36, 'EAS-HOO-BEI-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798924/products/dfitoxxptytvmvvkbnnt.webp', 65.00, NULL, '2026-05-26 12:22:20.318249', NULL);
INSERT INTO public.product_items VALUES (112, 37, 'EAS-HOO-BLU-XL', 33, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798925/products/nn58d4b3fuslxkny5gy6.webp', 65.00, NULL, '2026-05-26 12:22:20.351744', NULL);
INSERT INTO public.product_items VALUES (113, 37, 'EAS-HOO-BLU-XXL', 32, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798925/products/nn58d4b3fuslxkny5gy6.webp', 65.00, NULL, '2026-05-26 12:22:20.357644', NULL);
INSERT INTO public.product_items VALUES (117, 38, 'EAS-HOO-BRO-XL', 138, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/s3rxnpuri8jnk3thcmfj.webp', 65.00, NULL, '2026-05-26 12:22:20.390587', NULL);
INSERT INTO public.product_items VALUES (118, 38, 'EAS-HOO-BRO-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/s3rxnpuri8jnk3thcmfj.webp', 65.00, NULL, '2026-05-26 12:22:20.397054', NULL);
INSERT INTO public.product_items VALUES (127, 40, 'SLE-HOO-BEI-XL', 94, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798927/products/zndsvewaqjkvtjqubbox.webp', 65.00, NULL, '2026-05-26 12:22:20.472373', NULL);
INSERT INTO public.product_items VALUES (128, 40, 'SLE-HOO-BEI-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798927/products/zndsvewaqjkvtjqubbox.webp', 65.00, NULL, '2026-05-26 12:22:20.477705', NULL);
INSERT INTO public.product_items VALUES (132, 41, 'SLE-HOO-BLA-XL', 34, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798928/products/qdilacpfdxjcdkilxafp.webp', 65.00, NULL, '2026-05-26 12:22:20.513045', NULL);
INSERT INTO public.product_items VALUES (133, 41, 'SLE-HOO-BLA-XXL', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798928/products/qdilacpfdxjcdkilxafp.webp', 65.00, NULL, '2026-05-26 12:22:20.519848', NULL);
INSERT INTO public.product_items VALUES (138, 42, 'DUR-COR-BOM-JAC-BLU-XXL', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/dmu7bz7kxk17wcpy4avf.webp', 85.00, NULL, '2026-05-26 12:22:20.564472', NULL);
INSERT INTO public.product_items VALUES (145, 44, 'DUR-KHA-JAC-BLA-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798930/products/jthth4rmzcafj7iwdsyi.webp', 85.00, NULL, '2026-05-26 12:22:20.6316', NULL);
INSERT INTO public.product_items VALUES (146, 44, 'DUR-KHA-JAC-BLA-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798930/products/jthth4rmzcafj7iwdsyi.webp', 85.00, NULL, '2026-05-26 12:22:20.639351', NULL);
INSERT INTO public.product_items VALUES (147, 44, 'DUR-KHA-JAC-BLA-XL', 100, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798930/products/jthth4rmzcafj7iwdsyi.webp', 85.00, NULL, '2026-05-26 12:22:20.64611', NULL);
INSERT INTO public.product_items VALUES (148, 44, 'DUR-KHA-JAC-BLA-XXL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798930/products/jthth4rmzcafj7iwdsyi.webp', 85.00, NULL, '2026-05-26 12:22:20.65305', NULL);
INSERT INTO public.product_items VALUES (153, 45, 'DUR-KHA-JAC-BLU-XXL', 43, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798931/products/k6g5uu4o8bjedsfib6e8.webp', 85.00, NULL, '2026-05-26 12:22:20.694148', NULL);
INSERT INTO public.product_items VALUES (158, 46, 'DUR-KHA-JAC-WHI-XXL', 115, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798932/products/qxppcw9zu90j7xrxslpm.webp', 85.00, NULL, '2026-05-26 12:22:20.736193', NULL);
INSERT INTO public.product_items VALUES (162, 47, 'DUR-KHA-JAC-YEL-XL', 55, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798933/products/jxiziia6lga5pxtxb3r2.webp', 85.00, NULL, '2026-05-26 12:22:20.768261', NULL);
INSERT INTO public.product_items VALUES (163, 47, 'DUR-KHA-JAC-YEL-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798933/products/jxiziia6lga5pxtxb3r2.webp', 85.00, NULL, '2026-05-26 12:22:20.774916', NULL);
INSERT INTO public.product_items VALUES (168, 48, 'DUR-SUN-PRO-PAR-BEI-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/ky6fyrhpee50qjbmpo8m.webp', 85.00, NULL, '2026-05-26 12:22:20.808776', NULL);
INSERT INTO public.product_items VALUES (173, 49, 'DUR-SUN-PRO-PAR-BLA-XXL', 105, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798934/products/nha4nvzpvhoaamusk5ep.webp', 85.00, NULL, '2026-05-26 12:22:20.844497', NULL);
INSERT INTO public.product_items VALUES (178, 50, 'DUR-SUN-PRO-PAR-BRO-XXL', 135, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798935/products/ufb6wmelogqn7hgxvfus.webp', 85.00, NULL, '2026-05-26 12:22:20.88063', NULL);
INSERT INTO public.product_items VALUES (182, 51, 'EAS-COL-BLO-PAR-BLA-XL', 88, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798936/products/rvoqbrdxbbgkjdwnpx5f.webp', 85.00, NULL, '2026-05-26 12:22:20.909411', NULL);
INSERT INTO public.product_items VALUES (183, 51, 'EAS-COL-BLO-PAR-BLA-XXL', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798936/products/rvoqbrdxbbgkjdwnpx5f.webp', 85.00, NULL, '2026-05-26 12:22:20.914157', NULL);
INSERT INTO public.product_items VALUES (188, 52, 'EAS-COL-BLO-PAR-BRO--XXL', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/vialy5narx02elliyapr.webp', 85.00, NULL, '2026-05-26 12:22:20.947871', NULL);
INSERT INTO public.product_items VALUES (198, 54, 'AIR-PAN-BLA-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798939/products/x4jw2gsuqc9tlra0r54c.webp', 55.00, NULL, '2026-05-26 12:22:21.011976', NULL);
INSERT INTO public.product_items VALUES (206, 56, 'BEG-PAR-JOG-GRE-L', 90, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ax4vsno4etyflwv4vlqw.webp', 55.00, NULL, '2026-05-26 12:22:21.064682', NULL);
INSERT INTO public.product_items VALUES (207, 56, 'BEG-PAR-JOG-GRE-XL', 80, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ax4vsno4etyflwv4vlqw.webp', 55.00, NULL, '2026-05-26 12:22:21.071146', NULL);
INSERT INTO public.product_items VALUES (208, 56, 'BEG-PAR-JOG-GRE-XXL', 95, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ax4vsno4etyflwv4vlqw.webp', 55.00, NULL, '2026-05-26 12:22:21.076514', NULL);
INSERT INTO public.product_items VALUES (223, 59, 'DUR-BAG-JEA-NAV-XXL', 18, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798943/products/e5caoxoibsbyth3wop6v.webp', 55.00, NULL, '2026-05-26 12:22:21.173677', NULL);
INSERT INTO public.product_items VALUES (233, 61, 'DUR-ELE-TRO-BRO-XXL', 65, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/vbqsixu3syfbncypntc3.webp', 55.00, NULL, '2026-05-26 12:22:21.249642', NULL);
INSERT INTO public.product_items VALUES (237, 62, 'DUR-WID-LEG-KHA-PAN--XL', 89, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/jwpx6e4vdbyvmaatnbbx.webp', 55.00, NULL, '2026-05-26 12:22:21.281759', NULL);
INSERT INTO public.product_items VALUES (238, 62, 'DUR-WID-LEG-KHA-PAN--XXL', 40, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798945/products/jwpx6e4vdbyvmaatnbbx.webp', 55.00, NULL, '2026-05-26 12:22:21.286846', NULL);
INSERT INTO public.product_items VALUES (247, 64, 'FLE-JEA-BRO-XL', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798947/products/nragfjefaig4kofmybik.webp', 55.00, NULL, '2026-05-26 12:22:21.344892', NULL);
INSERT INTO public.product_items VALUES (248, 64, 'FLE-JEA-BRO-XXL', 141, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798947/products/nragfjefaig4kofmybik.webp', 55.00, NULL, '2026-05-26 12:22:21.35016', NULL);
INSERT INTO public.product_items VALUES (252, 65, 'FLE-JEA-DAR-BRO-XL', 83, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798948/products/iessav8wxdcww4yteyv2.webp', 55.00, NULL, '2026-05-26 12:22:21.376972', NULL);
INSERT INTO public.product_items VALUES (253, 65, 'FLE-JEA-DAR-BRO-XXL', 134, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798948/products/iessav8wxdcww4yteyv2.webp', 55.00, NULL, '2026-05-26 12:22:21.383504', NULL);
INSERT INTO public.product_items VALUES (261, 67, 'FLE-JEA-WHI-L', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/muxa6kvmrri6dnodmkny.webp', 55.00, NULL, '2026-05-26 12:22:21.434602', NULL);
INSERT INTO public.product_items VALUES (262, 67, 'FLE-JEA-WHI-XL', 89, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/muxa6kvmrri6dnodmkny.webp', 55.00, NULL, '2026-05-26 12:22:21.439578', NULL);
INSERT INTO public.product_items VALUES (263, 67, 'FLE-JEA-WHI-XXL', 58, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/muxa6kvmrri6dnodmkny.webp', 55.00, NULL, '2026-05-26 12:22:21.443988', NULL);
INSERT INTO public.product_items VALUES (266, 68, 'SCU-CLO-JOG-GRA-L', 138, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/ydqihzjhovmqipkfl8ea.webp', 55.00, NULL, '2026-05-26 12:22:21.46354', NULL);
INSERT INTO public.product_items VALUES (267, 68, 'SCU-CLO-JOG-GRA-XL', 76, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/ydqihzjhovmqipkfl8ea.webp', 55.00, NULL, '2026-05-26 12:22:21.468669', NULL);
INSERT INTO public.product_items VALUES (268, 68, 'SCU-CLO-JOG-GRA-XXL', 121, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798950/products/ydqihzjhovmqipkfl8ea.webp', 55.00, NULL, '2026-05-26 12:22:21.47411', NULL);
INSERT INTO public.product_items VALUES (277, 70, 'THE-MIN-KHA-PAN-BLA-XL', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798952/products/hferrn1i4r4umjqhsf0i.webp', 55.00, NULL, '2026-05-26 12:22:21.532196', NULL);
INSERT INTO public.product_items VALUES (278, 70, 'THE-MIN-KHA-PAN-BLA-XXL', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798952/products/hferrn1i4r4umjqhsf0i.webp', 55.00, NULL, '2026-05-26 12:22:21.538867', NULL);
INSERT INTO public.product_items VALUES (283, 71, 'DUR-CLA-COR-SHO-SLE--XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-05-26 12:22:21.5731', NULL);
INSERT INTO public.product_items VALUES (293, 75, 'DUR-DEN-OVE-DAR-BLU-XXL', 5, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798954/products/zl5mlbfovjnys3u0oh6s.webp', 45.00, NULL, '2026-05-26 12:22:21.675904', NULL);
INSERT INTO public.product_items VALUES (298, 76, 'DUR-DEN-OVE-LIG-BLU-XXL', 28, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798955/products/t2asqixho9lmniilxkzi.webp', 45.00, NULL, '2026-05-26 12:22:21.710233', NULL);
INSERT INTO public.product_items VALUES (303, 77, 'DUR-WAS-KHA-OVE-BEI-XXL', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798956/products/rzuvlcdohzsg3us7apw5.webp', 45.00, NULL, '2026-05-26 12:22:21.743825', NULL);
INSERT INTO public.product_items VALUES (308, 78, 'DUR-WAS-KHA-OVE-GRA-XXL', 94, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798958/products/sk18gwvbswto50hygrs1.webp', 45.00, NULL, '2026-05-26 12:22:21.778417', NULL);
INSERT INTO public.product_items VALUES (313, 79, 'EAS-BOX-SHO-SLE-OXF--XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-05-26 12:22:21.812495', NULL);
INSERT INTO public.product_items VALUES (316, 83, 'CLO-MIC-SWE-BEI-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798960/products/ptwwrlzcp8el4yj1qp1l.webp', 59.00, NULL, '2026-05-26 12:22:21.884496', NULL);
INSERT INTO public.product_items VALUES (317, 83, 'CLO-MIC-SWE-BEI-XL', 49, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798960/products/ptwwrlzcp8el4yj1qp1l.webp', 59.00, NULL, '2026-05-26 12:22:21.890507', NULL);
INSERT INTO public.product_items VALUES (318, 83, 'CLO-MIC-SWE-BEI-XXL', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798960/products/ptwwrlzcp8el4yj1qp1l.webp', 59.00, NULL, '2026-05-26 12:22:21.895918', NULL);
INSERT INTO public.product_items VALUES (328, 85, 'CLO-MIC-SWE-BRO-XXL', 97, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/utq9t6jbxnvtdvava5hf.webp', 59.00, NULL, '2026-05-26 12:22:21.967088', NULL);
INSERT INTO public.product_items VALUES (338, 87, 'COT-POL-SWE-BLA-WHI-XXL', 123, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798963/products/xd3axi8tnf9znfoiu9jm.webp', 59.00, NULL, '2026-05-26 12:22:22.037387', NULL);
INSERT INTO public.product_items VALUES (343, 88, 'COT-POL-SWE-BRO-BEI-XXL', 91, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798964/products/fwiaa8b1nwnvqjs3acba.webp', 59.00, NULL, '2026-05-26 12:22:22.077051', NULL);
INSERT INTO public.product_items VALUES (347, 89, 'COT-POL-SWE-RED-BEI-XL', 20, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798965/products/pjcnlmkamcshjzco1zsf.webp', 59.00, NULL, '2026-05-26 12:22:22.110706', NULL);
INSERT INTO public.product_items VALUES (348, 89, 'COT-POL-SWE-RED-BEI-XXL', 136, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798965/products/pjcnlmkamcshjzco1zsf.webp', 59.00, NULL, '2026-05-26 12:22:22.117863', NULL);
INSERT INTO public.product_items VALUES (357, 91, 'COT-SWE-BRO-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/bjqxi12bqkdcsb0w9iyp.webp', 59.00, NULL, '2026-05-26 12:22:22.193023', NULL);
INSERT INTO public.product_items VALUES (358, 91, 'COT-SWE-BRO-XXL', 60, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/bjqxi12bqkdcsb0w9iyp.webp', 59.00, NULL, '2026-05-26 12:22:22.19751', NULL);
INSERT INTO public.product_items VALUES (363, 92, 'LON-SLE-SWE-BLA-XXL', 143, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798967/products/swxd44aygxkhlzsby27o.webp', 59.00, NULL, '2026-05-26 12:22:22.232424', NULL);
INSERT INTO public.product_items VALUES (367, 93, 'LON-SLE-SWE-BLU-XL', 61, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798968/products/t7b9mr7gahxb5cbwvxve.webp', 59.00, NULL, '2026-05-26 12:22:22.260542', NULL);
INSERT INTO public.product_items VALUES (368, 93, 'LON-SLE-SWE-BLU-XXL', 138, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798968/products/t7b9mr7gahxb5cbwvxve.webp', 59.00, NULL, '2026-05-26 12:22:22.264798', NULL);
INSERT INTO public.product_items VALUES (373, 94, 'LON-SLE-SWE-WHI-XXL', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/wclyfsganpq5mrbauogd.webp', 59.00, NULL, '2026-05-26 12:22:22.301561', NULL);
INSERT INTO public.product_items VALUES (375, 95, 'ZIP-NEC-POL-SWE-GRA-M', 132, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/f2kwurkl5jo7uwinbblg.webp', 59.00, NULL, '2026-05-26 12:22:22.319168', NULL);
INSERT INTO public.product_items VALUES (377, 95, 'ZIP-NEC-POL-SWE-GRA-XL', 100, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/f2kwurkl5jo7uwinbblg.webp', 59.00, NULL, '2026-05-26 12:22:22.328526', NULL);
INSERT INTO public.product_items VALUES (378, 95, 'ZIP-NEC-POL-SWE-GRA-XXL', 33, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/f2kwurkl5jo7uwinbblg.webp', 59.00, NULL, '2026-05-26 12:22:22.334145', NULL);
INSERT INTO public.product_items VALUES (382, 96, 'BOX-RAG-T-SHI-BEI-XL', 63, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798970/products/knamwsasogb8ocpyjlpa.webp', 35.00, NULL, '2026-05-26 12:22:22.363883', NULL);
INSERT INTO public.product_items VALUES (383, 96, 'BOX-RAG-T-SHI-BEI-XXL', 118, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798970/products/knamwsasogb8ocpyjlpa.webp', 35.00, NULL, '2026-05-26 12:22:22.369275', NULL);
INSERT INTO public.product_items VALUES (387, 97, 'BOX-RAG-T-SHI-BRO-XL', 30, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798971/products/pdeaj2jpxnapeae1tg1j.webp', 35.00, NULL, '2026-05-26 12:22:22.395936', NULL);
INSERT INTO public.product_items VALUES (388, 97, 'BOX-RAG-T-SHI-BRO-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798971/products/pdeaj2jpxnapeae1tg1j.webp', 35.00, NULL, '2026-05-26 12:22:22.401112', NULL);
INSERT INTO public.product_items VALUES (393, 98, 'BOX-RAG-T-SHI-GRA-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798972/products/karaxe9ybvoafbqcxvfb.webp', 35.00, NULL, '2026-05-26 12:22:22.435276', NULL);
INSERT INTO public.product_items VALUES (397, 99, 'BOX-RAG-T-SHI-GRE-XL', 133, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798973/products/ckx1qh2bgy22lxrdficy.webp', 35.00, NULL, '2026-05-26 12:22:22.459106', NULL);
INSERT INTO public.product_items VALUES (398, 99, 'BOX-RAG-T-SHI-GRE-XXL', 82, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798973/products/ckx1qh2bgy22lxrdficy.webp', 35.00, NULL, '2026-05-26 12:22:22.464016', NULL);
INSERT INTO public.product_items VALUES (403, 100, 'EAS-T-SHI-BEI-XXL', 109, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/jr5lnpsx5yicncaa3rhn.webp', 35.00, NULL, '2026-05-26 12:22:22.494156', NULL);
INSERT INTO public.product_items VALUES (408, 101, 'EAS-T-SHI-BLA-XXL', 72, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798974/products/fb4z3qipg6gwvj47hbeo.webp', 35.00, NULL, '2026-05-26 12:22:22.525944', NULL);
INSERT INTO public.product_items VALUES (412, 102, 'EAS-T-SHI-WHI-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798975/products/pzcavlsnvtdf3titpm4x.webp', 35.00, NULL, '2026-05-26 12:22:22.553456', NULL);
INSERT INTO public.product_items VALUES (413, 102, 'EAS-T-SHI-WHI-XXL', 38, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798975/products/pzcavlsnvtdf3titpm4x.webp', 35.00, NULL, '2026-05-26 12:22:22.557992', NULL);
INSERT INTO public.product_items VALUES (418, 103, 'FLE-T-SHI-BLA-XXL', 74, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798976/products/xbtfsh6vnw7zxnk1pqtk.webp', 35.00, NULL, '2026-05-26 12:22:22.588888', NULL);
INSERT INTO public.product_items VALUES (422, 104, 'FLE-T-SHI-BLU-XL', 104, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798977/products/agalabg30250pym1owe9.webp', 35.00, NULL, '2026-05-26 12:22:22.613917', NULL);
INSERT INTO public.product_items VALUES (423, 104, 'FLE-T-SHI-BLU-XXL', 36, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798977/products/agalabg30250pym1owe9.webp', 35.00, NULL, '2026-05-26 12:22:22.620718', NULL);
INSERT INTO public.product_items VALUES (428, 105, 'FLE-T-SHI-GRA-XXL', 86, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/gibiswuhhsmptss91tab.webp', 35.00, NULL, '2026-05-26 12:22:22.657177', NULL);
INSERT INTO public.product_items VALUES (432, 106, 'FLE-T-SHI-WHI-XL', 83, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/e8ofmgh2civfenhjxqvv.webp', 35.00, NULL, '2026-05-26 12:22:22.686018', NULL);
INSERT INTO public.product_items VALUES (433, 106, 'FLE-T-SHI-WHI-XXL', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798978/products/e8ofmgh2civfenhjxqvv.webp', 35.00, NULL, '2026-05-26 12:22:22.692287', NULL);
INSERT INTO public.product_items VALUES (457, 111, 'DIS-FRI-ROU-KEY-XL', 46, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/vewf3eic9eatga1dufvn.jpg', 15.00, NULL, '2026-05-27 06:09:58.427909', NULL);
INSERT INTO public.product_items VALUES (459, 112, 'T1-3-IN-1-WIR-CHA-S', 74, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862198/products/hmfknato0vkda2p3k2vb.jpg', 15.00, NULL, '2026-05-27 06:09:59.451672', NULL);
INSERT INTO public.product_items VALUES (460, 112, 'T1-3-IN-1-WIR-CHA-M', 143, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862198/products/hmfknato0vkda2p3k2vb.jpg', 15.00, NULL, '2026-05-27 06:09:59.456473', NULL);
INSERT INTO public.product_items VALUES (461, 112, 'T1-3-IN-1-WIR-CHA-L', 44, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862198/products/hmfknato0vkda2p3k2vb.jpg', 15.00, NULL, '2026-05-27 06:09:59.461438', NULL);
INSERT INTO public.product_items VALUES (462, 112, 'T1-3-IN-1-WIR-CHA-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862198/products/hmfknato0vkda2p3k2vb.jpg', 15.00, NULL, '2026-05-27 06:09:59.465215', NULL);
INSERT INTO public.product_items VALUES (463, 112, 'T1-3-IN-1-WIR-CHA-XXL', 109, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862198/products/hmfknato0vkda2p3k2vb.jpg', 15.00, NULL, '2026-05-27 06:09:59.468839', NULL);
INSERT INTO public.product_items VALUES (464, 113, 'T1-ANI-FRI-FIG-KEY-S', 82, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862199/products/lwm5rngw0tliegm6swnf.jpg', 15.00, NULL, '2026-05-27 06:10:00.489246', NULL);
INSERT INTO public.product_items VALUES (465, 113, 'T1-ANI-FRI-FIG-KEY-M', 58, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862199/products/lwm5rngw0tliegm6swnf.jpg', 15.00, NULL, '2026-05-27 06:10:00.494473', NULL);
INSERT INTO public.product_items VALUES (466, 113, 'T1-ANI-FRI-FIG-KEY-L', 60, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862199/products/lwm5rngw0tliegm6swnf.jpg', 15.00, NULL, '2026-05-27 06:10:00.498914', NULL);
INSERT INTO public.product_items VALUES (467, 113, 'T1-ANI-FRI-FIG-KEY-XL', 61, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862199/products/lwm5rngw0tliegm6swnf.jpg', 15.00, NULL, '2026-05-27 06:10:00.503893', NULL);
INSERT INTO public.product_items VALUES (468, 113, 'T1-ANI-FRI-FIG-KEY-XXL', 51, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862199/products/lwm5rngw0tliegm6swnf.jpg', 15.00, NULL, '2026-05-27 06:10:00.510453', NULL);
INSERT INTO public.product_items VALUES (469, 114, 'T1-ANI-FRI-TIC-HOL-S', 87, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862200/products/n0spztv5ecjk6xkozxmb.jpg', 15.00, NULL, '2026-05-27 06:10:01.310773', NULL);
INSERT INTO public.product_items VALUES (470, 114, 'T1-ANI-FRI-TIC-HOL-M', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862200/products/n0spztv5ecjk6xkozxmb.jpg', 15.00, NULL, '2026-05-27 06:10:01.316263', NULL);
INSERT INTO public.product_items VALUES (471, 114, 'T1-ANI-FRI-TIC-HOL-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862200/products/n0spztv5ecjk6xkozxmb.jpg', 15.00, NULL, '2026-05-27 06:10:01.321108', NULL);
INSERT INTO public.product_items VALUES (472, 114, 'T1-ANI-FRI-TIC-HOL-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862200/products/n0spztv5ecjk6xkozxmb.jpg', 15.00, NULL, '2026-05-27 06:10:01.326704', NULL);
INSERT INTO public.product_items VALUES (473, 114, 'T1-ANI-FRI-TIC-HOL-XXL', 118, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862200/products/n0spztv5ecjk6xkozxmb.jpg', 15.00, NULL, '2026-05-27 06:10:01.330971', NULL);
INSERT INTO public.product_items VALUES (474, 115, 'T1-ATI-BEA-TOW-S', 147, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862201/products/v552g86m70gbjcelyhdf.jpg', 15.00, NULL, '2026-05-27 06:10:02.304801', NULL);
INSERT INTO public.product_items VALUES (475, 115, 'T1-ATI-BEA-TOW-M', 89, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862201/products/v552g86m70gbjcelyhdf.jpg', 15.00, NULL, '2026-05-27 06:10:02.312077', NULL);
INSERT INTO public.product_items VALUES (476, 115, 'T1-ATI-BEA-TOW-L', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862201/products/v552g86m70gbjcelyhdf.jpg', 15.00, NULL, '2026-05-27 06:10:02.317183', NULL);
INSERT INTO public.product_items VALUES (477, 115, 'T1-ATI-BEA-TOW-XL', 63, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862201/products/v552g86m70gbjcelyhdf.jpg', 15.00, NULL, '2026-05-27 06:10:02.324046', NULL);
INSERT INTO public.product_items VALUES (478, 115, 'T1-ATI-BEA-TOW-XXL', 142, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862201/products/v552g86m70gbjcelyhdf.jpg', 15.00, NULL, '2026-05-27 06:10:02.32986', NULL);
INSERT INTO public.product_items VALUES (479, 116, 'T1-ATI-REU-BAG-S', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862202/products/f4dflgu5rhwvtxmrqzun.jpg', 15.00, NULL, '2026-05-27 06:10:03.294681', NULL);
INSERT INTO public.product_items VALUES (480, 116, 'T1-ATI-REU-BAG-M', 132, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862202/products/f4dflgu5rhwvtxmrqzun.jpg', 15.00, NULL, '2026-05-27 06:10:03.299285', NULL);
INSERT INTO public.product_items VALUES (481, 116, 'T1-ATI-REU-BAG-L', 122, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862202/products/f4dflgu5rhwvtxmrqzun.jpg', 15.00, NULL, '2026-05-27 06:10:03.302775', NULL);
INSERT INTO public.product_items VALUES (482, 116, 'T1-ATI-REU-BAG-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862202/products/f4dflgu5rhwvtxmrqzun.jpg', 15.00, NULL, '2026-05-27 06:10:03.307425', NULL);
INSERT INTO public.product_items VALUES (483, 116, 'T1-ATI-REU-BAG-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862202/products/f4dflgu5rhwvtxmrqzun.jpg', 15.00, NULL, '2026-05-27 06:10:03.313247', NULL);
INSERT INTO public.product_items VALUES (484, 117, 'T1-DOC-POW-BAN-500-S', 139, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862203/products/imv76yx0wavzniyksu57.jpg', 15.00, NULL, '2026-05-27 06:10:04.36132', NULL);
INSERT INTO public.product_items VALUES (485, 117, 'T1-DOC-POW-BAN-500-M', 27, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862203/products/imv76yx0wavzniyksu57.jpg', 15.00, NULL, '2026-05-27 06:10:04.366083', NULL);
INSERT INTO public.product_items VALUES (486, 117, 'T1-DOC-POW-BAN-500-L', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862203/products/imv76yx0wavzniyksu57.jpg', 15.00, NULL, '2026-05-27 06:10:04.370693', NULL);
INSERT INTO public.product_items VALUES (487, 117, 'T1-DOC-POW-BAN-500-XL', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862203/products/imv76yx0wavzniyksu57.jpg', 15.00, NULL, '2026-05-27 06:10:04.376309', NULL);
INSERT INTO public.product_items VALUES (488, 117, 'T1-DOC-POW-BAN-500-XXL', 71, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862203/products/imv76yx0wavzniyksu57.jpg', 15.00, NULL, '2026-05-27 06:10:04.381475', NULL);
INSERT INTO public.product_items VALUES (489, 118, 'T1-EYE-MAS-S', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862204/products/dymchtattko7ygof0exj.jpg', 15.00, NULL, '2026-05-27 06:10:05.269003', NULL);
INSERT INTO public.product_items VALUES (490, 118, 'T1-EYE-MAS-M', 56, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862204/products/dymchtattko7ygof0exj.jpg', 15.00, NULL, '2026-05-27 06:10:05.273583', NULL);
INSERT INTO public.product_items VALUES (491, 118, 'T1-EYE-MAS-L', 148, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862204/products/dymchtattko7ygof0exj.jpg', 15.00, NULL, '2026-05-27 06:10:05.280162', NULL);
INSERT INTO public.product_items VALUES (492, 118, 'T1-EYE-MAS-XL', 136, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862204/products/dymchtattko7ygof0exj.jpg', 15.00, NULL, '2026-05-27 06:10:05.284615', NULL);
INSERT INTO public.product_items VALUES (493, 118, 'T1-EYE-MAS-XXL', 87, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862204/products/dymchtattko7ygof0exj.jpg', 15.00, NULL, '2026-05-27 06:10:05.288764', NULL);
INSERT INTO public.product_items VALUES (494, 119, 'T1-LOG-ECO-BAG-S', 41, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862205/products/twc55irnedzzizme1rf0.jpg', 15.00, NULL, '2026-05-27 06:10:06.058618', NULL);
INSERT INTO public.product_items VALUES (495, 119, 'T1-LOG-ECO-BAG-M', 24, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862205/products/twc55irnedzzizme1rf0.jpg', 15.00, NULL, '2026-05-27 06:10:06.065812', NULL);
INSERT INTO public.product_items VALUES (496, 119, 'T1-LOG-ECO-BAG-L', 92, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862205/products/twc55irnedzzizme1rf0.jpg', 15.00, NULL, '2026-05-27 06:10:06.070098', NULL);
INSERT INTO public.product_items VALUES (497, 119, 'T1-LOG-ECO-BAG-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862205/products/twc55irnedzzizme1rf0.jpg', 15.00, NULL, '2026-05-27 06:10:06.07587', NULL);
INSERT INTO public.product_items VALUES (498, 119, 'T1-LOG-ECO-BAG-XXL', 64, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862205/products/twc55irnedzzizme1rf0.jpg', 15.00, NULL, '2026-05-27 06:10:06.081051', NULL);
INSERT INTO public.product_items VALUES (499, 120, 'T1-LOG-LED-KEY-KEY-S', 64, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862206/products/zc1abuoljlngx5z4bxqn.jpg', 15.00, NULL, '2026-05-27 06:10:07.068871', NULL);
INSERT INTO public.product_items VALUES (500, 120, 'T1-LOG-LED-KEY-KEY-M', 63, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862206/products/zc1abuoljlngx5z4bxqn.jpg', 15.00, NULL, '2026-05-27 06:10:07.07622', NULL);
INSERT INTO public.product_items VALUES (501, 120, 'T1-LOG-LED-KEY-KEY-L', 47, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862206/products/zc1abuoljlngx5z4bxqn.jpg', 15.00, NULL, '2026-05-27 06:10:07.083527', NULL);
INSERT INTO public.product_items VALUES (502, 120, 'T1-LOG-LED-KEY-KEY-XL', 89, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862206/products/zc1abuoljlngx5z4bxqn.jpg', 15.00, NULL, '2026-05-27 06:10:07.08962', NULL);
INSERT INTO public.product_items VALUES (503, 120, 'T1-LOG-LED-KEY-KEY-XXL', 96, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862206/products/zc1abuoljlngx5z4bxqn.jpg', 15.00, NULL, '2026-05-27 06:10:07.09568', NULL);
INSERT INTO public.product_items VALUES (504, 121, 'LOL-202-T1-PLA-ACR-F-S', 85, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862207/products/r5l8nqxc2mzcxjx07obf.jpg', 15.00, NULL, '2026-05-27 06:10:08.184742', NULL);
INSERT INTO public.product_items VALUES (505, 121, 'LOL-202-T1-PLA-ACR-F-M', 81, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862207/products/r5l8nqxc2mzcxjx07obf.jpg', 15.00, NULL, '2026-05-27 06:10:08.190776', NULL);
INSERT INTO public.product_items VALUES (506, 121, 'LOL-202-T1-PLA-ACR-F-L', 72, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862207/products/r5l8nqxc2mzcxjx07obf.jpg', 15.00, NULL, '2026-05-27 06:10:08.197671', NULL);
INSERT INTO public.product_items VALUES (507, 121, 'LOL-202-T1-PLA-ACR-F-XL', 119, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862207/products/r5l8nqxc2mzcxjx07obf.jpg', 15.00, NULL, '2026-05-27 06:10:08.202081', NULL);
INSERT INTO public.product_items VALUES (508, 121, 'LOL-202-T1-PLA-ACR-F-XXL', 41, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862207/products/r5l8nqxc2mzcxjx07obf.jpg', 15.00, NULL, '2026-05-27 06:10:08.207171', NULL);
INSERT INTO public.product_items VALUES (514, 123, 'DIS-TOG-BAL-CAP-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862210/products/ctzsvu0y1zrca5ngoz4b.jpg', 25.00, NULL, '2026-05-27 06:10:10.494275', NULL);
INSERT INTO public.product_items VALUES (515, 123, 'DIS-TOG-BAL-CAP-M', 22, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862210/products/ctzsvu0y1zrca5ngoz4b.jpg', 25.00, NULL, '2026-05-27 06:10:10.499344', NULL);
INSERT INTO public.product_items VALUES (516, 123, 'DIS-TOG-BAL-CAP-L', 28, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862210/products/ctzsvu0y1zrca5ngoz4b.jpg', 25.00, NULL, '2026-05-27 06:10:10.504898', NULL);
INSERT INTO public.product_items VALUES (517, 123, 'DIS-TOG-BAL-CAP-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862210/products/ctzsvu0y1zrca5ngoz4b.jpg', 25.00, NULL, '2026-05-27 06:10:10.512097', NULL);
INSERT INTO public.product_items VALUES (518, 123, 'DIS-TOG-BAL-CAP-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862210/products/ctzsvu0y1zrca5ngoz4b.jpg', 25.00, NULL, '2026-05-27 06:10:10.517064', NULL);
INSERT INTO public.product_items VALUES (519, 124, 'AIR-FOR-1-07-SE-VAL--S', 75, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862676/products/xbsb0dzkdvnx8eesetqs.avif', 95.00, NULL, '2026-05-27 06:17:57.131441', NULL);
INSERT INTO public.product_items VALUES (520, 124, 'AIR-FOR-1-07-SE-VAL--M', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862676/products/xbsb0dzkdvnx8eesetqs.avif', 95.00, NULL, '2026-05-27 06:17:57.139841', NULL);
INSERT INTO public.product_items VALUES (521, 124, 'AIR-FOR-1-07-SE-VAL--L', 97, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862676/products/xbsb0dzkdvnx8eesetqs.avif', 95.00, NULL, '2026-05-27 06:17:57.145133', NULL);
INSERT INTO public.product_items VALUES (522, 124, 'AIR-FOR-1-07-SE-VAL--XL', 117, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862676/products/xbsb0dzkdvnx8eesetqs.avif', 95.00, NULL, '2026-05-27 06:17:57.152162', NULL);
INSERT INTO public.product_items VALUES (523, 124, 'AIR-FOR-1-07-SE-VAL--XXL', 143, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862676/products/xbsb0dzkdvnx8eesetqs.avif', 95.00, NULL, '2026-05-27 06:17:57.157764', NULL);
INSERT INTO public.product_items VALUES (524, 125, 'AIR-JOR-1-LOW-G-SPI-S', 141, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862677/products/tvuwgi4rpixkjwdb4oqj.avif', 95.00, NULL, '2026-05-27 06:17:57.910607', NULL);
INSERT INTO public.product_items VALUES (525, 125, 'AIR-JOR-1-LOW-G-SPI-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862677/products/tvuwgi4rpixkjwdb4oqj.avif', 95.00, NULL, '2026-05-27 06:17:57.91392', NULL);
INSERT INTO public.product_items VALUES (526, 125, 'AIR-JOR-1-LOW-G-SPI-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862677/products/tvuwgi4rpixkjwdb4oqj.avif', 95.00, NULL, '2026-05-27 06:17:57.918772', NULL);
INSERT INTO public.product_items VALUES (527, 125, 'AIR-JOR-1-LOW-G-SPI-XL', 52, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862677/products/tvuwgi4rpixkjwdb4oqj.avif', 95.00, NULL, '2026-05-27 06:17:57.924453', NULL);
INSERT INTO public.product_items VALUES (528, 125, 'AIR-JOR-1-LOW-G-SPI-XXL', 124, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862677/products/tvuwgi4rpixkjwdb4oqj.avif', 95.00, NULL, '2026-05-27 06:17:57.929387', NULL);
INSERT INTO public.product_items VALUES (529, 126, 'AIR-JOR-1-LOW-SE-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862678/products/fn1g5urrwvxgrhusk1tq.avif', 95.00, NULL, '2026-05-27 06:17:58.840331', NULL);
INSERT INTO public.product_items VALUES (530, 126, 'AIR-JOR-1-LOW-SE-M', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862678/products/fn1g5urrwvxgrhusk1tq.avif', 95.00, NULL, '2026-05-27 06:17:58.843604', NULL);
INSERT INTO public.product_items VALUES (531, 126, 'AIR-JOR-1-LOW-SE-L', 135, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862678/products/fn1g5urrwvxgrhusk1tq.avif', 95.00, NULL, '2026-05-27 06:17:58.84631', NULL);
INSERT INTO public.product_items VALUES (532, 126, 'AIR-JOR-1-LOW-SE-XL', 148, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862678/products/fn1g5urrwvxgrhusk1tq.avif', 95.00, NULL, '2026-05-27 06:17:58.850379', NULL);
INSERT INTO public.product_items VALUES (533, 126, 'AIR-JOR-1-LOW-SE-XXL', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862678/products/fn1g5urrwvxgrhusk1tq.avif', 95.00, NULL, '2026-05-27 06:17:58.854673', NULL);
INSERT INTO public.product_items VALUES (534, 127, 'BOO-2-RIS-EP-S', 40, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862679/products/muixjxuvess0fm5es4xa.avif', 95.00, NULL, '2026-05-27 06:17:59.784786', NULL);
INSERT INTO public.product_items VALUES (535, 127, 'BOO-2-RIS-EP-M', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862679/products/muixjxuvess0fm5es4xa.avif', 95.00, NULL, '2026-05-27 06:17:59.788286', NULL);
INSERT INTO public.product_items VALUES (536, 127, 'BOO-2-RIS-EP-L', 96, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862679/products/muixjxuvess0fm5es4xa.avif', 95.00, NULL, '2026-05-27 06:17:59.791172', NULL);
INSERT INTO public.product_items VALUES (537, 127, 'BOO-2-RIS-EP-XL', 129, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862679/products/muixjxuvess0fm5es4xa.avif', 95.00, NULL, '2026-05-27 06:17:59.795013', NULL);
INSERT INTO public.product_items VALUES (538, 127, 'BOO-2-RIS-EP-XXL', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862679/products/muixjxuvess0fm5es4xa.avif', 95.00, NULL, '2026-05-27 06:17:59.797652', NULL);
INSERT INTO public.product_items VALUES (539, 128, 'JOR-FRA-DAY-23-S', 113, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862680/products/abn9kmbpf03zymz4stde.avif', 95.00, NULL, '2026-05-27 06:18:00.713763', NULL);
INSERT INTO public.product_items VALUES (540, 128, 'JOR-FRA-DAY-23-M', 119, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862680/products/abn9kmbpf03zymz4stde.avif', 95.00, NULL, '2026-05-27 06:18:00.71793', NULL);
INSERT INTO public.product_items VALUES (541, 128, 'JOR-FRA-DAY-23-L', 54, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862680/products/abn9kmbpf03zymz4stde.avif', 95.00, NULL, '2026-05-27 06:18:00.722327', NULL);
INSERT INTO public.product_items VALUES (542, 128, 'JOR-FRA-DAY-23-XL', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862680/products/abn9kmbpf03zymz4stde.avif', 95.00, NULL, '2026-05-27 06:18:00.726631', NULL);
INSERT INTO public.product_items VALUES (543, 128, 'JOR-FRA-DAY-23-XXL', 113, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862680/products/abn9kmbpf03zymz4stde.avif', 95.00, NULL, '2026-05-27 06:18:00.730485', NULL);
INSERT INTO public.product_items VALUES (544, 129, 'JOR-FRA-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862681/products/do6lnpkeihsrzes4am6k.avif', 95.00, NULL, '2026-05-27 06:18:02.389299', NULL);
INSERT INTO public.product_items VALUES (545, 129, 'JOR-FRA-M', 37, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862681/products/do6lnpkeihsrzes4am6k.avif', 95.00, NULL, '2026-05-27 06:18:02.395831', NULL);
INSERT INTO public.product_items VALUES (546, 129, 'JOR-FRA-L', 123, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862681/products/do6lnpkeihsrzes4am6k.avif', 95.00, NULL, '2026-05-27 06:18:02.401861', NULL);
INSERT INTO public.product_items VALUES (547, 129, 'JOR-FRA-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862681/products/do6lnpkeihsrzes4am6k.avif', 95.00, NULL, '2026-05-27 06:18:02.407989', NULL);
INSERT INTO public.product_items VALUES (548, 129, 'JOR-FRA-XXL', 58, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862681/products/do6lnpkeihsrzes4am6k.avif', 95.00, NULL, '2026-05-27 06:18:02.413914', NULL);
INSERT INTO public.product_items VALUES (549, 130, 'NIK-AIR-FOR-1-07-S', 17, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862682/products/cb8txxw6qzdzqi0a8zye.avif', 95.00, NULL, '2026-05-27 06:18:03.58224', NULL);
INSERT INTO public.product_items VALUES (550, 130, 'NIK-AIR-FOR-1-07-M', 130, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862682/products/cb8txxw6qzdzqi0a8zye.avif', 95.00, NULL, '2026-05-27 06:18:03.587776', NULL);
INSERT INTO public.product_items VALUES (551, 130, 'NIK-AIR-FOR-1-07-L', 140, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862682/products/cb8txxw6qzdzqi0a8zye.avif', 95.00, NULL, '2026-05-27 06:18:03.594034', NULL);
INSERT INTO public.product_items VALUES (552, 130, 'NIK-AIR-FOR-1-07-XL', 35, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862682/products/cb8txxw6qzdzqi0a8zye.avif', 95.00, NULL, '2026-05-27 06:18:03.599767', NULL);
INSERT INTO public.product_items VALUES (553, 130, 'NIK-AIR-FOR-1-07-XXL', 127, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862682/products/cb8txxw6qzdzqi0a8zye.avif', 95.00, NULL, '2026-05-27 06:18:03.605743', NULL);
INSERT INTO public.product_items VALUES (554, 131, 'NIK-AIR-MAX-95-BIG-B-S', 76, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/kphvue64buikoet0wukn.avif', 95.00, NULL, '2026-05-27 06:18:04.479502', NULL);
INSERT INTO public.product_items VALUES (555, 131, 'NIK-AIR-MAX-95-BIG-B-M', 149, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/kphvue64buikoet0wukn.avif', 95.00, NULL, '2026-05-27 06:18:04.485244', NULL);
INSERT INTO public.product_items VALUES (556, 131, 'NIK-AIR-MAX-95-BIG-B-L', 28, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/kphvue64buikoet0wukn.avif', 95.00, NULL, '2026-05-27 06:18:04.491272', NULL);
INSERT INTO public.product_items VALUES (557, 131, 'NIK-AIR-MAX-95-BIG-B-XL', 134, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/kphvue64buikoet0wukn.avif', 95.00, NULL, '2026-05-27 06:18:04.495853', NULL);
INSERT INTO public.product_items VALUES (558, 131, 'NIK-AIR-MAX-95-BIG-B-XXL', 105, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/kphvue64buikoet0wukn.avif', 95.00, NULL, '2026-05-27 06:18:04.50278', NULL);
INSERT INTO public.product_items VALUES (559, 132, 'NIK-AIR-MAX-DN-ROA-S', 109, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/y0j8naxq9qn5qjmfglwo.avif', 95.00, NULL, '2026-05-27 06:18:05.530406', NULL);
INSERT INTO public.product_items VALUES (560, 132, 'NIK-AIR-MAX-DN-ROA-M', 71, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/y0j8naxq9qn5qjmfglwo.avif', 95.00, NULL, '2026-05-27 06:18:05.535481', NULL);
INSERT INTO public.product_items VALUES (561, 132, 'NIK-AIR-MAX-DN-ROA-L', 23, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/y0j8naxq9qn5qjmfglwo.avif', 95.00, NULL, '2026-05-27 06:18:05.53896', NULL);
INSERT INTO public.product_items VALUES (563, 132, 'NIK-AIR-MAX-DN-ROA-XXL', 121, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/y0j8naxq9qn5qjmfglwo.avif', 95.00, NULL, '2026-05-27 06:18:05.544743', NULL);
INSERT INTO public.product_items VALUES (564, 133, 'NIK-AIR-MAX-TL-25-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862685/products/kxnm2tbkzkuxgnarfftb.avif', 95.00, NULL, '2026-05-27 06:18:06.259703', NULL);
INSERT INTO public.product_items VALUES (565, 133, 'NIK-AIR-MAX-TL-25-M', 114, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862685/products/kxnm2tbkzkuxgnarfftb.avif', 95.00, NULL, '2026-05-27 06:18:06.265134', NULL);
INSERT INTO public.product_items VALUES (566, 133, 'NIK-AIR-MAX-TL-25-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862685/products/kxnm2tbkzkuxgnarfftb.avif', 95.00, NULL, '2026-05-27 06:18:06.2714', NULL);
INSERT INTO public.product_items VALUES (567, 133, 'NIK-AIR-MAX-TL-25-XL', 23, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862685/products/kxnm2tbkzkuxgnarfftb.avif', 95.00, NULL, '2026-05-27 06:18:06.275973', NULL);
INSERT INTO public.product_items VALUES (568, 133, 'NIK-AIR-MAX-TL-25-XXL', 17, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862685/products/kxnm2tbkzkuxgnarfftb.avif', 95.00, NULL, '2026-05-27 06:18:06.280734', NULL);
INSERT INTO public.product_items VALUES (574, 135, 'NIK-AVA-ROV-S', 82, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862687/products/gywxuhvyjlfap8opwnaz.avif', 95.00, NULL, '2026-05-27 06:18:07.941716', NULL);
INSERT INTO public.product_items VALUES (575, 135, 'NIK-AVA-ROV-M', 112, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862687/products/gywxuhvyjlfap8opwnaz.avif', 95.00, NULL, '2026-05-27 06:18:07.946325', NULL);
INSERT INTO public.product_items VALUES (576, 135, 'NIK-AVA-ROV-L', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862687/products/gywxuhvyjlfap8opwnaz.avif', 95.00, NULL, '2026-05-27 06:18:07.949229', NULL);
INSERT INTO public.product_items VALUES (577, 135, 'NIK-AVA-ROV-XL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862687/products/gywxuhvyjlfap8opwnaz.avif', 95.00, NULL, '2026-05-27 06:18:07.953185', NULL);
INSERT INTO public.product_items VALUES (578, 135, 'NIK-AVA-ROV-XXL', 55, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862687/products/gywxuhvyjlfap8opwnaz.avif', 95.00, NULL, '2026-05-27 06:18:07.956017', NULL);
INSERT INTO public.product_items VALUES (579, 136, 'NIK-COR-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862688/products/h3nj2l8papyunvzlqvc4.avif', 95.00, NULL, '2026-05-27 06:18:08.704563', NULL);
INSERT INTO public.product_items VALUES (580, 136, 'NIK-COR-M', 56, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862688/products/h3nj2l8papyunvzlqvc4.avif', 95.00, NULL, '2026-05-27 06:18:08.707696', NULL);
INSERT INTO public.product_items VALUES (581, 136, 'NIK-COR-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862688/products/h3nj2l8papyunvzlqvc4.avif', 95.00, NULL, '2026-05-27 06:18:08.711379', NULL);
INSERT INTO public.product_items VALUES (582, 136, 'NIK-COR-XL', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862688/products/h3nj2l8papyunvzlqvc4.avif', 95.00, NULL, '2026-05-27 06:18:08.716033', NULL);
INSERT INTO public.product_items VALUES (583, 136, 'NIK-COR-XXL', 57, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862688/products/h3nj2l8papyunvzlqvc4.avif', 95.00, NULL, '2026-05-27 06:18:08.72014', NULL);
INSERT INTO public.product_items VALUES (599, 140, 'NIK-OFF-ADJ-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862691/products/rom4qgz3putzzsnx1gdi.avif', 95.00, NULL, '2026-05-27 06:18:12.414975', NULL);
INSERT INTO public.product_items VALUES (600, 140, 'NIK-OFF-ADJ-M', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862691/products/rom4qgz3putzzsnx1gdi.avif', 95.00, NULL, '2026-05-27 06:18:12.418467', NULL);
INSERT INTO public.product_items VALUES (601, 140, 'NIK-OFF-ADJ-L', 5, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862691/products/rom4qgz3putzzsnx1gdi.avif', 95.00, NULL, '2026-05-27 06:18:12.422168', NULL);
INSERT INTO public.product_items VALUES (602, 140, 'NIK-OFF-ADJ-XL', 138, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862691/products/rom4qgz3putzzsnx1gdi.avif', 95.00, NULL, '2026-05-27 06:18:12.426172', NULL);
INSERT INTO public.product_items VALUES (603, 140, 'NIK-OFF-ADJ-XXL', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862691/products/rom4qgz3putzzsnx1gdi.avif', 95.00, NULL, '2026-05-27 06:18:12.428875', NULL);
INSERT INTO public.product_items VALUES (604, 141, 'NIK-OFF-S', 140, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862692/products/cen10unokiewotwixox2.avif', 95.00, NULL, '2026-05-27 06:18:13.390376', NULL);
INSERT INTO public.product_items VALUES (605, 141, 'NIK-OFF-M', 114, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862692/products/cen10unokiewotwixox2.avif', 95.00, NULL, '2026-05-27 06:18:13.393701', NULL);
INSERT INTO public.product_items VALUES (606, 141, 'NIK-OFF-L', 39, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862692/products/cen10unokiewotwixox2.avif', 95.00, NULL, '2026-05-27 06:18:13.398119', NULL);
INSERT INTO public.product_items VALUES (607, 141, 'NIK-OFF-XL', 86, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862692/products/cen10unokiewotwixox2.avif', 95.00, NULL, '2026-05-27 06:18:13.402375', NULL);
INSERT INTO public.product_items VALUES (608, 141, 'NIK-OFF-XXL', 18, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862692/products/cen10unokiewotwixox2.avif', 95.00, NULL, '2026-05-27 06:18:13.405985', NULL);
INSERT INTO public.product_items VALUES (609, 142, 'NIK-REA-REJ-S', 67, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862693/products/wj2ahq23t1z6yqbqcueg.avif', 95.00, NULL, '2026-05-27 06:18:14.20335', NULL);
INSERT INTO public.product_items VALUES (610, 142, 'NIK-REA-REJ-M', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862693/products/wj2ahq23t1z6yqbqcueg.avif', 95.00, NULL, '2026-05-27 06:18:14.207134', NULL);
INSERT INTO public.product_items VALUES (611, 142, 'NIK-REA-REJ-L', 146, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862693/products/wj2ahq23t1z6yqbqcueg.avif', 95.00, NULL, '2026-05-27 06:18:14.21034', NULL);
INSERT INTO public.product_items VALUES (612, 142, 'NIK-REA-REJ-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862693/products/wj2ahq23t1z6yqbqcueg.avif', 95.00, NULL, '2026-05-27 06:18:14.214093', NULL);
INSERT INTO public.product_items VALUES (613, 142, 'NIK-REA-REJ-XXL', 88, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862693/products/wj2ahq23t1z6yqbqcueg.avif', 95.00, NULL, '2026-05-27 06:18:14.217917', NULL);
INSERT INTO public.product_items VALUES (619, 144, 'NIK-VIC-ONE-S', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862695/products/txwjxynjctfudv5sfaxw.avif', 95.00, 2, '2026-05-27 06:18:16.026325', '2026-06-10 07:20:20.643951');
INSERT INTO public.product_items VALUES (618, 143, 'NIK-TIE-REA-LE-XXL', 68, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862694/products/loa0yjqa2txvxnq48dt6.avif', 95.00, 1, '2026-05-27 06:18:15.151009', NULL);
INSERT INTO public.product_items VALUES (624, 72, 'DUR-CLA-COR-SHO-SLE-GR-S', 44, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (625, 72, 'DUR-CLA-COR-SHO-SLE-GR-M', 109, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (626, 72, 'DUR-CLA-COR-SHO-SLE-GR-L', 139, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (627, 72, 'DUR-CLA-COR-SHO-SLE-GR-XL', 134, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (628, 72, 'DUR-CLA-COR-SHO-SLE-GR-XXL', 66, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (629, 73, 'DUR-CLA-COR-SHO-SLE-LB-S', 143, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (630, 73, 'DUR-CLA-COR-SHO-SLE-LB-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (631, 73, 'DUR-CLA-COR-SHO-SLE-LB-L', 70, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (632, 73, 'DUR-CLA-COR-SHO-SLE-LB-XL', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (633, 73, 'DUR-CLA-COR-SHO-SLE-LB-XXL', 96, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ubdx7y73milptosrwmjq.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (634, 80, 'EAS-BOX-SHO-SLE-OXF-BL-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (635, 80, 'EAS-BOX-SHO-SLE-OXF-BL-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (636, 80, 'EAS-BOX-SHO-SLE-OXF-BL-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (637, 80, 'EAS-BOX-SHO-SLE-OXF-BL-XL', 143, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (638, 80, 'EAS-BOX-SHO-SLE-OXF-BL-XXL', 46, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (639, 81, 'EAS-BOX-SHO-SLE-OXF-GY-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (640, 81, 'EAS-BOX-SHO-SLE-OXF-GY-M', 86, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (641, 81, 'EAS-BOX-SHO-SLE-OXF-GY-L', 109, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (642, 81, 'EAS-BOX-SHO-SLE-OXF-GY-XL', 149, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (643, 81, 'EAS-BOX-SHO-SLE-OXF-GY-XXL', 98, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (644, 82, 'EAS-BOX-SHO-SLE-OXF-WH-S', 37, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (645, 82, 'EAS-BOX-SHO-SLE-OXF-WH-M', 5, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (646, 82, 'EAS-BOX-SHO-SLE-OXF-WH-L', 42, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (647, 82, 'EAS-BOX-SHO-SLE-OXF-WH-XL', 42, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (648, 82, 'EAS-BOX-SHO-SLE-OXF-WH-XXL', 15, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798959/products/aiyc2jxo3bk9ace8a0op.webp', 45.00, NULL, '2026-06-07 23:30:58.847915', NULL);
INSERT INTO public.product_items VALUES (93, 33, 'AIR-ZIP-UP-HOO-BLA-XXL', 108, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798922/products/woph51g9mqtcimrdpjej.webp', 65.00, 1, '2026-05-26 12:22:20.192874', NULL);
INSERT INTO public.product_items VALUES (226, 60, 'DUR-ELE-TRO-BLA-L', 1, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798944/products/d7iup6ezhcbbjsagsjzw.webp', 55.00, 2, '2026-05-26 12:22:21.195967', NULL);
INSERT INTO public.product_items VALUES (323, 84, 'CLO-MIC-SWE-BLA-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798961/products/ohig08mplulzmg7wcpcx.webp', 59.00, 3, '2026-05-26 12:22:21.930446', NULL);
INSERT INTO public.product_items VALUES (191, 53, 'EAS-COL-BLO-PAR-GRE-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/turnyoy58qxlnex6l61f.webp', 85.00, 2, '2026-05-26 12:22:20.970868', NULL);
INSERT INTO public.product_items VALUES (36, 22, 'COR-BUC-HAT-WHI-L', 84, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798913/products/ehmklonmrlcnlucbhifx.webp', 25.00, 3, '2026-05-26 12:22:19.661352', NULL);
INSERT INTO public.product_items VALUES (142, 43, 'DUR-COR-BOM-JAC-GRE-XL', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/oombv9zwccqo3szpcrum.webp', 85.00, 1, '2026-05-26 12:22:20.602492', NULL);
INSERT INTO public.product_items VALUES (329, 86, 'CLO-MIC-SWE-RED-S', 88, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/g9anerm1rfqbie6xgn5c.webp', 59.00, 2, '2026-05-26 12:22:21.978765', NULL);
INSERT INTO public.product_items VALUES (201, 55, 'AIR-PAN-GRA-L', 5, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ul3rqv3o2egqz2ovhhxa.webp', 55.00, 3, '2026-05-26 12:22:21.033502', NULL);
INSERT INTO public.product_items VALUES (591, 138, 'NIK-DUN-LOW-RET-PRE-L', 83, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/leevsrxzy9hfzrlnuejs.avif', 95.00, 1, '2026-05-27 06:18:10.398701', NULL);
INSERT INTO public.product_items VALUES (212, 57, 'CLO-JEA-BLU-XL', 42, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/zponz28d3gbfeyvrfvan.webp', 55.00, 2, '2026-05-26 12:22:21.104573', NULL);
INSERT INTO public.product_items VALUES (120, 39, 'EAS-HOO-GRA-M', 36, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/homqcxk5822kvxzgkavb.webp', 65.00, 3, '2026-05-26 12:22:20.417026', NULL);
INSERT INTO public.product_items VALUES (509, 122, 'T1-X-MII-TOG-ALL-DAY-S', 86, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862208/products/ynmjs1vbvpoj0vhidc4b.png', 15.00, 1, '2026-05-27 06:10:09.597861', NULL);
INSERT INTO public.product_items VALUES (34, 22, 'COR-BUC-HAT-WHI-S', 48, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798913/products/ehmklonmrlcnlucbhifx.webp', 25.00, 2, '2026-05-26 12:22:19.646914', NULL);
INSERT INTO public.product_items VALUES (594, 139, 'NIK-MAR-S', 47, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862690/products/d9rlhoteyxtibhskshn2.avif', 95.00, 2, '2026-05-27 06:18:11.223346', NULL);
INSERT INTO public.product_items VALUES (587, 137, 'NIK-COU-BOR-LOW-ESS-XL', 106, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/kzsytlglcla6mzprl3di.avif', 95.00, 3, '2026-05-27 06:18:09.483891', NULL);
INSERT INTO public.product_items VALUES (79, 31, 'PAC-BUC-HAT-BLA-S', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798920/products/xj6zulf4ekuqo441o28s.webp', 25.00, 1, '2026-05-26 12:22:20.050207', NULL);
INSERT INTO public.product_items VALUES (573, 134, 'NIK-AIR-SUP-XXL', 52, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862686/products/hfh6zakbwfjt0shkj2pv.avif', 95.00, 2, '2026-05-27 06:18:07.052546', NULL);
INSERT INTO public.product_items VALUES (286, 74, 'DUR-DEN-OVE-BLU-L', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ewdwqzaepuzdzc4nhmdf.webp', 45.00, 3, '2026-05-26 12:22:21.631238', NULL);
INSERT INTO public.product_items VALUES (255, 66, 'FLE-JEA-GRA-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798949/products/fuzyij9v5un61jaskdon.webp', 55.00, 1, '2026-05-26 12:22:21.397614', NULL);
INSERT INTO public.product_items VALUES (269, 69, 'SCU-CLO-JOG-GRE-S', 16, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798951/products/zhwzqzy3ks8o2mfp47ok.webp', 55.00, 2, '2026-05-26 12:22:21.484382', NULL);
INSERT INTO public.product_items VALUES (77, 30, 'PAC-BUC-HAT-BEI-XL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798919/products/fju60wvrahqb79vw5fjn.webp', 25.00, 3, '2026-05-26 12:22:20.026448', NULL);
INSERT INTO public.product_items VALUES (349, 90, 'COT-SWE-BLU-S', 106, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/ydzqblffb8poj5ks8jeo.webp', 59.00, 1, '2026-05-26 12:22:22.131126', NULL);
INSERT INTO public.product_items VALUES (35, 22, 'COR-BUC-HAT-WHI-M', 72, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798913/products/ehmklonmrlcnlucbhifx.webp', 25.00, 3, '2026-05-26 12:22:19.654254', NULL);
INSERT INTO public.product_items VALUES (74, 30, 'PAC-BUC-HAT-BEI-S', 73, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798919/products/fju60wvrahqb79vw5fjn.webp', 25.00, 3, '2026-05-26 12:22:19.994028', NULL);
INSERT INTO public.product_items VALUES (75, 30, 'PAC-BUC-HAT-BEI-M', 112, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798919/products/fju60wvrahqb79vw5fjn.webp', 25.00, 3, '2026-05-26 12:22:20.001766', NULL);
INSERT INTO public.product_items VALUES (76, 30, 'PAC-BUC-HAT-BEI-L', 122, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798919/products/fju60wvrahqb79vw5fjn.webp', 25.00, 3, '2026-05-26 12:22:20.016045', NULL);
INSERT INTO public.product_items VALUES (80, 31, 'PAC-BUC-HAT-BLA-M', 126, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798920/products/xj6zulf4ekuqo441o28s.webp', 25.00, 1, '2026-05-26 12:22:20.057141', NULL);
INSERT INTO public.product_items VALUES (81, 31, 'PAC-BUC-HAT-BLA-L', 34, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798920/products/xj6zulf4ekuqo441o28s.webp', 25.00, 1, '2026-05-26 12:22:20.064041', NULL);
INSERT INTO public.product_items VALUES (82, 31, 'PAC-BUC-HAT-BLA-XL', 106, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798920/products/xj6zulf4ekuqo441o28s.webp', 25.00, 1, '2026-05-26 12:22:20.071386', NULL);
INSERT INTO public.product_items VALUES (89, 33, 'AIR-ZIP-UP-HOO-BLA-S', 39, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798922/products/woph51g9mqtcimrdpjej.webp', 65.00, 1, '2026-05-26 12:22:20.159649', NULL);
INSERT INTO public.product_items VALUES (90, 33, 'AIR-ZIP-UP-HOO-BLA-M', 133, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798922/products/woph51g9mqtcimrdpjej.webp', 65.00, 1, '2026-05-26 12:22:20.167583', NULL);
INSERT INTO public.product_items VALUES (91, 33, 'AIR-ZIP-UP-HOO-BLA-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798922/products/woph51g9mqtcimrdpjej.webp', 65.00, 1, '2026-05-26 12:22:20.176316', NULL);
INSERT INTO public.product_items VALUES (92, 33, 'AIR-ZIP-UP-HOO-BLA-XL', 27, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798922/products/woph51g9mqtcimrdpjej.webp', 65.00, 1, '2026-05-26 12:22:20.184999', NULL);
INSERT INTO public.product_items VALUES (119, 39, 'EAS-HOO-GRA-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/homqcxk5822kvxzgkavb.webp', 65.00, 3, '2026-05-26 12:22:20.411473', NULL);
INSERT INTO public.product_items VALUES (121, 39, 'EAS-HOO-GRA-L', 24, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/homqcxk5822kvxzgkavb.webp', 65.00, 3, '2026-05-26 12:22:20.423286', NULL);
INSERT INTO public.product_items VALUES (122, 39, 'EAS-HOO-GRA-XL', 51, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/homqcxk5822kvxzgkavb.webp', 65.00, 3, '2026-05-26 12:22:20.429849', NULL);
INSERT INTO public.product_items VALUES (139, 43, 'DUR-COR-BOM-JAC-GRE-S', 73, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/oombv9zwccqo3szpcrum.webp', 85.00, 1, '2026-05-26 12:22:20.580417', NULL);
INSERT INTO public.product_items VALUES (140, 43, 'DUR-COR-BOM-JAC-GRE-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/oombv9zwccqo3szpcrum.webp', 85.00, 1, '2026-05-26 12:22:20.587506', NULL);
INSERT INTO public.product_items VALUES (141, 43, 'DUR-COR-BOM-JAC-GRE-L', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/oombv9zwccqo3szpcrum.webp', 85.00, 1, '2026-05-26 12:22:20.594848', NULL);
INSERT INTO public.product_items VALUES (199, 55, 'AIR-PAN-GRA-S', 21, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ul3rqv3o2egqz2ovhhxa.webp', 55.00, 3, '2026-05-26 12:22:21.023044', NULL);
INSERT INTO public.product_items VALUES (189, 53, 'EAS-COL-BLO-PAR-GRE-S', 104, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/turnyoy58qxlnex6l61f.webp', 85.00, 2, '2026-05-26 12:22:20.959718', NULL);
INSERT INTO public.product_items VALUES (190, 53, 'EAS-COL-BLO-PAR-GRE-M', 23, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/turnyoy58qxlnex6l61f.webp', 85.00, 2, '2026-05-26 12:22:20.96498', NULL);
INSERT INTO public.product_items VALUES (192, 53, 'EAS-COL-BLO-PAR-GRE-XL', 110, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/turnyoy58qxlnex6l61f.webp', 85.00, 2, '2026-05-26 12:22:20.975164', NULL);
INSERT INTO public.product_items VALUES (209, 57, 'CLO-JEA-BLU-S', 83, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/zponz28d3gbfeyvrfvan.webp', 55.00, 2, '2026-05-26 12:22:21.087989', NULL);
INSERT INTO public.product_items VALUES (210, 57, 'CLO-JEA-BLU-M', 32, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/zponz28d3gbfeyvrfvan.webp', 55.00, 2, '2026-05-26 12:22:21.092988', NULL);
INSERT INTO public.product_items VALUES (211, 57, 'CLO-JEA-BLU-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/zponz28d3gbfeyvrfvan.webp', 55.00, 2, '2026-05-26 12:22:21.098676', NULL);
INSERT INTO public.product_items VALUES (215, 58, 'DUR-BAG-JEA-BLU-M', 139, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/g1dvcrta6uq5ijyv1ojw.webp', 55.00, 3, '2026-05-26 12:22:21.126648', NULL);
INSERT INTO public.product_items VALUES (216, 58, 'DUR-BAG-JEA-BLU-L', 73, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/g1dvcrta6uq5ijyv1ojw.webp', 55.00, 3, '2026-05-26 12:22:21.131531', NULL);
INSERT INTO public.product_items VALUES (224, 60, 'DUR-ELE-TRO-BLA-S', 100, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798944/products/d7iup6ezhcbbjsagsjzw.webp', 55.00, 2, '2026-05-26 12:22:21.184234', NULL);
INSERT INTO public.product_items VALUES (225, 60, 'DUR-ELE-TRO-BLA-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798944/products/d7iup6ezhcbbjsagsjzw.webp', 55.00, 2, '2026-05-26 12:22:21.190479', NULL);
INSERT INTO public.product_items VALUES (227, 60, 'DUR-ELE-TRO-BLA-XL', 21, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798944/products/d7iup6ezhcbbjsagsjzw.webp', 55.00, 2, '2026-05-26 12:22:21.201204', NULL);
INSERT INTO public.product_items VALUES (256, 66, 'FLE-JEA-GRA-L', 93, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798949/products/fuzyij9v5un61jaskdon.webp', 55.00, 1, '2026-05-26 12:22:21.403387', NULL);
INSERT INTO public.product_items VALUES (257, 66, 'FLE-JEA-GRA-XL', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798949/products/fuzyij9v5un61jaskdon.webp', 55.00, 1, '2026-05-26 12:22:21.408421', NULL);
INSERT INTO public.product_items VALUES (270, 69, 'SCU-CLO-JOG-GRE-M', 119, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798951/products/zhwzqzy3ks8o2mfp47ok.webp', 55.00, 2, '2026-05-26 12:22:21.48934', NULL);
INSERT INTO public.product_items VALUES (271, 69, 'SCU-CLO-JOG-GRE-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798951/products/zhwzqzy3ks8o2mfp47ok.webp', 55.00, 2, '2026-05-26 12:22:21.495017', NULL);
INSERT INTO public.product_items VALUES (285, 74, 'DUR-DEN-OVE-BLU-M', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ewdwqzaepuzdzc4nhmdf.webp', 45.00, 3, '2026-05-26 12:22:21.625885', NULL);
INSERT INTO public.product_items VALUES (287, 74, 'DUR-DEN-OVE-BLU-XL', 9, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ewdwqzaepuzdzc4nhmdf.webp', 45.00, 3, '2026-05-26 12:22:21.637723', NULL);
INSERT INTO public.product_items VALUES (319, 84, 'CLO-MIC-SWE-BLA-S', 112, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798961/products/ohig08mplulzmg7wcpcx.webp', 59.00, 3, '2026-05-26 12:22:21.908556', NULL);
INSERT INTO public.product_items VALUES (320, 84, 'CLO-MIC-SWE-BLA-M', 107, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798961/products/ohig08mplulzmg7wcpcx.webp', 59.00, 3, '2026-05-26 12:22:21.914549', NULL);
INSERT INTO public.product_items VALUES (330, 86, 'CLO-MIC-SWE-RED-M', 19, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/g9anerm1rfqbie6xgn5c.webp', 59.00, 2, '2026-05-26 12:22:21.984083', NULL);
INSERT INTO public.product_items VALUES (331, 86, 'CLO-MIC-SWE-RED-L', 77, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/g9anerm1rfqbie6xgn5c.webp', 59.00, 2, '2026-05-26 12:22:21.99013', NULL);
INSERT INTO public.product_items VALUES (332, 86, 'CLO-MIC-SWE-RED-XL', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/g9anerm1rfqbie6xgn5c.webp', 59.00, 2, '2026-05-26 12:22:21.994353', NULL);
INSERT INTO public.product_items VALUES (350, 90, 'COT-SWE-BLU-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/ydzqblffb8poj5ks8jeo.webp', 59.00, 1, '2026-05-26 12:22:22.137892', NULL);
INSERT INTO public.product_items VALUES (351, 90, 'COT-SWE-BLU-L', 37, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/ydzqblffb8poj5ks8jeo.webp', 59.00, 1, '2026-05-26 12:22:22.14458', NULL);
INSERT INTO public.product_items VALUES (352, 90, 'COT-SWE-BLU-XL', 133, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/ydzqblffb8poj5ks8jeo.webp', 59.00, 1, '2026-05-26 12:22:22.152379', NULL);
INSERT INTO public.product_items VALUES (37, 22, 'COR-BUC-HAT-WHI-XL', 5, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798913/products/ehmklonmrlcnlucbhifx.webp', 25.00, 3, '2026-05-26 12:22:19.668571', NULL);
INSERT INTO public.product_items VALUES (38, 22, 'COR-BUC-HAT-WHI-XXL', 67, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798913/products/ehmklonmrlcnlucbhifx.webp', 25.00, 3, '2026-05-26 12:22:19.67377', NULL);
INSERT INTO public.product_items VALUES (78, 30, 'PAC-BUC-HAT-BEI-XXL', 114, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798919/products/fju60wvrahqb79vw5fjn.webp', 25.00, 3, '2026-05-26 12:22:20.034616', NULL);
INSERT INTO public.product_items VALUES (83, 31, 'PAC-BUC-HAT-BLA-XXL', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798920/products/xj6zulf4ekuqo441o28s.webp', 25.00, 1, '2026-05-26 12:22:20.078272', NULL);
INSERT INTO public.product_items VALUES (123, 39, 'EAS-HOO-GRA-XXL', 33, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798926/products/homqcxk5822kvxzgkavb.webp', 65.00, 3, '2026-05-26 12:22:20.437248', NULL);
INSERT INTO public.product_items VALUES (143, 43, 'DUR-COR-BOM-JAC-GRE-XXL', 90, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798929/products/oombv9zwccqo3szpcrum.webp', 85.00, 1, '2026-05-26 12:22:20.609779', NULL);
INSERT INTO public.product_items VALUES (193, 53, 'EAS-COL-BLO-PAR-GRE-XXL', 138, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798938/products/turnyoy58qxlnex6l61f.webp', 85.00, 2, '2026-05-26 12:22:20.979925', NULL);
INSERT INTO public.product_items VALUES (200, 55, 'AIR-PAN-GRA-M', 125, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ul3rqv3o2egqz2ovhhxa.webp', 55.00, 3, '2026-05-26 12:22:21.028318', NULL);
INSERT INTO public.product_items VALUES (202, 55, 'AIR-PAN-GRA-XL', 33, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ul3rqv3o2egqz2ovhhxa.webp', 55.00, 3, '2026-05-26 12:22:21.039942', NULL);
INSERT INTO public.product_items VALUES (203, 55, 'AIR-PAN-GRA-XXL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798940/products/ul3rqv3o2egqz2ovhhxa.webp', 55.00, 3, '2026-05-26 12:22:21.044527', NULL);
INSERT INTO public.product_items VALUES (213, 57, 'CLO-JEA-BLU-XXL', 105, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/zponz28d3gbfeyvrfvan.webp', 55.00, 2, '2026-05-26 12:22:21.109115', NULL);
INSERT INTO public.product_items VALUES (217, 58, 'DUR-BAG-JEA-BLU-XL', 16, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/g1dvcrta6uq5ijyv1ojw.webp', 55.00, 3, '2026-05-26 12:22:21.136511', NULL);
INSERT INTO public.product_items VALUES (218, 58, 'DUR-BAG-JEA-BLU-XXL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/g1dvcrta6uq5ijyv1ojw.webp', 55.00, 3, '2026-05-26 12:22:21.142296', NULL);
INSERT INTO public.product_items VALUES (228, 60, 'DUR-ELE-TRO-BLA-XXL', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798944/products/d7iup6ezhcbbjsagsjzw.webp', 55.00, 2, '2026-05-26 12:22:21.208144', NULL);
INSERT INTO public.product_items VALUES (258, 66, 'FLE-JEA-GRA-XXL', 25, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798949/products/fuzyij9v5un61jaskdon.webp', 55.00, 1, '2026-05-26 12:22:21.413531', NULL);
INSERT INTO public.product_items VALUES (273, 69, 'SCU-CLO-JOG-GRE-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798951/products/zhwzqzy3ks8o2mfp47ok.webp', 55.00, 2, '2026-05-26 12:22:21.506187', NULL);
INSERT INTO public.product_items VALUES (321, 84, 'CLO-MIC-SWE-BLA-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798961/products/ohig08mplulzmg7wcpcx.webp', 59.00, 3, '2026-05-26 12:22:21.920357', NULL);
INSERT INTO public.product_items VALUES (322, 84, 'CLO-MIC-SWE-BLA-XL', 4, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798961/products/ohig08mplulzmg7wcpcx.webp', 59.00, 3, '2026-05-26 12:22:21.925941', NULL);
INSERT INTO public.product_items VALUES (333, 86, 'CLO-MIC-SWE-RED-XXL', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798962/products/g9anerm1rfqbie6xgn5c.webp', 59.00, 2, '2026-05-26 12:22:21.999865', NULL);
INSERT INTO public.product_items VALUES (353, 90, 'COT-SWE-BLU-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798966/products/ydzqblffb8poj5ks8jeo.webp', 59.00, 1, '2026-05-26 12:22:22.159206', NULL);
INSERT INTO public.product_items VALUES (510, 122, 'T1-X-MII-TOG-ALL-DAY-M', 90, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862208/products/ynmjs1vbvpoj0vhidc4b.png', 15.00, 1, '2026-05-27 06:10:09.602942', NULL);
INSERT INTO public.product_items VALUES (511, 122, 'T1-X-MII-TOG-ALL-DAY-L', 137, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862208/products/ynmjs1vbvpoj0vhidc4b.png', 15.00, 1, '2026-05-27 06:10:09.608191', NULL);
INSERT INTO public.product_items VALUES (512, 122, 'T1-X-MII-TOG-ALL-DAY-XL', 140, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862208/products/ynmjs1vbvpoj0vhidc4b.png', 15.00, 1, '2026-05-27 06:10:09.615701', NULL);
INSERT INTO public.product_items VALUES (513, 122, 'T1-X-MII-TOG-ALL-DAY-XXL', 51, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862208/products/ynmjs1vbvpoj0vhidc4b.png', 15.00, 1, '2026-05-27 06:10:09.62289', NULL);
INSERT INTO public.product_items VALUES (569, 134, 'NIK-AIR-SUP-S', 104, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862686/products/hfh6zakbwfjt0shkj2pv.avif', 95.00, 2, '2026-05-27 06:18:07.032984', NULL);
INSERT INTO public.product_items VALUES (570, 134, 'NIK-AIR-SUP-M', 69, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862686/products/hfh6zakbwfjt0shkj2pv.avif', 95.00, 2, '2026-05-27 06:18:07.037587', NULL);
INSERT INTO public.product_items VALUES (571, 134, 'NIK-AIR-SUP-L', 2, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862686/products/hfh6zakbwfjt0shkj2pv.avif', 95.00, 2, '2026-05-27 06:18:07.042413', NULL);
INSERT INTO public.product_items VALUES (572, 134, 'NIK-AIR-SUP-XL', 114, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862686/products/hfh6zakbwfjt0shkj2pv.avif', 95.00, 2, '2026-05-27 06:18:07.047706', NULL);
INSERT INTO public.product_items VALUES (584, 137, 'NIK-COU-BOR-LOW-ESS-S', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/kzsytlglcla6mzprl3di.avif', 95.00, 3, '2026-05-27 06:18:09.475486', NULL);
INSERT INTO public.product_items VALUES (585, 137, 'NIK-COU-BOR-LOW-ESS-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/kzsytlglcla6mzprl3di.avif', 95.00, 3, '2026-05-27 06:18:09.478833', NULL);
INSERT INTO public.product_items VALUES (586, 137, 'NIK-COU-BOR-LOW-ESS-L', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/kzsytlglcla6mzprl3di.avif', 95.00, 3, '2026-05-27 06:18:09.481283', NULL);
INSERT INTO public.product_items VALUES (588, 137, 'NIK-COU-BOR-LOW-ESS-XXL', 97, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/kzsytlglcla6mzprl3di.avif', 95.00, 3, '2026-05-27 06:18:09.488573', NULL);
INSERT INTO public.product_items VALUES (376, 95, 'ZIP-NEC-POL-SWE-GRA-L', 65, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798969/products/f2kwurkl5jo7uwinbblg.webp', 59.00, NULL, '2026-05-26 12:22:22.324345', NULL);
INSERT INTO public.product_items VALUES (458, 111, 'DIS-FRI-ROU-KEY-XXL', 112, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862197/products/vewf3eic9eatga1dufvn.jpg', 15.00, NULL, '2026-05-27 06:09:58.433356', NULL);
INSERT INTO public.product_items VALUES (562, 132, 'NIK-AIR-MAX-DN-ROA-XL', 87, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862684/products/y0j8naxq9qn5qjmfglwo.avif', 95.00, NULL, '2026-05-27 06:18:05.541888', NULL);
INSERT INTO public.product_items VALUES (214, 58, 'DUR-BAG-JEA-BLU-S', 68, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798942/products/g1dvcrta6uq5ijyv1ojw.webp', 55.00, 3, '2026-05-26 12:22:21.120376', NULL);
INSERT INTO public.product_items VALUES (288, 74, 'DUR-DEN-OVE-BLU-XXL', 41, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ewdwqzaepuzdzc4nhmdf.webp', 45.00, 1, '2026-05-26 12:22:21.643361', NULL);
INSERT INTO public.product_items VALUES (272, 69, 'SCU-CLO-JOG-GRE-XL', 104, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798951/products/zhwzqzy3ks8o2mfp47ok.webp', 55.00, 2, '2026-05-26 12:22:21.501421', NULL);
INSERT INTO public.product_items VALUES (284, 74, 'DUR-DEN-OVE-BLU-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779798953/products/ewdwqzaepuzdzc4nhmdf.webp', 45.00, 3, '2026-05-26 12:22:21.619926', NULL);
INSERT INTO public.product_items VALUES (589, 138, 'NIK-DUN-LOW-RET-PRE-S', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/leevsrxzy9hfzrlnuejs.avif', 95.00, 1, '2026-05-27 06:18:10.389579', NULL);
INSERT INTO public.product_items VALUES (590, 138, 'NIK-DUN-LOW-RET-PRE-M', 113, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/leevsrxzy9hfzrlnuejs.avif', 95.00, 1, '2026-05-27 06:18:10.393411', NULL);
INSERT INTO public.product_items VALUES (592, 138, 'NIK-DUN-LOW-RET-PRE-XL', 51, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/leevsrxzy9hfzrlnuejs.avif', 95.00, 1, '2026-05-27 06:18:10.402739', NULL);
INSERT INTO public.product_items VALUES (593, 138, 'NIK-DUN-LOW-RET-PRE-XXL', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862689/products/leevsrxzy9hfzrlnuejs.avif', 95.00, 1, '2026-05-27 06:18:10.406641', NULL);
INSERT INTO public.product_items VALUES (595, 139, 'NIK-MAR-M', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862690/products/d9rlhoteyxtibhskshn2.avif', 95.00, 2, '2026-05-27 06:18:11.227587', NULL);
INSERT INTO public.product_items VALUES (596, 139, 'NIK-MAR-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862690/products/d9rlhoteyxtibhskshn2.avif', 95.00, 2, '2026-05-27 06:18:11.232242', NULL);
INSERT INTO public.product_items VALUES (597, 139, 'NIK-MAR-XL', 10, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862690/products/d9rlhoteyxtibhskshn2.avif', 95.00, 2, '2026-05-27 06:18:11.236948', NULL);
INSERT INTO public.product_items VALUES (598, 139, 'NIK-MAR-XXL', 74, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862690/products/d9rlhoteyxtibhskshn2.avif', 95.00, 2, '2026-05-27 06:18:11.240733', NULL);
INSERT INTO public.product_items VALUES (614, 143, 'NIK-TIE-REA-LE-S', 62, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862694/products/loa0yjqa2txvxnq48dt6.avif', 95.00, 1, '2026-05-27 06:18:15.137867', NULL);
INSERT INTO public.product_items VALUES (620, 144, 'NIK-VIC-ONE-M', 6, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862695/products/txwjxynjctfudv5sfaxw.avif', 95.00, 2, '2026-05-27 06:18:16.029395', '2026-06-10 07:20:20.643951');
INSERT INTO public.product_items VALUES (616, 143, 'NIK-TIE-REA-LE-L', 3, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862694/products/loa0yjqa2txvxnq48dt6.avif', 95.00, 1, '2026-05-27 06:18:15.144655', NULL);
INSERT INTO public.product_items VALUES (617, 143, 'NIK-TIE-REA-LE-XL', 26, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862694/products/loa0yjqa2txvxnq48dt6.avif', 95.00, 1, '2026-05-27 06:18:15.148065', NULL);
INSERT INTO public.product_items VALUES (621, 144, 'NIK-VIC-ONE-L', 0, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862695/products/txwjxynjctfudv5sfaxw.avif', 95.00, 2, '2026-05-27 06:18:16.032998', '2026-06-10 07:20:20.643951');
INSERT INTO public.product_items VALUES (622, 144, 'NIK-VIC-ONE-XL', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862695/products/txwjxynjctfudv5sfaxw.avif', 95.00, 2, '2026-05-27 06:18:16.03632', '2026-06-10 07:20:20.643951');
INSERT INTO public.product_items VALUES (623, 144, 'NIK-VIC-ONE-XXL', 8, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862695/products/txwjxynjctfudv5sfaxw.avif', 95.00, 2, '2026-05-27 06:18:16.039205', '2026-06-10 07:20:20.643951');
INSERT INTO public.product_items VALUES (615, 143, 'NIK-TIE-REA-LE-M', 7, 'https://res.cloudinary.com/deqzkcuox/image/upload/v1779862694/products/loa0yjqa2txvxnq48dt6.avif', 95.00, 1, '2026-05-27 06:18:15.141058', '2026-06-09 11:27:54.361148');


--
-- TOC entry 3591 (class 0 OID 16464)
-- Dependencies: 232
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES (19, 'Corduroy Bucket Hat Black', 'corduroy-bucket-hat-black', 6, '2026-05-26 12:22:19.499707', NULL, 'Premium Corduroy Bucket Hat Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (20, 'Corduroy Bucket Hat Brown', 'corduroy-bucket-hat-brown', 6, '2026-05-26 12:22:19.557198', NULL, 'Premium Corduroy Bucket Hat Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (21, 'Corduroy Bucket Hat Pink', 'corduroy-bucket-hat-pink', 6, '2026-05-26 12:22:19.596547', NULL, 'Premium Corduroy Bucket Hat Pink, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (22, 'Corduroy Bucket Hat White', 'corduroy-bucket-hat-white', 6, '2026-05-26 12:22:19.639839', NULL, 'Premium Corduroy Bucket Hat White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (23, 'Khaki Fitted Cap Blue', 'khaki-fitted-cap-blue', 6, '2026-05-26 12:22:19.679925', NULL, 'Premium Khaki Fitted Cap Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (24, 'Khaki Fitted Cap Green', 'khaki-fitted-cap-green', 6, '2026-05-26 12:22:19.726839', NULL, 'Premium Khaki Fitted Cap Green, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (25, 'Khaki Fitted Cap Red', 'khaki-fitted-cap-red', 6, '2026-05-26 12:22:19.768292', NULL, 'Premium Khaki Fitted Cap Red, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (26, 'Mesh Trucker Cap Black', 'mesh-trucker-cap-black', 6, '2026-05-26 12:22:19.809686', NULL, 'Premium Mesh Trucker Cap Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (27, 'Mesh Trucker Cap Blue', 'mesh-trucker-cap-blue', 6, '2026-05-26 12:22:19.852945', NULL, 'Premium Mesh Trucker Cap Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (28, 'Mesh Trucker Cap Brown', 'mesh-trucker-cap-brown', 6, '2026-05-26 12:22:19.897617', NULL, 'Premium Mesh Trucker Cap Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (29, 'Mesh Trucker Cap Orange', 'mesh-trucker-cap-orange', 6, '2026-05-26 12:22:19.940587', NULL, 'Premium Mesh Trucker Cap Orange, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (30, 'Packable Bucket Hat Beige', 'packable-bucket-hat-beige', 6, '2026-05-26 12:22:19.984373', NULL, 'Premium Packable Bucket Hat Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (31, 'Packable Bucket Hat Black', 'packable-bucket-hat-black', 6, '2026-05-26 12:22:20.041684', NULL, 'Premium Packable Bucket Hat Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (32, 'Packable Bucket Hat Gray', 'packable-bucket-hat-gray', 6, '2026-05-26 12:22:20.086038', NULL, 'Premium Packable Bucket Hat Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (40, 'Sleeveless Hoodie Beige', 'sleeveless-hoodie-beige', 2, '2026-05-26 12:22:20.44393', NULL, 'Premium Sleeveless Hoodie Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (41, 'Sleeveless Hoodie Black', 'sleeveless-hoodie-black', 2, '2026-05-26 12:22:20.484472', NULL, 'Premium Sleeveless Hoodie Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (56, 'Beginner Parachute Joggers Green', 'beginner-parachute-joggers-green', 4, '2026-05-26 12:22:21.049955', NULL, 'Premium Beginner Parachute Joggers Green, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (70, 'The Minimalist Khaki Pants Black', 'the-minimalist-khaki-pants-black', 4, '2026-05-26 12:22:21.511788', NULL, 'Premium The Minimalist Khaki Pants Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (87, 'Cotton Polo Sweater Black White', 'cotton-polo-sweater-black-white', 9, '2026-05-26 12:22:22.006424', NULL, 'Premium Cotton Polo Sweater Black White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (88, 'Cotton Polo Sweater Brown Beige', 'cotton-polo-sweater-brown-beige', 9, '2026-05-26 12:22:22.043979', NULL, 'Premium Cotton Polo Sweater Brown Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (89, 'Cotton Polo Sweater Red Beige', 'cotton-polo-sweater-red-beige', 9, '2026-05-26 12:22:22.082833', NULL, 'Premium Cotton Polo Sweater Red Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (90, 'Cotton Sweatshirt Blue', 'cotton-sweatshirt-blue', 9, '2026-05-26 12:22:22.124536', NULL, 'Premium Cotton Sweatshirt Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (91, 'Cotton Sweatshirt Brown', 'cotton-sweatshirt-brown', 9, '2026-05-26 12:22:22.166227', NULL, 'Premium Cotton Sweatshirt Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (92, 'Long-Sleeve Sweater Black', 'long-sleeve-sweater-black', 9, '2026-05-26 12:22:22.203602', NULL, 'Premium Long-Sleeve Sweater Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (115, 'T1 ATI Beach Towel', 't1-ati-beach-towel', 5, '2026-05-27 06:10:02.29648', NULL, 'Premium T1 ATI Beach Towel, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (125, 'Air Jordan 1 Low G Spiked', 'air-jordan-1-low-g-spiked', 7, '2026-05-27 06:17:57.904271', NULL, 'Premium Air Jordan 1 Low G Spiked, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (93, 'Long-Sleeve Sweater Blue', 'long-sleeve-sweater-blue', 9, '2026-05-26 12:22:22.237829', NULL, 'Premium Long-Sleeve Sweater Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (94, 'Long-Sleeve Sweater White', 'long-sleeve-sweater-white', 9, '2026-05-26 12:22:22.271029', NULL, 'Premium Long-Sleeve Sweater White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (95, 'Zip-Neck Polo Sweater Gray', 'zip-neck-polo-sweater-gray', 9, '2026-05-26 12:22:22.306979', NULL, 'Premium Zip-Neck Polo Sweater Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (97, 'Boxy Raglan T-Shirt Brown', 'boxy-raglan-t-shirt-brown', 1, '2026-05-26 12:22:22.374197', NULL, 'Premium Boxy Raglan T-Shirt Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (98, 'Boxy Raglan T-Shirt Gray', 'boxy-raglan-t-shirt-gray', 1, '2026-05-26 12:22:22.407396', NULL, 'Premium Boxy Raglan T-Shirt Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (99, 'Boxy Raglan T-Shirt Green', 'boxy-raglan-t-shirt-green', 1, '2026-05-26 12:22:22.440058', NULL, 'Premium Boxy Raglan T-Shirt Green, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (103, 'FlexFit T-Shirt Black', 'flexfit-t-shirt-black', 1, '2026-05-26 12:22:22.56256', NULL, 'Premium FlexFit T-Shirt Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (104, 'FlexFit T-Shirt Blue', 'flexfit-t-shirt-blue', 1, '2026-05-26 12:22:22.592801', NULL, 'Premium FlexFit T-Shirt Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (105, 'FlexFit T-Shirt Gray', 'flexfit-t-shirt-gray', 1, '2026-05-26 12:22:22.626357', NULL, 'Premium FlexFit T-Shirt Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (106, 'FlexFit T-Shirt White', 'flexfit-t-shirt-white', 1, '2026-05-26 12:22:22.662759', NULL, 'Premium FlexFit T-Shirt White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (108, 'Disney Mickey_T1 Keychain', 'disney-mickeyt1-keychain', 5, '2026-05-27 06:09:55.771689', NULL, 'Premium Disney Mickey_T1 Keychain, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (109, 'Disney Mickey_T1 Mug', 'disney-mickeyt1-mug', 5, '2026-05-27 06:09:56.619411', NULL, 'Premium Disney Mickey_T1 Mug, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (110, 'Disney Minnie_T1 Keychain', 'disney-minniet1-keychain', 5, '2026-05-27 06:09:57.406033', NULL, 'Premium Disney Minnie_T1 Keychain, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (111, 'Disney_T1 Friends Roulette Keychain', 'disneyt1-friends-roulette-keychain', 5, '2026-05-27 06:09:58.401535', NULL, 'Premium Disney_T1 Friends Roulette Keychain, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (113, 'T1 Animal Friends Figure Keychain', 't1-animal-friends-figure-keychain', 5, '2026-05-27 06:10:00.482497', NULL, 'Premium T1 Animal Friends Figure Keychain, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (114, 'T1 Animal Friends Ticket Holder', 't1-animal-friends-ticket-holder', 5, '2026-05-27 06:10:01.303764', NULL, 'Premium T1 Animal Friends Ticket Holder, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (116, 'T1 ATI Reusable Bag', 't1-ati-reusable-bag', 5, '2026-05-27 06:10:03.286993', NULL, 'Premium T1 ATI Reusable Bag, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (117, 'T1 Docking Power Bank (5000mAh)', 't1-docking-power-bank-5000mah', 5, '2026-05-27 06:10:04.354466', NULL, 'Premium T1 Docking Power Bank (5000mAh), designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (118, 'T1 Eye Mask', 't1-eye-mask', 5, '2026-05-27 06:10:05.262983', NULL, 'Premium T1 Eye Mask, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (119, 'T1 logo Eco Bag', 't1-logo-eco-bag', 5, '2026-05-27 06:10:06.050812', NULL, 'Premium T1 logo Eco Bag, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (120, 'T1 Logo LED Keycap Keychain', 't1-logo-led-keycap-keychain', 5, '2026-05-27 06:10:07.062015', NULL, 'Premium T1 Logo LED Keycap Keychain, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (121, '[LoL] 2025 T1 Player Acrylic Figure', 'lol-2025-t1-player-acrylic-figure', 5, '2026-05-27 06:10:08.177921', NULL, 'Premium [LoL] 2025 T1 Player Acrylic Figure, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (96, 'Boxy Raglan T-Shirt Beige', 'boxy-raglan-t-shirt-beige', 1, '2026-05-26 12:22:22.342149', NULL, 'Premium Boxy Raglan T-Shirt Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (107, '2025 T1 Player Plushie', '2025-t1-player-plushie', 5, '2026-05-27 06:09:54.666709', NULL, 'Premium 2025 T1 Player Plushie, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (112, 'T1 3 in 1 Wireless Charger', 't1-3-in-1-wireless-charger', 5, '2026-05-27 06:09:59.444936', NULL, 'Premium T1 3 in 1 Wireless Charger, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (123, 'Disney_T1 Together Ball Cap', 'disneyt1-together-ball-cap', 6, '2026-05-27 06:10:10.486688', NULL, 'Premium Disney_T1 Together Ball Cap, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (126, 'Air Jordan 1 Low SE', 'air-jordan-1-low-se', 7, '2026-05-27 06:17:58.835697', NULL, 'Premium Air Jordan 1 Low SE, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (127, 'Book 2 ''Rising'' EP', 'book-2-rising-ep', 7, '2026-05-27 06:17:59.778189', NULL, 'Premium Book 2 ''Rising'' EP, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (128, 'Jordan Franchise ''Dayo 23''', 'jordan-franchise-dayo-23', 7, '2026-05-27 06:18:00.707583', NULL, 'Premium Jordan Franchise ''Dayo 23'', designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (129, 'Jordan Franchise', 'jordan-franchise', 7, '2026-05-27 06:18:02.38174', NULL, 'Premium Jordan Franchise, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (131, 'Nike Air Max 95 Big Bubble ''OG''', 'nike-air-max-95-big-bubble-og', 7, '2026-05-27 06:18:04.471095', NULL, 'Premium Nike Air Max 95 Big Bubble ''OG'', designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (132, 'Nike Air Max Dn Roam', 'nike-air-max-dn-roam', 7, '2026-05-27 06:18:05.524445', NULL, 'Premium Nike Air Max Dn Roam, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (133, 'Nike Air Max TL 2.5', 'nike-air-max-tl-25', 7, '2026-05-27 06:18:06.252011', NULL, 'Premium Nike Air Max TL 2.5, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (134, 'Nike Air Superfly', 'nike-air-superfly', 7, '2026-05-27 06:18:07.026715', NULL, 'Premium Nike Air Superfly, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (135, 'Nike Ava Rover', 'nike-ava-rover', 7, '2026-05-27 06:18:07.934761', NULL, 'Premium Nike Ava Rover, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (136, 'Nike Cortez', 'nike-cortez', 7, '2026-05-27 06:18:08.698501', NULL, 'Premium Nike Cortez, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (137, 'Nike Court Borough Low Essential+', 'nike-court-borough-low-essential', 7, '2026-05-27 06:18:09.469185', NULL, 'Premium Nike Court Borough Low Essential+, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (138, 'Nike Dunk Low Retro Premium', 'nike-dunk-low-retro-premium', 7, '2026-05-27 06:18:10.382742', NULL, 'Premium Nike Dunk Low Retro Premium, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (139, 'Nike Marina', 'nike-marina', 7, '2026-05-27 06:18:11.218638', NULL, 'Premium Nike Marina, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (140, 'Nike Offcourt Adjust', 'nike-offcourt-adjust', 7, '2026-05-27 06:18:12.409348', NULL, 'Premium Nike Offcourt Adjust, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (141, 'Nike Offcourt', 'nike-offcourt', 7, '2026-05-27 06:18:13.385281', NULL, 'Premium Nike Offcourt, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (142, 'Nike ReactX Rejuven8', 'nike-reactx-rejuven8', 7, '2026-05-27 06:18:14.19779', NULL, 'Premium Nike ReactX Rejuven8, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (143, 'Nike Tiempo Reactgato LE', 'nike-tiempo-reactgato-le', 7, '2026-05-27 06:18:15.132751', NULL, 'Premium Nike Tiempo Reactgato LE, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (34, 'AirDry™ Zip-Up Hoodie Blue', 'airdry-zip-up-hoodie-blue', 2, '2026-05-26 12:22:20.201405', NULL, 'Premium AirDry™ Zip-Up Hoodie Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (35, 'AirDry™ Zip-Up Hoodie Gray', 'airdry-zip-up-hoodie-gray', 2, '2026-05-26 12:22:20.244086', NULL, 'Premium AirDry™ Zip-Up Hoodie Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (36, 'EasyCare™ Hoodie Beige', 'easycare-hoodie-beige', 2, '2026-05-26 12:22:20.286896', NULL, 'Premium EasyCare™ Hoodie Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (37, 'EasyCare™ Hoodie Blue', 'easycare-hoodie-blue', 2, '2026-05-26 12:22:20.325136', NULL, 'Premium EasyCare™ Hoodie Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (38, 'EasyCare™ Hoodie Brown', 'easycare-hoodie-brown', 2, '2026-05-26 12:22:20.363842', NULL, 'Premium EasyCare™ Hoodie Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (39, 'EasyCare™ Hoodie Gray', 'easycare-hoodie-gray', 2, '2026-05-26 12:22:20.404585', NULL, 'Premium EasyCare™ Hoodie Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (43, 'DurableTex™ Corduroy Bomber Jacket Green', 'durabletex-corduroy-bomber-jacket-green', 3, '2026-05-26 12:22:20.572502', NULL, 'Premium DurableTex™ Corduroy Bomber Jacket Green, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (44, 'DurableTex™ Khaki Jacket Black', 'durabletex-khaki-jacket-black', 3, '2026-05-26 12:22:20.61697', NULL, 'Premium DurableTex™ Khaki Jacket Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (45, 'DurableTex™ Khaki Jacket Blue', 'durabletex-khaki-jacket-blue', 3, '2026-05-26 12:22:20.660614', NULL, 'Premium DurableTex™ Khaki Jacket Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (46, 'DurableTex™ Khaki Jacket White', 'durabletex-khaki-jacket-white', 3, '2026-05-26 12:22:20.701622', NULL, 'Premium DurableTex™ Khaki Jacket White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (47, 'DurableTex™ Khaki Jacket Yellow', 'durabletex-khaki-jacket-yellow', 3, '2026-05-26 12:22:20.741718', NULL, 'Premium DurableTex™ Khaki Jacket Yellow, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (48, 'DurableTex™ Sun-Protection Parka Beige', 'durabletex-sun-protection-parka-beige', 3, '2026-05-26 12:22:20.779922', NULL, 'Premium DurableTex™ Sun-Protection Parka Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (49, 'DurableTex™ Sun-Protection Parka Black', 'durabletex-sun-protection-parka-black', 3, '2026-05-26 12:22:20.815233', NULL, 'Premium DurableTex™ Sun-Protection Parka Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (50, 'DurableTex™ Sun-Protection Parka Brown', 'durabletex-sun-protection-parka-brown', 3, '2026-05-26 12:22:20.850426', NULL, 'Premium DurableTex™ Sun-Protection Parka Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (51, 'EasyCare™ Color-Block Parka Black', 'easycare-color-block-parka-black', 3, '2026-05-26 12:22:20.887553', NULL, 'Premium EasyCare™ Color-Block Parka Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (52, 'EasyCare™ Color-Block Parka Brown Beige', 'easycare-color-block-parka-brown-beige', 3, '2026-05-26 12:22:20.9208', NULL, 'Premium EasyCare™ Color-Block Parka Brown Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (53, 'EasyCare™ Color-Block Parka Green', 'easycare-color-block-parka-green', 3, '2026-05-26 12:22:20.95335', NULL, 'Premium EasyCare™ Color-Block Parka Green, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (54, 'AirDry™ Pants Black', 'airdry-pants-black', 4, '2026-05-26 12:22:20.986128', NULL, 'Premium AirDry™ Pants Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (55, 'AirDry™ Pants Gray', 'airdry-pants-gray', 4, '2026-05-26 12:22:21.018134', NULL, 'Premium AirDry™ Pants Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (58, 'DurableTex™ Baggy Jeans Blue', 'durabletex-baggy-jeans-blue', 4, '2026-05-26 12:22:21.114511', NULL, 'Premium DurableTex™ Baggy Jeans Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (59, 'DurableTex™ Baggy Jeans Navy', 'durabletex-baggy-jeans-navy', 4, '2026-05-26 12:22:21.148106', NULL, 'Premium DurableTex™ Baggy Jeans Navy, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (60, 'DurableTex™ Elegant Trousers Black', 'durabletex-elegant-trousers-black', 4, '2026-05-26 12:22:21.178563', NULL, 'Premium DurableTex™ Elegant Trousers Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (61, 'DurableTex™ Elegant Trousers Brown', 'durabletex-elegant-trousers-brown', 4, '2026-05-26 12:22:21.213998', NULL, 'Premium DurableTex™ Elegant Trousers Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (62, 'DurableTex™ Wide-Leg Khaki Pants Brown', 'durabletex-wide-leg-khaki-pants-brown', 4, '2026-05-26 12:22:21.255406', NULL, 'Premium DurableTex™ Wide-Leg Khaki Pants Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (63, 'FlexFit™ Jeans Blue', 'flexfit-jeans-blue', 4, '2026-05-26 12:22:21.292055', NULL, 'Premium FlexFit™ Jeans Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (64, 'FlexFit™ Jeans Brown', 'flexfit-jeans-brown', 4, '2026-05-26 12:22:21.323799', NULL, 'Premium FlexFit™ Jeans Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (65, 'FlexFit™ Jeans Dark Brown', 'flexfit-jeans-dark-brown', 4, '2026-05-26 12:22:21.35509', NULL, 'Premium FlexFit™ Jeans Dark Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (66, 'FlexFit™ Jeans Gray', 'flexfit-jeans-gray', 4, '2026-05-26 12:22:21.388827', NULL, 'Premium FlexFit™ Jeans Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (67, 'FlexFit™ Jeans White', 'flexfit-jeans-white', 4, '2026-05-26 12:22:21.419156', NULL, 'Premium FlexFit™ Jeans White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (69, 'Scuba CloudTouch™ Joggers Green', 'scuba-cloudtouch-joggers-green', 4, '2026-05-26 12:22:21.478733', NULL, 'Premium Scuba CloudTouch™ Joggers Green, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (71, 'DurableTex™ Classic Corduroy Short-Sleeve Shirt Dark Brown', 'durabletex-classic-corduroy-short-sleeve-shirt-dark-brown', 8, '2026-05-26 12:22:21.545471', NULL, 'Premium DurableTex™ Classic Corduroy Short-Sleeve Shirt Dark Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (72, 'DurableTex™ Classic Corduroy Short-Sleeve Shirt Green', 'durabletex-classic-corduroy-short-sleeve-shirt-green', 8, '2026-05-26 12:22:21.579361', NULL, 'Premium DurableTex™ Classic Corduroy Short-Sleeve Shirt Green, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (73, 'DurableTex™ Classic Corduroy Short-Sleeve Shirt Light Brown', 'durabletex-classic-corduroy-short-sleeve-shirt-light-brown', 8, '2026-05-26 12:22:21.595511', NULL, 'Premium DurableTex™ Classic Corduroy Short-Sleeve Shirt Light Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (75, 'DurableTex™ Denim Overshirt Dark Blue', 'durabletex-denim-overshirt-dark-blue', 8, '2026-05-26 12:22:21.648947', NULL, 'Premium DurableTex™ Denim Overshirt Dark Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (76, 'DurableTex™ Denim Overshirt Light Blue', 'durabletex-denim-overshirt-light-blue', 8, '2026-05-26 12:22:21.681716', NULL, 'Premium DurableTex™ Denim Overshirt Light Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (77, 'DurableTex™ Washed Khaki Overshirt Beige', 'durabletex-washed-khaki-overshirt-beige', 8, '2026-05-26 12:22:21.716278', NULL, 'Premium DurableTex™ Washed Khaki Overshirt Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (78, 'DurableTex™ Washed Khaki Overshirt Gray', 'durabletex-washed-khaki-overshirt-gray', 8, '2026-05-26 12:22:21.749696', NULL, 'Premium DurableTex™ Washed Khaki Overshirt Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (79, 'EasyCare™ Boxy Short-Sleeve Oxford Shirt Black', 'easycare-boxy-short-sleeve-oxford-shirt-black', 8, '2026-05-26 12:22:21.783772', NULL, 'Premium EasyCare™ Boxy Short-Sleeve Oxford Shirt Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (80, 'EasyCare™ Boxy Short-Sleeve Oxford Shirt Blue', 'easycare-boxy-short-sleeve-oxford-shirt-blue', 8, '2026-05-26 12:22:21.81728', NULL, 'Premium EasyCare™ Boxy Short-Sleeve Oxford Shirt Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (81, 'EasyCare™ Boxy Short-Sleeve Oxford Shirt Gray', 'easycare-boxy-short-sleeve-oxford-shirt-gray', 8, '2026-05-26 12:22:21.832669', NULL, 'Premium EasyCare™ Boxy Short-Sleeve Oxford Shirt Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (57, 'CloudTouch™ Jeans Blue', 'cloudtouch-jeans-blue', 4, '2026-05-26 12:22:21.082681', NULL, 'Premium CloudTouch™ Jeans Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (82, 'EasyCare™ Boxy Short-Sleeve Oxford Shirt White', 'easycare-boxy-short-sleeve-oxford-shirt-white', 8, '2026-05-26 12:22:21.848451', NULL, 'Premium EasyCare™ Boxy Short-Sleeve Oxford Shirt White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (84, 'CloudTouch™ MICHIGAN Sweater Black', 'cloudtouch-michigan-sweater-black', 9, '2026-05-26 12:22:21.902968', NULL, 'Premium CloudTouch™ MICHIGAN Sweater Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (85, 'CloudTouch™ MICHIGAN Sweater Brown', 'cloudtouch-michigan-sweater-brown', 9, '2026-05-26 12:22:21.936717', NULL, 'Premium CloudTouch™ MICHIGAN Sweater Brown, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (86, 'CloudTouch™ MICHIGAN Sweater Red', 'cloudtouch-michigan-sweater-red', 9, '2026-05-26 12:22:21.972703', NULL, 'Premium CloudTouch™ MICHIGAN Sweater Red, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (100, 'EasyCare™ T-Shirt Beige', 'easycare-t-shirt-beige', 1, '2026-05-26 12:22:22.469204', NULL, 'Premium EasyCare™ T-Shirt Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (101, 'EasyCare™ T-Shirt Black', 'easycare-t-shirt-black', 1, '2026-05-26 12:22:22.500614', NULL, 'Premium EasyCare™ T-Shirt Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (102, 'EasyCare™ T-Shirt White', 'easycare-t-shirt-white', 1, '2026-05-26 12:22:22.530889', NULL, 'Premium EasyCare™ T-Shirt White, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);
INSERT INTO public.products VALUES (33, 'AirDry™ Zip-Up Hoodie Black', 'airdry-zip-up-hoodie-black', 2, '2026-05-26 12:22:20.151486', NULL, 'Premium AirDry™ Zip-Up Hoodie Black, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (42, 'DurableTex™ Corduroy Bomber Jacket Blue', 'durabletex-corduroy-bomber-jacket-blue', 3, '2026-05-26 12:22:20.528318', NULL, 'Premium DurableTex™ Corduroy Bomber Jacket Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (68, 'Scuba CloudTouch™ Joggers Gray', 'scuba-cloudtouch-joggers-gray', 4, '2026-05-26 12:22:21.44937', NULL, 'Premium Scuba CloudTouch™ Joggers Gray, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (74, 'DurableTex™ Denim Overshirt Blue', 'durabletex-denim-overshirt-blue', 8, '2026-05-26 12:22:21.612331', NULL, 'Premium DurableTex™ Denim Overshirt Blue, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (83, 'CloudTouch™ MICHIGAN Sweater Beige', 'cloudtouch-michigan-sweater-beige', 9, '2026-05-26 12:22:21.864331', NULL, 'Premium CloudTouch™ MICHIGAN Sweater Beige, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (122, '[T1 x MiiR] Together All Day Straw Cup', 't1-x-miir-together-all-day-straw-cup', 5, '2026-05-27 06:10:09.589973', NULL, 'Premium [T1 x MiiR] Together All Day Straw Cup, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (124, 'Air Force 1 ''07 SE ''Valentine''s Day''', 'air-force-1-07-se-valentines-day', 7, '2026-05-27 06:17:57.120578', NULL, 'Premium Air Force 1 ''07 SE ''Valentine''s Day'', designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (130, 'Nike Air Force 1 ''07', 'nike-air-force-1-07', 7, '2026-05-27 06:18:03.575236', NULL, 'Premium Nike Air Force 1 ''07, designed for ultimate style and daily comfort. Part of our new seasonal collection.', true);
INSERT INTO public.products VALUES (144, 'Nike Victori One', 'nike-victori-one', 7, '2026-05-27 06:18:16.021049', '2026-06-10 07:20:20.643951', 'Premium Nike Victori One, designed for ultimate style and daily comfort. Part of our new seasonal collection.', false);


--
-- TOC entry 3593 (class 0 OID 16472)
-- Dependencies: 234
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reviews VALUES (1, 1, 68, 4, 'Amazing product! Highly recommend.', NULL, '2026-05-09 14:07:33.934', '2026-05-09 14:07:33.934');
INSERT INTO public.reviews VALUES (2, 10, 46, 5, '5 stars from me!', NULL, '2026-05-10 14:07:33.937', '2026-05-10 14:07:33.937');
INSERT INTO public.reviews VALUES (3, 6, 118, 5, 'Looks just like the pictures.', NULL, '2026-05-03 14:07:33.94', '2026-05-03 14:07:33.94');
INSERT INTO public.reviews VALUES (4, 3, 20, 3, 'Will definitely buy again.', NULL, '2026-04-19 14:07:33.942', '2026-04-19 14:07:33.942');
INSERT INTO public.reviews VALUES (5, 2, 100, 3, 'Looks just like the pictures.', NULL, '2026-05-04 14:07:33.943', '2026-05-04 14:07:33.943');
INSERT INTO public.reviews VALUES (6, 4, 56, 4, 'Looks just like the pictures.', NULL, '2026-04-06 14:07:33.944', '2026-04-06 14:07:33.944');
INSERT INTO public.reviews VALUES (7, 10, 69, 4, 'Quality is decent for the price.', NULL, '2026-04-30 14:07:33.945', '2026-04-30 14:07:33.945');
INSERT INTO public.reviews VALUES (8, 10, 97, 4, 'Quality is decent for the price.', NULL, '2026-03-31 14:07:33.947', '2026-03-31 14:07:33.947');
INSERT INTO public.reviews VALUES (9, 10, 65, 3, 'Amazing product! Highly recommend.', NULL, '2026-05-24 14:07:33.949', '2026-05-24 14:07:33.949');
INSERT INTO public.reviews VALUES (10, 10, 31, 3, 'The material is very comfortable.', NULL, '2026-04-08 14:07:33.951', '2026-04-08 14:07:33.951');
INSERT INTO public.reviews VALUES (11, 9, 34, 5, 'The material is very comfortable.', NULL, '2026-04-25 14:07:33.954', '2026-04-25 14:07:33.954');
INSERT INTO public.reviews VALUES (12, 10, 66, 5, 'Will definitely buy again.', NULL, '2026-05-04 14:07:33.955', '2026-05-04 14:07:33.955');
INSERT INTO public.reviews VALUES (13, 10, 44, 3, 'Love the design, fits perfectly!', NULL, '2026-05-12 14:07:33.957', '2026-05-12 14:07:33.957');
INSERT INTO public.reviews VALUES (14, 9, 78, 4, 'Amazing product! Highly recommend.', NULL, '2026-04-18 14:07:33.959', '2026-04-18 14:07:33.959');
INSERT INTO public.reviews VALUES (15, 11, 140, 4, 'Love the design, fits perfectly!', NULL, '2026-04-17 14:07:33.961', '2026-04-17 14:07:33.961');
INSERT INTO public.reviews VALUES (16, 6, 70, 5, 'Amazing product! Highly recommend.', NULL, '2026-05-13 14:07:33.964', '2026-05-13 14:07:33.964');
INSERT INTO public.reviews VALUES (17, 10, 124, 4, 'Looks just like the pictures.', NULL, '2026-05-17 14:07:33.966', '2026-05-17 14:07:33.966');
INSERT INTO public.reviews VALUES (18, 7, 124, 5, 'Delivery was a bit slow but the item is good.', NULL, '2026-05-09 14:07:33.969', '2026-05-09 14:07:33.969');
INSERT INTO public.reviews VALUES (19, 7, 80, 3, 'Not exactly what I expected, but still nice.', NULL, '2026-05-02 14:07:33.972', '2026-05-02 14:07:33.972');
INSERT INTO public.reviews VALUES (20, 7, 79, 4, 'Amazing product! Highly recommend.', NULL, '2026-05-20 14:07:33.974', '2026-05-20 14:07:33.974');
INSERT INTO public.reviews VALUES (21, 9, 104, 3, 'Not exactly what I expected, but still nice.', NULL, '2026-04-01 14:07:33.977', '2026-04-01 14:07:33.977');
INSERT INTO public.reviews VALUES (22, 2, 108, 3, 'Not exactly what I expected, but still nice.', NULL, '2026-04-16 14:07:33.978', '2026-04-16 14:07:33.978');
INSERT INTO public.reviews VALUES (23, 4, 80, 5, 'Will definitely buy again.', NULL, '2026-04-30 14:07:33.98', '2026-04-30 14:07:33.98');
INSERT INTO public.reviews VALUES (24, 11, 125, 3, 'Love the design, fits perfectly!', NULL, '2026-04-26 14:07:33.983', '2026-04-26 14:07:33.983');
INSERT INTO public.reviews VALUES (25, 10, 38, 3, 'Quality is decent for the price.', NULL, '2026-04-17 14:07:33.986', '2026-04-17 14:07:33.986');
INSERT INTO public.reviews VALUES (26, 1, 79, 5, 'Will definitely buy again.', NULL, '2026-04-21 14:07:33.988', '2026-04-21 14:07:33.988');
INSERT INTO public.reviews VALUES (27, 3, 101, 5, 'Delivery was a bit slow but the item is good.', NULL, '2026-04-16 14:07:33.991', '2026-04-16 14:07:33.991');
INSERT INTO public.reviews VALUES (28, 5, 107, 3, 'Best purchase ever!', NULL, '2026-05-01 14:07:33.993', '2026-05-01 14:07:33.993');
INSERT INTO public.reviews VALUES (29, 10, 74, 5, 'Best purchase ever!', NULL, '2026-05-13 14:07:33.996', '2026-05-13 14:07:33.996');
INSERT INTO public.reviews VALUES (30, 9, 53, 5, 'Looks just like the pictures.', NULL, '2026-05-03 14:07:33.998', '2026-05-03 14:07:33.998');
INSERT INTO public.reviews VALUES (31, 5, 76, 3, 'Amazing product! Highly recommend.', NULL, '2026-04-13 14:07:34.001', '2026-04-13 14:07:34.001');
INSERT INTO public.reviews VALUES (32, 11, 98, 3, 'Amazing product! Highly recommend.', NULL, '2026-04-16 14:07:34.003', '2026-04-16 14:07:34.003');
INSERT INTO public.reviews VALUES (33, 5, 70, 5, 'Best purchase ever!', NULL, '2026-05-09 14:07:34.005', '2026-05-09 14:07:34.005');
INSERT INTO public.reviews VALUES (34, 9, 64, 3, '5 stars from me!', NULL, '2026-04-12 14:07:34.007', '2026-04-12 14:07:34.007');
INSERT INTO public.reviews VALUES (35, 5, 54, 4, 'Looks just like the pictures.', NULL, '2026-05-01 14:07:34.01', '2026-05-01 14:07:34.01');
INSERT INTO public.reviews VALUES (36, 2, 128, 4, 'Love the design, fits perfectly!', NULL, '2026-05-10 14:07:34.012', '2026-05-10 14:07:34.012');
INSERT INTO public.reviews VALUES (37, 2, 87, 5, '5 stars from me!', NULL, '2026-04-08 14:07:34.014', '2026-04-08 14:07:34.014');
INSERT INTO public.reviews VALUES (38, 7, 72, 4, 'Quality is decent for the price.', NULL, '2026-04-30 14:07:34.016', '2026-04-30 14:07:34.016');
INSERT INTO public.reviews VALUES (39, 7, 71, 3, 'Love the design, fits perfectly!', NULL, '2026-05-06 14:07:34.019', '2026-05-06 14:07:34.019');
INSERT INTO public.reviews VALUES (40, 12, 70, 4, 'Quality is decent for the price.', NULL, '2026-04-02 14:07:34.021', '2026-04-02 14:07:34.021');
INSERT INTO public.reviews VALUES (41, 3, 66, 3, 'Will definitely buy again.', NULL, '2026-04-22 14:07:34.023', '2026-04-22 14:07:34.023');
INSERT INTO public.reviews VALUES (42, 4, 74, 3, 'Looks just like the pictures.', NULL, '2026-05-22 14:07:34.025', '2026-05-22 14:07:34.025');
INSERT INTO public.reviews VALUES (43, 1, 111, 3, 'The material is very comfortable.', NULL, '2026-05-04 14:07:34.027', '2026-05-04 14:07:34.027');
INSERT INTO public.reviews VALUES (44, 12, 40, 4, 'Quality is decent for the price.', NULL, '2026-05-03 14:07:34.028', '2026-05-03 14:07:34.028');
INSERT INTO public.reviews VALUES (45, 2, 42, 4, '5 stars from me!', NULL, '2026-05-05 14:07:34.03', '2026-05-05 14:07:34.03');
INSERT INTO public.reviews VALUES (46, 4, 140, 3, 'Looks just like the pictures.', NULL, '2026-04-27 14:07:34.032', '2026-04-27 14:07:34.032');
INSERT INTO public.reviews VALUES (47, 4, 81, 5, 'Best purchase ever!', NULL, '2026-04-22 14:07:34.034', '2026-04-22 14:07:34.034');
INSERT INTO public.reviews VALUES (48, 7, 125, 5, 'Looks just like the pictures.', NULL, '2026-05-22 14:07:34.038', '2026-05-22 14:07:34.038');
INSERT INTO public.reviews VALUES (49, 3, 30, 4, 'Not exactly what I expected, but still nice.', NULL, '2026-03-30 14:07:34.041', '2026-03-30 14:07:34.041');
INSERT INTO public.reviews VALUES (50, 1, 78, 4, 'Best purchase ever!', NULL, '2026-03-30 14:07:34.044', '2026-03-30 14:07:34.044');
INSERT INTO public.reviews VALUES (51, 7, 70, 3, 'Love the design, fits perfectly!', NULL, '2026-04-03 14:07:34.046', '2026-04-03 14:07:34.046');
INSERT INTO public.reviews VALUES (52, 9, 55, 4, 'The material is very comfortable.', NULL, '2026-05-11 14:07:34.047', '2026-05-11 14:07:34.047');
INSERT INTO public.reviews VALUES (53, 1, 142, 3, 'Looks just like the pictures.', NULL, '2026-05-05 14:07:34.048', '2026-05-05 14:07:34.048');
INSERT INTO public.reviews VALUES (54, 10, 105, 5, 'Love the design, fits perfectly!', NULL, '2026-04-21 14:07:34.049', '2026-04-21 14:07:34.049');
INSERT INTO public.reviews VALUES (55, 7, 113, 3, 'The material is very comfortable.', NULL, '2026-05-20 14:07:34.052', '2026-05-20 14:07:34.052');
INSERT INTO public.reviews VALUES (56, 11, 19, 5, 'Sản phẩm cực kỳ chất lượng, chất vải dày dặn và mặc rất thoải mái. Áo hoodie này phối đồ cực đẹp!', 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&q=80&w=600', '2026-06-10 11:22:12.703174', '2026-06-10 11:22:12.703174');
INSERT INTO public.reviews VALUES (57, 12, 20, 5, 'Giao hàng nhanh, đóng gói cẩn thận. Sản phẩm hoàn toàn giống hình mô tả, vải mặc mát mẻ, form siêu rộng đẹp.', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&q=80&w=600', '2026-06-10 11:22:12.712092', '2026-06-10 11:22:12.712092');
INSERT INTO public.reviews VALUES (58, 3, 21, 5, 'Cực kỳ ưng ý luôn! Thiết kế đẹp mắt, tôn dáng và mang đậm phong cách T1. Sẽ ủng hộ shop thêm nhiều lần nữa.', 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&q=80&w=600', '2026-06-10 11:22:12.715992', '2026-06-10 11:22:12.715992');
INSERT INTO public.reviews VALUES (59, 11, 22, 5, 'Chất lượng áo thun này quá đỉnh! Vải 100% cotton dày dặn, hình in sắc nét không bị bong tróc khi giặt.', 'https://images.unsplash.com/photo-1562157873-818bc0726f68?auto=format&fit=crop&q=80&w=600', '2026-06-10 11:22:12.719643', '2026-06-10 11:22:12.719643');


--
-- TOC entry 3595 (class 0 OID 16481)
-- Dependencies: 236
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (11, 'chivinh123abes', 'mail.yuukimy1ne@gmail.com', '$2b$08$3y9RYP89mIuXzrXaxRG8qen6UDeA62o36dm0VoWTZ6qlIuDygpWJK', '0394442221', 0, 0, NULL, '2026-05-14 17:04:33.918977', NULL, '019e25f1-f2fd-732c-b94a-5fdd178c2e1c', false, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (12, 'chivinh123abessa', 'mail.yuukim1y1ne@gmail.com', '$2b$08$gWYAwojkXXPQfh9jb40ko.yku9oSxpanPFeiNPBJtttCL.A94Y7.O', '0394442221', 0, 0, NULL, '2026-05-14 17:07:16.29252', '2026-05-14 17:07:50.399303', NULL, true, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (3, 'admin1', 'ryanluong01@gmail.com', '$2b$08$imgjQLlITnHFhbpT6JNlnOXbrlBDet2mAcF4XcwahMLrhnGWPKata', '0839123123', 1, 0, NULL, '2026-04-15 21:52:04.785666', '2026-05-12 22:11:39.58524', '019d91a0-c130-72ce-aeb9-65f30428ad81', true, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (6, 'chivinh123abcd', 'mail.lcvinh2@gmail.com', '$2b$08$tzGt1aPVH4HICO2DL7vsGu8le/tqkTXxVCeWi9iwJo6pcbYSq.DaG', '0908223312', 0, 0, NULL, '2026-05-13 16:42:26.386268', NULL, '019e20b7-5b85-73b8-9aaf-dd3c18989410', false, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (7, 'chivinh123abcde', 'mail.lcvinh3@gmail.com', '$2b$08$/b9VcrQ/jiUZK7WB8bAhS.myThG4ZacugSP208CZUKZHN/NW7ZEaa', '0394063997', 0, 0, NULL, '2026-05-13 16:45:43.883289', NULL, '019e20ba-5ffd-733d-b0a7-be1374a8974e', false, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (4, 'user123abc', 'ryanluong02@gmail.com', '$2b$08$Jaq01J.MrftvQCYELTTsuO.UQLoZayZWe9Qh5BHT.wdameS9z0Xa.', '0839123124', 0, 0, NULL, '2026-04-15 21:52:20.593114', '2026-05-14 20:22:57.798382', '019d91a0-fef0-729c-8de2-1900d7c8be41', true, false, '123, X├ú Bß╗Öc Bß╗æ, Huyß╗çn P├íc Nß║╖m, Tß╗ënh Bß║»c Kß║ín', 'Ryanluong123', 'Luong Chi Vinh', NULL);
INSERT INTO public.users VALUES (9, 'chivinh123abv', 'mail.yuukimyne2@gmail.com', '$2b$08$bxWOY6Yn8SSti3fnc0G4YO4NgX1WfyxiJR2SwA.dNWDocoXuPWax6', '0394442221', 0, 0, NULL, '2026-05-13 17:24:28.489511', '2026-05-13 17:46:22.135337', NULL, true, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (2, 'user', 'user1@gmail.com', '$2b$08$qOQjeCmTakg7i9tnlSCDu.aknRbrxzuglilq5C44thDPRaPlTyF6C', NULL, 0, 1, NULL, '2026-04-15 21:20:13.481852', '2026-05-12 22:11:41.340714', NULL, true, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (1, 'admin', 'admin@gmail.com', '$2b$08$qOQjeCmTakg7i9tnlSCDu.aknRbrxzuglilq5C44thDPRaPlTyF6C', '', 1, 1, NULL, '2026-04-15 21:20:13.481852', '2026-05-12 22:15:24.753527', NULL, true, false, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES (5, 'chivinh123abc', 'mail.lcvinh@gmail.com', '$2b$08$gKs1u4Q0KegIChPzacNAd.u/R2MpdCD5Tgi4NBNpbb2CKbXr204WC', '0394063999', 0, 0, NULL, '2026-05-13 16:28:10.718789', '2026-06-09 15:05:30.769817', '019e20aa-4921-742c-802f-ddac653b71a7', false, false, NULL, NULL, NULL, '019eacea-d191-71a9-9aed-b79a0bf6fed8');
INSERT INTO public.users VALUES (10, 'chivinh123abe', 'mail.yuukimyne@gmail.com', '$2b$08$aSQGQnor2/uZm7zqKAUOcOdaPbBYVIcAfEkaQ0cs9ldzD74wpD6Vu', '0394442221', 0, 2, NULL, '2026-05-14 17:03:15.983699', '2026-06-09 15:23:44.855522', '019e25fa-2a2f-7758-978a-f020c129542c', false, false, NULL, NULL, NULL, NULL);


--
-- TOC entry 3597 (class 0 OID 16492)
-- Dependencies: 238
-- Data for Name: variant_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.variant_options VALUES (1, 1, 'S', 'size-tshirt-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (2, 1, 'M', 'size-tshirt-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (3, 1, 'L', 'size-tshirt-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (4, 1, 'XL', 'size-tshirt-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (5, 1, 'XXL', 'size-tshirt-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (6, 2, 'S', 'size-hoodie-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (7, 2, 'M', 'size-hoodie-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (8, 2, 'L', 'size-hoodie-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (9, 2, 'XL', 'size-hoodie-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (10, 2, 'XXL', 'size-hoodie-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (11, 3, 'S', 'size-jacket-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (12, 3, 'M', 'size-jacket-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (13, 3, 'L', 'size-jacket-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (14, 3, 'XL', 'size-jacket-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (15, 3, 'XXL', 'size-jacket-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (16, 4, 'S', 'size-pants-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (17, 4, 'M', 'size-pants-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (18, 4, 'L', 'size-pants-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (19, 4, 'XL', 'size-pants-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (20, 4, 'XXL', 'size-pants-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (21, 5, 'S', 'size-accessories-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (22, 5, 'M', 'size-accessories-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (23, 5, 'L', 'size-accessories-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (24, 5, 'XL', 'size-accessories-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (25, 5, 'XXL', 'size-accessories-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (26, 6, 'S', 'size-hat-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (27, 6, 'M', 'size-hat-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (28, 6, 'L', 'size-hat-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (29, 6, 'XL', 'size-hat-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (30, 6, 'XXL', 'size-hat-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (31, 7, 'S', 'size-shoes-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (32, 7, 'M', 'size-shoes-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (33, 7, 'L', 'size-shoes-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (34, 7, 'XL', 'size-shoes-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (35, 7, 'XXL', 'size-shoes-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (36, 8, 'S', 'size-shirt-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (37, 8, 'M', 'size-shirt-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (38, 8, 'L', 'size-shirt-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (39, 8, 'XL', 'size-shirt-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (40, 8, 'XXL', 'size-shirt-xxl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (41, 9, 'S', 'size-sweater-s', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (42, 9, 'M', 'size-sweater-m', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (43, 9, 'L', 'size-sweater-l', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (44, 9, 'XL', 'size-sweater-xl', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variant_options VALUES (45, 9, 'XXL', 'size-sweater-xxl', '2026-05-13 16:08:05.925763', NULL);


--
-- TOC entry 3599 (class 0 OID 16499)
-- Dependencies: 240
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.variants VALUES (1, 1, 'Size', 'size-tshirt', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (2, 2, 'Size', 'size-hoodie', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (3, 3, 'Size', 'size-jacket', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (4, 4, 'Size', 'size-pants', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (5, 5, 'Size', 'size-accessories', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (6, 6, 'Size', 'size-hat', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (7, 7, 'Size', 'size-shoes', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (8, 8, 'Size', 'size-shirt', '2026-05-13 16:08:05.925763', NULL);
INSERT INTO public.variants VALUES (9, 9, 'Size', 'size-sweater', '2026-05-13 16:08:05.925763', NULL);


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 215
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_cart_item_id_seq', 11, true);


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 217
-- Name: carts_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_cart_id_seq', 1, true);


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 219
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 9, true);


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 221
-- Name: collections_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collections_collection_id_seq', 22, true);


--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 223
-- Name: discounts_discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discounts_discount_id_seq', 3, true);


--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 225
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 420, true);


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 172, true);


--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_items_product_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_items_product_item_id_seq', 648, true);


--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 233
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 144, true);


--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 235
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 59, true);


--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 237
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 12, true);


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 239
-- Name: variant_options_variant_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.variant_options_variant_option_id_seq', 45, true);


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 241
-- Name: variants_variant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.variants_variant_id_seq', 9, true);


--
-- TOC entry 3370 (class 2606 OID 16520)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);


--
-- TOC entry 3372 (class 2606 OID 16522)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);


--
-- TOC entry 3374 (class 2606 OID 16524)
-- Name: categories categories_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_slug_key UNIQUE (category_slug);


--
-- TOC entry 3376 (class 2606 OID 16526)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 3378 (class 2606 OID 16528)
-- Name: collections collections_collection_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_collection_slug_key UNIQUE (collection_slug);


--
-- TOC entry 3380 (class 2606 OID 16530)
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (collection_id);


--
-- TOC entry 3382 (class 2606 OID 16532)
-- Name: discounts discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (discount_id);


--
-- TOC entry 3384 (class 2606 OID 16534)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 3386 (class 2606 OID 16536)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3388 (class 2606 OID 16538)
-- Name: product_collections product_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collections
    ADD CONSTRAINT product_collections_pkey PRIMARY KEY (product_id, collection_id);


--
-- TOC entry 3390 (class 2606 OID 16540)
-- Name: product_configurations product_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_configurations
    ADD CONSTRAINT product_configurations_pkey PRIMARY KEY (product_item_id, variant_option_id);


--
-- TOC entry 3392 (class 2606 OID 16542)
-- Name: product_items product_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
    ADD CONSTRAINT product_items_pkey PRIMARY KEY (product_item_id);


--
-- TOC entry 3394 (class 2606 OID 16544)
-- Name: product_items product_items_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
    ADD CONSTRAINT product_items_sku_key UNIQUE (sku);


--
-- TOC entry 3396 (class 2606 OID 16546)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3398 (class 2606 OID 16548)
-- Name: products products_product_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_slug_key UNIQUE (product_slug);


--
-- TOC entry 3400 (class 2606 OID 16550)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 3402 (class 2606 OID 16552)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3404 (class 2606 OID 16554)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3406 (class 2606 OID 16556)
-- Name: variant_options variant_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_pkey PRIMARY KEY (variant_option_id);


--
-- TOC entry 3408 (class 2606 OID 16558)
-- Name: variant_options variant_options_variant_option_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_variant_option_slug_key UNIQUE (variant_option_slug);


--
-- TOC entry 3410 (class 2606 OID 16560)
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (variant_id);


--
-- TOC entry 3412 (class 2606 OID 16562)
-- Name: variants variants_variant_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_variant_slug_key UNIQUE (variant_slug);


--
-- TOC entry 3413 (class 2606 OID 16563)
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(cart_id) ON DELETE RESTRICT;


--
-- TOC entry 3414 (class 2606 OID 16568)
-- Name: cart_items cart_items_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items(product_item_id) ON DELETE RESTRICT;


--
-- TOC entry 3415 (class 2606 OID 16573)
-- Name: carts carts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE RESTRICT;


--
-- TOC entry 3416 (class 2606 OID 16578)
-- Name: collections collections_parent_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_parent_collection_id_fkey FOREIGN KEY (parent_collection_id) REFERENCES public.collections(collection_id) ON DELETE SET NULL;


--
-- TOC entry 3417 (class 2606 OID 16583)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE RESTRICT;


--
-- TOC entry 3418 (class 2606 OID 16588)
-- Name: order_items order_items_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items(product_item_id) ON DELETE RESTRICT;


--
-- TOC entry 3419 (class 2606 OID 16593)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE RESTRICT;


--
-- TOC entry 3420 (class 2606 OID 16598)
-- Name: product_collections product_collections_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collections
    ADD CONSTRAINT product_collections_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(collection_id) ON DELETE CASCADE;


--
-- TOC entry 3421 (class 2606 OID 16603)
-- Name: product_collections product_collections_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collections
    ADD CONSTRAINT product_collections_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- TOC entry 3422 (class 2606 OID 16608)
-- Name: product_configurations product_configurations_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_configurations
    ADD CONSTRAINT product_configurations_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items(product_item_id) ON DELETE RESTRICT;


--
-- TOC entry 3423 (class 2606 OID 16613)
-- Name: product_configurations product_configurations_variant_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_configurations
    ADD CONSTRAINT product_configurations_variant_option_id_fkey FOREIGN KEY (variant_option_id) REFERENCES public.variant_options(variant_option_id) ON DELETE RESTRICT;


--
-- TOC entry 3424 (class 2606 OID 16618)
-- Name: product_items product_items_discount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
    ADD CONSTRAINT product_items_discount_id_fkey FOREIGN KEY (discount_id) REFERENCES public.discounts(discount_id) ON DELETE SET NULL;


--
-- TOC entry 3425 (class 2606 OID 16623)
-- Name: product_items product_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
    ADD CONSTRAINT product_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE RESTRICT;


--
-- TOC entry 3426 (class 2606 OID 16628)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE RESTRICT;


--
-- TOC entry 3427 (class 2606 OID 16633)
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- TOC entry 3428 (class 2606 OID 16638)
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3429 (class 2606 OID 16643)
-- Name: variant_options variant_options_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variants(variant_id) ON DELETE RESTRICT;


--
-- TOC entry 3430 (class 2606 OID 16648)
-- Name: variants variants_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE RESTRICT;


--
-- TOC entry 3431 (class 2606 OID 16660)
-- Name: orders orders_payment_method_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_payment_method_check CHECK ((payment_method::text = ANY (ARRAY['cod'::text, 'momo'::text])));


-- Completed on 2026-06-10 18:48:44

--
-- PostgreSQL database dump complete
--

