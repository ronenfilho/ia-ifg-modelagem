# Laboratório Snowflake: Parquet, Time Travel e Evolução de Schema

Este laboratório aborda funcionalidades intermediárias do Snowflake, essenciais para engenharia e análise de dados.

### 🎯 Objetivos de Aprendizagem

- **Manipulação de Dados Semi-estruturados**: Exportar dados relacionais para o formato Parquet em um *internal stage* e consultá-los diretamente.
- **Auditoria e Recuperação**: Utilizar o Time Travel nativo do Snowflake para auditar alterações e consultar versões passadas de tabelas.
- **Evolução de Schema**: Praticar a adição de colunas em tabelas existentes e garantir a integridade dos dados exportados.

### 📝 Estrutura

O laboratório é dividido em duas partes:

1.  **🧑‍🏫 Laboratório Guiado**: Passos executados em conjunto com o instrutor para aprender os conceitos fundamentais.
2.  **🧑‍💻 Atividade Individual**: Tarefas práticas para aplicar o conhecimento adquirido, a serem resolvidas individualmente ou em duplas.

---

## 🛠️ Pré-requisitos

- Warehouse `LAB_WH`, database `LAB_DWH`, schemas `STAGING` e `CORE`.
- Tabelas já criadas e populadas: `CORE.DIM_CUSTOMERS`, `CORE.DIM_PRODUCTS`, `CORE.DIM_ORDERS`, `CORE.FACT_SALES`.

---

## 🧑‍🏫 Parte 1 — Laboratório Guiado

Nesta seção, serão realizados os passos para explorar o UNLOAD para Parquet e o Time Travel.

### UNLOAD para Parquet

#### 1. Preparar Formatos e Stage Internos (Parquet)

Para exportar dados, precisamos de um `FILE FORMAT` que descreva o tipo de arquivo (Parquet) e um `STAGE` (uma área de armazenamento interna) onde os arquivos serão colocados.

```sql
CREATE OR REPLACE FILE FORMAT STAGING.FF_PARQUET TYPE = PARQUET;

CREATE OR REPLACE STAGE STAGING.PQ_STAGE
  FILE_FORMAT = STAGING.FF_PARQUET;
```

**✔️ Checkpoint**: Verifique se o stage foi criado.
```sql
SHOW STAGES IN SCHEMA STAGING;
```
*O stage `PQ_STAGE` deve aparecer na lista.*

#### 2. UNLOAD da Tabela Fato para Parquet

Vamos exportar a tabela `FACT_SALES` para o nosso stage no formato Parquet. O comando `COPY INTO @...` é usado para "descarregar" (UNLOAD) dados de uma tabela para um stage.

```sql
-- Exporta a FACT_SALES (com coluna derivada) para Parquet no stage interno
COPY INTO @STAGING.PQ_STAGE/fact_sales/
FROM (
  SELECT
    ORDER_ID,
    ORDER_ITEM,
    ORDER_SK,
    CUSTOMER_SK,
    PRODUCT_SK,
    QUANTITY,
    UNIT_PRICE,
    QUANTITY * UNIT_PRICE AS GROSS_AMOUNT, -- Coluna derivada em tempo de exportação
    CURRENT_TIMESTAMP()::TIMESTAMP AS LOAD_TS
  FROM CORE.FACT_SALES
)
OVERWRITE = TRUE; -- Sobrescreve arquivos anteriores nesse prefixo
```

Agora, vamos inspecionar os arquivos gerados no stage.

```sql
LIST @STAGING.PQ_STAGE/fact_sales/;
```

**✔️ Checkpoint**: A saída do `LIST` deve mostrar um ou mais arquivos `.parquet.gz` com tamanho maior que zero.

#### 3. Ler Parquet Diretamente do Stage

Uma grande vantagem do Snowflake é a capacidade de consultar arquivos em um stage sem precisar carregá-los para uma tabela. Cada linha do arquivo Parquet é tratada como um objeto `VARIANT` (similar a JSON), que pode ser acessado com a notação `$1`.

```sql
-- Cada linha do Parquet vira um objeto VARIANT ($1)
SELECT
  $1:ORDER_ID::STRING               AS ORDER_ID,
  $1:ORDER_ITEM::INT                AS ORDER_ITEM,
  $1:GROSS_AMOUNT::NUMBER(12,2)     AS GROSS_AMOUNT
FROM @STAGING.PQ_STAGE/fact_sales/
LIMIT 10;
```

**✔️ Checkpoint**: O resultado deve ser uma tabela com 10 linhas e as colunas `ORDER_ID`, `ORDER_ITEM` e `GROSS_AMOUNT`.

### Time Travel

#### 0. Contexto e Retenção para Time Travel

O Time Travel do Snowflake permite consultar dados em um ponto específico do passado. Para que funcione, o período de retenção de dados da tabela (ou do banco de dados/schema) deve ser maior que zero.

```sql
USE WAREHOUSE LAB_WH;
USE DATABASE LAB_DWH;

-- Garanta retenção mínima para Time Travel (pode ser 1 dia)
ALTER DATABASE LAB_DWH SET DATA_RETENTION_TIME_IN_DAYS = 1;
```


#### 2. Time Travel nas Tabelas do CORE

Agora, vamos simular uma alteração acidental nos dados e usar o Time Travel para auditar o que aconteceu.

**a) Estado Atual (Baseline)**

Primeiro, capture o estado atual da receita e do preço de um produto específico.

