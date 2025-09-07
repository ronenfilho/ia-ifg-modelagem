# Laboratório de Modelagem de Dados - IFG IA
## Implementação de Data Warehouse com Modelo Dimensional no Snowflake

### 📋 Visão Geral

Este laboratório tem como objetivo ensinar os conceitos fundamentais de modelagem dimensional através da implementação prática de um Data Warehouse no Snowflake. O projeto aborda desde a configuração inicial do ambiente até a validação dos dados, passando pela criação de um modelo estrela (star schema) completo.

### 🎯 Objetivos de Aprendizagem

Ao final deste laboratório, você será capaz de:
- Configurar um ambiente de Data Warehouse no Snowflake
- Implementar um modelo dimensional (estrela)
- Criar e popular tabelas de dimensões e fatos
- Realizar validações de qualidade de dados
- Executar consultas analíticas em um modelo dimensional

### 🏗️ Arquitetura do Projeto

O projeto implementa um Data Warehouse com duas camadas principais:
- **STAGING**: Área de dados de origem (dados transacionais)
- **DWH**: Modelo analítico dimensional (schema estrela)

**Modelo de Dados:**
- **Dimensões**: DIM_DATE, DIM_CUSTOMER, DIM_PRODUCT, DIM_ORDER
- **Fato**: FACT_SALES

### 📊 Conjunto de Dados

O laboratório utiliza dados de um e-commerce fictício contendo:
- 10 clientes distribuídos por diferentes estados brasileiros
- 5 produtos de tecnologia (smartphones, notebooks, tablets, câmeras, fones)
- 25 pedidos com múltiplos itens cada, cobrindo 5 meses (Janeiro a Maio 2024)
- Estrutura normalizada com separação entre cabeçalho do pedido e itens
- Campos de totais e impostos para análises mais completas

---

## 🚀 Passo a Passo do Laboratório

### Pré-requisitos

1. **Conta Trial do Snowflake**
   - Acesse: https://signup.snowflake.com/
   - Crie uma conta trial gratuita
   - Escolha a região mais próxima (ex: AWS São Paulo)
   - Anote as credenciais de acesso

2. **Acesso ao Snowflake Web Interface**
   - Faça login na interface web do Snowflake
   - Certifique-se de ter permissões SYSADMIN

---

### Etapa 1: Configuração do Ambiente

**Objetivo**: Criar a infraestrutura básica do Data Warehouse

1. **Execute o arquivo `setup.sql`**
   ```sql
   -- Copie e execute o conteúdo completo do arquivo setup.sql
   ```

**O que acontece nesta etapa:**
- ✅ Criação de um warehouse computacional otimizado (XSMALL com auto-suspend)
- ✅ Criação do database LAB_DWH
- ✅ Criação dos schemas STAGING e DWH
- ✅ Configuração para economia de créditos

**Validação da Etapa 1:**
```sql
-- Verificar se os objetos foram criados
SHOW WAREHOUSES LIKE 'LAB_WH';
SHOW DATABASES LIKE 'LAB_DWH';
SHOW SCHEMAS IN DATABASE LAB_DWH;
```

---

### Etapa 2: Criação da Área de Staging

**Objetivo**: Criar e popular as tabelas de origem com dados transacionais

1. **Execute o arquivo `staging.sql`**
   ```sql
   -- Copie e execute o conteúdo completo do arquivo staging.sql
   ```

**O que acontece nesta etapa:**
- ✅ Criação das tabelas CUSTOMERS, PRODUCTS, ORDERS e ORDER_ITEMS no schema STAGING
- ✅ Inserção de dados de exemplo (10 clientes, 5 produtos, 25 pedidos, 50 itens)
- ✅ Simulação de um sistema transacional normalizado de e-commerce
- ✅ Estrutura normalizada separando pedidos dos itens do pedido

