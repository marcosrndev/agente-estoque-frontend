

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


CREATE SCHEMA IF NOT EXISTS "public";


ALTER SCHEMA "public" OWNER TO "pg_database_owner";


COMMENT ON SCHEMA "public" IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."categorias_grupos" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "grupos" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "criado_em" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."categorias_grupos" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."categorias_grupos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."categorias_grupos_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."categorias_grupos_id_seq" OWNED BY "public"."categorias_grupos"."id";



CREATE TABLE IF NOT EXISTS "public"."cotacao_itens" (
    "id" bigint NOT NULL,
    "grupo" "text" NOT NULL,
    "codigo" "text" NOT NULL,
    "preco" numeric DEFAULT 0,
    "qtd_manual" numeric DEFAULT 0,
    "editado_por" "text",
    "username" "text",
    "ultima_edicao" "text",
    "criado_em" timestamp without time zone DEFAULT "now"(),
    "precos_fornecedores" "jsonb",
    "nomes_fornecedores" "jsonb"
);


ALTER TABLE "public"."cotacao_itens" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."cotacao_itens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."cotacao_itens_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."cotacao_itens_id_seq" OWNED BY "public"."cotacao_itens"."id";



CREATE TABLE IF NOT EXISTS "public"."cotacoes" (
    "id" bigint NOT NULL,
    "grupo" "text" NOT NULL,
    "nome" "text" NOT NULL,
    "desde" "text",
    "status" "text" DEFAULT 'em_cotacao'::"text",
    "concluido_em" "text",
    "username" "text",
    "dados_atualizados" boolean DEFAULT false,
    "sessao_id" "text",
    "pedido_enviado_em" timestamp without time zone
);


ALTER TABLE "public"."cotacoes" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."cotacoes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."cotacoes_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."cotacoes_id_seq" OWNED BY "public"."cotacoes"."id";



CREATE TABLE IF NOT EXISTS "public"."fornecedores" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "contato" "text",
    "prazo_padrao" "text",
    "observacao" "text",
    "ativo" boolean DEFAULT true,
    "criado_em" timestamp without time zone DEFAULT "now"(),
    "cnpj" "text"
);


ALTER TABLE "public"."fornecedores" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."fornecedores_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."fornecedores_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."fornecedores_id_seq" OWNED BY "public"."fornecedores"."id";



CREATE TABLE IF NOT EXISTS "public"."historico_precos" (
    "id" bigint NOT NULL,
    "codigo" "text" NOT NULL,
    "grupo" "text",
    "fornecedor_id" "text",
    "fornecedor_nome" "text",
    "preco" numeric(12,4) NOT NULL,
    "qtd" numeric(12,4),
    "data" timestamp without time zone DEFAULT "now"(),
    "username" "text"
);


ALTER TABLE "public"."historico_precos" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."historico_precos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."historico_precos_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."historico_precos_id_seq" OWNED BY "public"."historico_precos"."id";



CREATE TABLE IF NOT EXISTS "public"."meta" (
    "id" bigint NOT NULL,
    "chave" "text" NOT NULL,
    "valor" "text"
);


ALTER TABLE "public"."meta" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."meta_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."meta_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."meta_id_seq" OWNED BY "public"."meta"."id";



CREATE TABLE IF NOT EXISTS "public"."produtos" (
    "id" bigint NOT NULL,
    "codigo" "text",
    "nome" "text" NOT NULL,
    "un" "text",
    "grupo" "text",
    "abc" "text",
    "estoque_atual" numeric DEFAULT 0,
    "pedido_forn" numeric DEFAULT 0,
    "est_min" numeric DEFAULT 0,
    "est_max" numeric DEFAULT 0,
    "comprar_min" numeric DEFAULT 0,
    "comprar_max" numeric DEFAULT 0,
    "status" "text"
);


ALTER TABLE "public"."produtos" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."produtos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."produtos_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."produtos_id_seq" OWNED BY "public"."produtos"."id";



