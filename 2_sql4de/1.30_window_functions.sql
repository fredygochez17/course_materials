/*

.read 1.29_window_functions.sql

*/

-- Count Rows — Aggregation Only
SELECT 
    COUNT(*)
FROM
    job_postings_fact;

-- Count Rows — Windows Function
SELECT
    job_id,
    COUNT(*) OVER()
FROM
    job_postings_fact


-- PARTITION BY — Find average hourly salary by job_title_short
SELECT 
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER( 
        PARTITION BY 
            job_title_short,
            company_id
    )
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY 
    company_id, 
    job_title_short
LIMIT 25;



-- ORDER BY — ranking hourly salary
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER(
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC -- could comment and get same result but still good practice to include
LIMIT 25;


-- PARTITION BY and ORDER BY
-- running average hourly salary
SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER( 
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL AND
    job_title_short = 'Data Engineer'

ORDER BY 
    job_title_short,
    job_posted_date
LIMIT 25;

-- ranking by job_title_short
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER(
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY     
    salary_hour_avg DESC,
    job_title_short
LIMIT 25;






-- AGGREGATION FUNCITONS - more powerful when combined with window functions
SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    MIN(salary_hour_avg) OVER( -- switch between MIN, MAX, SUM, & AVG to see what happens
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL AND
    job_title_short = 'Data Engineer'

ORDER BY 
    job_title_short,
    job_posted_date
LIMIT 25;




------------- ROW & RANK FUNCITONS -------------

-- DENSE_RANK()
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    DENSE_RANK() OVER( -- using DENSE_RANK so rank doesn't "jump" with duplicate values
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC 
LIMIT 150;


-- ROW_NUMBER() — Providing a new job_id
SELECT
    *,
    ROW_NUMBER() OVER(
        ORDER BY job_posted_date
    )
FROM 
    job_postings_fact
ORDER BY
    job_posted_date
LIMIT 20;





------------- NAVIGATION FUNCITONS -------------
-- LAG() — Time Based Comparison of Company Yearly Salary
SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LAG(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) salary_of_prev_posting,
    salary_year_avg - salary_of_prev_posting AS salary_change -- likely that not all SQL dialects will accept alias in expression
FROM
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
ORDER BY 
    company_id,
    job_posted_date
LIMIT 60;


-- LEAD() — Time Based Comparison of Company Yearly Salary
SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LEAD(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) salary_of_next_posting,
    salary_of_next_posting - salary_year_avg AS salary_change -- likely that not all SQL dialects will accept alias in expression
FROM
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
ORDER BY 
    company_id,
    job_posted_date
LIMIT 60;