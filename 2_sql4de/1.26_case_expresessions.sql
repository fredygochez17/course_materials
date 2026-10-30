/*

.read 1.25_case_expresessions.sql

*/

-- Bucket Salaries
-- < 25  = 'Low'
-- 25-50 = 'Medium'
-- > 50  = 'High'
SELECT 
    job_title_short, 
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg NOT NULL
LIMIT 10;


-- Handling missing data 
-- Filter NULL salary values
SELECT 
    job_title_short, 
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'Missing'
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
LIMIT 10;



-- Categorizing Categorical Values
-- Classify  the 'job_title' column values as:
    -- 'Data Analyst'
    -- 'Data Engineer'
    -- 'Data Scientist'
SELECT
    job_title,
    CASE 
        WHEN job_title LIKE '%ata%' AND (
            job_title LIKE '%nalyst%' 
            OR job_title LIKE '%nalytics%' 
            OR job_title LIKE '%nalysis%')   THEN 'Data Analyst'
        WHEN job_title LIKE '%ata%' AND job_title LIKE '%ngineer%'  THEN 'Data Engineer'
        WHEN job_title LIKE '%ata%' AND (
            job_title LIKE '%cientist%' 
            OR job_title LIKE '%cience%') THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category, 
    job_title_short
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    OR job_title_short = 'Data Engineer'
    OR job_title_short = 'Data Scientist'
ORDER BY RANDOM()
LIMIT 20;



-- Conditional Aggregation
-- Calculate Median Salaries for Different Buckets
    -- <  $100k
    -- >= $100k
SELECT
    job_title_short,
    COUNT(*) total_postings,
    MEDIAN(
        CASE
            WHEN salary_year_avg <  100_000 THEN salary_year_avg
        END
    ) AS median_low_salary,
    MEDIAN(
        CASE
            WHEN salary_year_avg >= 100_000 THEN salary_year_avg
        END
    ) AS median_high_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short;





--------------------- FINAL EXAMPLE -------------------------
-- Conditional Calculations
-- Compute a standarized_salary using yearly salary and adjusted hourly salary (e.g. 2080 hours/year)
-- Categroize salaries into tiers of: 
    -- < 75k        'Low'
    -- 75k — 150k   'Medium'
    -- >= 150k      'High'

-- My Solution: 
WITH calculated_yearly_salary AS (
    SELECT
        job_id,
        salary_year_avg,
        salary_hour_avg,
        CASE
            WHEN salary_year_avg IS NULL THEN salary_hour_avg*2080
            ELSE salary_year_avg
        END AS standarized_salary
    FROM job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
SELECT
    jpf.job_title_short,
    cys.standarized_salary::INT,
    CASE
        WHEN cys.standarized_salary < 75_000 THEN 'Low'
        WHEN cys.standarized_salary < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_tier
FROM 
    job_postings_fact AS jpf
JOIN calculated_yearly_salary AS cys
    ON jpf.job_id = cys.job_id
LIMIT 25;



-- Luke's Solution: 
WITH salaries AS (
    SELECT 
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        CASE
            WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
            WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
        END AS standarized_salary
    FROM 
        job_postings_fact
)
SELECT
    *,
    CASE
        WHEN standarized_salary IS NULL   THEN 'Missing'
        WHEN standarized_salary <  75_000 THEN 'Low'
        WHEN standarized_salary < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM salaries;









-- count salary tiers by job_title
WITH salary_tiers AS (
    WITH salaries AS (
        SELECT 
            job_title_short,
            salary_hour_avg,
            salary_year_avg,
            CASE
                WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
                WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
            END AS standarized_salary
        FROM 
            job_postings_fact
    )
    SELECT
        job_title_short,
        CASE
            WHEN standarized_salary IS NULL   THEN 'Missing'
            WHEN standarized_salary <  75_000 THEN 'Low'
            WHEN standarized_salary < 150_000 THEN 'Medium'
            ELSE 'High'
        END AS salary_bucket
    FROM salaries
)
SELECT
    job_title_short,
    COUNT(
            CASE
                WHEN salary_bucket = 'Missing' THEN salary_bucket
            END
    ) AS missing,
    COUNT(
            CASE
                WHEN salary_bucket = 'Low' THEN salary_bucket
            END
    ) AS low,
    COUNT(
            CASE
                WHEN salary_bucket = 'Medium' THEN salary_bucket
            END
    ) AS medium,
    COUNT(
            CASE
                WHEN salary_bucket = 'High' THEN salary_bucket
            END
    ) AS high
FROM salary_tiers
GROUP BY job_title_short;