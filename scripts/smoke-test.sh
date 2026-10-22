#!/usr/bin/env bash
# =============================================================================
# JC Bank — smoke test de continuidade
#
# Verifica se o que já foi implementado continua funcionando. Deve ser rodado
# ao fim de cada aula (gate de continuidade) e no teste de percurso final.
#
# Uso:
#   ./scripts/smoke-test.sh          # etapa 00
#   ./scripts/smoke-test.sh 01       # etapas 00 e 01
#   ./scripts/smoke-test.sh 04       # etapas 00 a 04
#   BASE_URL=http://localhost:8080 ./scripts/smoke-test.sh 04
#
# Pré-requisitos: aplicação rodando (./gradlew bootRun) e curl instalado.
#
# Cada aula adiciona os checks da sua etapa. Ver docs/plano/continuidade.md.
# =============================================================================
set -u

BASE_URL="${BASE_URL:-http://localhost:8080}"
STAGE="${1:-00}"

PASS=0
FAIL=0
BODY="$(mktemp)"
trap 'rm -f "$BODY"' EXIT

if [ "$STAGE" = "-h" ] || [ "$STAGE" = "--help" ]; then
  awk 'NR > 1 { if (/^#/) { sub(/^# ?/, ""); print } else { exit } }' "$0"
  exit 0
fi

# Converte "04" em 4 (evita interpretação octal).
N="$((10#${STAGE:-0}))"

check() {
  local desc="$1" expected="$2" method="$3" path="$4" data="${5:-}"
  local args=(-s -o "$BODY" -w '%{http_code}' -X "$method" "$BASE_URL$path")

  if [ -n "$data" ]; then
    args+=(-H 'Content-Type: application/json' -d "$data")
  fi

  local code
  code="$(curl "${args[@]}" 2>/dev/null)"
  [ -z "$code" ] && code="000"

  if printf '%s' "$expected" | tr ',' '\n' | grep -qx -- "$code"; then
    printf 'PASS  [%s] %s\n' "$code" "$desc"
    PASS=$((PASS + 1))
  else
    printf 'FAIL  [%s, esperado %s] %s\n' "$code" "$expected" "$desc"
    printf '      corpo: %s\n' "$(head -c 200 "$BODY" 2>/dev/null)"
    FAIL=$((FAIL + 1))
  fi
}

echo "JC Bank — smoke test (etapa $STAGE) — $BASE_URL"
echo "------------------------------------------------------------"

# ----- Etapa 00: aplicação no ar ---------------------------------------------
if [ "$N" -ge 0 ]; then
  check "aplicação no ar (404 esperado em /)" "200,404" GET "/"
fi

# ----- Etapa 01: Cliente (leitura em memória) --------------------------------
if [ "$N" -ge 1 ]; then
  check "GET /api/v1/clientes retorna 200" "200" GET "/api/v1/clientes"
  check "GET /api/v1/clientes/999999 retorna 404" "404" GET "/api/v1/clientes/999999"
fi

# ----- Etapas 02 em diante ---------------------------------------------------
# Adicione os checks de cada etapa quando o contrato da aula estiver definido.
# Exemplo (etapa 04 — cadastro de cliente):
#   check "POST /api/v1/clientes cria cliente" "201" POST "/api/v1/clientes" \
#     '{"nome":"Teste","cpf":"00000000000","email":"teste@example.com"}'
#   check "POST /api/v1/clientes com dados inválidos" "400" POST "/api/v1/clientes" '{}'
#
if [ "$N" -ge 2 ]; then
  echo "SKIP  etapas 02–12 ainda sem checks definidos (serão adicionados em cada aula)."
fi

echo "------------------------------------------------------------"
printf 'Resultado: %d PASS, %d FAIL\n' "$PASS" "$FAIL"

[ "$FAIL" -eq 0 ]
