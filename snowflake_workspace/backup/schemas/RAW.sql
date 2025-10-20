SELECT GET_DDL('SCHEMA', 'IE_DB.RAW');
+-----------------------------------------------------------------+
| GET_DDL('SCHEMA', 'IE_DB.RAW')                                  |
|-----------------------------------------------------------------|
| create or replace schema RAW;                                   |
|                                                                 |
| create or replace TABLE DISPONIBILIDADE_USINA_2025_08_AIRFLOW ( |
|         "id_subsistema" VARCHAR(16777216),                      |
|         "nom_subsistema" VARCHAR(16777216),                     |
|         "id_estado" VARCHAR(16777216),                          |
|         "nom_estado" VARCHAR(16777216),                         |
|         "nom_usina" VARCHAR(16777216),                          |
|         "id_tipousina" VARCHAR(16777216),                       |
|         "nom_tipocombustivel" VARCHAR(16777216),                |
|         "id_ons" VARCHAR(16777216),                             |
|         "ceg" VARCHAR(16777216),                                |
|         "din_instante" VARCHAR(16777216),                       |
|         "val_potenciainstalada" VARCHAR(16777216),              |
|         "val_dispoperacional" VARCHAR(16777216),                |
|         "val_dispsincronizada" VARCHAR(16777216)                |
| );                                                              |
| create or replace TRANSIENT TABLE MY_FIRST_DBT_MODEL (          |
|         ID NUMBER(1,0)                                          |
| );                                                              |
| create or replace view MY_SECOND_DBT_MODEL(                     |
|         ID                                                      |
| ) as (                                                          |
|     -- Use the `ref` function to select from other models       |
|                                                                 |
| select *                                                        |
| from IE_DB.RAW.my_first_dbt_model                               |
| where id = 1                                                    |
|   );                                                            |
+-----------------------------------------------------------------+
