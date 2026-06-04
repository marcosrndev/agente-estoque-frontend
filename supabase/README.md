# Schema do banco — Agente de Compras

Captura inicial do schema do projeto Supabase de produção
(`vfgesyzzpnpvqxbtypgo` — "agente-compras", Postgres 17.6.1.121, região `sa-east-1`),
feita em 2026-05-22 por `pg_dump --schema-only` via pipeline do `supabase db dump`.

Antes desta captura, o schema só existia dentro do banco — ele foi construído
manualmente no Supabase Studio ao longo do tempo, com 3 SQLs de mudança aplicados
à mão (que ficavam soltos em `../../SQL_*.sql`, fora do git).

## Arquivos

### `schema_inicial.sql` (fonte da verdade)
Dump do schema `public` da produção. Cobre 8 tabelas, sequences, PKs/uniques,
índices, RLS habilitado + policies, e grants para os roles `anon`,
`authenticated`, `service_role`. **Esse é o arquivo a usar para semear projetos
novos** (dev isolado, ou um eventual `main` novo).

### `schema_dev.sql` (referência, NÃO usar como template)
Dump do schema `dev` interno do mesmo projeto de produção. Hoje o backend
alterna entre os dois via env var `SUPABASE_SCHEMA` no proxy.

**Atenção: o schema `dev` interno tem drift vs `public`** — não é um clone.
Diferenças encontradas em 2026-05-22:

- Falta a UNIQUE constraint `cotacoes_grupo_key` em `cotacoes.grupo`
- Faltam os índices `idx_cotacoes_grupo` e `idx_produtos_grupo`
- Faltam 5 RLS policies (`allow_all_cotacao_itens`, `allow_all_cotacoes`,
  `allow_all_meta`, `allow_all_produtos`, `allow_all_usuarios`) — RLS está
  habilitado nas tabelas, mas sem policy nenhuma. Funciona hoje porque o proxy
  usa a service-role key (que bypassa RLS).
- Índices têm sufixo `_dev` em vez do nome original
- Schema é dono de `postgres` em vez de `pg_database_owner`
- Faltam alguns grants/default privileges para o role `postgres`

Este arquivo está versionado só como **referência histórica do estado atual**.
Não use para recriar um ambiente novo — use `schema_inicial.sql`.

## Como o dump foi gerado

```bash
# Pré-requisitos: pg_dump 17+, sed (Git for Windows), SUPABASE_DB_PASSWORD no env
PGPASSWORD='<senha>' bash dump.sh public  schema_inicial.sql
PGPASSWORD='<senha>' bash dump.sh dev     schema_dev.sql
```

O `dump.sh` (em `~/pg_tools/dump.sh`) replica o pipeline exato do
`supabase db dump --schema-only`, incluindo as substituições `sed` que filtram
objetos managed pelo Supabase (event triggers, pgsodium grants, etc.).

## Aplicar num projeto novo

Compatível com qualquer projeto Supabase novo (vazio):

```bash
psql "postgresql://postgres.<NOVO_PROJECT_REF>:<SENHA>@<HOST>:5432/postgres" \
     -f schema_inicial.sql
```

O dump usa os roles `postgres`, `anon`, `authenticated`, `service_role` e
`pg_database_owner` — todos pré-existentes em qualquer projeto Supabase. **Não é
portável para um Postgres vanilla sem antes criar esses roles.**

Não tem `CREATE EXTENSION` — o schema não usa pgcrypto, uuid-ossp, etc.

Não tem triggers, funções/RPCs nem enums — a lógica toda mora no proxy
FastAPI (`../../../proxy/main.py`).