**Validação da Etapa 2:**
```sql
-- Verificar a carga dos dados
SELECT 'CUSTOMERS' AS TABELA, COUNT(*) AS REGISTROS FROM STAGING.CUSTOMERS
UNION ALL
SELECT 'PRODUCTS', COUNT(*) FROM STAGING.PRODUCTS  
UNION ALL
SELECT 'ORDERS', COUNT(*) FROM STAGING.ORDERS
UNION ALL
SELECT 'ORDER_ITEMS', COUNT(*) FROM STAGING.ORDER_ITEMS;

-- Verificar alguns dados
SELECT * FROM STAGING.CUSTOMERS LIMIT 5;
SELECT * FROM STAGING.PRODUCTS;
SELECT * FROM STAGING.ORDERS LIMIT 5;
SELECT * FROM STAGING.ORDER_ITEMS LIMIT 10;
```

---

### Etapa 3: Implementação das Dimensões

**Objetivo**: Criar o modelo dimensional com tabelas de dimensão

1. **Execute o arquivo `dimensions.sql`**
   ```sql
   -- Copie e execute o conteúdo completo do arquivo dimensions.sql
   ```

**O que acontece nesta etapa:**
- ✅ **DIM_DATE**: Dimensão de tempo com 3 anos de dados (2023-2025)
- ✅ **DIM_CUSTOMER**: Dimensão de clientes com surrogate keys
- ✅ **DIM_PRODUCT**: Dimensão de produtos com surrogate keys
- ✅ **DIM_ORDER**: Dimensão de pedidos com informações agregadas
- ✅ Implementação de chaves surrogadas para melhor performance

**Conceitos Abordados:**
- **Surrogate Keys**: Chaves técnicas auto-incrementais
- **Dimensão de Tempo**: Calendário pré-populado
- **Atributos Dimensionais**: Propriedades descritivas dos objetos de negócio

**Validação da Etapa 3:**
```sql
-- Verificar as dimensões criadas
SELECT 'DIM_DATE' AS DIMENSAO, COUNT(*) AS REGISTROS FROM DWH.DIM_DATE
UNION ALL
SELECT 'DIM_CUSTOMER', COUNT(*) FROM DWH.DIM_CUSTOMER
UNION ALL  
SELECT 'DIM_PRODUCT', COUNT(*) FROM DWH.DIM_PRODUCT
UNION ALL
SELECT 'DIM_ORDER', COUNT(*) FROM DWH.DIM_ORDER;

-- Verificar alguns registros da dimensão tempo
SELECT * FROM DWH.DIM_DATE WHERE YEAR = 2024 AND MONTH = 1 LIMIT 10;

-- Verificar surrogate keys
SELECT CUSTOMER_SK, CUSTOMER_ID, FULL_NAME FROM DWH.DIM_CUSTOMER LIMIT 5;
SELECT ORDER_SK, ORDER_ID, TOTAL_AMOUNT FROM DWH.DIM_ORDER LIMIT 5;
```

---

### Etapa 4: Criação da Tabela Fato

**Objetivo**: Implementar a tabela fato central do modelo estrela

1. **Execute o arquivo `facts.sql`**
   ```sql
   -- Copie e execute o conteúdo completo do arquivo facts.sql
   ```

**O que acontece nesta etapa:**
- ✅ Criação da tabela FACT_SALES com referências às 4 dimensões
- ✅ ETL dos dados via JOINs entre DIM_ORDER, ORDER_ITEMS e outras dimensões
- ✅ Cálculo de métricas derivadas (GROSS_AMOUNT)
- ✅ Uso exclusivo de surrogate keys (elimina dependência do staging)
- ✅ Estabelecimento das relações chave estrangeira

**Conceitos Abordados:**
- **Tabela Fato**: Armazena métricas e medidas do negócio
- **Grain**: Nível de granularidade (item do pedido)
- **Foreign Keys**: Relacionamentos com dimensões
- **ETL**: Extração, transformação e carga dos dados

**Validação da Etapa 4:**
```sql
-- Verificar a carga da tabela fato
SELECT COUNT(*) AS TOTAL_REGISTROS FROM DWH.FACT_SALES;

-- Verificar alguns registros
SELECT * FROM DWH.FACT_SALES LIMIT 10;

-- Verificar integridade referencial
SELECT 
  f.ORDER_ID,
  f.ORDER_ITEM,
  dt.DDATE,
  c.FULL_NAME,
  p.PRODUCT,
  o.TOTAL_AMOUNT,
  o.TAX_AMOUNT,
  f.QUANTITY,
  f.GROSS_AMOUNT
FROM DWH.FACT_SALES f
JOIN DWH.DIM_DATE dt ON dt.DATE_KEY = f.DATE_KEY
JOIN DWH.DIM_CUSTOMER c ON c.CUSTOMER_SK = f.CUSTOMER_SK  
JOIN DWH.DIM_PRODUCT p ON p.PRODUCT_SK = f.PRODUCT_SK
JOIN DWH.DIM_ORDER o ON o.ORDER_SK = f.ORDER_SK
LIMIT 5;
```

