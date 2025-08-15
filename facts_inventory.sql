-- =====================================================
-- TABELA FATO: FACT_INVENTORY
-- =====================================================

USE SCHEMA DWH;

-- Tabela Fato de Estoque
CREATE OR REPLACE TABLE FACT_INVENTORY (
  -- Chaves Dimensionais
  DATE_KEY            INT           REFERENCES DIM_DATE(DATE_KEY),
  WAREHOUSE_SK        NUMBER        REFERENCES DIM_WAREHOUSE(WAREHOUSE_SK),
  PRODUCT_SK          NUMBER        REFERENCES DIM_PRODUCT(PRODUCT_SK),
  SUPPLIER_SK         NUMBER        REFERENCES DIM_SUPPLIER(SUPPLIER_SK),
  MOVEMENT_TYPE_SK    NUMBER        REFERENCES DIM_MOVEMENT_TYPE(MOVEMENT_TYPE_SK),
  
  -- Chaves Degeneradas
  MOVEMENT_ID         VARCHAR,
  REFERENCE_ID        VARCHAR,
  
  -- Métricas de Estoque
  QUANTITY_CHANGE     INT,          -- Quantidade da movimentação (+/-)
  UNIT_COST           NUMBER(12,2), -- Custo unitário
  TOTAL_COST          NUMBER(12,2), -- Custo total da movimentação
  RUNNING_BALANCE     INT,          -- Saldo corrente após a movimentação
  RUNNING_VALUE       NUMBER(12,2), -- Valor do estoque após a movimentação
  
  -- Métricas Calculadas
  STOCK_DAYS          INT,          -- Dias de estoque (se aplicável)
  MOVEMENT_FLAG       BOOLEAN,      -- TRUE se houve movimentação
  
  -- Metadados
  MOVEMENT_TIMESTAMP  TIMESTAMP,
  NOTES               VARCHAR,
  
  PRIMARY KEY (DATE_KEY, WAREHOUSE_SK, PRODUCT_SK, MOVEMENT_ID)
);

-- =====================================================
-- ETL PARA FACT_INVENTORY
-- =====================================================

-- Step 1: Criar CTE com running balance por produto/warehouse
WITH inventory_movements AS (
  SELECT 
    im.MOVEMENT_ID,
    im.WAREHOUSE_ID,
    im.SKU,
    im.MOVEMENT_TYPE,
    im.MOVEMENT_DATE,
    im.QUANTITY,
    im.UNIT_COST,
    im.REFERENCE_ID,
    im.SUPPLIER_ID,
    im.NOTES,
    
    -- Calcular running balance
    SUM(im.QUANTITY) OVER (
      PARTITION BY im.WAREHOUSE_ID, im.SKU 
      ORDER BY im.MOVEMENT_DATE, im.MOVEMENT_ID
      ROWS UNBOUNDED PRECEDING
    ) AS running_balance,
    
    -- Calcular valor da movimentação
    im.QUANTITY * im.UNIT_COST AS total_cost
    
  FROM STAGING.INVENTORY_MOVEMENTS im
),

-- Step 2: Calcular valor do estoque com FIFO aproximado
inventory_with_value AS (
  SELECT 
    *,
    -- Valor do estoque (simplified - usando último custo)
    running_balance * unit_cost AS running_value
  FROM inventory_movements
)

