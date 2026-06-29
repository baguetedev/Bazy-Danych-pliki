--
-- PostgreSQL database dump
--

\restrict tysgav1LkHF2naeuL5mEWQlAPYd6ENNFAcRg83bG0WUZ6MeGO3PKsaUNngDGtT0

-- Dumped from database version 17.10 (Debian 17.10-0+deb13u1)
-- Dumped by pg_dump version 17.10 (Debian 17.10-0+deb13u1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: autorzy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autorzy (
    id_autora integer NOT NULL,
    imie character varying(50),
    nazwisko character varying(50)
);


ALTER TABLE public.autorzy OWNER TO postgres;

--
-- Name: autorzy_id_autora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autorzy_id_autora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autorzy_id_autora_seq OWNER TO postgres;

--
-- Name: autorzy_id_autora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autorzy_id_autora_seq OWNED BY public.autorzy.id_autora;


--
-- Name: czytelnicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.czytelnicy (
    id_czytelnika integer NOT NULL,
    imie character varying(50),
    nazwisko character varying(50),
    ulica character varying(100),
    kod_pocztowy character varying(6),
    miasto character varying(50),
    data_zapisu date DEFAULT CURRENT_DATE
);


ALTER TABLE public.czytelnicy OWNER TO postgres;

--
-- Name: czytelnicy_id_czytelnika_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.czytelnicy_id_czytelnika_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.czytelnicy_id_czytelnika_seq OWNER TO postgres;

--
-- Name: czytelnicy_id_czytelnika_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.czytelnicy_id_czytelnika_seq OWNED BY public.czytelnicy.id_czytelnika;


--
-- Name: kategorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategorie (
    id_kategorii integer NOT NULL,
    nazwa_kategorii character varying(50)
);


ALTER TABLE public.kategorie OWNER TO postgres;

--
-- Name: kategorie_id_kategorii_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategorie_id_kategorii_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kategorie_id_kategorii_seq OWNER TO postgres;

--
-- Name: kategorie_id_kategorii_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategorie_id_kategorii_seq OWNED BY public.kategorie.id_kategorii;


--
-- Name: ksiazki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ksiazki (
    id_ksiazki integer NOT NULL,
    id_autora integer,
    id_kategorii integer,
    tytul character varying(150) NOT NULL,
    rok_wydania smallint
);


ALTER TABLE public.ksiazki OWNER TO postgres;

--
-- Name: ksiazki_id_ksiazki_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ksiazki_id_ksiazki_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ksiazki_id_ksiazki_seq OWNER TO postgres;

--
-- Name: ksiazki_id_ksiazki_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ksiazki_id_ksiazki_seq OWNED BY public.ksiazki.id_ksiazki;


--
-- Name: wypozyczenia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wypozyczenia (
    id_wypozyczenia integer NOT NULL,
    id_czytelnika integer,
    id_ksiazki integer,
    data_wypozyczenia date DEFAULT CURRENT_DATE,
    data_zwrotu date
);


ALTER TABLE public.wypozyczenia OWNER TO postgres;

--
-- Name: wypozyczenia_id_wypozyczenia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wypozyczenia_id_wypozyczenia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wypozyczenia_id_wypozyczenia_seq OWNER TO postgres;

--
-- Name: wypozyczenia_id_wypozyczenia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wypozyczenia_id_wypozyczenia_seq OWNED BY public.wypozyczenia.id_wypozyczenia;


--
-- Name: autorzy id_autora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorzy ALTER COLUMN id_autora SET DEFAULT nextval('public.autorzy_id_autora_seq'::regclass);


--
-- Name: czytelnicy id_czytelnika; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.czytelnicy ALTER COLUMN id_czytelnika SET DEFAULT nextval('public.czytelnicy_id_czytelnika_seq'::regclass);


--
-- Name: kategorie id_kategorii; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategorie ALTER COLUMN id_kategorii SET DEFAULT nextval('public.kategorie_id_kategorii_seq'::regclass);


--
-- Name: ksiazki id_ksiazki; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ksiazki ALTER COLUMN id_ksiazki SET DEFAULT nextval('public.ksiazki_id_ksiazki_seq'::regclass);


--
-- Name: wypozyczenia id_wypozyczenia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wypozyczenia ALTER COLUMN id_wypozyczenia SET DEFAULT nextval('public.wypozyczenia_id_wypozyczenia_seq'::regclass);


--
-- Data for Name: autorzy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autorzy (id_autora, imie, nazwisko) FROM stdin;
1	Andrzej	Sapkowski
2	Adam	Mickiewicz
3	Stephen	King
\.


--
-- Data for Name: czytelnicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.czytelnicy (id_czytelnika, imie, nazwisko, ulica, kod_pocztowy, miasto, data_zapisu) FROM stdin;
1	Jan	Kowalski	Kwiatowa 1	00-001	Warszawa	2024-01-15
2	Anna	Nowak	Polna 2	31-444	Kraków	2023-11-05
\.


--
-- Data for Name: kategorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategorie (id_kategorii, nazwa_kategorii) FROM stdin;
1	Fantastyka
2	Kryminał
3	Literatura faktu
4	Poezja
5	Horror
\.


--
-- Data for Name: ksiazki; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ksiazki (id_ksiazki, id_autora, id_kategorii, tytul, rok_wydania) FROM stdin;
1	1	1	Wiedźmin	1993
2	2	4	Pan Tadeusz	1834
3	3	5	Lśnienie	1977
\.


--
-- Data for Name: wypozyczenia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wypozyczenia (id_wypozyczenia, id_czytelnika, id_ksiazki, data_wypozyczenia, data_zwrotu) FROM stdin;
1	1	1	2024-03-01	2024-03-15
2	1	2	2024-03-10	\N
3	2	3	2024-02-20	2024-03-05
\.


--
-- Name: autorzy_id_autora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autorzy_id_autora_seq', 3, true);


--
-- Name: czytelnicy_id_czytelnika_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.czytelnicy_id_czytelnika_seq', 2, true);


--
-- Name: kategorie_id_kategorii_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategorie_id_kategorii_seq', 5, true);


--
-- Name: ksiazki_id_ksiazki_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ksiazki_id_ksiazki_seq', 3, true);


--
-- Name: wypozyczenia_id_wypozyczenia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wypozyczenia_id_wypozyczenia_seq', 3, true);


--
-- Name: autorzy autorzy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorzy
    ADD CONSTRAINT autorzy_pkey PRIMARY KEY (id_autora);


--
-- Name: czytelnicy czytelnicy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.czytelnicy
    ADD CONSTRAINT czytelnicy_pkey PRIMARY KEY (id_czytelnika);


--
-- Name: kategorie kategorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategorie
    ADD CONSTRAINT kategorie_pkey PRIMARY KEY (id_kategorii);


--
-- Name: ksiazki ksiazki_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ksiazki
    ADD CONSTRAINT ksiazki_pkey PRIMARY KEY (id_ksiazki);


--
-- Name: wypozyczenia wypozyczenia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wypozyczenia
    ADD CONSTRAINT wypozyczenia_pkey PRIMARY KEY (id_wypozyczenia);


--
-- Name: ksiazki ksiazki_id_autora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ksiazki
    ADD CONSTRAINT ksiazki_id_autora_fkey FOREIGN KEY (id_autora) REFERENCES public.autorzy(id_autora);


--
-- Name: ksiazki ksiazki_id_kategorii_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ksiazki
    ADD CONSTRAINT ksiazki_id_kategorii_fkey FOREIGN KEY (id_kategorii) REFERENCES public.kategorie(id_kategorii);


--
-- Name: wypozyczenia wypozyczenia_id_czytelnika_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wypozyczenia
    ADD CONSTRAINT wypozyczenia_id_czytelnika_fkey FOREIGN KEY (id_czytelnika) REFERENCES public.czytelnicy(id_czytelnika);


--
-- Name: wypozyczenia wypozyczenia_id_ksiazki_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wypozyczenia
    ADD CONSTRAINT wypozyczenia_id_ksiazki_fkey FOREIGN KEY (id_ksiazki) REFERENCES public.ksiazki(id_ksiazki);


--
-- PostgreSQL database dump complete
--

\unrestrict tysgav1LkHF2naeuL5mEWQlAPYd6ENNFAcRg83bG0WUZ6MeGO3PKsaUNngDGtT0

