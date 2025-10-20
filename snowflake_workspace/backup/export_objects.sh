#!/bin/bash

# =====================================================================
# SCRIPT: Exportar objetos do Snowflake para arquivos separados
# =====================================================================
# Este script exporta todos os objetos do Snowflake para o GitHub
# =====================================================================

set -e

BACKUP_DIR="snowflake_workspace/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "🚀 Iniciando exportação de objetos do Snowflake..."
echo "📁 Diretório: $BACKUP_DIR"
echo "⏰ Timestamp: $TIMESTAMP"
echo ""

# Criar diretórios
mkdir -p "$BACKUP_DIR/schemas"
mkdir -p "$BACKUP_DIR/tables/staging"
mkdir -p "$BACKUP_DIR/views/staging"
mkdir -p "$BACKUP_DIR/views/core"
mkdir -p "$BACKUP_DIR/views/raw"

# =====================================================================
# 1. EXPORTAR DATABASE
# =====================================================================
echo "📦 Exportando DATABASE..."
snow sql -q "SELECT GET_DDL('DATABASE', 'IE_DB');" > "$BACKUP_DIR/database_IE_DB.sql"

# =====================================================================
# 2. EXPORTAR SCHEMAS
# =====================================================================
echo "📂 Exportando SCHEMAS..."

snow sql -q "SELECT GET_DDL('SCHEMA', 'IE_DB.STAGING');" > "$BACKUP_DIR/schemas/STAGING.sql"
snow sql -q "SELECT GET_DDL('SCHEMA', 'IE_DB.CORE');" > "$BACKUP_DIR/schemas/CORE.sql"
snow sql -q "SELECT GET_DDL('SCHEMA', 'IE_DB.RAW');" > "$BACKUP_DIR/schemas/RAW.sql"

# =====================================================================
# 3. EXPORTAR TABELAS DO STAGING
# =====================================================================
echo "📊 Exportando TABLES do schema STAGING..."

