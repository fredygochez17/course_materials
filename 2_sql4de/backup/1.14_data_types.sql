/*
1.14 Data Types

NUMERIC
    - int
    - float
    - double
    - decimal(p,s)
    - numeric(p,s)
CHARACTER
    - char(n)
    - varchar(n)
    - text
BOOLEAN
    - boolean true, false
DATE/TIME
    - date
    - time
    - timestamp
    - timestamptz (time zone)
OTHER TYPES
    - array
    - json 
    - UUID
    - binary

*/

-- -- query for viewing data types of table columns
-- SELECT
--     table_name,
--     column_name,
--     data_type,
--     is_nullable
-- FROM
--     information_schema.columns
-- WHERE 
--     table_name = 'job_postings_fact' ;

-- -- DESCRIBE keyrword specific only to DuckDB
-- DESCRIBE 
-- SELECT
--     job_title_short,
--     salary_year_avg
-- FROM
--     job_postings_fact;




-------------------------------------------------------------------------------------
-- CASTING - converting Data Types within queries to different data types

-- SELECT CAST('123' AS INT) AS integers ; -- convert string '123' in integer

-- SELECT
--     CAST(job_id AS VARCHAR) AS job_id,             -- "more unique" identifier
--     CAST(company_id AS VARCHAR) AS company_id,
--     CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR) AS combined_id,
--     -- job_id || '.' || company_id AS alias_combined_id, -- can concatenate with alias
--     -- CAST(alias_combined_id AS FLOAT) AS combined_id_float, -- change back to numeric (takes less memory)
--     -- CAST(combined_id_float AS DECIMAL(8,4)) AS combined_id_all_digits, -- digits get changed likely due to rounding
--     CAST (job_work_from_home AS INT)    AS job_work_from_home,      -- from boolean to numeric value
--     CAST (job_posted_date AS DATE)      AS job_posted_date,         -- from timestamp to date only
--     CAST (salary_year_avg AS DECIMAL(9, 2)) AS salary_year_avg      -- from double to now decimal places
-- FROM
--     job_postings_fact
-- WHERE
--     salary_year_avg IS NOT NULL
-- LIMIT 
--     10 ;



-- -- popular syntax for casting that other databases use is double colons (::)
-- SELECT
--     job_id::VARCHAR || '-' || company_id::VARCHAR AS unique_id,
--     job_id || '-' ||company_id AS alias_combined_id,
--     job_work_from_home::INT AS job_work_from_home,
--     job_posted_date::DATE AS job_posted_date,
--     salary_year_avg::DECIMAL AS salary_year_avg
-- FROM
--     job_postings_fact
-- WHERE
--     salary_year_avg IS NOT NULL
-- LIMIT
--     10;




-- good practice to cast when combining columbs that may cause ambiguity in data type when combining them
-- e.g. adding 3 (INT) to 5.5 (float)
SELECT (3+5.5)::INT;    -- yields 9 as INT
SELECT (3+5.5)::FLOAT;  -- yields 8.5 as FLOAT
