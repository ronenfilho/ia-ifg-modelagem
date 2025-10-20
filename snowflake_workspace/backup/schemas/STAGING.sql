SELECT GET_DDL('SCHEMA', 'IE_DB.STAGING');
+--------------------------------------------------------------------------------------------------------------------+
| GET_DDL('SCHEMA', 'IE_DB.STAGING')                                                                                 |
|--------------------------------------------------------------------------------------------------------------------|
| create or replace schema STAGING COMMENT='Schema para dados brutos ou semi-estruturados, antes da transformação.'; |
|                                                                                                                    |
| create or replace TABLE DISPONIBILIDADE_USINA_2024_01 (                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE DISPONIBILIDADE_USINA_2024_07 (                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE DISPONIBILIDADE_USINA_2024_12 (                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-01" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-02" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-03" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-04" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-05" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-06" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-07" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-08" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE "DISPONIBILIDADE_USINA_2025-09" (                                                          |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_07 (                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_08 (                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_08_AIRFLOW (                                                    |
|         "id_subsistema" VARCHAR(16777216),                                                                         |
|         "nom_subsistema" VARCHAR(16777216),                                                                        |
|         "id_estado" VARCHAR(16777216),                                                                             |
|         "nom_estado" VARCHAR(16777216),                                                                            |
|         "nom_usina" VARCHAR(16777216),                                                                             |
|         "id_tipousina" VARCHAR(16777216),                                                                          |
|         "nom_tipocombustivel" VARCHAR(16777216),                                                                   |
|         "id_ons" VARCHAR(16777216),                                                                                |
|         "ceg" VARCHAR(16777216),                                                                                   |
|         "din_instante" VARCHAR(16777216),                                                                          |
|         "val_potenciainstalada" VARCHAR(16777216),                                                                 |
|         "val_dispoperacional" VARCHAR(16777216),                                                                   |
|         "val_dispsincronizada" VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_09 (                                                            |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_TIPOUSINA VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         VAL_DISPOPERACIONAL FLOAT,                                                                                 |
|         VAL_DISPSINCRONIZADA FLOAT,                                                                                |
|         VAL_POTENCIAINSTALADA FLOAT                                                                                |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2000 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2001 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2002 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2003 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2004 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2005 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2006 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2007 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2008 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2009 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2010 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2011 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2012 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2013 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2014 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2015 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2016 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2017 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2018 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2019 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2020 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE GERACAO_USINA_2_2021 (                                                                     |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-01" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-02" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-03" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-04" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-05" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-06" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-07" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-08" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-09" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-10" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-11" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2022-12" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-01" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-02" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-03" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-04" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-05" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-06" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-07" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-08" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-09" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-10" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-11" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2023-12" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-01" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-02" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-03" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-04" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-05" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-06" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-07" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-08" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-09" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-10" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-11" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2024-12" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-01" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-02" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-03" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-04" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-05" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-06" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-07" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-08" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE "GERACAO_USINA_2_2025-09" (                                                                |
|         _AIRBYTE_RAW_ID VARCHAR(16777216) NOT NULL COLLATE 'utf8',                                                 |
|         _AIRBYTE_EXTRACTED_AT TIMESTAMP_TZ(9) NOT NULL,                                                            |
|         _AIRBYTE_META VARIANT NOT NULL,                                                                            |
|         _AIRBYTE_GENERATION_ID NUMBER(38,0),                                                                       |
|         CEG VARCHAR(16777216),                                                                                     |
|         ID_ONS VARCHAR(16777216),                                                                                  |
|         ID_ESTADO VARCHAR(16777216),                                                                               |
|         NOM_USINA VARCHAR(16777216),                                                                               |
|         NOM_ESTADO VARCHAR(16777216),                                                                              |
|         VAL_GERACAO FLOAT,                                                                                         |
|         DIN_INSTANTE VARCHAR(16777216),                                                                            |
|         ID_SUBSISTEMA VARCHAR(16777216),                                                                           |
|         NOM_TIPOUSINA VARCHAR(16777216),                                                                           |
|         NOM_SUBSISTEMA VARCHAR(16777216),                                                                          |
|         NOM_TIPOCOMBUSTIVEL VARCHAR(16777216),                                                                     |
|         COD_MODALIDADEOPERACAO VARCHAR(16777216)                                                                   |
| );                                                                                                                 |
| create or replace TABLE STG_IRRADIACAO_SOLAR (                                                                     |
|         ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,                                                 |
|         UF VARCHAR(2),                                                                                             |
|         TIPO_ANGULO VARCHAR(50),                                                                                   |
|         INCLINACAO VARCHAR(10),                                                                                    |
|         JANEIRO NUMBER(4,2),                                                                                       |
|         FEVEREIRO NUMBER(4,2),                                                                                     |
|         MARCO NUMBER(4,2),                                                                                         |
|         ABRIL NUMBER(4,2),                                                                                         |
|         MAIO NUMBER(4,2),                                                                                          |
|         JUNHO NUMBER(4,2),                                                                                         |
|         JULHO NUMBER(4,2),                                                                                         |
|         AGOSTO NUMBER(4,2),                                                                                        |
|         SETEMBRO NUMBER(4,2),                                                                                      |
|         OUTUBRO NUMBER(4,2),                                                                                       |
|         NOVEMBRO NUMBER(4,2),                                                                                      |
|         DEZEMBRO NUMBER(4,2),                                                                                      |
|         MEDIA NUMBER(4,2),                                                                                         |
|         DELTA NUMBER(4,2),                                                                                         |
|         DATA_CARGA TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP(),                                                   |
|         FONTE VARCHAR(255)                                                                                         |
| );                                                                                                                 |
| create or replace view STG_USINA_DISP(                                                                             |
|         MES_REFERENCIA,                                                                                            |
|         ID_SUBSISTEMA,                                                                                             |
|         NOM_SUBSISTEMA,                                                                                            |
|         ID_ESTADO,                                                                                                 |
|         NOM_ESTADO,                                                                                                |
|         ID_ONS,                                                                                                    |
|         CEG,                                                                                                       |
|         NOM_USINA,                                                                                                 |
|         ID_TIPOUSINA,                                                                                              |
|         NOM_TIPOCOMBUSTIVEL,                                                                                       |
|         INSTANTE,                                                                                                  |
|         POT_INSTALADA_MW,                                                                                          |
|         DISP_OPERACIONAL_MW,                                                                                       |
|         DISP_SINCRONIZADA_MW                                                                                       |
| ) as (                                                                                                             |
|     -- models/stg_usina_disp.sql                                                                                   |
|                                                                                                                    |
| -- Bloco de código para os dados de Julho                                                                          |
| SELECT                                                                                                             |
|     '2025-07-01'::DATE AS mes_referencia,                                                                          |
|     id_subsistema::STRING AS id_subsistema,                                                                        |
|     nom_subsistema::STRING AS nom_subsistema,                                                                      |
|     id_estado::STRING AS id_estado,                                                                                |
|     nom_estado::STRING AS nom_estado,                                                                              |
|     id_ons::STRING AS id_ons,                                                                                      |
|     ceg::STRING AS ceg,                                                                                            |
|     nom_usina::STRING AS nom_usina,                                                                                |
|     id_tipousina::STRING AS id_tipousina,                                                                          |
|     nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                            |
|     din_instante::TIMESTAMP AS instante,                                                                           |
|     val_potenciainstalada::NUMBER(38, 5) AS pot_instalada_mw,                                                      |
|     val_dispoperacional::NUMBER(38, 5) AS disp_operacional_mw,                                                     |
|     val_dispsincronizada::NUMBER(38, 5) AS disp_sincronizada_mw                                                    |
| FROM IE_DB.staging.disponibilidade_usina_2025_07                                                                   |
|                                                                                                                    |
| UNION ALL                                                                                                          |
|                                                                                                                    |
| -- Bloco de código para os dados de Agosto                                                                         |
| SELECT                                                                                                             |
|     '2025-08-01'::DATE AS mes_referencia,                                                                          |
|     id_subsistema::STRING AS id_subsistema,                                                                        |
|     nom_subsistema::STRING AS nom_subsistema,                                                                      |
|     id_estado::STRING AS id_estado,                                                                                |
|     nom_estado::STRING AS nom_estado,                                                                              |
|     id_ons::STRING AS id_ons,                                                                                      |
|     ceg::STRING AS ceg,                                                                                            |
|     nom_usina::STRING AS nom_usina,                                                                                |
|     id_tipousina::STRING AS id_tipousina,                                                                          |
|     nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                            |
|     din_instante::TIMESTAMP AS instante,                                                                           |
|     val_potenciainstalada::NUMBER(38, 5) AS pot_instalada_mw,                                                      |
|     val_dispoperacional::NUMBER(38, 5) AS disp_operacional_mw,                                                     |
|     val_dispsincronizada::NUMBER(38, 5) AS disp_sincronizada_mw                                                    |
| FROM IE_DB.staging.disponibilidade_usina_2025_08                                                                   |
|                                                                                                                    |
| UNION ALL                                                                                                          |
|                                                                                                                    |
| -- Bloco de código para os dados de Setembro                                                                       |
| SELECT                                                                                                             |
|     '2025-09-01'::DATE AS mes_referencia,                                                                          |
|     id_subsistema::STRING AS id_subsistema,                                                                        |
|     nom_subsistema::STRING AS nom_subsistema,                                                                      |
|     id_estado::STRING AS id_estado,                                                                                |
|     nom_estado::STRING AS nom_estado,                                                                              |
|     id_ons::STRING AS id_ons,                                                                                      |
|     ceg::STRING AS ceg,                                                                                            |
|     nom_usina::STRING AS nom_usina,                                                                                |
|     id_tipousina::STRING AS id_tipousina,                                                                          |
|     nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                            |
|     din_instante::TIMESTAMP AS instante,                                                                           |
|     val_potenciainstalada::NUMBER(38, 5) AS pot_instalada_mw,                                                      |
|     val_dispoperacional::NUMBER(38, 5) AS disp_operacional_mw,                                                     |
|     val_dispsincronizada::NUMBER(38, 5) AS disp_sincronizada_mw                                                    |
| FROM IE_DB.staging.disponibilidade_usina_2025_09                                                                   |
|   );                                                                                                               |
| create or replace view STG_USINA_GERACAO(                                                                          |
|         MES_REFERENCIA,                                                                                            |
|         ID_SUBSISTEMA,                                                                                             |
|         NOM_SUBSISTEMA,                                                                                            |
|         ID_ESTADO,                                                                                                 |
|         NOM_ESTADO,                                                                                                |
|         ID_ONS,                                                                                                    |
|         CEG,                                                                                                       |
|         NOM_USINA,                                                                                                 |
|         NOM_TIPOUSINA,                                                                                             |
|         NOM_TIPOCOMBUSTIVEL,                                                                                       |
|         COD_MODALIDADEOPERACAO,                                                                                    |
|         INSTANTE,                                                                                                  |
|         VAL_GERACAO_MW,                                                                                            |
|         SOURCE_TABLE_NAME,                                                                                         |
|         DATA_TYPE                                                                                                  |
| ) as (                                                                                                             |
|     -- models/stg_usina_geracao.sql                                                                                |
| -- Union de todas as tabelas de geração de usina                                                                   |
| -- Compatível com nomenclatura ONS: anuais (2000-2021) e mensais (2022+)                                           |
| -- Usa macro union_geracao_tables para centralizar a lógica                                                        |
|                                                                                                                    |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2000-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2000'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2000                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2001-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2001'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2001                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2002-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2002'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2002                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2003-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2003'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2003                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2004-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2004'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2004                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2005-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2005'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2005                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2006-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2006'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2006                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2007-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2007'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2007                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2008-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2008'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2008                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2009-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2009'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2009                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2010-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2010'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2010                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2011-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2011'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2011                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2012-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2012'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2012                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2013-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2013'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2013                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2014-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2014'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2014                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2015-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2015'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2015                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2016-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2016'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2016                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2017-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2017'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2017                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2018-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2018'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2018                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2019-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2019'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2019                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2020-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2020'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2020                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2021-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2021'::STRING AS source_table_name,                                               |
|                 'annual'::STRING AS data_type                                                                      |
|             FROM STAGING.GERACAO_USINA_2_2021                                                                      |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-01'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-01"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-02-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-02'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-02"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-03-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-03'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-03"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-04-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-04'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-04"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-05-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-05'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-05"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-06-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-06'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-06"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-07-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-07'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-07"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-08-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-08'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-08"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-09-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-09'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-09"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-10-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-10'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-10"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-11-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-11'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-11"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2022-12-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2022-12'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2022-12"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-01'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-01"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-02-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-02'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-02"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-03-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-03'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-03"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-04-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-04'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-04"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-05-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-05'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-05"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-06-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-06'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-06"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-07-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-07'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-07"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-08-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-08'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-08"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-09-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-09'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-09"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-10-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-10'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-10"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-11-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-11'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-11"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2023-12-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2023-12'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2023-12"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-01'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-01"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-02-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-02'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-02"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-03-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-03'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-03"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-04-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-04'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-04"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-05-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-05'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-05"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-06-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-06'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-06"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-07-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-07'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-07"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-08-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-08'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-08"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-09-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-09'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-09"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-10-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-10'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-10"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-11-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-11'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-11"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2024-12-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2024-12'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2024-12"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-01-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-01'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-01"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-02-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-02'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-02"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-03-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-03'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-03"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-04-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-04'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-04"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-05-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-05'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-05"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-06-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-06'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-06"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-07-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-07'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-07"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-08-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-08'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-08"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|             UNION ALL                                                                                              |
|                                                                                                                    |
|         SELECT                                                                                                     |
|                 '2025-09-01'::DATE AS mes_referencia,                                                              |
|                 id_subsistema::STRING AS id_subsistema,                                                            |
|                 nom_subsistema::STRING AS nom_subsistema,                                                          |
|                 id_estado::STRING AS id_estado,                                                                    |
|                 nom_estado::STRING AS nom_estado,                                                                  |
|                 id_ons::STRING AS id_ons,                                                                          |
|                 ceg::STRING AS ceg,                                                                                |
|                 nom_usina::STRING AS nom_usina,                                                                    |
|                 nom_tipousina::STRING AS nom_tipousina,                                                            |
|                 nom_tipocombustivel::STRING AS nom_tipocombustivel,                                                |
|                 cod_modalidadeoperacao::STRING AS cod_modalidadeoperacao,                                          |
|                 din_instante::TIMESTAMP AS instante,                                                               |
|                 val_geracao::NUMBER(38, 5) AS val_geracao_mw,                                                      |
|                 'GERACAO_USINA_2_2025-09'::STRING AS source_table_name,                                            |
|                 'monthly'::STRING AS data_type                                                                     |
|             FROM STAGING."GERACAO_USINA_2_2025-09"                                                                 |
|                                                                                                                    |
|                                                                                                                    |
|                                                                                                                    |
|                                                                                                                    |
|                                                                                                                    |
|                                                                                                                    |
|   );                                                                                                               |
| create or replace view STG_USINA_GERACAO_GO(                                                                       |
|         MES_REFERENCIA,                                                                                            |
|         ID_SUBSISTEMA,                                                                                             |
|         NOM_SUBSISTEMA,                                                                                            |
|         ID_ESTADO,                                                                                                 |
|         NOM_ESTADO,                                                                                                |
|         ID_ONS,                                                                                                    |
|         CEG,                                                                                                       |
|         NOM_USINA,                                                                                                 |
|         NOM_TIPOUSINA,                                                                                             |
|         NOM_TIPOCOMBUSTIVEL,                                                                                       |
|         COD_MODALIDADEOPERACAO,                                                                                    |
|         INSTANTE,                                                                                                  |
|         VAL_GERACAO_MW                                                                                             |
| ) as (                                                                                                             |
|     -- models/stg_usina_geracao_go.sql                                                                             |
| -- Dados de geração das usinas do estado de Goiás (GO)                                                             |
|                                                                                                                    |
| SELECT                                                                                                             |
|     mes_referencia,                                                                                                |
|     id_subsistema,                                                                                                 |
|     nom_subsistema,                                                                                                |
|     id_estado,                                                                                                     |
|     nom_estado,                                                                                                    |
|     id_ons,                                                                                                        |
|     ceg,                                                                                                           |
|     nom_usina,                                                                                                     |
|     nom_tipousina,                                                                                                 |
|     nom_tipocombustivel,                                                                                           |
|     cod_modalidadeoperacao,                                                                                        |
|     instante,                                                                                                      |
|     val_geracao_mw                                                                                                 |
| FROM IE_DB.STAGING.stg_usina_geracao                                                                               |
| WHERE id_estado = 'GO'                                                                                             |
|   AND nom_tipocombustivel = 'Fotovoltaica'                                                                         |
|   );                                                                                                               |
+--------------------------------------------------------------------------------------------------------------------+
