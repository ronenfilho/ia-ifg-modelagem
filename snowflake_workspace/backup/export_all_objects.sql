-- =====================================================================
-- SCRIPT: Exportar todos os objetos do Snowflake
-- =====================================================================
-- Este script gera os DDLs de todos os objetos do database IE_DB
-- Execute este script e salve a saída para backup
-- =====================================================================

USE ROLE IE_TRANSFORM_ROLE;
USE DATABASE IE_DB;

-- =====================================================================
-- 1. EXPORTAR ESTRUTURA DO DATABASE
-- =====================================================================
SELECT '-- ====================================================================' AS DDL
UNION ALL SELECT '-- DATABASE: IE_DB'
UNION ALL SELECT '-- ====================================================================' 
UNION ALL SELECT GET_DDL('DATABASE', 'IE_DB');

-- =====================================================================
-- 2. EXPORTAR SCHEMAS
-- =====================================================================
SELECT '-- ====================================================================' AS DDL
UNION ALL SELECT '-- SCHEMAS'
UNION ALL SELECT '-- ===================================================================='
UNION ALL
SELECT GET_DDL('SCHEMA', 'IE_DB.' || schema_name) AS DDL
FROM IE_DB.INFORMATION_SCHEMA.SCHEMATA
WHERE schema_name IN ('STAGING', 'CORE', 'RAW')
ORDER BY schema_name;

-- =====================================================================
-- 3. EXPORTAR TODAS AS TABELAS DO SCHEMA STAGING
-- =====================================================================
SELECT '-- ====================================================================' AS DDL
UNION ALL SELECT '-- TABLES - SCHEMA: STAGING'
UNION ALL SELECT '-- ===================================================================='
UNION ALL
SELECT GET_DDL('TABLE', 'IE_DB.STAGING.' || table_name) AS DDL
FROM IE_DB.INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'STAGING'
AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- =====================================================================
-- 4. EXPORTAR TODAS AS VIEWS DO SCHEMA STAGING
-- =====================================================================
SELECT '-- ====================================================================' AS DDL
UNION ALL SELECT '-- VIEWS - SCHEMA: STAGING'
UNION ALL SELECT '-- ===================================================================='
UNION ALL
SELECT GET_DDL('VIEW', 'IE_DB.STAGING.' || table_name) AS DDL
FROM IE_DB.INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'STAGING'
ORDER BY table_name;

-- =====================================================================
-- 5. EXPORTAR TODAS AS VIEWS DO SCHEMA CORE
-- =====================================================================
SELECT '-- ====================================================================' AS DDL
UNION ALL SELECT '-- VIEWS - SCHEMA: CORE'
UNION ALL SELECT '-- ===================================================================='
UNION ALL
SELECT GET_DDL('VIEW', 'IE_DB.CORE.' || table_name) AS DDL
FROM IE_DB.INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'CORE'
ORDER BY table_name;

-- =====================================================================
-- 6. EXPORTAR TODAS AS VIEWS DO SCHEMA RAW
-- =====================================================================
SELECT '-- ====================================================================' AS DDL
UNION ALL SELECT '-- VIEWS - SCHEMA: RAW'
UNION ALL SELECT '-- ===================================================================='
UNION ALL
SELECT GET_DDL('VIEW', 'IE_DB.RAW.' || table_name) AS DDL
FROM IE_DB.INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'RAW'
ORDER BY table_name;

-- =====================================================================
-- CONCLUÍDO
-- =====================================================================
SELECT '-- ====================================================================' AS DDL
UNION ALL SELECT '-- EXPORT COMPLETED: ' || CURRENT_TIMESTAMP()::STRING
UNION ALL SELECT '-- ====================================================================';