-- Step 3: Inserir na tabela fato
INSERT INTO FACT_INVENTORY (
  DATE_KEY, WAREHOUSE_SK, PRODUCT_SK, SUPPLIER_SK, MOVEMENT_TYPE_SK,
  MOVEMENT_ID, REFERENCE_ID, QUANTITY_CHANGE, UNIT_COST, TOTAL_COST,
  RUNNING_BALANCE, RUNNING_VALUE, MOVEMENT_FLAG, MOVEMENT_TIMESTAMP, NOTES
)
SELECT
  -- Chaves dimensionais
  TO_NUMBER(TO_VARCHAR(CAST(iwv.MOVEMENT_DATE AS DATE), 'YYYYMMDD')) AS DATE_KEY,
  dw.WAREHOUSE_SK,
  dp.PRODUCT_SK,
  COALESCE(ds.SUPPLIER_SK, -1) AS SUPPLIER_SK, -- -1 para Unknown
  dmt.MOVEMENT_TYPE_SK,
  
  -- Chaves degeneradas
  iwv.MOVEMENT_ID,
  iwv.REFERENCE_ID,
  
  -- Métricas
  iwv.QUANTITY AS QUANTITY_CHANGE,
  iwv.UNIT_COST,
  iwv.total_cost AS TOTAL_COST,
  iwv.running_balance AS RUNNING_BALANCE,
  iwv.running_value AS RUNNING_VALUE,
  TRUE AS MOVEMENT_FLAG,
  iwv.MOVEMENT_DATE AS MOVEMENT_TIMESTAMP,
  iwv.NOTES
  
FROM inventory_with_value iwv
JOIN DIM_WAREHOUSE dw ON dw.WAREHOUSE_ID = iwv.WAREHOUSE_ID
JOIN DIM_PRODUCT dp ON dp.SKU = iwv.SKU
JOIN DIM_MOVEMENT_TYPE dmt ON dmt.MOVEMENT_TYPE = iwv.MOVEMENT_TYPE
LEFT JOIN DIM_SUPPLIER ds ON ds.SUPPLIER_ID = iwv.SUPPLIER_ID;

-- =====================================================
-- CRIAÇÃO DE SNAPSHOTS DIÁRIOS (OPCIONAL)
-- =====================================================

-- Esta view calcula o estoque atual de cada produto por depósito
CREATE OR REPLACE VIEW V_CURRENT_INVENTORY AS
SELECT 
  dw.WAREHOUSE_ID,
  dw.WAREHOUSE_NAME,
  dp.SKU,
  dp.PRODUCT,
  dp.CATEGORY,
  SUM(fi.QUANTITY_CHANGE) AS CURRENT_STOCK,
  
  -- Valor usando média ponderada dos custos
  CASE 
    WHEN SUM(fi.QUANTITY_CHANGE) > 0 
    THEN SUM(CASE WHEN fi.QUANTITY_CHANGE > 0 THEN fi.TOTAL_COST ELSE 0 END) / 
         SUM(CASE WHEN fi.QUANTITY_CHANGE > 0 THEN fi.QUANTITY_CHANGE ELSE 0 END)
    ELSE 0 
  END AS AVG_UNIT_COST,
  
  -- Valor total do estoque
  SUM(fi.QUANTITY_CHANGE) * 
  CASE 
    WHEN SUM(fi.QUANTITY_CHANGE) > 0 
    THEN SUM(CASE WHEN fi.QUANTITY_CHANGE > 0 THEN fi.TOTAL_COST ELSE 0 END) / 
         SUM(CASE WHEN fi.QUANTITY_CHANGE > 0 THEN fi.QUANTITY_CHANGE ELSE 0 END)
    ELSE 0 
  END AS TOTAL_STOCK_VALUE,
  
  MAX(fi.MOVEMENT_TIMESTAMP) AS LAST_MOVEMENT
  
FROM FACT_INVENTORY fi
JOIN DIM_WAREHOUSE dw ON dw.WAREHOUSE_SK = fi.WAREHOUSE_SK
JOIN DIM_PRODUCT dp ON dp.PRODUCT_SK = fi.PRODUCT_SK
GROUP BY dw.WAREHOUSE_ID, dw.WAREHOUSE_NAME, dp.SKU, dp.PRODUCT, dp.CATEGORY
HAVING SUM(fi.QUANTITY_CHANGE) <> 0  -- Mostrar apenas itens com estoque
ORDER BY dw.WAREHOUSE_NAME, dp.PRODUCT; 