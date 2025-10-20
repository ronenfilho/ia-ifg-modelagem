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
