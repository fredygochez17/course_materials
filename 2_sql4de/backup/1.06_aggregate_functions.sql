/*
1.6 Aggregate Functions

*** Remember to connect to Luke Barousse's Job_Listings database on Mother Duck. ***
ATTACH 'md:_share/data_jobs/87603155-cdc7-4c80-85ad-3a6b0d760d93';
USE data_jobs;

side note: there were more notes in here but I accidentally overwrote them with the echo bash command
           and couldn't recover them.
*/

--------------------------------------------------------------------------------------------
------------------------------------ AGGREGATE FUNCTIONS -----------------------------------
--------------------------------------------------------------------------------------------

/*
-- average salary by job title
SELECT
    job_title_short,
    AVG(salary_year_avg) AS avg_salary
FROM job_postings_fact
GROUP BY job_title_short
*/

SELECT
    job_title_short,
    AVG(salary_year_avg) AS avg_salary,
    MEDIAN(salary_year_avg) AS median_salary
FROM 
    job_postings_fact
GROUP BY 
    job_title_short
HAVING 
    MEDIAN(salary_year_avg) > 100_000
ORDER BY 
    avg_salary DESC;

-- just testing out nano text editor