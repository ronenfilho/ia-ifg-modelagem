# Laboratório — Ingestão CSV com Airbyte + Transformação com dbt

## 🎯 Objetivos
- Instalar e configurar **dbt** e **Airbyte**.  
- Ingerir o CSV (dados de usinas) para o Snowflake via Airbyte.  
- Criar modelos dbt com base no dicionário do arquivo.  

---

## 🧑‍🏫 Parte 1 — Laboratório Guiado

### 1. Instalação e configuração preliminar
- **Snowflake**: execute o arquivo setup_lab_airbyte.sql
- **Airbyte**: já configurado antes ou use Docker Compose.  
- **dbt**:
  ```bash
  pip install dbt-snowflake
  dbt init laboratorio_dbt
  ```
  Configure o `profiles.yml` para apontar à sua conta Snowflake:
  
  **Localização do arquivo**: `~/.dbt/profiles.yml` (Linux/Mac) ou `C:\Users\{username}\.dbt\profiles.yml` (Windows)
  
  **Conteúdo do `profiles.yml`:**
  ```yaml
  laboratorio_dbt:
    outputs:
      dev:
        type: snowflake
        account: [sua_conta_snowflake]  # ex: ZBUHFWH-HY64747
        user: AIRBYTE_DEV
        password: [sua_senha]
        role: AIRBYTE_DEV
        database: LAB_AIRBYTE
        warehouse: LAB_WH_AIRBYTE
        schema: CORE
        threads: 4
        keepalives_idle: 240
    target: dev
  ```
  
  **Teste a conexão:**
  ```bash
  cd laboratorio_dbt
  dbt debug
  ```
  
  **Estrutura de pastas esperada:**
  ```
  laboratorio_dbt/
  ├── dbt_project.yml
  ├── models/
  │   └── schema.yml
  └── ~/.dbt/profiles.yml
  ```

---

### 2. Ingestão com Airbyte
- Fonte: CSV de disponibilidade de usinas (horária) a partir da URL `https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/disponibilidade_usina_ho/DISPONIBILIDADE_USINA_2025_08.csv`.  
- Destination: tabela `STAGING.DISPONIBILIDADE_USINA_2025_08`.  
- Verifique no Snowflake:
  ```sql
  SELECT * FROM STAGING.DISPONIBILIDADE_USINA_2025_08 LIMIT 5;
  ```

---

### 3. Criação de modelo transforma no dbt (com dicionário)

**Exemplo `models/stg_usina_disp.sql`:**
```sql
SELECT
  id_subsistema,
  nom_estado,
  nom_usina,
  din_instante::TIMESTAMP       AS instante,
  val_potenciainstalada         AS pot_instalada_mw,
  val_dispoperacional           AS disp_operacional_mw,
  val_dispsincronizada          AS disp_sincronizada_mw
FROM {{ source('staging','disponibilidade_usina_2025_08') }};
```

**schema.yml**:
```yaml
sources:
  - name: staging
    tables:
      - name: disponibilidade_usina_2025_08

models:
  - name: stg_usina_disp
    columns:
      - name: instante
        tests: [not_null]
      - name: id_subsistema
        tests: [not_null]
```

Execute:
```bash
dbt run --select stg_usina_disp
dbt test --select stg_usina_disp
```

---

## 🧑‍💻 Parte 2 — Atividades dos Estudantes

### Atividade A — Ingestão de Novos Dados
- Configure o Airbyte para ingerir dados de mais dois meses. Para pegar os dados de outros meses, basta trocar na URL, por exemplo:
  - Julho: `https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/disponibilidade_usina_ho/DISPONIBILIDADE_USINA_2025_07.csv`
  - Setembro: `https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/disponibilidade_usina_ho/DISPONIBILIDADE_USINA_2025_09.csv`
- Crie uma tabela de destino para cada mês no schema `STAGING`.
- Atualize seu `schema.yml` para declarar as duas novas tabelas como fontes (`sources`).

### Atividade B — Desenvolver Modelos de Dimensão (Core)
Com base nos dados extraídos, crie os seguintes modelos dimensionais no schema `CORE`. 
**Importante**: cada dimensão deve ser construída a partir da união dos dados de **todos os meses** ingeridos para garantir que contenha todos os valores únicos.

1.  **`dim_usina.sql`**:
    - Deve conter atributos únicos de cada usina (`nom_usina`, `nom_tipocombustivel`, `ceg`).
    - Crie uma chave primária substituta (surrogate key) chamada `id_dim_usina` usando `dbt_utils.generate_surrogate_key`.

2.  **`dim_localidade.sql`**:
    - Deve conter atributos únicos de localidade (`nom_subsistema`, `nom_estado`).
    - Crie uma chave primária substituta chamada `id_dim_localidade`.

3.  **`dim_tempo.sql`**:
    - Extraia componentes de data e hora da coluna `din_instante` (ano, mês, dia, hora).
    - Crie uma chave primária substituta a partir do próprio instante.

### Atividade C — Desenvolver Modelo de Fatos (Core)
Crie o seguinte modelo de fatos no schema `CORE`:

1.  **`fact_disponibilidade.sql`**:
    - Crie um modelo de fatos centralizado que servirá de base para as **agregações** necessárias para responder às perguntas de negócio.
    - **Lógica de Construção**:
        - Enriqueça os dados com as chaves das tabelas de dimensão (`dim_usina`, `dim_localidade`, `dim_tempo`).
        - Utilize uma unidade agregada de tempo (por exemplo: dia).
        - O modelo deve conter as métricas (`pot_instalada_mw`, `disp_operacional_mw`, `disp_sincronizada_mw`) no seu grão mais detalhado (usina, localidade, instante) para permitir máxima flexibilidade nas análises.
    - **Perguntas a Responder (via Agregação)**: O modelo deve ser a fonte para responder a perguntas como:
        - Qual a disponibilidade operacional **total** por estado em um determinado mês?
        - Qual usina teve a **maior média** de potência instalada no último trimestre?
        - Qual a **média** de disponibilidade sincronizada por hora do dia para usinas do tipo "Hidráulica"?

### Atividade D — Adicionar Testes de Qualidade
- No `schema.yml`, adicione testes para os novos modelos:
  - `unique` e `not_null` para as chaves primárias de todas as tabelas de dimensão.
  - `relationships` na tabela de fatos para garantir que todas as chaves estrangeiras correspondam a um registro em suas respectivas tabelas de dimensão.

---

## ✅ Critérios de Avaliação
- Configurar dbt e Airbyte sem ajuda.  
- Carregar múltiplos arquivos CSV corretamente via Airbyte.  
- Criar modelos dimensionais (dimensões e fatos) seguindo as boas práticas.
- Definir testes de qualidade para garantir a integridade referencial dos modelos.