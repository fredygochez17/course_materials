/*
1.2 Basic keywords and readable text

*** Remember to connect to Luke Barousse's Job_Listings database on Mother Duck. ***
ATTACH 'md:_share/data_jobs/87603155-cdc7-4c80-85ad-3a6b0d760d93';
USE data_jobs;

*/

SELECT 
    job_title_short, job_location, salary_year_avg
FROM
    job_postings_fact
WHERE
    job_location = 'Spain' AND salary_year_avg IS NOT NULL
LIMIT 
    10 -- for an input script, semicolon at the end is optional