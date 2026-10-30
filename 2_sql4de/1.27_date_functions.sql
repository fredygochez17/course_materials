/*

.read 1.26_date_functions.sql

*/

-- type casting timestamp to different time data types
SELECT 
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time, 
    job_posted_date::TIMESTAMP AS timestamp, 
    job_posted_date::TIMESTAMPTZ AS timestampz  
FROM job_postings_fact
LIMIT 10;




------------- EXTRACT ----------------

-- extracting year, month, and day from timestamp
SELECT 
    job_posted_date,
    EXTRACT(YEAR  FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    EXTRACT(DAY   FROM job_posted_date) AS job_posted_day
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 10;

-- aggregate total number of job postings for data engineers on a monthly basis
SELECT 
    EXTRACT(YEAR  FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY
    EXTRACT(YEAR  FROM job_posted_date), -- could use alising here but mose SQL dialects don't allow it
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY
    job_posted_year, job_posted_month;







--------------- DATE_TRUNC ----------------
-- rounds down to the specified precision parameter
SELECT 
    job_posted_date,
    DATE_TRUNC('year', job_posted_date) AS job_posted_year,
    DATE_TRUNC('quarter', job_posted_date) AS job_posted_quarter,
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    DATE_TRUNC('week', job_posted_date) AS job_posted_week,
    DATE_TRUNC('day', job_posted_date) AS job_posted_day,
    DATE_TRUNC('hour', job_posted_date) AS job_posted_hour,
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 25;

SELECT 
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Engineer' AND
    -- DATE_TRUNC('year', job_posted_date) = '2024-01-01'
    EXTRACT(YEAR FROM job_posted_date) = 2024   -- same as previouse line using DATE_TRUNC but easier to read
GROUP BY
    DATE_TRUNC('month', job_posted_date) 
ORDER BY
    job_posted_month;







--------------- AT TIME ZONE ----------------
-- converts to the specified time zone
SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'EST';

SELECT
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' -- first specify timezone data is in and then specify time zone you want to convert to
FROM job_postings_fact                                    -- luke recorded this data in UTC
WHERE
    job_location LIKE 'New York, NY';

SELECT
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS job_posted_hour,
    COUNT(job_id)
FROM job_postings_fact                                    
WHERE
    job_location LIKE 'New York, NY'
GROUP BY 
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')
ORDER BY job_posted_hour;