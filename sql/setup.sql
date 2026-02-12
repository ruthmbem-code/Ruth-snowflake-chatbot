-- 0) (optionnel) choisir le rôle qui a les droits
-- USE ROLE <ROLE_ADMIN>;
USE ROLE ACCOUNTADMIN;

-- 1) Warehouse
CREATE WAREHOUSE IF NOT EXISTS WH_LAB
  WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

-- 2) Database + schema
CREATE DATABASE IF NOT EXISTS DB_LAB;
CREATE SCHEMA IF NOT EXISTS DB_LAB.CHAT_APP;

-- 3) Contexte
USE WAREHOUSE WH_LAB;
USE DATABASE DB_LAB;
USE SCHEMA CHAT_APP;

-- 4) Table de persistance (Partie D)
CREATE TABLE IF NOT EXISTS CHAT_MESSAGES (
  conversation_id STRING,
  timestamp TIMESTAMP_NTZ,
  role STRING,
  content STRING
);

-- Test simple : le LLM répond ?
SELECT AI_COMPLETE('snowflake-arctic', 'Dis bonjour en une phrase.');


-- ========================================
-- TESTS DE VALIDATION
-- ========================================

-- Warehouse OK ?
SELECT 1;

-- Cortex OK ?
SELECT SNOWFLAKE.CORTEX.COMPLETE(
  'llama3.1-8b',
  'Dis bonjour en une phrase.'
);
