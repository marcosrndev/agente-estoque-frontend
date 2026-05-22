#!/usr/bin/env bash
# Replica do pipeline do `supabase db dump` (extraido do --dry-run).
# Uso: dump.sh <schema> <output_file>
set -euo pipefail

SCHEMA="${1:?usage: dump.sh <schema> <output_file>}"
OUT="${2:?usage: dump.sh <schema> <output_file>}"

export PGHOST="aws-1-sa-east-1.pooler.supabase.com"
export PGPORT="5432"
export PGUSER="postgres.vfgesyzzpnpvqxbtypgo"
export PGDATABASE="postgres"
# PGPASSWORD vem do ambiente (nao hardcoded no arquivo)

PG_DUMP="/c/Users/Usuário/pg_tools/pgsql/bin/pg_dump.exe"
SED="/c/Program Files/Git/usr/bin/sed.exe"

"$PG_DUMP" \
    --schema-only \
    --quote-all-identifiers \
    --role "postgres" \
    --schema="$SCHEMA" \
| "$SED" -E 's/^\\(un)?restrict .*$/-- &/' \
| "$SED" -E 's/^CREATE SCHEMA "/CREATE SCHEMA IF NOT EXISTS "/' \
| "$SED" -E 's/^CREATE TABLE "/CREATE TABLE IF NOT EXISTS "/' \
| "$SED" -E 's/^CREATE SEQUENCE "/CREATE SEQUENCE IF NOT EXISTS "/' \
| "$SED" -E 's/^CREATE VIEW "/CREATE OR REPLACE VIEW "/' \
| "$SED" -E 's/^CREATE FUNCTION "/CREATE OR REPLACE FUNCTION "/' \
| "$SED" -E 's/^CREATE TRIGGER "/CREATE OR REPLACE TRIGGER "/' \
| "$SED" -E 's/^CREATE PUBLICATION "supabase_realtime/-- &/' \
| "$SED" -E 's/^CREATE EVENT TRIGGER /-- &/' \
| "$SED" -E 's/^         WHEN TAG IN /-- &/' \
| "$SED" -E 's/^   EXECUTE FUNCTION /-- &/' \
| "$SED" -E 's/^ALTER EVENT TRIGGER /-- &/' \
| "$SED" -E 's/^ALTER PUBLICATION "supabase_realtime_/-- &/' \
| "$SED" -E 's/^ALTER FOREIGN DATA WRAPPER (.+) OWNER TO /-- &/' \
| "$SED" -E 's/^ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin"/-- &/' \
| "$SED" -E 's/^GRANT ALL ON FOREIGN DATA WRAPPER (.+) TO "postgres" WITH GRANT OPTION/-- &/' \
| "$SED" -E "s/^GRANT (.+) ON (.+) \"()\"/-- &/" \
| "$SED" -E "s/^REVOKE (.+) ON (.+) \"()\"/-- &/" \
| "$SED" -E 's/^(CREATE EXTENSION IF NOT EXISTS "pg_tle").+/\1;/' \
| "$SED" -E 's/^(CREATE EXTENSION IF NOT EXISTS "pgsodium").+/\1;/' \
| "$SED" -E 's/^(CREATE EXTENSION IF NOT EXISTS "pgmq").+/\1;/' \
| "$SED" -E 's/^COMMENT ON EXTENSION (.+)/-- &/' \
| "$SED" -E 's/^CREATE POLICY "cron_job_/-- &/' \
| "$SED" -E 's/^ALTER TABLE "cron"/-- &/' \
| "$SED" -E 's/^SET transaction_timeout = 0;/-- &/' \
| "$SED" -E "/^--/d" \
> "$OUT"

echo "Dump de schema '$SCHEMA' salvo em $OUT ($(wc -l < "$OUT") linhas)"
