--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE access_tokens (
    id integer NOT NULL,
    user_id uuid NOT NULL,
    access_token character varying(255) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE access_tokens_id_seq OWNED BY access_tokens.id;


--
-- Name: badges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE badges (
    id integer NOT NULL,
    user_id uuid,
    pull_request_id uuid,
    body text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: badges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE badges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: badges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE badges_id_seq OWNED BY badges.id;


--
-- Name: pull_request_reviews; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pull_request_reviews (
    id integer NOT NULL,
    user_id uuid,
    pull_request_id uuid,
    body text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pull_request_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pull_request_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pull_request_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pull_request_reviews_id_seq OWNED BY pull_request_reviews.id;


--
-- Name: pull_requests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pull_requests (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    base_repo_full_name character varying(255),
    number integer,
    user_id uuid,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    number_of_comments integer,
    number_of_commits integer,
    number_of_additions integer,
    number_of_deletions integer,
    number_of_changed_files integer,
    merged_at timestamp without time zone
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: scores; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE scores (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id uuid,
    points integer DEFAULT 0,
    time_span character varying(255) DEFAULT 'all_time'::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying(255),
    nickname character varying(255),
    email character varying(255),
    avatar_url character varying(255),
    api_token character varying(255),
    github_id character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: weekly_winnings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE weekly_winnings (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    winner_id uuid,
    start_date date,
    points integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY access_tokens ALTER COLUMN id SET DEFAULT nextval('access_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY badges ALTER COLUMN id SET DEFAULT nextval('badges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pull_request_reviews ALTER COLUMN id SET DEFAULT nextval('pull_request_reviews_id_seq'::regclass);


--
-- Name: access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (id);


--
-- Name: badges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY badges
    ADD CONSTRAINT badges_pkey PRIMARY KEY (id);


--
-- Name: pull_request_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pull_request_reviews
    ADD CONSTRAINT pull_request_reviews_pkey PRIMARY KEY (id);


--
-- Name: pull_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_pkey PRIMARY KEY (id);


--
-- Name: scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weekly_winnings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weekly_winnings
    ADD CONSTRAINT weekly_winnings_pkey PRIMARY KEY (id);


--
-- Name: index_access_tokens_on_access_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_access_tokens_on_access_token ON access_tokens USING btree (access_token);


--
-- Name: index_access_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_access_tokens_on_user_id ON access_tokens USING btree (user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131229155016');

INSERT INTO schema_migrations (version) VALUES ('20131229155017');

INSERT INTO schema_migrations (version) VALUES ('20140109172823');

INSERT INTO schema_migrations (version) VALUES ('20140114201221');

INSERT INTO schema_migrations (version) VALUES ('20140117105727');

INSERT INTO schema_migrations (version) VALUES ('20140117111005');

INSERT INTO schema_migrations (version) VALUES ('20140117163026');

INSERT INTO schema_migrations (version) VALUES ('20140119144046');

INSERT INTO schema_migrations (version) VALUES ('20140119153421');

INSERT INTO schema_migrations (version) VALUES ('20140130113827');

INSERT INTO schema_migrations (version) VALUES ('20140130114414');

INSERT INTO schema_migrations (version) VALUES ('20140305145044');

INSERT INTO schema_migrations (version) VALUES ('20140306095102');

INSERT INTO schema_migrations (version) VALUES ('20140306144333');

INSERT INTO schema_migrations (version) VALUES ('20140306144642');

INSERT INTO schema_migrations (version) VALUES ('20140308163203');

INSERT INTO schema_migrations (version) VALUES ('20140312142045');

INSERT INTO schema_migrations (version) VALUES ('20140312155402');

INSERT INTO schema_migrations (version) VALUES ('20140314164600');

INSERT INTO schema_migrations (version) VALUES ('20140317174840');

INSERT INTO schema_migrations (version) VALUES ('20140317181014');

INSERT INTO schema_migrations (version) VALUES ('20140317181219');

INSERT INTO schema_migrations (version) VALUES ('20140328152146');

INSERT INTO schema_migrations (version) VALUES ('20140402201031');

INSERT INTO schema_migrations (version) VALUES ('20140412113638');

INSERT INTO schema_migrations (version) VALUES ('20140929114547');

INSERT INTO schema_migrations (version) VALUES ('20150313115749');

INSERT INTO schema_migrations (version) VALUES ('20151204231151');

INSERT INTO schema_migrations (version) VALUES ('20151204231249');

INSERT INTO schema_migrations (version) VALUES ('20151204231312');

