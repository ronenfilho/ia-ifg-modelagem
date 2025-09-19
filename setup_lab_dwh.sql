-- =====================================================================
-- 0) CONTEXTO (opcional)
-- =====================================================================
-- USE ROLE SYSADMIN;

-- =====================================================================
-- 1) WAREHOUSE LEVE (economiza custo, auto-suspende)
-- =====================================================================
CREATE WAREHOUSE IF NOT EXISTS LAB_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

USE WAREHOUSE LAB_WH;

-- =====================================================================
-- 2) DATABASE E SCHEMAS
-- =====================================================================
CREATE DATABASE IF NOT EXISTS LAB_DWH;
USE DATABASE LAB_DWH;

CREATE SCHEMA IF NOT EXISTS STAGING;  -- dados de origem
CREATE SCHEMA IF NOT EXISTS CORE;     -- modelo analítico (estrela)
