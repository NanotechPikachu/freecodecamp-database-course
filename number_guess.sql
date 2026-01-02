--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: guess; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guess (
    username character varying(22) NOT NULL,
    guesses integer DEFAULT 0 NOT NULL,
    played integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.guess OWNER TO freecodecamp;

--
-- Data for Name: guess; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guess VALUES ('atesh', 1, 1);
INSERT INTO public.guess VALUES ('user_1767347204076', 6, 1);
INSERT INTO public.guess VALUES ('user_1767347204075', 9, 1);
INSERT INTO public.guess VALUES ('user_1767347670932', 2, 2);
INSERT INTO public.guess VALUES ('user_1767347672557', 3, 2);
INSERT INTO public.guess VALUES ('user_1767347670933', 3, 4);
INSERT INTO public.guess VALUES ('user_1767347672558', 4, 4);
INSERT INTO public.guess VALUES ('user_1767347814852', 5, 2);
INSERT INTO public.guess VALUES ('user_1767347814853', 2, 5);
INSERT INTO public.guess VALUES ('user_1767347857296', 379, 2);
INSERT INTO public.guess VALUES ('user_1767347857297', 195, 5);
INSERT INTO public.guess VALUES ('user_1767347933608', 225, 2);
INSERT INTO public.guess VALUES ('user_1767347933609', 75, 5);


--
-- PostgreSQL database dump complete
--

