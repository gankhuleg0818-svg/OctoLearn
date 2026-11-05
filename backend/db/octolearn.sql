--
-- PostgreSQL database dump
--

\restrict s5KTVZIampDdh4EwfVAAn99Is4fAzcpU7upl4oW0KVs5yMIXWg4cCKb31MDLmrZ

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

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
-- Name: app_settings; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.app_settings (
    key text NOT NULL,
    value text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.app_settings OWNER TO octolearn;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.courses (
    id text NOT NULL,
    title text NOT NULL,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.courses OWNER TO octolearn;

--
-- Name: lesson_completions; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.lesson_completions (
    user_id uuid NOT NULL,
    lesson_id text NOT NULL,
    xp_earned integer NOT NULL,
    completed_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lesson_completions OWNER TO octolearn;

--
-- Name: lessons; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.lessons (
    id text NOT NULL,
    unit_id text NOT NULL,
    "position" integer NOT NULL,
    title text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    video_url text NOT NULL,
    duration_sec integer NOT NULL,
    xp integer DEFAULT 10 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    bunny_video_id text,
    video_fallback_url text,
    video_status text DEFAULT 'ready'::text NOT NULL,
    CONSTRAINT lessons_duration_sec_check CHECK ((duration_sec > 0)),
    CONSTRAINT lessons_video_status_check CHECK ((video_status = ANY (ARRAY['ready'::text, 'processing'::text, 'error'::text]))),
    CONSTRAINT lessons_xp_check CHECK ((xp >= 0))
);


ALTER TABLE public.lessons OWNER TO octolearn;

--
-- Name: quiz_attempts; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.quiz_attempts (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    quiz_id text NOT NULL,
    correct_count integer NOT NULL,
    total_count integer NOT NULL,
    score_percent integer NOT NULL,
    passed boolean NOT NULL,
    xp_earned integer NOT NULL,
    answers jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.quiz_attempts OWNER TO octolearn;

--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: octolearn
--

ALTER TABLE public.quiz_attempts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.quiz_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.quiz_questions (
    id text NOT NULL,
    quiz_id text NOT NULL,
    "position" integer NOT NULL,
    text text NOT NULL,
    options jsonb NOT NULL,
    answer_index integer NOT NULL,
    CONSTRAINT quiz_questions_answer_index_check CHECK ((answer_index >= 0))
);


ALTER TABLE public.quiz_questions OWNER TO octolearn;

--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.quizzes (
    id text NOT NULL,
    unit_id text NOT NULL,
    title text NOT NULL,
    pass_percent integer DEFAULT 60 NOT NULL,
    CONSTRAINT quizzes_pass_percent_check CHECK (((pass_percent >= 0) AND (pass_percent <= 100)))
);


ALTER TABLE public.quizzes OWNER TO octolearn;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.schema_migrations (
    name text NOT NULL,
    applied_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO octolearn;

--
-- Name: units; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.units (
    id text NOT NULL,
    course_id text NOT NULL,
    "position" integer NOT NULL,
    title text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.units OWNER TO octolearn;

--
-- Name: users; Type: TABLE; Schema: public; Owner: octolearn
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    password_hash text NOT NULL,
    avatar_url text,
    role text DEFAULT 'learner'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT users_role_check CHECK ((role = ANY (ARRAY['learner'::text, 'admin'::text])))
);


ALTER TABLE public.users OWNER TO octolearn;

--
-- Data for Name: app_settings; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.app_settings (key, value, updated_at) FROM stdin;
bunny.libraryId	797950	2026-11-03 16:34:47.852641+08
bunny.cdnHostname	vz-b78d8890-74a.b-cdn.net	2026-11-03 16:34:47.852641+08
bunny.apiBaseUrl	https://video.bunnycdn.com	2026-11-03 16:34:47.852641+08
bunny.apiKey	enc:v1:epQ0TC3jLtc9eTP9AxH38U3j4p2U2qom4MV+m9zCltTJ2ZB4eScFZrD+LyDoISaBZ7L8Si/NHP5TSDdQ+4/6rnnpAsw3	2026-11-03 16:34:47.852641+08
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.courses (id, title, description) FROM stdin;
eng-a1	Англи хэл — Анхан шат	
\.


--
-- Data for Name: lesson_completions; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.lesson_completions (user_id, lesson_id, xp_earned, completed_at) FROM stdin;
b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-l1	10	2026-11-03 13:26:23.802798+08
b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-l2	10	2026-11-03 16:24:46.466696+08
b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-l3	10	2026-11-03 16:27:50.692224+08
b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-l4	10	2026-11-03 16:30:51.364256+08
b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-l5	10	2026-11-03 16:32:14.943678+08
b4d9ad0a-e39d-4042-a913-0da7391b25b7	u2-l1	10	2026-11-03 16:41:56.035911+08
b4d9ad0a-e39d-4042-a913-0da7391b25b7	u2-l2	10	2026-11-03 16:42:52.442913+08
1a1fd1be-4d12-438d-bf0e-340a79dfec66	u1-l1	10	2026-11-04 12:03:19.123004+08
1a1fd1be-4d12-438d-bf0e-340a79dfec66	u1-l2	10	2026-11-04 12:03:32.617782+08
14e7f595-00be-49cc-850f-38daa7aa752c	u1-l1	10	2026-11-04 12:20:40.857224+08
14e7f595-00be-49cc-850f-38daa7aa752c	u1-l2	10	2026-11-04 12:20:52.600341+08
14e7f595-00be-49cc-850f-38daa7aa752c	u1-l3	10	2026-11-04 12:23:07.036305+08
14e7f595-00be-49cc-850f-38daa7aa752c	u1-l4	10	2026-11-04 12:24:25.635777+08
14e7f595-00be-49cc-850f-38daa7aa752c	u1-l5	10	2026-11-04 12:24:42.237473+08
14e7f595-00be-49cc-850f-38daa7aa752c	u2-l1	10	2026-11-04 17:20:26.608819+08
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.lessons (id, unit_id, "position", title, description, video_url, duration_sec, xp, created_at, bunny_video_id, video_fallback_url, video_status) FROM stdin;
u2-l2	u2	2	Хоол хүнс	Bread, milk, apple — дэлгүүрт хэрэгтэй үгс.	https://download.samplelib.com/mp4/sample-10s.mp4	10	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u2-l3	u2	3	Гэр орон	Kitchen, bedroom, window — гэрийн өрөө, эд зүйлс.	https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4	10	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u2-l4	u2	4	Хувцас	Shirt, shoes, jacket — хувцасны нэрс.	https://download.samplelib.com/mp4/sample-15s.mp4	15	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u2-l5	u2	5	Цаг агаар	It's sunny / rainy / cold — цаг агаарыг тайлбарлах.	https://test-videos.co.uk/vids/jellyfish/mp4/h264/360/Jellyfish_360_10s_1MB.mp4	10	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u3-l1	u3	1	Тээврийн хэрэгсэл	Bus, train, plane — тээврийн төрлүүд.	https://download.samplelib.com/mp4/sample-30s.mp4	30	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u3-l2	u3	2	Чиглэл асуух	Where is…? Turn left / right — зам асуух.	https://test-videos.co.uk/vids/sintel/mp4/h264/360/Sintel_360_10s_1MB.mp4	10	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u3-l3	u3	3	Зочид буудал	I have a reservation — өрөө захиалах, бүртгүүлэх.	https://download.samplelib.com/mp4/sample-20s.mp4	20	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u3-l4	u3	4	Дэлгүүр хэсэх	How much is it? — үнэ асуух, худалдан авах.	https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4	10	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u3-l5	u3	5	Ресторанд	Can I have the menu, please? — хоол захиалах.	https://download.samplelib.com/mp4/sample-15s.mp4	15	10	2026-11-03 12:48:45.901848+08	\N	\N	ready
u2-l1	u2	1	Цаг хэлэх	What time is it? — цаг асууж, хариулах.	https://vz-b78d8890-74a.b-cdn.net/bade2c5c-9582-4974-9a04-af85e691eae3/playlist.m3u8	11	10	2026-11-03 12:48:45.901848+08	bade2c5c-9582-4974-9a04-af85e691eae3	https://vz-b78d8890-74a.b-cdn.net/bade2c5c-9582-4974-9a04-af85e691eae3/play_480p.mp4	ready
u1-l2	u1	2	Өөрийгөө танилцуулах	My name is…, I am from… — нэр, гарал үүслээ хэлэх.	https://vz-b78d8890-74a.b-cdn.net/9fb784db-efa5-49fe-9336-07fc35fa3799/playlist.m3u8	6	10	2026-11-03 12:48:45.901848+08	9fb784db-efa5-49fe-9336-07fc35fa3799	https://vz-b78d8890-74a.b-cdn.net/9fb784db-efa5-49fe-9336-07fc35fa3799/play_720p.mp4	ready
u1-l4	u1	3	Өнгөнүүд	Red, blue, green — үндсэн өнгөнүүдийн нэр.	https://vz-b78d8890-74a.b-cdn.net/df96a85e-acf7-4cd0-801a-f2ede30e66b9/playlist.m3u8	10	10	2026-11-03 12:48:45.901848+08	df96a85e-acf7-4cd0-801a-f2ede30e66b9	https://vz-b78d8890-74a.b-cdn.net/df96a85e-acf7-4cd0-801a-f2ede30e66b9/play_720p.mp4	ready
u1-l5	u1	5	Гэр бүл	Mother, father, sister, brother — гэр бүлийн гишүүд.	https://vz-b78d8890-74a.b-cdn.net/238fdb7d-9a81-4b24-a072-6ac49d39bcfc/playlist.m3u8	10	10	2026-11-03 12:48:45.901848+08	238fdb7d-9a81-4b24-a072-6ac49d39bcfc	https://vz-b78d8890-74a.b-cdn.net/238fdb7d-9a81-4b24-a072-6ac49d39bcfc/play_720p.mp4	ready
u1-l1	u1	1	Мэндчилгээ	Hello, Hi, Good morning — өдрийн цагаас хамаарсан мэндчилгээ.	https://vz-b78d8890-74a.b-cdn.net/6caa1aab-2c2c-43fe-aa02-399232c1a420/playlist.m3u8	14	10	2026-11-03 12:48:45.901848+08	6caa1aab-2c2c-43fe-aa02-399232c1a420	https://vz-b78d8890-74a.b-cdn.net/6caa1aab-2c2c-43fe-aa02-399232c1a420/play_720p.mp4	ready
u1-l3	u1	4	Тоо 1–10	One-ээс ten хүртэлх тоог зөв дуудаж сурна.	https://vz-b78d8890-74a.b-cdn.net/3a6c8172-371e-430d-b3d3-5c9a96453713/playlist.m3u8	11	10	2026-11-03 12:48:45.901848+08	3a6c8172-371e-430d-b3d3-5c9a96453713	https://vz-b78d8890-74a.b-cdn.net/3a6c8172-371e-430d-b3d3-5c9a96453713/play_480p.mp4	ready
\.


--
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.quiz_attempts (id, user_id, quiz_id, correct_count, total_count, score_percent, passed, xp_earned, answers, created_at) FROM stdin;
1	b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-quiz	3	5	60	t	35	[{"correct": true, "questionId": "u1-q1", "correctIndex": 1, "selectedIndex": 1}, {"correct": false, "questionId": "u1-q2", "correctIndex": 0, "selectedIndex": 1}, {"correct": false, "questionId": "u1-q3", "correctIndex": 2, "selectedIndex": 0}, {"correct": true, "questionId": "u1-q4", "correctIndex": 0, "selectedIndex": 0}, {"correct": true, "questionId": "u1-q5", "correctIndex": 1, "selectedIndex": 1}]	2026-11-03 16:32:50.977169+08
2	b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-quiz	1	5	20	f	0	[{"correct": true, "questionId": "u1-q1", "correctIndex": 1, "selectedIndex": 1}, {"correct": false, "questionId": "u1-q2", "correctIndex": 0, "selectedIndex": 2}, {"correct": false, "questionId": "u1-q3", "correctIndex": 2, "selectedIndex": 1}, {"correct": false, "questionId": "u1-q4", "correctIndex": 0, "selectedIndex": 2}, {"correct": false, "questionId": "u1-q5", "correctIndex": 1, "selectedIndex": 2}]	2026-11-03 16:40:25.342718+08
3	b4d9ad0a-e39d-4042-a913-0da7391b25b7	u1-quiz	1	5	20	f	0	[{"correct": false, "questionId": "u1-q1", "correctIndex": 1, "selectedIndex": 0}, {"correct": false, "questionId": "u1-q2", "correctIndex": 0, "selectedIndex": 1}, {"correct": true, "questionId": "u1-q3", "correctIndex": 2, "selectedIndex": 2}, {"correct": false, "questionId": "u1-q4", "correctIndex": 0, "selectedIndex": 2}, {"correct": false, "questionId": "u1-q5", "correctIndex": 1, "selectedIndex": 2}]	2026-11-04 11:35:01.526749+08
4	14e7f595-00be-49cc-850f-38daa7aa752c	u1-quiz	3	5	60	t	35	[{"correct": true, "questionId": "u1-q1", "correctIndex": 1, "selectedIndex": 1}, {"correct": true, "questionId": "u1-q2", "correctIndex": 0, "selectedIndex": 0}, {"correct": false, "questionId": "u1-q3", "correctIndex": 2, "selectedIndex": 1}, {"correct": true, "questionId": "u1-q4", "correctIndex": 0, "selectedIndex": 0}, {"correct": false, "questionId": "u1-q5", "correctIndex": 1, "selectedIndex": 0}]	2026-11-04 12:25:12.625001+08
\.


--
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.quiz_questions (id, quiz_id, "position", text, options, answer_index) FROM stdin;
u1-q1	u1-quiz	1	"Hello" гэдэг ямар утгатай вэ?	["Баяртай", "Сайн байна уу", "Баярлалаа"]	1
u1-q2	u1-quiz	2	"My name is Bold" гэдгийг орчуулна уу.	["Намайг Болд гэдэг", "Би Болдын найз", "Болд хаана байна?"]	0
u1-q3	u1-quiz	3	"Seven" гэдэг хэд вэ?	["6", "9", "7"]	2
u1-q4	u1-quiz	4	"Цэнхэр" өнгийг англиар юу гэх вэ?	["Blue", "Green", "Red"]	0
u1-q5	u1-quiz	5	"Sister" гэдэг хэн бэ?	["Ах", "Эгч / дүү охин", "Аав"]	1
u3-q1	u3-quiz	1	"Train" гэдэг юу вэ?	["Онгоц", "Галт тэрэг", "Автобус"]	1
u3-q2	u3-quiz	2	"Turn left" гэвэл аль тийш эргэх вэ?	["Зүүн тийш", "Баруун тийш", "Шулуун явна"]	0
u3-q3	u3-quiz	3	"How much is it?" гэдгийг орчуулна уу.	["Энэ юу вэ?", "Хэд вэ (үнэ)?", "Хаана байна?"]	1
u2-q1	u2-quiz	1	"What time is it?" гэдэг юу гэсэн үг вэ?	["Хэдэн цаг болж байна?", "Чи хаана байна?", "Өнөөдөр хэдэн бэ?"]	0
u2-q2	u2-quiz	2	"Сүү" гэдгийг англиар юу гэх вэ?	["Bread", "Milk", "Water"]	1
u2-q3	u2-quiz	3	"Kitchen" бол аль өрөө вэ?	["Унтлагын өрөө", "Угаалгын өрөө", "Гал тогоо"]	2
u2-q4	u2-quiz	4	"Shoes" гэдэг юу вэ?	["Гутал", "Малгай", "Цамц"]	0
u2-q5	u2-quiz	5	"It's rainy" гэдэг ямар цаг агаар вэ?	["Нартай", "Бороотой", "Цастай"]	1
\.


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.quizzes (id, unit_id, title, pass_percent) FROM stdin;
u1-quiz	u1	Бүлэг 1-ийн шалгалт	60
u3-quiz	u3	Бүлэг 3-ын шалгалт	60
u2-quiz	u2	Бүлэг 2-ын шалгалт	80
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.schema_migrations (name, applied_at) FROM stdin;
001_init.sql	2026-11-03 12:48:43.84283+08
002_bunny_video.sql	2026-11-03 12:48:43.920816+08
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.units (id, course_id, "position", title, description, published, created_at) FROM stdin;
u1	eng-a1	1	Бүлэг 1: Танилцах	Мэндлэх, өөрийгөө танилцуулах, энгийн үгс.	t	2026-11-03 12:48:45.901848+08
u2	eng-a1	2	Бүлэг 2: Өдөр тутам	Цаг, хоол хүнс, гэр орны тухай ярих.	t	2026-11-03 12:48:45.901848+08
u3	eng-a1	3	Бүлэг 3: Аялал	Тээвэр, чиглэл асуух, зочид буудал.	t	2026-11-03 12:48:45.901848+08
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: octolearn
--

COPY public.users (id, email, name, password_hash, avatar_url, role, created_at) FROM stdin;
c5cf44ac-dd2e-4c4f-abb1-286d93acd44c	admin@octolearn.mn	Админ	$2b$10$Ea0icaAAxN8OQ/tCX.YTuO459tGeJsKwRF3XbdAOlUiN.wQxPh9ai	\N	admin	2026-11-03 12:48:45.901848+08
14e7f595-00be-49cc-850f-38daa7aa752c	ganhuleg@gmail.com	Ганхүлэг	$2b$10$LlX0tADjPvC8wn4tSVHhvuzeIJruASWpc.d15tI06.rC1qDUxK/hW	\N	learner	2026-11-04 12:16:55.231746+08
1a1fd1be-4d12-438d-bf0e-340a79dfec66	ga@gmail.com	Цэцгээ	$2b$10$YDFGPSrJmEjGm5NZc8PDrex3NIAJBRq156CRNUGF2dSjmnFmf5p/C	\N	learner	2026-11-04 12:02:25.419797+08
b4d9ad0a-e39d-4042-a913-0da7391b25b7	demo@octolearn.mn	Демо	$2b$10$nZ2OjCLPR/qxADhaqvInsuzCrFMaKufjwkJgeCRBPI66fQtn2C.Ka	\N	learner	2026-11-03 12:48:45.901848+08
8c4cf703-6d86-42e7-9fdc-7c6a53fa20c5	simple1793776951961@test.mn	Туршилт	$2b$10$3fCJEvS.mL1owUu9rJ7ws.zWpD1aH3cfvO5nyHnQJVj5Bu8pVaexe	\N	learner	2026-11-04 15:22:32.682346+08
90753ad6-d8ee-4f1e-803d-6c4bd0eea4dc	simple1793777112913@test.mn	Туршилт	$2b$10$ImjVFeT21mnZVaKQJPJT.OQIpcts8WKCGRB1EWtwwQZmS4Xi5jaMu	\N	learner	2026-11-04 15:25:13.65686+08
\.


--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octolearn
--

SELECT pg_catalog.setval('public.quiz_attempts_id_seq', 6, true);


--
-- Name: app_settings app_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.app_settings
    ADD CONSTRAINT app_settings_pkey PRIMARY KEY (key);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: lesson_completions lesson_completions_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_pkey PRIMARY KEY (user_id, lesson_id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_unit_id_key; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_unit_id_key UNIQUE (unit_id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (name);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: lesson_completions_user_time_idx; Type: INDEX; Schema: public; Owner: octolearn
--

CREATE INDEX lesson_completions_user_time_idx ON public.lesson_completions USING btree (user_id, completed_at);


--
-- Name: lessons_bunny_video_idx; Type: INDEX; Schema: public; Owner: octolearn
--

CREATE INDEX lessons_bunny_video_idx ON public.lessons USING btree (bunny_video_id) WHERE (bunny_video_id IS NOT NULL);


--
-- Name: lessons_unit_idx; Type: INDEX; Schema: public; Owner: octolearn
--

CREATE INDEX lessons_unit_idx ON public.lessons USING btree (unit_id, "position");


--
-- Name: quiz_attempts_user_idx; Type: INDEX; Schema: public; Owner: octolearn
--

CREATE INDEX quiz_attempts_user_idx ON public.quiz_attempts USING btree (user_id, quiz_id);


--
-- Name: quiz_questions_quiz_idx; Type: INDEX; Schema: public; Owner: octolearn
--

CREATE INDEX quiz_questions_quiz_idx ON public.quiz_questions USING btree (quiz_id, "position");


--
-- Name: units_course_idx; Type: INDEX; Schema: public; Owner: octolearn
--

CREATE INDEX units_course_idx ON public.units USING btree (course_id, "position");


--
-- Name: lesson_completions lesson_completions_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lesson_completions lesson_completions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lessons lessons_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: quiz_attempts quiz_attempts_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: quiz_attempts quiz_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: quiz_questions quiz_questions_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: quizzes quizzes_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: units units_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: octolearn
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict s5KTVZIampDdh4EwfVAAn99Is4fAzcpU7upl4oW0KVs5yMIXWg4cCKb31MDLmrZ

