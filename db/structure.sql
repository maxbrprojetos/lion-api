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
-- Name: completions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE completions (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    completable_id uuid,
    completable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id uuid
);


--
-- Name: notices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notices (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    title text,
    type character varying(255) DEFAULT 'warning'::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    app character varying(255)
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    title text,
    completed boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id uuid,
    assignee_id uuid
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
    updated_at timestamp without time zone,
    points integer DEFAULT 0
);


--
-- Name: completions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY completions
    ADD CONSTRAINT completions_pkey PRIMARY KEY (id);


--
-- Name: notices_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notices
    ADD CONSTRAINT notices_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


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