CREATE TABLE IF NOT EXISTS "public"."usuarios" (
    "id" bigint NOT NULL,
    "username" "text" NOT NULL,
    "senha_hash" "text" NOT NULL,
    "nome" "text" NOT NULL,
    "is_admin" boolean DEFAULT false,
    "ativo" boolean DEFAULT true,
    "criado_em" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."usuarios" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."usuarios_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."usuarios_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."usuarios_id_seq" OWNED BY "public"."usuarios"."id";



ALTER TABLE ONLY "public"."categorias_grupos" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."categorias_grupos_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."cotacao_itens" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cotacao_itens_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."cotacoes" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cotacoes_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."fornecedores" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."fornecedores_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."historico_precos" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."historico_precos_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."meta" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."meta_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."produtos" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."produtos_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."usuarios" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."usuarios_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."categorias_grupos"
    ADD CONSTRAINT "categorias_grupos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cotacao_itens"
    ADD CONSTRAINT "cotacao_itens_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cotacoes"
    ADD CONSTRAINT "cotacoes_grupo_key" UNIQUE ("grupo");



ALTER TABLE ONLY "public"."cotacoes"
    ADD CONSTRAINT "cotacoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."fornecedores"
    ADD CONSTRAINT "fornecedores_nome_key" UNIQUE ("nome");



ALTER TABLE ONLY "public"."fornecedores"
    ADD CONSTRAINT "fornecedores_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."historico_precos"
    ADD CONSTRAINT "historico_precos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."meta"
    ADD CONSTRAINT "meta_chave_key" UNIQUE ("chave");



ALTER TABLE ONLY "public"."meta"
    ADD CONSTRAINT "meta_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."produtos"
    ADD CONSTRAINT "produtos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."usuarios"
    ADD CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."usuarios"
    ADD CONSTRAINT "usuarios_username_key" UNIQUE ("username");



CREATE INDEX "idx_cotacao_itens_grupo" ON "public"."cotacao_itens" USING "btree" ("grupo");



CREATE INDEX "idx_cotacoes_grupo" ON "public"."cotacoes" USING "btree" ("grupo");



CREATE INDEX "idx_hp_codigo_data" ON "public"."historico_precos" USING "btree" ("codigo", "data" DESC);



CREATE INDEX "idx_hp_grupo" ON "public"."historico_precos" USING "btree" ("grupo");



CREATE INDEX "idx_produtos_grupo" ON "public"."produtos" USING "btree" ("grupo");



CREATE UNIQUE INDEX "uniq_forn_cnpj_public" ON "public"."fornecedores" USING "btree" ("cnpj") WHERE (("cnpj" IS NOT NULL) AND ("cnpj" <> ''::"text"));



CREATE POLICY "allow_all_categorias" ON "public"."categorias_grupos" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_cotacao_itens" ON "public"."cotacao_itens" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_cotacoes" ON "public"."cotacoes" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_forn" ON "public"."fornecedores" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_hp" ON "public"."historico_precos" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_meta" ON "public"."meta" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_produtos" ON "public"."produtos" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_usuarios" ON "public"."usuarios" USING (true) WITH CHECK (true);



ALTER TABLE "public"."categorias_grupos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."cotacao_itens" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."cotacoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."fornecedores" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."historico_precos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."meta" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."produtos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."usuarios" ENABLE ROW LEVEL SECURITY;


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



GRANT ALL ON TABLE "public"."categorias_grupos" TO "anon";
GRANT ALL ON TABLE "public"."categorias_grupos" TO "authenticated";
GRANT ALL ON TABLE "public"."categorias_grupos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."categorias_grupos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."categorias_grupos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."categorias_grupos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."cotacao_itens" TO "anon";
GRANT ALL ON TABLE "public"."cotacao_itens" TO "authenticated";
GRANT ALL ON TABLE "public"."cotacao_itens" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cotacao_itens_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cotacao_itens_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cotacao_itens_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."cotacoes" TO "anon";
GRANT ALL ON TABLE "public"."cotacoes" TO "authenticated";
GRANT ALL ON TABLE "public"."cotacoes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cotacoes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cotacoes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cotacoes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."fornecedores" TO "anon";
GRANT ALL ON TABLE "public"."fornecedores" TO "authenticated";
GRANT ALL ON TABLE "public"."fornecedores" TO "service_role";



GRANT ALL ON SEQUENCE "public"."fornecedores_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fornecedores_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fornecedores_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."historico_precos" TO "anon";
GRANT ALL ON TABLE "public"."historico_precos" TO "authenticated";
GRANT ALL ON TABLE "public"."historico_precos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."historico_precos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."historico_precos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."historico_precos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."meta" TO "anon";
GRANT ALL ON TABLE "public"."meta" TO "authenticated";
GRANT ALL ON TABLE "public"."meta" TO "service_role";



GRANT ALL ON SEQUENCE "public"."meta_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."meta_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."meta_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."produtos" TO "anon";
GRANT ALL ON TABLE "public"."produtos" TO "authenticated";
GRANT ALL ON TABLE "public"."produtos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."produtos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."produtos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."produtos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."usuarios" TO "anon";
GRANT ALL ON TABLE "public"."usuarios" TO "authenticated";
GRANT ALL ON TABLE "public"."usuarios" TO "service_role";



GRANT ALL ON SEQUENCE "public"."usuarios_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."usuarios_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."usuarios_id_seq" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






