/*

.read 1.27_set_operations.sql

*/



----------- UNION -----------
-- combines rows of table A and table B

-- removes duplicates
SELECT UNNEST([1, 1, 1, 2]) -- UNNEST keyword to turn into column
UNION
SELECT UNNEST([1, 1, 3]); 

-- preserves duplicates (i.e. combines all values)
SELECT UNNEST([1, 1, 1, 2])
UNION ALL
SELECT UNNEST([1, 1, 3]); 



----------- INTERSECT -----------
-- returns rows in both table A and table B

-- removes duplicates
SELECT UNNEST([1, 1, 1, 2])
INTERSECT
SELECT UNNEST([1, 1, 3]); 

-- preserves duplicates
SELECT UNNEST([1, 1, 1, 2])
INTERSECT ALL
SELECT UNNEST([1, 1, 3]); 



----------- EXCEPT -----------
-- returns rows in table A but not table B

-- duplciates
SELECT UNNEST([1, 1, 1, 2])
EXCEPT
SELECT UNNEST([1, 1, 3]); 

-- duplciates removed one-for-one
SELECT UNNEST([1, 1, 1, 2])
EXCEPT ALL
SELECT UNNEST([1, 1, 3]); 








----------- FINAL EXAMPLE -----------

-- make 2023 temp table
CREATE OR REPLACE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date) -- EXCLUDE keyword not supported by all SQL dialects
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * FROM jobs_2023;

-- make 2024 temp table
CREATE OR REPLACE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT * FROM jobs_2024;


-- 1. Which unique job postings appeared in either 2023 or 2024?
SELECT * FROM jobs_2023
UNION
SELECT * FROM jobs_2024;

SELECT 
    'jobs_2023' AS table_name,
    COUNT(*)    AS record_count
FROM jobs_2023
UNION
SELECT 
    'jobs_2024' AS table_name,
    COUNT(*)    AS record_count
FROM jobs_2024;


-- 2. Which job postings appeared across both years, counting duplicates? 
SELECT * FROM jobs_2023
UNION ALL
SELECT * FROM jobs_2024;


-- 3. Which job postings appeared in 2023 but not in 2024?
SELECT * FROM jobs_2023
EXCEPT
SELECT * FROM jobs_2024;


-- 4. Which job postings from 2023 remain after subtracting matching 2024 postings, one-for-one?
SELECT * FROM jobs_2023
EXCEPT ALL
SELECT * FROM jobs_2024;


-- 5. Which job postings appeared in both 2023 and 2024, not counting duplicates? 
SELECT * FROM jobs_2023
INTERSECT
SELECT * FROM jobs_2024;


-- 6. Which job postings appeared in both years, preserving duplicate counts? 
SELECT * FROM jobs_2023
INTERSECT ALL
SELECT * FROM jobs_2024;