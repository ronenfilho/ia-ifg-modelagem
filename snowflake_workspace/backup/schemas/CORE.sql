SELECT GET_DDL('SCHEMA', 'IE_DB.CORE');
+------------------------------------------------------------------------------------------------------------------------------------------------+
| GET_DDL('SCHEMA', 'IE_DB.CORE')                                                                                                                |
|------------------------------------------------------------------------------------------------------------------------------------------------|
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
+------------------------------------------------------------------------------------------------------------------------------------------------+
