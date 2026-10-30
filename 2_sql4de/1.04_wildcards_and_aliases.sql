/*
1.4 Wildcards & Aliases

*** Remember to connect to Luke Barousse's Job_Listings database on Mother Duck. ***
ATTACH 'md:_share/data_jobs/87603155-cdc7-4c80-85ad-3a6b0d760d93';
USE data_jobs;

*/




--------------------------------------------------------------------------------------------
------------------------------------ WILDCARDS ---------------------------------------------
--------------------------------------------------------------------------------------------

 /*
SELECT 
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_via                 -- 5
FROM 
    job_postings_fact
WHERE
    -- LIKE is a keyword used for "pattern matching"
    job_location LIKE 'Columbus, OH' 
*/


/*
SELECT 
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_via                 -- 5
FROM 
    job_postings_fact
WHERE
    -- the underscore (_) stands for any character in a string
    job_location LIKE 'Columbus, __' 
*/

/*
SELECT 
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_via                 -- 5
FROM 
    job_postings_fact
WHERE
    -- percent sign (%) represents zero, one, or more characters
    job_title LIKE '%Data Engineer%'
*/



--------------------------------------------------------------------------------------------
------------------------------------- ALIASES ----------------------------------------------
--------------------------------------------------------------------------------------------

/*
SELECT 
    jpf.job_id AS id,                   -- AS keyword is optional but improves readability 
    job_title AS job_title_original,    -- change the column label that appears in query output
    job_title_short AS job_category,
    job_location,
    job_via AS tuna
FROM 
    job_postings_fact AS jpf -- can now use 'jpf' when selecting columns (see job_id line)
WHERE
    job_title LIKE '%Data Engineer%'
*/


--------------------------------------------------------------------------------------------
-------------------------------- FINAL EXAMPLE ---------------------------------------------
--------------------------------------------------------------------------------------------

/*
    > Look for non-senior data engineer and non-senior software engineer roles
        - Only get job titles that include either 'Data' or 'Software'
        - Also include those with 'Engineer' in any part of the title
        - Don't include any job titles with 'Senior' or 'Sr' followed by any character
    > Get the job_id, job_title, location, and job_platform
        - rename the columns appropriately
*/

/*
-- MY SOLUTION -> 327,688 rows
SELECT 
    job_id,
    job_title           AS 'job title',     -- syntax error without quotes due to white space
--    job_title_short,
    job_location        AS location,
    job_via             AS platform
FROM 
    job_postings_fact
WHERE
    (job_title LIKE '%Data Engineer%' OR job_title LIKE '%Software Engineer%')
    AND NOT
    (job_title LIKE '%Senior%' OR job_title LIKE '%Sr%')
*/

-- LUKE'S SOLUTION -> 386,181 rows
SELECT 
    job_id AS id,
    job_title,
    job_location AS location,
    job_via AS platform
FROM 
    job_postings_fact
WHERE
    (job_title LIKE '%Data%' OR job_title LIKE '%Software%')
    AND job_title LIKE '%Engineer%'
    AND NOT (job_title LIKE '%Senior%' OR job_title LIKE '%Sr%')