/*
1.3 Comparison and Logical Operators

*** Remember to connect to Luke Barousse's Job_Listings database on Mother Duck. ***
ATTACH 'md:_share/data_jobs/87603155-cdc7-4c80-85ad-3a6b0d760d93';
USE data_jobs;

> Get job details for 'Data Engineer' OR 'Data Analyst
    - Data Engineer: $75k  - $100k
    - Data Analyst:  $100k - $125k
> Only include jobs located in EITHER
    - Bentonville, AR
    - San Diego, CA
    - Remote Jobs

*/

SELECT
    job_id,
    job_title_short,
    job_location,
    job_via,
    salary_year_avg,
    job_work_from_home
FROM
    job_postings_fact
WHERE
    (   
        (job_title_short = 'Data Engineer' AND salary_year_avg BETWEEN 75_000  and 100_000)
        OR
        (job_title_short = 'Data Analyst'  AND salary_year_avg BETWEEN 100_000 and 125_000)
    )
    AND
    (
        job_location IN ('Bentonville, AR', 'San Diego, CA')
        OR
        job_work_from_home IS TRUE -- pretty sure IS or '=' works here
    )