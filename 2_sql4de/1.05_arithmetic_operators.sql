/*
1.5 Arithmetic Operators

*** Remember to connect to Luke Barousse's Job_Listings database on Mother Duck. ***
ATTACH 'md:_share/data_jobs/87603155-cdc7-4c80-85ad-3a6b0d760d93';
USE data_jobs;

*/

/*
-- adding and subtracting
SELECT 
    job_id,
    job_title_short, 
    salary_hour_avg - 5 AS salary_hour_min,
    salary_hour_avg,
    salary_hour_avg + 5 AS salary_hour_max
FROM job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
*/

/*
-- multiplication and division
SELECT 
    job_id,
    job_title_short, 
    salary_hour_avg * 0.80 AS salary_hour_min,
    salary_hour_avg,
    salary_hour_avg * 1.20 AS salary_hour_max,
    salary_year_avg,
    salary_year_avg / (52*40) AS 'per hour from yearly'
FROM job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL 
    OR 
    salary_year_avg IS NOT NULL
*/



-- modulus returns remainder of a division operation
SELECT 
    job_id,
    job_title_short, 
    salary_year_avg,
    salary_year_avg % 1000
FROM job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
    AND 
    salary_year_avg % 1000 = 0