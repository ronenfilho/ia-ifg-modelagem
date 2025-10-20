-- =====================================================================
-- SCRIPT: Criar SECRET para GitHub Personal Access Token
-- =====================================================================
-- Este script cria um secret para acessar repositórios privados do GitHub
-- ou para ter mais controle sobre repositórios públicos
-- =====================================================================

USE ROLE IE_TRANSFORM_ROLE;
USE DATABASE IE_DB;
USE SCHEMA STAGING;

-- =====================================================================
-- 1. CRIAR SECRET COM PERSONAL ACCESS TOKEN
-- =====================================================================
-- Substitua 'SEU_GITHUB_USERNAME' e 'SEU_GITHUB_TOKEN' pelos seus dados
-- 
-- Para criar um PAT no GitHub:
-- 1. Acesse: https://github.com/settings/tokens
-- 2. Clique em "Generate new token" → "Generate new token (classic)"
-- 3. Dê um nome descritivo (ex: "Snowflake Integration")
-- 4. Marque o scope: "repo" (acesso total aos repositórios)
-- 5. Clique em "Generate token"
-- 6. COPIE O TOKEN (você não verá novamente!)

CREATE OR REPLACE SECRET git_secret
  TYPE = password
  USERNAME = 'ronenfilho'  -- Seu username do GitHub
  PASSWORD = 'ghp_YOUR_GITHUB_TOKEN_HERE'  -- Cole seu token aqui
  COMMENT = 'Personal Access Token para acessar repositórios GitHub';

-- =====================================================================
-- 2. VERIFICAR SECRET CRIADO
-- =====================================================================
SHOW SECRETS;
DESCRIBE SECRET git_secret;

-- =====================================================================
-- 3. RECRIAR REPOSITÓRIO GIT USANDO O SECRET
-- =====================================================================
-- Agora recrie o repositório usando o secret
DROP GIT REPOSITORY IF EXISTS ia_ifg_modelagem;

CREATE OR REPLACE GIT REPOSITORY ia_ifg_modelagem
  API_INTEGRATION = git_api_integration
  GIT_CREDENTIALS = git_secret
  ORIGIN = 'https://github.com/ronenfilho/ia-ifg-modelagem.git';

-- =====================================================================
-- 4. FAZER FETCH COM AUTENTICAÇÃO
-- =====================================================================
ALTER GIT REPOSITORY ia_ifg_modelagem FETCH;

-- =====================================================================
-- 5. VERIFICAR REPOSITÓRIO
-- =====================================================================
SHOW GIT REPOSITORIES;
DESCRIBE GIT REPOSITORY ia_ifg_modelagem;

SELECT 'Secret configurado com sucesso!' AS STATUS;
SELECT 'Repositório atualizado para usar autenticação via PAT' AS INFO;