```sql
SELECT COUNT(*) AS CNT_FACT, SUM(QUANTITY*UNIT_PRICE) AS RECEITA
FROM CORE.FACT_SALES;

SELECT PRICE AS AVG_PRICE_S10_BEFORE
FROM CORE.DIM_PRODUCTS WHERE SKU = 'S10';
```

**b) Aplicar uma Mudança (Simular Erro)**

Vamos supor que um processo atualizou o preço do produto 'S10' incorretamente.

```sql
UPDATE CORE.DIM_PRODUCTS SET PRICE = PRICE * 1.10 WHERE SKU = 'S10';

-- Verifique o novo preço
SELECT PRICE AS AVG_PRICE_S10_NOW
FROM CORE.DIM_PRODUCTS WHERE SKU = 'S10';
```

**c) Consultar o Passado (2 minutos atrás)**

Com o Time Travel, podemos ver como a tabela era *antes* da nossa alteração. A cláusula `AT` nos permite "voltar no tempo".

```sql
SELECT PRICE AS AVG_PRICE_S10_PAST
FROM CORE.DIM_PRODUCTS
  AT (TIMESTAMP => DATEADD('minute', -2, CURRENT_TIMESTAMP()))
WHERE SKU = 'S10';
```

**✔️ Checkpoint**: Compare os valores de `AVG_PRICE_S10_NOW` e `AVG_PRICE_S10_PAST`. Eles devem ser diferentes, provando que o Time Travel acessou o estado anterior da tabela.

> **Dica para o Instrutor**: Explique que Time Travel é uma operação de **leitura** de "como a tabela era". É ideal para auditoria, reconciliação e recuperação de desastres. Para "desfazer" uma alteração, você pode usar o estado antigo para popular uma nova tabela ou executar um `UPDATE` corretivo.

### 3. (Opcional) CLONE por Time Travel

Se você precisar de uma cópia completa da tabela em um estado anterior (para uma análise mais aprofundada, por exemplo), pode usar `CLONE`.

```sql
CREATE OR REPLACE TABLE CORE.DIM_PRODUCTS_TT
CLONE CORE.DIM_PRODUCTS
  AT (TIMESTAMP => DATEADD('minute', -2, CURRENT_TIMESTAMP()));

SELECT * FROM CORE.DIM_PRODUCTS_TT WHERE SKU = 'S10';
```

**✔️ Checkpoint**: A nova tabela `DIM_PRODUCTS_TT` deve conter o preço do produto 'S10' *antes* do `UPDATE`.

---

## 🧑‍💻 Parte 2 — Atividade Individual

Execute as tarefas a seguir para praticar os conceitos aprendidos. Para cada tarefa, entregue os comandos SQL executados e capturas de tela (*prints*) dos resultados.

### Tarefa A — Exportar Outra Entidade para Parquet

1.  Exporte a tabela `DIM_PRODUCTS` para um novo prefixo (`dim_products/`) no mesmo stage.
2.  Liste os arquivos no novo prefixo para confirmar a exportação.
3.  Consulte 5 linhas diretamente do stage, selecionando as colunas `SKU` e `PRICE`.

**📦 Entrega**:
1.  Captura de tela do resultado do comando `LIST`.
2.  Captura de tela do resultado do `SELECT` no stage.

### Tarefa B — Evolução Simples de Schema e UNLOAD

1.  Adicione uma nova coluna `NOTE` (do tipo `VARCHAR`) na tabela `CORE.FACT_SALES`.
2.  Faça um `UPDATE` para preencher a coluna `NOTE` com o valor `'lote_extra'` para o segundo item de pedido (`ORDER_ITEM = 2`).
3.  Exporte novamente a tabela `CORE.FACT_SALES` para um novo prefixo (`fact_sales_v2/`).
4.  Consulte os dados no stage (`fact_sales_v2/`) e filtre pelas linhas onde a coluna `NOTE` não é nula, confirmando que os dados foram exportados corretamente.

**📦 Entrega**:
1.  Captura de tela do `SELECT` no stage, mostrando que a coluna `NOTE` existe e contém o valor `'lote_extra'`.

### Tarefa C — Auditoria com Time Travel

1.  **Baseline**: Execute um `SELECT COUNT(*)` na tabela `CORE.FACT_SALES` para obter a contagem inicial de linhas. Anote este número.
2.  **Alteração**: Simule uma exclusão acidental de dados, removendo 5 linhas da tabela `CORE.FACT_SALES`.
3.  **Auditoria**:
    - Execute um `SELECT COUNT(*)` novamente para ver a contagem *após* o `DELETE`.
    - Use o Time Travel para executar um `SELECT COUNT(*)` na tabela como ela era 2 minutos no passado.
4.  **Análise**: Compare as três contagens (antes do delete, depois do delete e no passado).

**📦 Entrega**:
1.  As três contagens obtidas (`CNT_NOW`, `CNT_AFTER`, `CNT_PAST`).
2.  Uma frase explicando por que a contagem do passado (`CNT_PAST`) é igual à contagem inicial (`CNT_NOW`) e diferente da contagem atual (`CNT_AFTER`).

> **Importante**: Ao final da atividade, você pode deixar os dados como estão ou restaurá-los. Para restaurar, uma opção seria: `INSERT INTO CORE.FACT_SALES SELECT * FROM CORE.FACT_SALES AT (TIMESTAMP => DATEADD('minute', -5, CURRENT_TIMESTAMP()));`