# Obter lista de tabelas
TABLES=$(snow sql -q "
SELECT table_name 
FROM IE_DB.INFORMATION_SCHEMA.TABLES 
WHERE table_schema = 'STAGING' 
AND table_type = 'BASE TABLE'
ORDER BY table_name;" | grep -v "^+" | grep -v "^|" | grep -v "TABLE_NAME" | tr -d ' ')

# Exportar cada tabela
for TABLE in $TABLES; do
    if [ ! -z "$TABLE" ] && [ "$TABLE" != "---" ] && [ "$TABLE" != "" ]; then
        echo "  - Exportando tabela: $TABLE"
        snow sql -q "SELECT GET_DDL('TABLE', 'IE_DB.STAGING.$TABLE');" > "$BACKUP_DIR/tables/staging/${TABLE}.sql" 2>/dev/null || echo "    ⚠️  Erro ao exportar $TABLE"
    fi
done

# =====================================================================
# 4. EXPORTAR VIEWS DO STAGING
# =====================================================================
echo "👁️  Exportando VIEWS do schema STAGING..."

VIEWS=$(snow sql -q "
SELECT table_name 
FROM IE_DB.INFORMATION_SCHEMA.VIEWS 
WHERE table_schema = 'STAGING'
ORDER BY table_name;" | grep -v "^+" | grep -v "^|" | grep -v "TABLE_NAME" | tr -d ' ')

for VIEW in $VIEWS; do
    if [ ! -z "$VIEW" ] && [ "$VIEW" != "---" ] && [ "$VIEW" != "" ]; then
        echo "  - Exportando view: $VIEW"
        snow sql -q "SELECT GET_DDL('VIEW', 'IE_DB.STAGING.$VIEW');" > "$BACKUP_DIR/views/staging/${VIEW}.sql" 2>/dev/null || echo "    ⚠️  Erro ao exportar $VIEW"
    fi
done

# =====================================================================
# 5. EXPORTAR VIEWS DO CORE
# =====================================================================
echo "👁️  Exportando VIEWS do schema CORE..."

VIEWS=$(snow sql -q "
SELECT table_name 
FROM IE_DB.INFORMATION_SCHEMA.VIEWS 
WHERE table_schema = 'CORE'
ORDER BY table_name;" | grep -v "^+" | grep -v "^|" | grep -v "TABLE_NAME" | tr -d ' ')

for VIEW in $VIEWS; do
    if [ ! -z "$VIEW" ] && [ "$VIEW" != "---" ] && [ "$VIEW" != "" ]; then
        echo "  - Exportando view: $VIEW"
        snow sql -q "SELECT GET_DDL('VIEW', 'IE_DB.CORE.$VIEW');" > "$BACKUP_DIR/views/core/${VIEW}.sql" 2>/dev/null || echo "    ⚠️  Erro ao exportar $VIEW"
    fi
done

# =====================================================================
# 6. EXPORTAR VIEWS DO RAW
# =====================================================================
echo "👁️  Exportando VIEWS do schema RAW..."

VIEWS=$(snow sql -q "
SELECT table_name 
FROM IE_DB.INFORMATION_SCHEMA.VIEWS 
WHERE table_schema = 'RAW'
ORDER BY table_name;" | grep -v "^+" | grep -v "^|" | grep -v "TABLE_NAME" | tr -d ' ')

for VIEW in $VIEWS; do
    if [ ! -z "$VIEW" ] && [ "$VIEW" != "---" ] && [ "$VIEW" != "" ]; then
        echo "  - Exportando view: $VIEW"
        snow sql -q "SELECT GET_DDL('VIEW', 'IE_DB.RAW.$VIEW');" > "$BACKUP_DIR/views/raw/${VIEW}.sql" 2>/dev/null || echo "    ⚠️  Erro ao exportar $VIEW"
    fi
done

# =====================================================================
# 7. CRIAR README
# =====================================================================
echo "📄 Criando README..."

cat > "$BACKUP_DIR/README.md" << 'EOF'
# Backup Snowflake - IE_DB

Backup automático de todos os objetos do database IE_DB.

## 📁 Estrutura

```
backup/
├── database_IE_DB.sql          # DDL do database
├── schemas/                    # DDL dos schemas
│   ├── STAGING.sql
│   ├── CORE.sql
│   └── RAW.sql
├── tables/                     # DDL das tabelas
│   └── staging/
│       ├── STG_IRRADIACAO_SOLAR.sql
│       ├── GERACAO_USINA_*.sql
│       └── DISPONIBILIDADE_USINA_*.sql
└── views/                      # DDL das views
    ├── staging/
    │   ├── STG_USINA_DISP.sql
    │   ├── STG_USINA_GERACAO.sql
    │   └── STG_USINA_GERACAO_GO.sql
    ├── core/
    │   ├── DIM_LOCALIDADE.sql
    │   ├── DIM_TEMPO.sql
    │   ├── DIM_USINA.sql
    │   ├── FACT_DISPONIBILIDADE.sql
    │   ├── FACT_GERACAO_SUMMARY.sql
    │   └── GERACAO_MENSAL_ANALYSIS.sql
    └── raw/
        └── MY_SECOND_DBT_MODEL.sql
```

## 🔄 Como restaurar

### 1. Restaurar Database e Schemas

```sql
-- Executar nesta ordem:
@database_IE_DB.sql
@schemas/STAGING.sql
@schemas/CORE.sql
@schemas/RAW.sql
```

### 2. Restaurar Tabelas

```sql
-- Executar todos os arquivos em tables/staging/
@tables/staging/STG_IRRADIACAO_SOLAR.sql
-- ... outros arquivos
```

### 3. Restaurar Views

```sql
-- Executar na ordem: staging → core → raw
@views/staging/*.sql
@views/core/*.sql
@views/raw/*.sql
```

## ⚙️ Como gerar novo backup

```bash
./snowflake_workspace/backup/export_objects.sh
```

## 📊 Estatísticas

- **Database**: 1 (IE_DB)
- **Schemas**: 3 (STAGING, CORE, RAW)
- **Tabelas STAGING**: ~90 (geração e disponibilidade de usinas)
- **Views STAGING**: 3
- **Views CORE**: 6
- **Views RAW**: 1

## 📅 Última atualização

Gerado automaticamente em: $(date '+%Y-%m-%d %H:%M:%S')
EOF

# =====================================================================
# 8. RESUMO
# =====================================================================
echo ""
echo "✅ Exportação concluída!"
echo ""
echo "📊 Resumo:"
echo "  - Database: 1 arquivo"
echo "  - Schemas: $(ls -1 $BACKUP_DIR/schemas/*.sql 2>/dev/null | wc -l) arquivos"
echo "  - Tables: $(find $BACKUP_DIR/tables -name "*.sql" 2>/dev/null | wc -l) arquivos"
echo "  - Views: $(find $BACKUP_DIR/views -name "*.sql" 2>/dev/null | wc -l) arquivos"
echo ""
echo "📁 Arquivos salvos em: $BACKUP_DIR"
echo ""
echo "🔄 Próximo passo:"
echo "   git add snowflake_workspace/backup/"
echo "   git commit -m 'backup: adiciona objetos do Snowflake'"
echo "   git push origin main"
echo ""
