-- =====================================================
-- EXTENSÃO DO STAGING PARA CONTROLE DE ESTOQUE
-- =====================================================

USE SCHEMA STAGING;

-- Tabela de Depósitos/Armazéns
CREATE OR REPLACE TABLE WAREHOUSES (
  WAREHOUSE_ID VARCHAR PRIMARY KEY,
  WAREHOUSE_NAME VARCHAR,
  LOCATION VARCHAR,
  WAREHOUSE_TYPE VARCHAR, -- 'CENTRAL', 'REGIONAL', 'STORE'
  CREATED_AT TIMESTAMP
);

-- Tabela de Fornecedores
CREATE OR REPLACE TABLE SUPPLIERS (
  SUPPLIER_ID VARCHAR PRIMARY KEY,
  SUPPLIER_NAME VARCHAR,
  CONTACT_EMAIL VARCHAR,
  STATE VARCHAR,
  CREATED_AT TIMESTAMP
);

-- Tabela de Movimentações de Estoque
CREATE OR REPLACE TABLE INVENTORY_MOVEMENTS (
  MOVEMENT_ID VARCHAR PRIMARY KEY,
  WAREHOUSE_ID VARCHAR,
  SKU VARCHAR,
  MOVEMENT_TYPE VARCHAR, -- 'PURCHASE', 'SALE', 'ADJUSTMENT', 'TRANSFER_IN', 'TRANSFER_OUT'
  MOVEMENT_DATE TIMESTAMP,
  QUANTITY INT, -- Positivo para entradas, negativo para saídas
  UNIT_COST NUMBER(12,2),
  REFERENCE_ID VARCHAR, -- ORDER_ID para vendas, PO_ID para compras
  SUPPLIER_ID VARCHAR,
  NOTES VARCHAR
);

-- =====================================================
-- DADOS DE EXEMPLO
-- =====================================================

-- Inserir Depósitos
INSERT INTO WAREHOUSES (WAREHOUSE_ID, WAREHOUSE_NAME, LOCATION, WAREHOUSE_TYPE, CREATED_AT) VALUES
('WH001', 'Depósito Central SP', 'São Paulo - SP', 'CENTRAL', '2023-12-01 08:00:00'),
('WH002', 'Depósito Regional RJ', 'Rio de Janeiro - RJ', 'REGIONAL', '2023-12-01 08:00:00'),
('WH003', 'Loja Bela Vista', 'São Paulo - SP', 'STORE', '2023-12-15 09:00:00'),
('WH004', 'Loja Copacabana', 'Rio de Janeiro - RJ', 'STORE', '2023-12-15 09:00:00');

-- Inserir Fornecedores
INSERT INTO SUPPLIERS (SUPPLIER_ID, SUPPLIER_NAME, CONTACT_EMAIL, STATE, CREATED_AT) VALUES
('SUP001', 'TechSupply Ltda', 'vendas@techsupply.com', 'SP', '2023-11-15 10:00:00'),
('SUP002', 'ElectroMax Distribuidora', 'comercial@electromax.com', 'RJ', '2023-11-20 14:30:00'),
('SUP003', 'Global Electronics', 'supply@globalelec.com', 'MG', '2023-11-25 11:15:00');

-- =====================================================
-- MOVIMENTAÇÕES DE ESTOQUE - 2024
-- =====================================================

-- Estoque Inicial (Janeiro 2024)
INSERT INTO INVENTORY_MOVEMENTS (MOVEMENT_ID, WAREHOUSE_ID, SKU, MOVEMENT_TYPE, MOVEMENT_DATE, QUANTITY, UNIT_COST, REFERENCE_ID, SUPPLIER_ID, NOTES) VALUES
-- Depósito Central SP - Estoque Inicial
('MOV001', 'WH001', 'S10', 'ADJUSTMENT', '2024-01-01 08:00:00', 50, 2000.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV002', 'WH001', 'N20', 'ADJUSTMENT', '2024-01-01 08:00:00', 30, 4500.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV003', 'WH001', 'F30', 'ADJUSTMENT', '2024-01-01 08:00:00', 100, 280.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV004', 'WH001', 'T40', 'ADJUSTMENT', '2024-01-01 08:00:00', 40, 1500.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV005', 'WH001', 'C60', 'ADJUSTMENT', '2024-01-01 08:00:00', 25, 2200.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),

