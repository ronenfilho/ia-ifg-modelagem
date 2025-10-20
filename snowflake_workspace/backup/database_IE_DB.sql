SELECT GET_DDL('DATABASE', 'IE_DB');
+------------------------------------------------------------------------------------------------------------------------------------------------+
| GET_DDL('DATABASE', 'IE_DB')                                                                                                                   |
|------------------------------------------------------------------------------------------------------------------------------------------------|
| create or replace database IE_DB COMMENT='Database com dados brutos (staging) e tratados (core) para o projeto Inteligencia Energetica.';      |
|                                                                                                                                                |
| create or replace schema CORE COMMENT='Schema para modelos de dados de negócio, prontos para consumo (tabelas largas).';                       |
|                                                                                                                                                |
| create or replace view DIM_LOCALIDADE(                                                                                                         |
|         ID_DIM_LOCALIDADE,                                                                                                                     |
|         NOM_SUBSISTEMA,                                                                                                                        |
|         NOM_ESTADO                                                                                                                             |
| ) as (                                                                                                                                         |
|     WITH localidades_unicas AS (                                                                                                               |
|     SELECT                                                                                                                                     |
|         DISTINCT                                                                                                                               |
|         nom_subsistema,                                                                                                                        |
|         nom_estado                                                                                                                             |
|     FROM IE_DB.STAGING.stg_usina_disp                                                                                                          |
| )                                                                                                                                              |
| SELECT                                                                                                                                         |
|     md5(cast(coalesce(cast(nom_subsistema as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(nom_estado as TEXT),             |
| '_dbt_utils_surrogate_key_null_') as TEXT)) AS id_dim_localidade,                                                                              |
|     nom_subsistema,                                                                                                                            |
|     nom_estado                                                                                                                                 |
| FROM localidades_unicas                                                                                                                        |
|   );                                                                                                                                           |
| create or replace view DIM_TEMPO(                                                                                                              |
|         ID_DIM_TEMPO,                                                                                                                          |
|         INSTANTE,                                                                                                                              |
|         ANO,                                                                                                                                   |
|         MES,                                                                                                                                   |
|         DIA,                                                                                                                                   |
|         HORA,                                                                                                                                  |
|         DIA_DA_SEMANA                                                                                                                          |
| ) as (                                                                                                                                         |
|     WITH instantes_unicos AS (                                                                                                                 |
|     SELECT                                                                                                                                     |
|         DISTINCT instante                                                                                                                      |
|     FROM IE_DB.STAGING.stg_usina_disp                                                                                                          |
| )                                                                                                                                              |
| SELECT                                                                                                                                         |
|     md5(cast(coalesce(cast(instante::STRING as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS id_dim_tempo,                             |
|     instante,                                                                                                                                  |
|     EXTRACT(YEAR FROM instante)    AS ano,                                                                                                     |
|     EXTRACT(MONTH FROM instante)   AS mes,                                                                                                     |
|     EXTRACT(DAY FROM instante)     AS dia,                                                                                                     |
|     EXTRACT(HOUR FROM instante)    AS hora,                                                                                                    |
|     EXTRACT(DAYOFWEEK FROM instante) AS dia_da_semana -- Ex: 0=Domingo, 1=Segunda, etc. (varia com o DB)                                       |
| FROM instantes_unicos                                                                                                                          |
|   );                                                                                                                                           |
| create or replace view DIM_USINA(                                                                                                              |
|         ID_DIM_USINA,                                                                                                                          |
|         CEG,                                                                                                                                   |
|         NOM_USINA,                                                                                                                             |
|         NOM_TIPOCOMBUSTIVEL                                                                                                                    |
| ) as (                                                                                                                                         |
|     WITH usinas_unicas AS (                                                                                                                    |
|     SELECT                                                                                                                                     |
|         DISTINCT                                                                                                                               |
|         ceg,                                                                                                                                   |
|         nom_usina,                                                                                                                             |
|         nom_tipocombustivel                                                                                                                    |
|     FROM IE_DB.STAGING.stg_usina_disp                                                                                                          |
| )                                                                                                                                              |
|                                                                                                                                                |
| SELECT                                                                                                                                         |
|     md5(cast(coalesce(cast(ceg as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(nom_usina as TEXT),                         |
| '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(nom_tipocombustivel as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS         |
| id_dim_usina,                                                                                                                                  |
|     ceg,                                                                                                                                       |
|     nom_usina,                                                                                                                                 |
|     nom_tipocombustivel                                                                                                                        |
| FROM usinas_unicas                                                                                                                             |
|   );                                                                                                                                           |
| create or replace view FACT_DISPONIBILIDADE(                                                                                                   |
|         ID_FACT_DISPONIBILIDADE,                                                                                                               |
|         ID_DIM_USINA,                                                                                                                          |
|         ID_DIM_LOCALIDADE,                                                                                                                     |
|         ID_DIM_TEMPO,                                                                                                                          |
|         INSTANTE,                                                                                                                              |
|         POT_INSTALADA_MW,                                                                                                                      |
|         DISP_OPERACIONAL_MW,                                                                                                                   |
|         DISP_SINCRONIZADA_MW                                                                                                                   |
| ) as (                                                                                                                                         |
|     -- CTE principal para buscar os dados de staging.                                                                                          |
| WITH stg_dados AS (                                                                                                                            |
|     SELECT * FROM IE_DB.STAGING.stg_usina_disp                                                                                                 |
| ),                                                                                                                                             |
|                                                                                                                                                |
| -- CTE para buscar os dados da dimensão de usina.                                                                                              |
| dim_usina AS (                                                                                                                                 |
|     SELECT * FROM IE_DB.CORE.dim_usina                                                                                                         |
| ),                                                                                                                                             |
|                                                                                                                                                |
| -- CTE para buscar os dados da dimensão de localidade.                                                                                         |
| dim_localidade AS (                                                                                                                            |
|     SELECT * FROM IE_DB.CORE.dim_localidade                                                                                                    |
| ),                                                                                                                                             |
|                                                                                                                                                |
| -- CTE para buscar os dados da dimensão de tempo.                                                                                              |
| dim_tempo AS (                                                                                                                                 |
|     SELECT * FROM IE_DB.CORE.dim_tempo                                                                                                         |
| )                                                                                                                                              |
|                                                                                                                                                |
| -- Seleção final para construir a tabela de fatos.                                                                                             |
| -- O objetivo aqui é substituir as chaves de negócio (ex: 'ceg', 'nom_estado')                                                                 |
| -- pelas chaves primárias substitutas das tabelas de dimensão (ex: 'id_dim_usina').                                                            |
| SELECT                                                                                                                                         |
|     -- Chave primária da fato (opcional, mas boa prática)                                                                                      |
|     md5(cast(coalesce(cast(stg.ceg as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(stg.instante as TEXT),                  |
| '_dbt_utils_surrogate_key_null_') as TEXT)) AS id_fact_disponibilidade,                                                                        |
|                                                                                                                                                |
|     -- Chaves estrangeiras (Foreign Keys) das nossas dimensões                                                                                 |
|     dus.id_dim_usina,                                                                                                                          |
|     dlo.id_dim_localidade,                                                                                                                     |
|     dti.id_dim_tempo,                                                                                                                          |
|                                                                                                                                                |
|     -- Coluna de data original para referência e joins mais fáceis                                                                             |
|     stg.instante,                                                                                                                              |
|                                                                                                                                                |
|     -- Métricas (os fatos numéricos que queremos analisar)                                                                                     |
|     stg.pot_instalada_mw,                                                                                                                      |
|     stg.disp_operacional_mw,                                                                                                                   |
|     stg.disp_sincronizada_mw                                                                                                                   |
|                                                                                                                                                |
| FROM stg_dados AS stg                                                                                                                          |
|                                                                                                                                                |
| -- JOIN com a dimensão de usina usando a chave de negócio 'ceg'                                                                                |
| LEFT JOIN dim_usina AS dus                                                                                                                     |
|     ON stg.ceg = dus.ceg                                                                                                                       |
|                                                                                                                                                |
| -- JOIN com a dimensão de localidade usando a combinação de 'nom_subsistema' e 'nom_estado'                                                    |
| LEFT JOIN dim_localidade AS dlo                                                                                                                |
|     ON stg.nom_subsistema = dlo.nom_subsistema                                                                                                 |
|     AND stg.nom_estado = dlo.nom_estado                                                                                                        |
|                                                                                                                                                |
| -- JOIN com a dimensão de tempo usando a chave de negócio 'instante'                                                                           |
| LEFT JOIN dim_tempo AS dti                                                                                                                     |
|     ON stg.instante = dti.instante                                                                                                             |
|   );                                                                                                                                           |
| create or replace view FACT_GERACAO_SUMMARY(                                                                                                   |
|         MES_REFERENCIA,                                                                                                                        |
|         DATA_TYPE,                                                                                                                             |
|         SOURCE_TABLE_NAME,                                                                                                                     |
|         TOTAL_RECORDS,                                                                                                                         |
|         TOTAL_USINAS,                                                                                                                          |
|         TOTAL_SUBSISTEMAS,                                                                                                                     |
|         TOTAL_ESTADOS,                                                                                                                         |
|         RECORDS_WITH_GENERATION,                                                                                                               |
|         TOTAL_GENERATION_MW,                                                                                                                   |
|         AVG_GENERATION_MW,                                                                                                                     |
|         MIN_GENERATION_MW,                                                                                                                     |
|         MAX_GENERATION_MW,                                                                                                                     |
|         PERIOD_START,                                                                                                                          |
|         PERIOD_END,                                                                                                                            |
|         PERIOD_DAYS,                                                                                                                           |
|         GENERATION_COMPLETENESS_PCT,                                                                                                           |
|         PROCESSED_AT                                                                                                                           |
| ) as (                                                                                                                                         |
|     -- models/core/fact_geracao_summary.sql                                                                                                    |
| -- Fato agregado de geração por período com análise temporal                                                                                   |
|                                                                                                                                                |
| SELECT                                                                                                                                         |
|     mes_referencia,                                                                                                                            |
|     data_type,                                                                                                                                 |
|     source_table_name,                                                                                                                         |
|     COUNT(*) as total_records,                                                                                                                 |
|     COUNT(DISTINCT ceg) as total_usinas,                                                                                                       |
|     COUNT(DISTINCT id_subsistema) as total_subsistemas,                                                                                        |
|     COUNT(DISTINCT nom_estado) as total_estados,                                                                                               |
|                                                                                                                                                |
|     -- Estatísticas de geração                                                                                                                 |
|     COUNT(val_geracao_mw) as records_with_generation,                                                                                          |
|     SUM(val_geracao_mw) as total_generation_mw,                                                                                                |
|     AVG(val_geracao_mw) as avg_generation_mw,                                                                                                  |
|     MIN(val_geracao_mw) as min_generation_mw,                                                                                                  |
|     MAX(val_geracao_mw) as max_generation_mw,                                                                                                  |
|                                                                                                                                                |
|     -- Cobertura temporal                                                                                                                      |
|     MIN(instante) as period_start,                                                                                                             |
|     MAX(instante) as period_end,                                                                                                               |
|     DATEDIFF('day', MIN(instante), MAX(instante)) + 1 as period_days,                                                                          |
|                                                                                                                                                |
|     -- Qualidade dos dados                                                                                                                     |
|     ROUND(                                                                                                                                     |
|         (COUNT(val_geracao_mw) * 100.0) / COUNT(*), 2                                                                                          |
|     ) as generation_completeness_pct,                                                                                                          |
|                                                                                                                                                |
|     -- Metadados                                                                                                                               |
|     CURRENT_TIMESTAMP() as processed_at                                                                                                        |
|                                                                                                                                                |
| FROM IE_DB.STAGING.stg_usina_geracao                                                                                                           |
| WHERE source_table_name != 'NO_TABLES_FOUND'                                                                                                   |
| GROUP BY mes_referencia, data_type, source_table_name                                                                                          |
| ORDER BY mes_referencia DESC, source_table_name                                                                                                |
|   );                                                                                                                                           |
| create or replace view GERACAO_MENSAL_ANALYSIS(                                                                                                |
|         MES_REFERENCIA,                                                                                                                        |
|         ANO,                                                                                                                                   |
|         MES,                                                                                                                                   |
|         CEG,                                                                                                                                   |
|         NOM_USINA,                                                                                                                             |
|         NOM_TIPOUSINA,                                                                                                                         |
|         NOM_TIPOCOMBUSTIVEL,                                                                                                                   |
|         ID_SUBSISTEMA,                                                                                                                         |
|         NOM_SUBSISTEMA,                                                                                                                        |
|         ID_ESTADO,                                                                                                                             |
|         NOM_ESTADO,                                                                                                                            |
|         GERACAO_TOTAL_MW,                                                                                                                      |
|         TOTAL_REGISTROS,                                                                                                                       |
|         PRIMEIRO_REGISTRO,                                                                                                                     |
|         ULTIMO_REGISTRO,                                                                                                                       |
|         SOURCE_GRANULARITY,                                                                                                                    |
|         GERACAO_MEDIA_3M,                                                                                                                      |
|         GERACAO_MESMO_MES_ANO_ANTERIOR,                                                                                                        |
|         RANKING_COMBUSTIVEL_MES,                                                                                                               |
|         PROCESSED_AT                                                                                                                           |
| ) as (                                                                                                                                         |
|     -- models/core/geracao_mensal_analysis.sql                                                                                                 |
| -- Análise mensal de geração consolidando dados anuais e mensais                                                                               |
| -- Expande dados anuais em meses para análise consistente                                                                                      |
|                                                                                                                                                |
| WITH monthly_data AS (                                                                                                                         |
|     -- Dados já mensais (2022+)                                                                                                                |
|     SELECT                                                                                                                                     |
|         mes_referencia,                                                                                                                        |
|         EXTRACT(YEAR FROM mes_referencia) as ano,                                                                                              |
|         EXTRACT(MONTH FROM mes_referencia) as mes,                                                                                             |
|         ceg,                                                                                                                                   |
|         nom_usina,                                                                                                                             |
|         nom_tipousina,                                                                                                                         |
|         nom_tipocombustivel,                                                                                                                   |
|         id_subsistema,                                                                                                                         |
|         nom_subsistema,                                                                                                                        |
|         id_estado,                                                                                                                             |
|         nom_estado,                                                                                                                            |
|         SUM(val_geracao_mw) as geracao_total_mw,                                                                                               |
|         COUNT(*) as total_registros,                                                                                                           |
|         MIN(instante) as primeiro_registro,                                                                                                    |
|         MAX(instante) as ultimo_registro                                                                                                       |
|     FROM IE_DB.STAGING.stg_usina_geracao                                                                                                       |
|     WHERE data_type = 'monthly'                                                                                                                |
|     GROUP BY 1,2,3,4,5,6,7,8,9,10,11                                                                                                           |
| ),                                                                                                                                             |
|                                                                                                                                                |
| annual_expanded AS (                                                                                                                           |
|     -- Expandir dados anuais em 12 meses                                                                                                       |
|     SELECT                                                                                                                                     |
|         DATE_TRUNC('month',                                                                                                                    |
|             DATEADD('month', month_num - 1,                                                                                                    |
|                 DATE_TRUNC('year', mes_referencia)                                                                                             |
|             )                                                                                                                                  |
|         ) as mes_referencia,                                                                                                                   |
|         EXTRACT(YEAR FROM mes_referencia) as ano,                                                                                              |
|         month_num as mes,                                                                                                                      |
|         ceg,                                                                                                                                   |
|         nom_usina,                                                                                                                             |
|         nom_tipousina,                                                                                                                         |
|         nom_tipocombustivel,                                                                                                                   |
|         id_subsistema,                                                                                                                         |
|         nom_subsistema,                                                                                                                        |
|         id_estado,                                                                                                                             |
|         nom_estado,                                                                                                                            |
|         -- Dividir geração anual por 12 (aproximação)                                                                                          |
|         SUM(val_geracao_mw) / 12.0 as geracao_total_mw,                                                                                        |
|         COUNT(*) as total_registros,                                                                                                           |
|         MIN(instante) as primeiro_registro,                                                                                                    |
|         MAX(instante) as ultimo_registro                                                                                                       |
|     FROM IE_DB.STAGING.stg_usina_geracao                                                                                                       |
|     CROSS JOIN (                                                                                                                               |
|         SELECT 1 as month_num UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL                                                                  |
|         SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL                                                                               |
|         SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL                                                                               |
|         SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12                                                                                      |
|     ) months                                                                                                                                   |
|     WHERE data_type = 'annual'                                                                                                                 |
|     GROUP BY 1,2,3,4,5,6,7,8,9,10,11                                                                                                           |
| ),                                                                                                                                             |
|                                                                                                                                                |
| consolidated AS (                                                                                                                              |
|     SELECT                                                                                                                                     |
|         mes_referencia,                                                                                                                        |
|         ano,                                                                                                                                   |
|         mes,                                                                                                                                   |
|         ceg,                                                                                                                                   |
|         nom_usina,                                                                                                                             |
|         nom_tipousina,                                                                                                                         |
|         nom_tipocombustivel,                                                                                                                   |
|         id_subsistema,                                                                                                                         |
|         nom_subsistema,                                                                                                                        |
|         id_estado,                                                                                                                             |
|         nom_estado,                                                                                                                            |
|         geracao_total_mw,                                                                                                                      |
|         total_registros,                                                                                                                       |
|         primeiro_registro,                                                                                                                     |
|         ultimo_registro,                                                                                                                       |
|         'monthly' as source_granularity                                                                                                        |
|     FROM monthly_data                                                                                                                          |
|                                                                                                                                                |
|     UNION ALL                                                                                                                                  |
|                                                                                                                                                |
|     SELECT                                                                                                                                     |
|         mes_referencia,                                                                                                                        |
|         ano,                                                                                                                                   |
|         mes,                                                                                                                                   |
|         ceg,                                                                                                                                   |
|         nom_usina,                                                                                                                             |
|         nom_tipousina,                                                                                                                         |
|         nom_tipocombustivel,                                                                                                                   |
|         id_subsistema,                                                                                                                         |
|         nom_subsistema,                                                                                                                        |
|         id_estado,                                                                                                                             |
|         nom_estado,                                                                                                                            |
|         geracao_total_mw,                                                                                                                      |
|         total_registros,                                                                                                                       |
|         primeiro_registro,                                                                                                                     |
|         ultimo_registro,                                                                                                                       |
|         'annual_expanded' as source_granularity                                                                                                |
|     FROM annual_expanded                                                                                                                       |
| )                                                                                                                                              |
|                                                                                                                                                |
| SELECT                                                                                                                                         |
|     *,                                                                                                                                         |
|     -- Calcular médias móveis trimestrais                                                                                                      |
|     AVG(geracao_total_mw) OVER (                                                                                                               |
|         PARTITION BY ceg                                                                                                                       |
|         ORDER BY ano, mes                                                                                                                      |
|         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW                                                                                               |
|     ) as geracao_media_3m,                                                                                                                     |
|                                                                                                                                                |
|     -- Comparação com mesmo mês do ano anterior                                                                                                |
|     LAG(geracao_total_mw, 12) OVER (                                                                                                           |
|         PARTITION BY ceg, mes                                                                                                                  |
|         ORDER BY ano                                                                                                                           |
|     ) as geracao_mesmo_mes_ano_anterior,                                                                                                       |
|                                                                                                                                                |
|     -- Ranking mensal por tipo de combustível                                                                                                  |
|     ROW_NUMBER() OVER (                                                                                                                        |
|         PARTITION BY ano, mes, nom_tipocombustivel                                                                                             |
|         ORDER BY geracao_total_mw DESC                                                                                                         |
|     ) as ranking_combustivel_mes,                                                                                                              |
|                                                                                                                                                |
|     CURRENT_TIMESTAMP() as processed_at                                                                                                        |
|                                                                                                                                                |
| FROM consolidated                                                                                                                              |
| ORDER BY ano DESC, mes DESC, geracao_total_mw DESC                                                                                             |
|   );                                                                                                                                           |
| create or replace schema RAW;                                                                                                                  |
|                                                                                                                                                |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_08_AIRFLOW (                                                                                |
|         "id_subsistema" VARCHAR(16777216),                                                                                                     |
|         "nom_subsistema" VARCHAR(16777216),                                                                                                    |
|         "id_estado" VARCHAR(16777216),                                                                                                         |
|         "nom_estado" VARCHAR(16777216),                                                                                                        |
|         "nom_usina" VARCHAR(16777216),                                                                                                         |
|         "id_tipousina" VARCHAR(16777216),                                                                                                      |
|         "nom_tipocombustivel" VARCHAR(16777216),                                                                                               |
|         "id_ons" VARCHAR(16777216),                                                                                                            |
|         "ceg" VARCHAR(16777216),                                                                                                               |
|         "din_instante" VARCHAR(16777216),                                                                                                      |
|         "val_potenciainstalada" VARCHAR(16777216),                                                                                             |
|         "val_dispoperacional" VARCHAR(16777216),                                                                                               |
|         "val_dispsincronizada" VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TRANSIENT TABLE MY_FIRST_DBT_MODEL (                                                                                         |
|         ID NUMBER(1,0)                                                                                                                         |
| );                                                                                                                                             |
| create or replace view MY_SECOND_DBT_MODEL(                                                                                                    |
|         ID                                                                                                                                     |
| ) as (                                                                                                                                         |
|     -- Use the `ref` function to select from other models                                                                                      |
|                                                                                                                                                |
| select *                                                                                                                                       |
| from IE_DB.RAW.my_first_dbt_model                                                                                                              |
| where id = 1                                                                                                                                   |
|   );                                                                                                                                           |
| create or replace schema STAGING COMMENT='Schema para dados brutos ou semi-estruturados, antes da transformação.';                             |
|                                                                                                                                                |
| create or replace TABLE DISPONIBILIDADE_USINA_2024_01 (                                                                                        |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE DISPONIBILIDADE_USINA_2024_07 (                                                                                        |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE DISPONIBILIDADE_USINA_2024_12 (                                                                                        |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-01" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-02" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-03" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-04" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-05" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-06" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-07" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-08" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-09" (                                                                                      |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_07 (                                                                                        |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_08 (                                                                                        |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_08_AIRFLOW (                                                                                |
|         "id_subsistema" VARCHAR(16777216),                                                                                                     |
|         "nom_subsistema" VARCHAR(16777216),                                                                                                    |
|         "id_estado" VARCHAR(16777216),                                                                                                         |
|         "nom_estado" VARCHAR(16777216),                                                                                                        |
|         "nom_usina" VARCHAR(16777216),                                                                                                         |
|         "id_tipousina" VARCHAR(16777216),                                                                                                      |
|         "nom_tipocombustivel" VARCHAR(16777216),                                                                                               |
|         "id_ons" VARCHAR(16777216),                                                                                                            |
|         "ceg" VARCHAR(16777216),                                                                                                               |
|         "din_instante" VARCHAR(16777216),                                                                                                      |
|         "val_potenciainstalada" VARCHAR(16777216),                                                                                             |
|         "val_dispoperacional" VARCHAR(16777216),                                                                                               |
|         "val_dispsincronizada" VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_09 (                                                                                        |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                                             |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                                            |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                                            |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2000 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2001 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2002 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2003 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2004 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2005 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2006 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2007 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2008 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2009 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2010 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2011 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2012 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2013 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2014 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2015 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2016 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2017 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2018 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2019 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2020 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE GERACAO_USINA_2_2021 (                                                                                                 |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-01" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-02" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-03" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-04" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-05" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-06" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-07" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-08" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-09" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-10" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-11" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2022-12" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-01" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-02" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-03" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-04" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-05" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-06" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-07" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-08" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-09" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-10" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-11" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2023-12" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-01" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-02" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-03" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-04" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-05" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-06" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-07" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-08" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-09" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-10" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-11" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2024-12" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-01" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-02" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-03" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-04" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-05" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-06" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-07" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-08" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE "GERACAO_USINA_2_2025-09" (                                                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                                             |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                                                        |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                                                        |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                                                   |
|         CEG VARCHAR(16777216),                                                                                                                 |
|         ID_ONS VARCHAR(16777216),                                                                                                              |
|         ID_ESTADO VARCHAR(16777216),                                                                                                           |
|         NOM_USINA VARCHAR(16777216),                                                                                                           |
|         NOM_ESTADO VARCHAR(16777216),                                                                                                          |
|         VAL_GERACAO FLOAT,                                                                                                                     |
|         DIN_INSTANTE VARCHAR(16777216),                                                                                                        |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                                                       |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                                                       |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                                                      |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                                                 |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                                               |
| );                                                                                                                                             |
| create or replace TABLE STG_IRRADIACAO_SOLAR (                                                                                                 |
|         ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,                                                                             |
|         UF VARCHAR(2),                                                                                                                         |
|         TIPO_ANGULO VARCHAR(50),                                                                                                               |
|         INCLINACAO VARCHAR(10),                                                                                                                |
|         JANEIRO NUMBER(4,2),                                                                                                                   |
|         FEVEREIRO NUMBER(4,2),                                                                                                                 |
|         MARCO NUMBER(4,2),                                                                                                                     |
|         ABRIL NUMBER(4,2),                                                                                                                     |
|         MAIO NUMBER(4,2),                                                                                                                      |
|         JUNHO NUMBER(4,2),                                                                                                                     |
|         JULHO NUMBER(4,2),                                                                                                                     |
|         AGOSTO NUMBER(4,2),                                                                                                                    |
|         SETEMBRO NUMBER(4,2),                                                                                                                  |
|         OUTUBRO NUMBER(4,2),                                                                                                                   |
|         NOVEMBRO NUMBER(4,2),                                                                                                                  |
|         DEZEMBRO NUMBER(4,2),                                                                                                                  |
|         MEDIA NUMBER(4,2),                                                                                                                     |
|         DELTA NUMBER(4,2),                                                                                                                     |
|         DATA_CARGA TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                               |
|         FONTE VARCHAR(255)                                                                                                                     |
| );                                                                                                                                             |
| create or replace view STG_USINA_DISP(                                                                                                         |
|         MES_REFERENCIA,                                                                                                                        |
|         ID_SUBSISTEMA,                                                                                                                         |
|         NOM_SUBSISTEMA,                                                                                                                        |
|         ID_ESTADO,                                                                                                                             |
|         NOM_ESTADO,                                                                                                                            |
|         ID_ONS,                                                                                                                                |
|         CEG,                                                                                                                                   |
|         NOM_USINA,                                                                                                                             |
|         ID_TIPOUSINA,                                                                                                                          |
|         NOM_TIPOCOMBUSTIVEL,                                                                                                                   |
|         INSTANTE,                                                                                                                              |
|         POT_INSTALADA_MW,                                                                                                                      |
|         DISP_OPERACIONAL_MW,                                                                                                                   |
|         DISP_SINCRONIZADA_MW                                                                                                                   |
| ) as (                                                                                                                                         |
|     -- models/stg_usina_disp.sql                                                                                                               |
|                                                                                                                                                |
| -- Bloco de código para os dados de Julho                                                                                                      |
| SELECT                                                                                                                                         |
|     '2025-07-01'::DATE AS mes_referencia,                                                                                                      |
|     id_subsistema::STRING AS id_subsistema,                                                                                                    |
|     nom_subsistema::STRING AS nom_subsistema,                                                                                                  |
|     id_estado::STRING AS id_estado,                                                                                                            |
|     nom_estado::STRING AS nom_estado,                                                                                                          |
|     id_ons::STRING AS id_ons,                                                                                                                  |
|     ceg::STRING AS ceg,                                                                                                                        |
|     nom_usina::STRING AS nom_usina,                                                                                                            |
|     id_tipousina::STRING AS id_tipousina,                                                                                                      |
|     nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                                        |
|     din_instante::TIMESTAMP AS instante,                                                                                                       |
|     val_potenciainstalada::NUMBER(38, 5) AS pot_instalada_mw,                                                                                  |
|     val_dispoperacional::NUMBER(38, 5) AS disp_operacional_mw,                                                                                 |
|     val_dispsincronizada::NUMBER(38, 5) AS disp_sincronizada_mw                                                                                |
| FROM IE_DB.staging.disponibilidade_usina_2025_07                                                                                               |
|                                                                                                                                                |
| UNION ALL                                                                                                                                      |
|                                                                                                                                                |
| -- Bloco de código para os dados de Agosto                                                                                                     |
| SELECT                                                                                                                                         |
|     '2025-08-01'::DATE AS mes_referencia,                                                                                                      |
|     id_subsistema::STRING AS id_subsistema,                                                                                                    |
|     nom_subsistema::STRING AS nom_subsistema,                                                                                                  |
|     id_estado::STRING AS id_estado,                                                                                                            |
|     nom_estado::STRING AS nom_estado,                                                                                                          |
|     id_ons::STRING AS id_ons,                                                                                                                  |
|     ceg::STRING AS ceg,                                                                                                                        |
|     nom_usina::STRING AS nom_usina,                                                                                                            |
|     id_tipousina::STRING AS id_tipousina,                                                                                                      |
|     nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                                        |
|     din_instante::TIMESTAMP AS instante,                                                                                                       |
|     val_potenciainstalada::NUMBER(38, 5) AS pot_instalada_mw,                                                                                  |
|     val_dispoperacional::NUMBER(38, 5) AS disp_operacional_mw,                                                                                 |
|     val_dispsincronizada::NUMBER(38, 5) AS disp_sincronizada_mw                                                                                |
| FROM IE_DB.staging.disponibilidade_usina_2025_08                                                                                               |
|                                                                                                                                                |
| UNION ALL                                                                                                                                      |
|                                                                                                                                                |
| -- Bloco de código para os dados de Setembro                                                                                                   |
| SELECT                                                                                                                                         |
|     '2025-09-01'::DATE AS mes_referencia,                                                                                                      |
|     id_subsistema::STRING AS id_subsistema,                                                                                                    |
|     nom_subsistema::STRING AS nom_subsistema,                                                                                                  |
|     id_estado::STRING AS id_estado,                                                                                                            |
|     nom_estado::STRING AS nom_estado,                                                                                                          |
|     id_ons::STRING AS id_ons,                                                                                                                  |
|     ceg::STRING AS ceg,                                                                                                                        |
|     nom_usina::STRING AS nom_usina,                                                                                                            |
|     id_tipousina::STRING AS id_tipousina,                                                                                                      |
|     nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                                        |
|     din_instante::TIMESTAMP AS instante,                                                                                                       |
|     val_potenciainstalada::NUMBER(38, 5) AS pot_instalada_mw,                                                                                  |
|     val_dispoperacional::NUMBER(38, 5) AS disp_operacional_mw,                                                                                 |
|     val_dispsincronizada::NUMBER(38, 5) AS disp_sincronizada_mw                                                                                |
| FROM IE_DB.staging.disponibilidade_usina_2025_09                                                                                               |
|   );                                                                                                                                           |
| create or replace view STG_USINA_GERACAO(                                                                                                      |
|         MES_REFERENCIA,                                                                                                                        |
|         ID_SUBSISTEMA,                                                                                                                         |
|         NOM_SUBSISTEMA,                                                                                                                        |
|         ID_ESTADO,                                                                                                                             |
|         NOM_ESTADO,                                                                                                                            |
|         ID_ONS,                                                                                                                                |
|         CEG,                                                                                                                                   |
|         NOM_USINA,                                                                                                                             |
|         NOM_TIPOUSINA,                                                                                                                         |
|         NOM_TIPOCOMBUSTIVEL,                                                                                                                   |
|         COD_MODALIDADEOPERACAO,                                                                                                                |
|         INSTANTE,                                                                                                                              |
|         VAL_GERACAO_MW,                                                                                                                        |
|         SOURCE_TABLE_NAME,                                                                                                                     |
|         DATA_TYPE                                                                                                                              |
| ) as (                                                                                                                                         |
|     -- models/stg_usina_geracao.sql                                                                                                            |
| -- Union de todas as tabelas de geração de usina                                                                                               |
| -- Compatível com nomenclatura ONS: anuais (2000-2021) e mensais (2022+)                                                                       |
| -- Usa macro union_geracao_tables para centralizar a lógica                                                                                    |
|                                                                                                                                                |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2000-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2000'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2000                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2001-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2001'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2001                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2002-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2002'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2002                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2003-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2003'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2003                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2004-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2004'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2004                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2005-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2005'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2005                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2006-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2006'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2006                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2007-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2007'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2007                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2008-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2008'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2008                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2009-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2009'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2009                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2010-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2010'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2010                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2011-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2011'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2011                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2012-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2012'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2012                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2013-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2013'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2013                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2014-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2014'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2014                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2015-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2015'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2015                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2016-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2016'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2016                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2017-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2017'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2017                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2018-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2018'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2018                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2019-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2019'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2019                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2020-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2020'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2020                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2021-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2021'::STRING AS source_table_name,                                                                           |
|                 'annual'::STRING AS data_type                                                                                                  |
|             FROM STAGING.GERACAO_USINA_2_2021                                                                                                  |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-01'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-01"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-02-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-02'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-02"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-03-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-03'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-03"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-04-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-04'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-04"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-05-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-05'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-05"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-06-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-06'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-06"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-07-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-07'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-07"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-08-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-08'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-08"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-09-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-09'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-09"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-10-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-10'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-10"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-11-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-11'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-11"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2022-12-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2022-12'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2022-12"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-01'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-01"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-02-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-02'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-02"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-03-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-03'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-03"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-04-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-04'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-04"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-05-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-05'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-05"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-06-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-06'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-06"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-07-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-07'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-07"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-08-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-08'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-08"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-09-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-09'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-09"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-10-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-10'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-10"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-11-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-11'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-11"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2023-12-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2023-12'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2023-12"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-01'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-01"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-02-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-02'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-02"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-03-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-03'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-03"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-04-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-04'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-04"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-05-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-05'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-05"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-06-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-06'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-06"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-07-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-07'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-07"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-08-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-08'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-08"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-09-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-09'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-09"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-10-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-10'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-10"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-11-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-11'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-11"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2024-12-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2024-12'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2024-12"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-01-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-01'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-01"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-02-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-02'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-02"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-03-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-03'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-03"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-04-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-04'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-04"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-05-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-05'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-05"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-06-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-06'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-06"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-07-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-07'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-07"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-08-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-08'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-08"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|             UNION ALL                                                                                                                          |
|                                                                                                                                                |
|         SELECT                                                                                                                                 |
|                 '2025-09-01'::DATE AS mes_referencia,                                                                                          |
|                 id_subsistema::STRING AS id_subsistema,                                                                                        |
|                 nom_subsistema::STRING AS nom_subsistema,                                                                                      |
|                 id_estado::STRING AS id_estado,                                                                                                |
|                 nom_estado::STRING AS nom_estado,                                                                                              |
|                 id_ons::STRING AS id_ons,                                                                                                      |
|                 ceg::STRING AS ceg,                                                                                                            |
|                 nom_usina::STRING AS nom_usina,                                                                                                |
|                 nom_tipousina::STRING AS nom_tipousina,                                                                                        |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                                            |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                                                      |
|                 din_instante::TIMESTAMP AS instante,                                                                                           |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                                                  |
|                 'GERACAO_USINA_2_2025-09'::STRING AS source_table_name,                                                                        |
|                 'monthly'::STRING AS data_type                                                                                                 |
|             FROM STAGING."GERACAO_USINA_2_2025-09"                                                                                             |
|                                                                                                                                                |
|                                                                                                                                                |
|                                                                                                                                                |
|                                                                                                                                                |
|                                                                                                                                                |
|                                                                                                                                                |
|   );                                                                                                                                           |
| create or replace view STG_USINA_GERACAO_GO(                                                                                                   |
|         MES_REFERENCIA,                                                                                                                        |
|         ID_SUBSISTEMA,                                                                                                                         |
|         NOM_SUBSISTEMA,                                                                                                                        |
|         ID_ESTADO,                                                                                                                             |
|         NOM_ESTADO,                                                                                                                            |
|         ID_ONS,                                                                                                                                |
|         CEG,                                                                                                                                   |
|         NOM_USINA,                                                                                                                             |
|         NOM_TIPOUSINA,                                                                                                                         |
|         NOM_TIPOCOMBUSTIVEL,                                                                                                                   |
|         COD_MODALIDADEOPERACAO,                                                                                                                |
|         INSTANTE,                                                                                                                              |
|         VAL_GERACAO_MW                                                                                                                         |
| ) as (                                                                                                                                         |
|     -- models/stg_usina_geracao_go.sql                                                                                                         |
| -- Dados de geração das usinas do estado de Goiás (GO)                                                                                         |
|                                                                                                                                                |
| SELECT                                                                                                                                         |
|     mes_referencia,                                                                                                                            |
|     id_subsistema,                                                                                                                             |
|     nom_subsistema,                                                                                                                            |
|     id_estado,                                                                                                                                 |
|     nom_estado,                                                                                                                                |
|     id_ons,                                                                                                                                    |
|     ceg,                                                                                                                                       |
|     nom_usina,                                                                                                                                 |
|     nom_tipousina,                                                                                                                             |
|     nom_tipocombustivel,                                                                                                                       |
|     cod_modalidadeoperacao,                                                                                                                    |
|     instante,                                                                                                                                  |
|     val_geracao_mw                                                                                                                             |
| FROM IE_DB.STAGING.stg_usina_geracao                                                                                                           |
| WHERE id_estado = 'GO'                                                                                                                         |
|   AND nom_tipocombustivel = 'Fotovoltaica'                                                                                                     |
|   );                                                                                                                                           |
| create or replace schema "airbyte_internal";                                                                                                   |
|                                                                                                                                                |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2024_01" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2024_07" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2024_12" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-01" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-02" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-03" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-04" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-05" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-06" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-07" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-08" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025-09" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025_07" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025_08" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_DISPONIBILIDADE_USINA_2025_09" (                                                                  |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2000" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2001" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2002" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2003" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2004" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2005" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2006" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2007" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2008" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2009" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2010" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2011" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2012" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2013" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2014" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2015" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2016" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2017" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2018" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2019" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2020" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2021" (                                                                           |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-01" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-02" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-03" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-04" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-05" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-06" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-07" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-08" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-09" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-10" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-11" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2022-12" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-01" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-02" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-03" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-04" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-05" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-06" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-07" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-08" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-09" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-10" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-11" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2023-12" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-01" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-02" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-03" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-04" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-05" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-06" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-07" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-08" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-09" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-10" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-11" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2024-12" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-01" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-02" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-03" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-04" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-05" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-06" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-07" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-08" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_GERACAO_USINA_2_2025-09" (                                                                        |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream__airbyte_connection_test_5c7dc7f1e0374570b86ea4750a8e5d5f" (                                      |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream__airbyte_connection_test_90516d1f997444ba8a9f22ac1616fc7c" (                                      |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "STAGING_raw__stream_k4wo2n_DISPONIBILIDADE_USINA_2025_07_airbyte_tmp" (                                               |
|         "_airbyte_raw_id" VARCHAR(16777216) NOT NULL,                                                                                          |
|         "_airbyte_extracted_at" TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                                   |
|         "_airbyte_loaded_at" TIMESTAMP_TZ(9),                                                                                                  |
|         "_airbyte_data" VARIANT,                                                                                                               |
|         "_airbyte_meta" VARIANT,                                                                                                               |
|         "_airbyte_generation_id" NUMBER(38,0),                                                                                                 |
|         primary key ("_airbyte_raw_id")                                                                                                        |
| );                                                                                                                                             |
| create or replace TABLE "_airbyte_destination_state" (                                                                                         |
|         "name" VARCHAR(16777216),                                                                                                              |
|         "namespace" VARCHAR(16777216),                                                                                                         |
|         "destination_state" VARCHAR(16777216),                                                                                                 |
|         "updated_at" TIMESTAMP_TZ(9)                                                                                                           |
| );                                                                                                                                             |
+------------------------------------------------------------------------------------------------------------------------------------------------+
