------------------------------ ERD -----------------------------------------

-- ERD = "Entity Relationship Management"

-- SELECT 
--     job_id,
--     job_title_short,
--     salary_year_avg,
--     company_id
-- FROM
--     job_postings_fact ;

-- SELECT
--     *
-- FROM 
--     company_dim
-- LIMIT 10 ;

-- SELECT
--     company_id,
--     name
-- FROM 
--     company_dim
-- WHERE
--     name IN ('Facebook', 'Meta') -- helps keep old company names

-- -- composite primary key because the combination of primary keys make a unique value
-- SELECT * FROM skills_job_dim LIMIT 5;
-- SELECT * FROM skills_dim     LIMIT 5;




----------------- INFORMATION SCHEMA -----------------------

-- -- let's look at the metadata
-- SELECT *
-- FROM information_schema.tables
-- WHERE table_catalog = 'data_jobs';

-- -- only look at specific columns of metadata
-- SELECT table_name, column_name, data_type
-- FROM information_schema.columns
-- WHERE table_catalog = 'data_jobs';

-- -- 
-- SELECT *
-- FROM information_schema.table_constraints
-- WHERE table_catalog = 'data_jobs';

-- -- 
-- SELECT *
-- FROM information_schema.key_column_usage
-- WHERE table_catalog = 'data_jobs';

-- --slightly easer command to inspect metadata
-- PRAGMA show_tables; -- method adapted from SQLite
-- PRAGMA show_tables_expanded;

-- another quick way of looking at metadata: 
DESCRIBE job_postings_fact;