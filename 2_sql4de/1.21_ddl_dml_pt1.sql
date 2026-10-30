/*
1.21_ddl_dml_pt1.sql

         DDL                                  DML
Data Definition Language            Data Manipulation Language

This lesson shows how to create/delete databases, schemas, and tables. 
We also learn how to modify table rows, columns, cells and data types. 

*/
USE data_jobs;

-- be very careful with DROP.
-- it can ruin lives if you delete the wrong thing
DROP DATABASE IF EXISTS jobs_mart;

-- create database
CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES; 

SELECT * 
FROM information_schema.schemata;

-- USE keyword is only allowed in some databases
USE jobs_mart;

-- create schema
CREATE SCHEMA IF NOT EXISTS staging;
-- DROP SCHEMA IF EXISTS staging;

-- create table
CREATE TABLE IF NOT EXISTS staging.preferred_roles(   -- must specify schema "staging" when creating a table or it will be created in the "main" schema of jobs_mart
    role_id INTEGER PRIMARY KEY,    -- PRIMARY KEY keywords prevent duplicate entries. No two entries can have same ID.                
    role_name VARCHAR
);

SELECT * 
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

-- DROP TABLE IF EXISTS main.preferred_roles; -- 'IF EXISTS' & 'main.' are optional but preferred for clarity

-- add rows to existing table
INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES 
    (1, 'Data Engineer'), 
    -- (1, 'Data Engineer'),    --duplicate not allowed due to PRIMARY KEY
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

SELECT * FROM staging.preferred_roles;

-- add column to existing table
ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN; 

SELECT * FROM staging.preferred_roles;

-- update cells 
UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id=1 OR role_id=2;

SELECT * FROM staging.preferred_roles;

-- update cell
UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id=3;

SELECT * FROM staging.preferred_roles;

-- rename table
ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;   -- no need to specify schema here

SELECT * 
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

-- rename column
ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role to priority_lvl;

SELECT * FROM staging.priority_roles;

-- update column data type
ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER; -- be mindful that a data type can't necessarily be transfered to all other data types

SELECT * FROM staging.priority_roles;

-- update the cell
UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT * FROM staging.priority_roles;