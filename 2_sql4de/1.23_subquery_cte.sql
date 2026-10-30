/*
.read 1.23_subquery_cte.sql

Subqueries & CTEs

CTE - Common Table Expression, exists only for the duration of the query execuation then automatically disappears


*/

-- subquery
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL 
        OR salary_hour_avg IS NOT NULL
) AS valid_salaries -- providing alias here is optional but good practice for context and readability
LIMIT 10;

-- CTE
WITH valid_salaries AS (
    SELECT *
    FROM job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL 
        OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries






------------------- Subquery Deep-Dive ------------------------

-- Scenario 1 — Subquery in 'SELECT'
-- Show each job's salary next to the overall market median:
SELECT
    job_title_short,
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
    ) AS market_median_salary
FROM job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
limit 10;


-- Scenario 2 — Subquery in 'FROM'
-- Stage only jobs that are remote before aggregating to detemine the remote median salary per job:
SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE 
            -- AND salary_year_avg IS NOT NULL -- this line is optional, MEDIAN function in subquery ignores NULL values
    ) AS market_remote_median_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS jobs_cleaned_up
-- WHERE                            -- WHERE clause here is optional 
--     salary_year_avg IS NOT NULL  -- MEDIAN function in outer SELECT clause ignores NULL values
GROUP BY
    job_title_short
ORDER BY 
    median_salary DESC;
-- good practice to simplify queries where applicable. 
-- comments left in for notes


-- Scenario 3 — Subquery in 'HAVING'
-- Keep only job titles whose remote median salary is above the overall median for remote jobs:
SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE 
    ) AS market_remote_median_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS jobs_cleaned_up
GROUP BY
    job_title_short
HAVING
    MEDIAN(salary_year_avg) > (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE 
    )
ORDER BY 
    median_salary DESC;




--------------- CTEs — Common Table Expressions --------------------
-- CTEs exist only during the execution of a query

-- CTE Example
-- Compare how much more (or less) remote roles pay compared to onsite roles for each job title,
-- Use a CTE to calculate the median salary by title and work arrangment, then compare those medians. 
WITH title_median AS (
    SELECT
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    WHERE
        job_country = 'United States'
    GROUP BY
        job_title_short,
        job_work_from_home
    -- ORDER BY
    --     job_title_short
)
SELECT
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    remote_median_salary - onsite_median_salary AS remote_premium
FROM title_median AS r          -- r for "remote"
INNER JOIN title_median AS o    -- o for "on_site"
    ON r.job_title_short = o.job_title_short
WHERE 
    r.job_work_from_home = TRUE
    AND o.job_work_from_home = FALSE
ORDER BY
    remote_premium DESC;

-- existence filtering
SELECT *
FROM range(3) AS src(key);

SELECT *
FROM range(2) AS tgt(key);

SELECT *
FROM range(3) AS src(key)
WHERE NOT EXISTS (  -- result depends on having 'NOT' key word there or not
    SELECT 1    -- "SELECT 1" is a common way of symbolizing that this is existence filtering
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);





---------------------- FINAL EXAMPLE -------------------------
-- Identify job postings that have no associated skills before loading them into a data mart
-- Have job posting who's job ID exists in the job_postings_fact table but not in the skills_dim table

-- no job IDs get skipped
SELECT * 
FROM job_postings_fact
ORDER BY job_id
LIMIT 10;

-- some job IDs get skipped
SELECT *
FROM skills_job_dim
ORDER BY job_id
LIMIT 40; 



SELECT *
FROM job_postings_fact AS tgt   -- target table
WHERE NOT EXISTS ( -- existence filtering
    SELECT 1    -- using '1' here is good practice
    FROM skills_job_dim AS src  -- source table
    WHERE tgt.job_id = src.job_id
)
ORDER BY job_id;