/*

.read 1.22_ddl_dml_pt2.sql

CTAS - CREATE TABLE AS

*/


-- CTAS locked in place at time of creating
CREATE OR REPLACE TABLE staging.job_postings_flat AS
SELECT 
    jpf.job_id,          
    jpf.job_title_short,      
    jpf.job_title,            
    jpf.job_location,        
    jpf.job_via,              
    jpf.job_schedule_type,   
    jpf.job_work_from_home,  
    jpf.search_location,                
    jpf.job_posted_date,
    jpf.job_no_degree_mention,  
    jpf.job_health_insurance,  
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,   
    cd.name AS company_name
FROM                                  
    data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd 
    ON jpf.company_id = cd.company_id;

SELECT COUNT(*)
FROM 
    staging.job_postings_flat;

-- build out VIEW which does update in real time
CREATE OR REPLACE VIEW staging.priority_jobs_flat_view AS
SELECT 
    jpf.* 
    -- r.priority_lvl
FROM 
    staging.job_postings_flat AS jpf
JOIN 
    staging.priority_roles AS r
    ON jpf.job_title_short = r.role_name
WHERE
    r.priority_lvl = 1;

SELECT 
    job_title_short,
    COUNT(*) AS job_count
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short -- need GROUP by bc doing aggregation COUNT
ORDER BY job_count DESC;

-- TEMP TABLE is a session scope table, good for debugging and staging
-- TEMPORARY is more widely used by different data bases
CREATE TEMPORARY TABLE senior_jobs_flat_temp AS -- no need to specify schema bc temp table doesn't  exist in a schema
SELECT * 
FROM 
    staging.priority_jobs_flat_view
WHERE 
    job_title_short = 'Senior Data Engineer'; -- double quotes is for columns & table names in Duckdb. single quotes for text values in cells

SELECT 
    job_title_short,
    COUNT(*) AS job_count
FROM senior_jobs_flat_temp
GROUP BY job_title_short
ORDER BY job_count DESC;

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;

-- DELETE jobs from before 2024
DELETE FROM staging.job_postings_flat
WHERE job_posted_date < '2024-01-01'; 

SELECT COUNT(*) FROM staging.job_postings_flat;         -- should change
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;   -- should change
SELECT COUNT(*) FROM senior_jobs_flat_temp;             -- should stay the same

-- TRUNCATE data from job_postings_flat
TRUNCATE TABLE staging.job_postings_flat;

SELECT COUNT(*) FROM staging.job_postings_flat; -- should be 0 rows
SELECT * FROM staging.job_postings_flat;        -- columns should still be in there


TRUNCATE TABLE staging.job_postings_flat;

-- INSERT data back into table excluding postings before 2024
INSERT INTO staging.job_postings_flat
SELECT 
    jpf.job_id,          
    jpf.job_title_short,      
    jpf.job_title,            
    jpf.job_location,        
    jpf.job_via,              
    jpf.job_schedule_type,   
    jpf.job_work_from_home,  
    jpf.search_location,                
    jpf.job_posted_date,
    jpf.job_no_degree_mention,  
    jpf.job_health_insurance,  
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,   
    cd.name AS company_name
FROM                                  
    data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd 
    ON jpf.company_id = cd.company_id
WHERE job_posted_date >= '2024-01-01';

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;