---

### Etapa 5: Validações e Qualidade dos Dados

**Objetivo**: Garantir a integridade e qualidade do modelo implementado

1. **Execute o arquivo `validations.sql`**
   ```sql
   -- Copie e execute o conteúdo completo do arquivo validations.sql
   ```

**O que acontece nesta etapa:**
- ✅ **Teste de Órfãos**: Verificar registros sem chaves válidas
- ✅ **Reconciliação**: Comparar totais entre staging e DWH (itens, pedidos, impostos)
- ✅ **Unicidade**: Validar o grain da tabela fato
- ✅ **Integridade**: Verificar consistência entre totais de pedido e soma dos itens
- ✅ **Contagens**: Validar número de registros entre camadas
- ✅ **Distribuição Temporal**: Analisar vendas por data

**Resultados Esperados:**
- ✅ 0 registros órfãos em CUSTOMER, PRODUCT e ORDER
- ✅ Receita total idêntica entre STAGING.ORDER_ITEMS e FACT_SALES
- ✅ Totais de pedidos consistentes entre STAGING.ORDERS e DIM_ORDER
- ✅ Nenhuma duplicata no grain (ORDER_ID, ORDER_ITEM)
- ✅ Mesma quantidade de itens e pedidos entre camadas
- ✅ Todas as 4 dimensões populadas corretamente
- ✅ Distribuição temporal consistente

**Validação da Etapa 5:**
```sql
-- Todos os resultados devem retornar 0 ou valores consistentes
-- Se alguma validação falhar, revisar as etapas anteriores
```

---

### Etapa 6: Consultas Analíticas

**Objetivo**: Explorar o modelo dimensional com consultas de negócio

Execute as seguintes consultas para explorar os dados:

```sql
-- 1. Top 5 produtos mais vendidos
SELECT 
  p.PRODUCT,
  p.CATEGORY,
  SUM(f.QUANTITY) AS TOTAL_QUANTIDADE,
  SUM(f.GROSS_AMOUNT) AS RECEITA_TOTAL
FROM DWH.FACT_SALES f
JOIN DWH.DIM_PRODUCT p ON p.PRODUCT_SK = f.PRODUCT_SK
GROUP BY p.PRODUCT, p.CATEGORY
ORDER BY RECEITA_TOTAL DESC
LIMIT 5;

-- 2. Vendas por mês
SELECT 
  d.YEAR,
  d.MONTH,
  COUNT(DISTINCT f.ORDER_ID) AS TOTAL_PEDIDOS,
  SUM(f.QUANTITY) AS ITENS_VENDIDOS,
  SUM(f.GROSS_AMOUNT) AS RECEITA_MENSAL
FROM DWH.FACT_SALES f
JOIN DWH.DIM_DATE d ON d.DATE_KEY = f.DATE_KEY
GROUP BY d.YEAR, d.MONTH
ORDER BY d.YEAR, d.MONTH;

-- 3. Top clientes por estado
SELECT 
  c.STATE,
  COUNT(DISTINCT c.CUSTOMER_SK) AS TOTAL_CLIENTES,
  COUNT(DISTINCT f.ORDER_ID) AS TOTAL_PEDIDOS,
  SUM(f.GROSS_AMOUNT) AS RECEITA_ESTADO
FROM DWH.FACT_SALES f
JOIN DWH.DIM_CUSTOMER c ON c.CUSTOMER_SK = f.CUSTOMER_SK
GROUP BY c.STATE
ORDER BY RECEITA_ESTADO DESC;

-- 4. Análise de vendas por categoria e trimestre
SELECT 
  d.YEAR,
  d.QUARTER,
  p.CATEGORY,
  SUM(f.GROSS_AMOUNT) AS RECEITA_CATEGORIA
FROM DWH.FACT_SALES f
JOIN DWH.DIM_DATE d ON d.DATE_KEY = f.DATE_KEY
JOIN DWH.DIM_PRODUCT p ON p.PRODUCT_SK = f.PRODUCT_SK
GROUP BY d.YEAR, d.QUARTER, p.CATEGORY
ORDER BY d.YEAR, d.QUARTER, RECEITA_CATEGORIA DESC;

-- 6. Análise de impostos e margem
SELECT 
  p.CATEGORY,
  SUM(f.GROSS_AMOUNT) AS RECEITA_BRUTA,
  SUM(DISTINCT o.TAX_AMOUNT) AS TOTAL_IMPOSTOS,
  SUM(f.GROSS_AMOUNT) - SUM(DISTINCT o.TAX_AMOUNT) AS RECEITA_LIQUIDA,
  (SUM(DISTINCT o.TAX_AMOUNT) / SUM(f.GROSS_AMOUNT)) * 100 AS PERCENTUAL_IMPOSTO
FROM DWH.FACT_SALES f
JOIN DWH.DIM_PRODUCT p ON p.PRODUCT_SK = f.PRODUCT_SK
JOIN DWH.DIM_ORDER o ON o.ORDER_SK = f.ORDER_SK
GROUP BY p.CATEGORY
ORDER BY RECEITA_BRUTA DESC;

-- 7. Análise de sazonalidade (vendas por dia da semana)
SELECT 
  d.DOW_ISO,
  CASE d.DOW_ISO 
    WHEN 1 THEN 'Segunda'
    WHEN 2 THEN 'Terça'
    WHEN 3 THEN 'Quarta'
    WHEN 4 THEN 'Quinta'
    WHEN 5 THEN 'Sexta'
    WHEN 6 THEN 'Sábado'
    WHEN 7 THEN 'Domingo'
  END AS DIA_SEMANA,
  COUNT(*) AS TOTAL_TRANSACOES,
  SUM(f.GROSS_AMOUNT) AS RECEITA_DIA_SEMANA
FROM DWH.FACT_SALES f
JOIN DWH.DIM_DATE d ON d.DATE_KEY = f.DATE_KEY
GROUP BY d.DOW_ISO
ORDER BY d.DOW_ISO;
```

---

## 📚 Conceitos Abordados

### 1. **Modelagem Dimensional**
- **Schema Estrela**: Organização com uma tabela fato central e dimensões ao redor
- **Dimensões**: Contexto descritivo (quem, o que, quando, onde)
- **Fatos**: Métricas e medidas do negócio (quanto, quantos)

### 2. **Design Patterns**
- **Surrogate Keys**: Chaves técnicas para melhor performance
- **Slowly Changing Dimensions**: Tratamento de mudanças nas dimensões
- **Grain Definition**: Definição clara do nível de detalhe

### 3. **Qualidade de Dados**
- **Integridade Referencial**: Relacionamentos consistentes
- **Reconciliação**: Validação entre camadas
- **Testes de Qualidade**: Verificações automatizadas

---

## 🔍 Troubleshooting

### Problemas Comuns

1. **Erro de Permissão**
   ```sql
   USE ROLE SYSADMIN;
   ```

2. **Warehouse Suspenso**
   ```sql
   ALTER WAREHOUSE LAB_WH RESUME;
   ```

3. **Schema Não Encontrado**
   ```sql
   USE DATABASE LAB_DWH;
   USE SCHEMA DWH; -- ou STAGING
   ```

4. **Dados Não Carregados**
   - Verifique se executou todos os arquivos na sequência correta
   - Confirme se está no database e schema corretos

---

## 📈 Próximos Passos

Após concluir o laboratório, considere explorar:

1. **Expansão do Modelo**
   - Adicionar mais dimensões (fornecedores, campanhas)
   - Implementar hierarquias (categoria → subcategoria)
   - Criar agregações (tabelas sumário)

2. **Slowly Changing Dimensions**
   - Implementar SCD Tipo 1 (sobrescrita)
   - Implementar SCD Tipo 2 (histórico)

3. **Performance**
   - Criar clustering keys
   - Implementar particionamento
   - Otimizar consultas com materialized views

4. **Automação**
   - Criar procedures para ETL
   - Implementar schedule de atualizações
   - Desenvolver pipelines de dados
