# Laboratórios de Modelagem de Dados - IFG IA

Este repositório contém uma série de laboratórios práticos para o ensino de modelagem de dados, data warehousing e engenharia de dados, desenvolvidos para o curso de Inteligência Artificial do Instituto Federal de Goiás (IFG).

## 📚 Laboratórios Disponíveis

### 1. 🏗️ [Laboratório Snowflake - Modelo Dimensional](laboratorio_snowflake.md)
**Implementação de Data Warehouse com Modelo Dimensional no Snowflake**

- **Objetivo**: Ensinar conceitos fundamentais de modelagem dimensional através da implementação prática de um Data Warehouse
- **Tecnologias**: Snowflake, SQL
- **Conceitos**: Schema estrela, dimensões, fatos, surrogate keys, ETL
- **Duração**: 6 etapas guiadas
- **Pré-requisitos**: Conta trial do Snowflake

**Tópicos abordados:**
- Configuração de ambiente Snowflake
- Criação de área de staging
- Implementação de dimensões (DIM_DATE, DIM_CUSTOMER, DIM_PRODUCT, DIM_ORDER)
- Criação de tabela fato (FACT_SALES)
- Validações e qualidade de dados
- Consultas analíticas
- Troubleshooting e próximos passos

---

### 2. 📊 [Laboratório Parquet e Time Travel](laboratorio_parquet_time_travel.md)
**Manipulação de Dados Semi-estruturados e Auditoria no Snowflake**

- **Objetivo**: Explorar funcionalidades intermediárias do Snowflake para engenharia e análise de dados
- **Tecnologias**: Snowflake, Parquet, Time Travel
- **Conceitos**: Dados semi-estruturados, auditoria, recuperação de dados, evolução de schema
- **Duração**: Laboratório guiado + atividades individuais
- **Pré-requisitos**: Laboratório Snowflake concluído

**Tópicos abordados:**
- Exportação de dados para formato Parquet
- Criação e uso de stages internos
- Consulta direta de arquivos Parquet
- Time Travel para auditoria e recuperação
- Evolução de schema com adição de colunas
- Clone de tabelas por Time Travel
- Atividades práticas individuais

---

### 3. 🔄 [Laboratório Airbyte + dbt](laboratorio_airbyte_dbt.md)
**Ingestão CSV com Airbyte e Transformação com dbt**

- **Objetivo**: Integrar ferramentas modernas de ETL/ELT para ingestão e transformação de dados
- **Tecnologias**: Airbyte, dbt, Snowflake, Python
- **Conceitos**: ELT, transformação de dados, testes de qualidade, modelagem dimensional
- **Duração**: Laboratório guiado + atividades dos estudantes
- **Pré-requisitos**: Conhecimento básico de Python e YAML

**Tópicos abordados:**
- Instalação e configuração do dbt
- Configuração do Airbyte para ingestão CSV
- Criação de modelos dbt com dicionário de dados
- Desenvolvimento de dimensões e fatos
- Testes de qualidade de dados
- Ingestão de múltiplos arquivos CSV
- Agregações e análises de negócio

---

## 🛠️ Arquivos de Configuração

### Scripts SQL de Setup
- **`setup_lab_dwh.sql`**: Configuração inicial do Data Warehouse
- **`setup_lab_airbyte.sql`**: Configuração específica para laboratório Airbyte
- **`setup_lab_dbt.sql`**: Configuração para ambiente dbt

### Scripts de Implementação
- **`staging.sql`**: Criação e população da área de staging
- **`dimensions.sql`**: Implementação das tabelas de dimensão
- **`facts.sql`**: Criação da tabela fato central
- **`validations.sql`**: Scripts de validação e qualidade de dados
