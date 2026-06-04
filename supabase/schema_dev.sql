

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


CREATE SCHEMA IF NOT EXISTS "dev";


ALTER SCHEMA "dev" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "dev"."categorias_grupos" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "grupos" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "criado_em" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "dev"."categorias_grupos" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."categorias_grupos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."categorias_grupos_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."categorias_grupos_id_seq" OWNED BY "dev"."categorias_grupos"."id";



CREATE TABLE IF NOT EXISTS "dev"."cotacao_itens" (
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


ALTER TABLE "dev"."cotacao_itens" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."cotacao_itens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."cotacao_itens_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."cotacao_itens_id_seq" OWNED BY "dev"."cotacao_itens"."id";



CREATE TABLE IF NOT EXISTS "dev"."cotacoes" (
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


ALTER TABLE "dev"."cotacoes" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."cotacoes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."cotacoes_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."cotacoes_id_seq" OWNED BY "dev"."cotacoes"."id";



CREATE TABLE IF NOT EXISTS "dev"."fornecedores" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "contato" "text",
    "prazo_padrao" "text",
    "observacao" "text",
    "ativo" boolean DEFAULT true,
    "criado_em" timestamp without time zone DEFAULT "now"(),
    "cnpj" "text"
);


ALTER TABLE "dev"."fornecedores" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."fornecedores_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."fornecedores_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."fornecedores_id_seq" OWNED BY "dev"."fornecedores"."id";



CREATE TABLE IF NOT EXISTS "dev"."historico_precos" (
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


ALTER TABLE "dev"."historico_precos" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."historico_precos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."historico_precos_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."historico_precos_id_seq" OWNED BY "dev"."historico_precos"."id";



CREATE TABLE IF NOT EXISTS "dev"."meta" (
    "id" bigint NOT NULL,
    "chave" "text" NOT NULL,
    "valor" "text"
);


ALTER TABLE "dev"."meta" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."meta_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."meta_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."meta_id_seq" OWNED BY "dev"."meta"."id";



CREATE TABLE IF NOT EXISTS "dev"."produtos" (
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


ALTER TABLE "dev"."produtos" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."produtos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."produtos_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."produtos_id_seq" OWNED BY "dev"."produtos"."id";



CREATE TABLE IF NOT EXISTS "dev"."usuarios" (
    "id" bigint NOT NULL,
    "username" "text" NOT NULL,
    "senha_hash" "text" NOT NULL,
    "nome" "text" NOT NULL,
    "is_admin" boolean DEFAULT false,
    "ativo" boolean DEFAULT true,
    "criado_em" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "dev"."usuarios" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."usuarios_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."usuarios_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."usuarios_id_seq" OWNED BY "dev"."usuarios"."id";



ALTER TABLE ONLY "dev"."categorias_grupos" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."categorias_grupos_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."cotacao_itens" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."cotacao_itens_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."cotacoes" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."cotacoes_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."fornecedores" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."fornecedores_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."historico_precos" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."historico_precos_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."meta" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."meta_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."produtos" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."produtos_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."usuarios" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."usuarios_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."categorias_grupos"
    ADD CONSTRAINT "categorias_grupos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."cotacao_itens"
    ADD CONSTRAINT "cotacao_itens_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."cotacoes"
    ADD CONSTRAINT "cotacoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."fornecedores"
    ADD CONSTRAINT "fornecedores_nome_key" UNIQUE ("nome");



ALTER TABLE ONLY "dev"."fornecedores"
    ADD CONSTRAINT "fornecedores_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."historico_precos"
    ADD CONSTRAINT "historico_precos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."meta"
    ADD CONSTRAINT "meta_chave_key" UNIQUE ("chave");



ALTER TABLE ONLY "dev"."meta"
    ADD CONSTRAINT "meta_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."produtos"
    ADD CONSTRAINT "produtos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."usuarios"
    ADD CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."usuarios"
    ADD CONSTRAINT "usuarios_username_key" UNIQUE ("username");



CREATE INDEX "idx_dev_cotacao_itens_grupo" ON "dev"."cotacao_itens" USING "btree" ("grupo");



CREATE INDEX "idx_hp_codigo_data_dev" ON "dev"."historico_precos" USING "btree" ("codigo", "data" DESC);



CREATE INDEX "idx_hp_grupo_dev" ON "dev"."historico_precos" USING "btree" ("grupo");



CREATE UNIQUE INDEX "uniq_forn_cnpj_dev" ON "dev"."fornecedores" USING "btree" ("cnpj") WHERE (("cnpj" IS NOT NULL) AND ("cnpj" <> ''::"text"));



CREATE POLICY "allow_all_categorias" ON "dev"."categorias_grupos" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_forn" ON "dev"."fornecedores" USING (true) WITH CHECK (true);



CREATE POLICY "allow_all_hp" ON "dev"."historico_precos" USING (true) WITH CHECK (true);



ALTER TABLE "dev"."categorias_grupos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."cotacao_itens" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."cotacoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."fornecedores" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."historico_precos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."meta" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."produtos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."usuarios" ENABLE ROW LEVEL SECURITY;


GRANT USAGE ON SCHEMA "dev" TO "anon";
GRANT USAGE ON SCHEMA "dev" TO "authenticated";
GRANT USAGE ON SCHEMA "dev" TO "service_role";



GRANT ALL ON TABLE "dev"."categorias_grupos" TO "anon";
GRANT ALL ON TABLE "dev"."categorias_grupos" TO "authenticated";
GRANT ALL ON TABLE "dev"."categorias_grupos" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."categorias_grupos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."categorias_grupos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."categorias_grupos_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."cotacao_itens" TO "anon";
GRANT ALL ON TABLE "dev"."cotacao_itens" TO "authenticated";
GRANT ALL ON TABLE "dev"."cotacao_itens" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."cotacao_itens_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."cotacao_itens_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."cotacao_itens_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."cotacoes" TO "anon";
GRANT ALL ON TABLE "dev"."cotacoes" TO "authenticated";
GRANT ALL ON TABLE "dev"."cotacoes" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."cotacoes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."cotacoes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."cotacoes_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."fornecedores" TO "anon";
GRANT ALL ON TABLE "dev"."fornecedores" TO "authenticated";
GRANT ALL ON TABLE "dev"."fornecedores" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."fornecedores_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."fornecedores_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."fornecedores_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."historico_precos" TO "anon";
GRANT ALL ON TABLE "dev"."historico_precos" TO "authenticated";
GRANT ALL ON TABLE "dev"."historico_precos" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."historico_precos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."historico_precos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."historico_precos_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."meta" TO "anon";
GRANT ALL ON TABLE "dev"."meta" TO "authenticated";
GRANT ALL ON TABLE "dev"."meta" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."meta_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."meta_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."meta_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."produtos" TO "anon";
GRANT ALL ON TABLE "dev"."produtos" TO "authenticated";
GRANT ALL ON TABLE "dev"."produtos" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."produtos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."produtos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."produtos_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."usuarios" TO "anon";
GRANT ALL ON TABLE "dev"."usuarios" TO "authenticated";
GRANT ALL ON TABLE "dev"."usuarios" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."usuarios_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."usuarios_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."usuarios_id_seq" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON SEQUENCES TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON FUNCTIONS TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON TABLES TO "service_role";



