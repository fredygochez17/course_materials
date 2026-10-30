----------------- JOINS ----------------------

-- remember to attach Luke's data jobs data base to run these queries

-- 4 major types of joins (commonly rep'd by ven diagrams): 
        -- left  join (very common)
        -- right join
        -- inner join (very common)
        -- outer join
        -- advanced concept side note: cross join - produces cartesian product of two tables (linear algebra)






-- --                     Left Join
-- -- job_postings_fact <------------- company_dim
-- --     (Table A)                     (Table B)
-- --
-- -- data from Table A is preserved, only related data from Table B gets brought over

-- SELECT
--     jpf.job_id,
--     jpf.job_title_short,
--     cd.company_id,
--     cd.name AS company_name,
--     jpf.job_location
-- FROM
--     job_postings_fact AS jpf
-- LEFT JOIN company_dim AS cd 
--     ON jpf.company_id = cd.company_id ;

------------------------------------------------------------------------------------------

-- --                     Right Join (less common than Left Join)
-- -- job_postings_fact -------------> company_dim
-- --     (Table A)                     (Table B)
-- --
-- -- data from Table B is preserved, only related data from Table A gets brought over

-- SELECT
--     jpf.job_id,
--     jpf.job_title_short,
--     cd.company_id,
--     cd.name AS company_name,
--     jpf.job_location
-- FROM
--     job_postings_fact AS jpf
-- RIGHT JOIN company_dim AS cd 
--     ON jpf.company_id = cd.company_id ;

------------------------------------------------------------------------------------------

-- --                     Inner Join (very common)
-- -- returns rows when there is a match in both tables being joined

-- SELECT
--     jpf.job_id,
--     jpf.job_title_short,
--     cd.company_id,
--     cd.name AS company_name,
--     jpf.job_location
-- FROM
--     job_postings_fact AS jpf
-- INNER JOIN company_dim AS cd -- INNER keyword is optional but a good practice
--     ON jpf.company_id = cd.company_id ;

------------------------------------------------------------------------------------------

-- --                     Full Outer Join
-- -- returns all rows rom both tables
-- -- great for checking for data completness and 'orphan data'

-- SELECT
--     jpf.job_id,
--     jpf.job_title_short,
--     cd.company_id,
--     cd.name AS company_name,
--     jpf.job_location
-- FROM
--     job_postings_fact AS jpf
-- FULL OUTER JOIN company_dim AS cd -- OUTER keyword is optional. NOTE: LEFT and RIGHT joins are technically two types of OUTER joins
--     ON jpf.company_id = cd.company_id ;






--------------------------------------------------------------------------------------------
------------------------------------- FINAL EXAMPLE ----------------------------------------
--------------------------------------------------------------------------------------------
/*
JOB_POSTINGS_FACT                          SKILLS_JOB_DIM                           
job_id       (PK)--|------------------|<---job_id (PK/FK)                         SKILLS_DIM
company_id   (FK)-->|--------              skills_id (PK/FK)-->|---------------|--skill_id (PK)
                             |
                             |             COMPANY_DIM
                             -----------|--company_id (PK)
*/

----- view tables ------
-- SELECT *
-- FROM skills_job_dim
-- LIMIT 10;

-- SELECT *
-- FROM skills_dim
-- LIMIT 10;

-- -- LEFT JOIN useful if we want to preseve all values from 
-- -- job_postings_fact regardless if it has an associated skill
-- -- FULL JOIN in this case would yield same result
-- SELECT
--     jpf.job_id,
--     jpf.job_title_short,
--     sjd.skill_id,
--     sd.skills
-- FROM
--     job_postings_fact AS jpf
--     LEFT JOIN
--         skills_job_dim AS sjd
--         ON jpf.job_id = sjd.job_id
--     LEFT JOIN
--         skills_dim AS sd
--         ON sjd.skill_id = sd.skill_id ;


-- with INNER JOIN, job postings that don't have an associated skill won't appear
SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
    INNER JOIN
        skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN
        skills_dim AS sd
        ON sjd.skill_id = sd.skill_id ;