/*

.read 1.28_text_null_functions.sql

this sections goes through the most common text and null functions
see sql dialect documentation for all others

*/


-- Length & Count
SELECT LENGTH('SQL');
SELECT CHAR_LENGTH('SQL'); -- same result as previous query (alias)


-- Case Conversion
SELECT UPPER('Data Nerd');
SELECT LOWER('Data Nerd');


 -- Substring / Extraction
SELECT LEFT('Data Nerd', 2);
SELECT RIGHT('Data Nerd', 2);
SELECT SUBSTRING('Data Nerd', 2, 3);


-- Concatenation
SELECT CONCAT('Data', '—', 'Nerd');
SELECT 'Data' || '—' || 'Nerd';     -- same as previous query


-- Trimming - removes whitespace
SELECT TRIM('          SQL Functions          ');


-- Replacement
SELECT REPLACE('Data Nerd', 'a', '_');
-- REGEXP stand for regular expression
-- regular expression syntax slightly covered in Dr. Chuck's PY4E course
-- regular expression syntax could honestly be it's own course
SELECT REGEXP_REPLACE('data.nerd@gmail.com', '^.*(@)', '\1'); -- extacts @gmail.com domain





------------------------ Text Functions Final Example ------------------------
-- Clean up previous query using text functions
WITH title_lower AS (
    SELECT  
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%'
            THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%'
            THEN 'Data Scientist'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%'
            THEN 'Data Engineer'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 25;










----------------------- NULL FUNCTONS -----------------------
-- fall into "Utility Functions" section of DuckDB documentation
-- hard to categorize and are broadly useful

-- NULLIF - returns NULL if values are equal
-- use case: filtering out 0 values for salary data listed as 0 instead of NULL
SELECT NULLIF(10,10);
SELECT NULLIF(10,20);

-- COALESCE — returns first non-NULL value
SELECT COALESCE(NULL, NULL, 0, 1, 2, 3, 4);

-- Using COALESCE to clean up standarized salaries query
SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080)::INTEGER AS standarized_salary
FROM job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL 
    OR salary_year_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 25;


------------------------ NULL Functions Final Example ------------------------
-- Using COALESCE to clean up standarized salaries query
SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080)::INTEGER AS standarized_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) IS NULL   THEN 'Missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) <  75_000 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) < 150_000 THEN 'Mid'
        ELSE 'High'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standarized_salary DESC;