-- Depósito Regional RJ - Estoque Inicial
('MOV006', 'WH002', 'S10', 'ADJUSTMENT', '2024-01-01 08:00:00', 30, 2000.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV007', 'WH002', 'N20', 'ADJUSTMENT', '2024-01-01 08:00:00', 20, 4500.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV008', 'WH002', 'F30', 'ADJUSTMENT', '2024-01-01 08:00:00', 80, 280.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV009', 'WH002', 'T40', 'ADJUSTMENT', '2024-01-01 08:00:00', 25, 1500.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),
('MOV010', 'WH002', 'C60', 'ADJUSTMENT', '2024-01-01 08:00:00', 15, 2200.00, 'INITIAL_STOCK', NULL, 'Estoque inicial'),

-- Compras Janeiro 2024
('MOV011', 'WH001', 'S10', 'PURCHASE', '2024-01-05 14:30:00', 20, 1950.00, 'PO001', 'SUP001', 'Reposição estoque'),
('MOV012', 'WH001', 'N20', 'PURCHASE', '2024-01-08 10:15:00', 15, 4400.00, 'PO002', 'SUP002', 'Reposição estoque'),
('MOV013', 'WH002', 'F30', 'PURCHASE', '2024-01-10 16:20:00', 50, 270.00, 'PO003', 'SUP003', 'Reposição estoque'),

-- Vendas Janeiro 2024 (baseadas nos pedidos existentes)
('MOV014', 'WH001', 'S10', 'SALE', '2024-01-03 10:12:00', -1, 2000.00, 'O101', NULL, 'Venda - Pedido O101'),
('MOV015', 'WH001', 'F30', 'SALE', '2024-01-03 10:12:00', -2, 280.00, 'O101', NULL, 'Venda - Pedido O101'),
('MOV016', 'WH002', 'N20', 'SALE', '2024-01-06 14:20:00', -1, 4500.00, 'O102', NULL, 'Venda - Pedido O102'),
('MOV017', 'WH002', 'F30', 'SALE', '2024-01-06 14:20:00', -1, 280.00, 'O102', NULL, 'Venda - Pedido O102'),
('MOV018', 'WH001', 'T40', 'SALE', '2024-01-09 09:05:00', -1, 1500.00, 'O103', NULL, 'Venda - Pedido O103'),
('MOV019', 'WH001', 'F30', 'SALE', '2024-01-09 09:05:00', -3, 280.00, 'O103', NULL, 'Venda - Pedido O103'),
('MOV020', 'WH002', 'C60', 'SALE', '2024-01-15 16:45:00', -1, 2200.00, 'O104', NULL, 'Venda - Pedido O104'),
('MOV021', 'WH002', 'S10', 'SALE', '2024-01-15 16:45:00', -1, 2000.00, 'O104', NULL, 'Venda - Pedido O104'),

-- Transferências entre depósitos
('MOV022', 'WH001', 'S10', 'TRANSFER_OUT', '2024-01-20 09:30:00', -5, 2000.00, 'TRF001', NULL, 'Transferência WH001->WH002'),
('MOV023', 'WH002', 'S10', 'TRANSFER_IN', '2024-01-20 11:45:00', 5, 2000.00, 'TRF001', NULL, 'Transferência WH001->WH002'),

-- Compras Fevereiro 2024
('MOV024', 'WH001', 'T40', 'PURCHASE', '2024-02-01 09:00:00', 25, 1480.00, 'PO004', 'SUP001', 'Reposição estoque'),
('MOV025', 'WH002', 'C60', 'PURCHASE', '2024-02-03 14:15:00', 20, 2150.00, 'PO005', 'SUP002', 'Reposição estoque'),

-- Vendas Fevereiro 2024 (algumas das vendas dos pedidos existentes)
('MOV026', 'WH001', 'S10', 'SALE', '2024-02-02 10:10:00', -1, 2000.00, 'O106', NULL, 'Venda - Pedido O106'),
('MOV027', 'WH001', 'N20', 'SALE', '2024-02-02 10:10:00', -1, 4500.00, 'O106', NULL, 'Venda - Pedido O106'),
('MOV028', 'WH002', 'F30', 'SALE', '2024-02-07 19:00:00', -3, 280.00, 'O107', NULL, 'Venda - Pedido O107'),
('MOV029', 'WH002', 'C60', 'SALE', '2024-02-07 19:00:00', -1, 2200.00, 'O107', NULL, 'Venda - Pedido O107'),

-- Ajustes de Inventário
('MOV030', 'WH001', 'F30', 'ADJUSTMENT', '2024-02-15 17:00:00', -2, 280.00, 'ADJ001', NULL, 'Ajuste inventário - dano'),
('MOV031', 'WH002', 'T40', 'ADJUSTMENT', '2024-02-20 08:30:00', 3, 1500.00, 'ADJ002', NULL, 'Ajuste inventário - encontrado'),

-- Compras Março 2024
('MOV032', 'WH001', 'S10', 'PURCHASE', '2024-03-01 10:00:00', 30, 1920.00, 'PO006', 'SUP003', 'Reposição estoque'),
('MOV033', 'WH002', 'N20', 'PURCHASE', '2024-03-05 15:30:00', 20, 4350.00, 'PO007', 'SUP001', 'Reposição estoque'),

-- Continuar com mais movimentações para Abril e Maio...
('MOV034', 'WH001', 'F30', 'PURCHASE', '2024-04-01 11:20:00', 60, 275.00, 'PO008', 'SUP002', 'Reposição estoque'),
('MOV035', 'WH002', 'C60', 'PURCHASE', '2024-04-10 13:45:00', 25, 2180.00, 'PO009', 'SUP003', 'Reposição estoque'),
('MOV036', 'WH001', 'T40', 'PURCHASE', '2024-05-01 09:15:00', 35, 1460.00, 'PO010', 'SUP001', 'Reposição estoque'),
('MOV037', 'WH002', 'S10', 'PURCHASE', '2024-05-15 14:00:00', 25, 1900.00, 'PO011', 'SUP002', 'Reposição estoque'); 