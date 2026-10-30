-------------------------------- ORDER OF EXECUTION ------------------------------------
/*
    remeber to attach Luke's database hosted on Mother Duck when launching DuckDB CLI:
        $ duckdb MD:data_jobs_luke <-------------- Note: routine within ~/.bashrc
*/


---------------- SQL Clause Order - Refresh -------------------
-- -- Note: This is separate from how the order of a query is executed,
--          but instead, the order in it must be written
-- SELECT column1, column2, ...
-- FROM table1
-- JOIN table2
--     ON join_condition
-- WHERE condition 
-- GROUP BY column 
-- HAVING condition 
-- ORDER BY column1 
-- LIMIT number;






























---------------- SQL Query Order -------------------
-- Step 1: FROM Table_A 
--         JOIN Table_B 
--             ON Table_A.column_1 = Table_B.column_2

-- Step 2: WHERE expression

-- Step 3: GROUP BY columns

-- Step 4: HAVING columns

-- Step 5: SELECT DISTINCT
--             Table_A.*,
--             Table_B.*

-- Step 6: ORDER BY columns

-- Step 7: LIMIT count 



































----------------------- FINAL EXAMPLE PT. 1 -----------------------------
------------------ Order of Execution in a Query ------------------------
/* 
    Find the top 10 companies for posting jobs.
    They must have > 3,000 job postings
    Limit this to only include jobs in the United States
*/

-- SELECT
--     cd.name AS company_name,
--     COUNT(jpf.job_id) AS posting_count
-- FROM
--     job_postings_fact AS jpf
--     LEFT JOIN company_dim AS cd
--     ON jpf.company_id = cd.company_id
-- WHERE
--     jpf.job_country = 'United States'
-- GROUP BY
--     cd.name -- Note: most data base dialects don't support using aliasing of column names here (e.g. company_name) but alias of the JOIN (e.g. cd) is valid
-- HAVING 
--     COUNT(jpf.job_id) > 3_000 
-- ORDER BY 
--     posting_count DESC
-- LIMIT 10; -- limit is optional for this example





----------------------- FINAL EXAMPLE PT. 2 -----------------------------
------------------ Order of Execution with EXPLAIN ----------------------
-- EXPLAIN statement displays the physical plan i.e. query plan
-- add ANALYZE keyword to actually execute the query

EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM
    job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_country = 'United States'
GROUP BY
    cd.name -- Note: most data base dialects don't support using aliasing of column names here (e.g. company_name) but alias of the JOIN (e.g. cd) is valid
HAVING 
    COUNT(jpf.job_id) > 3_000 
ORDER BY 
    posting_count DESC
LIMIT 10; -- limit is optional for this example