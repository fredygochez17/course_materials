/*

.read 1.31_nested_functions.sql

*/


-- ARRAY
SELECT ['python', 'sql', 'r'] AS skills_array;

WITH skills AS (
    SELECT 'python' AS skill 
    UNION ALL 
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), skills_array AS (
    SELECT ARRAY_AGG(skill ORDER BY skill) AS skills -- LIST() is an alias for ARRAY_AGG()
    FROM skills
)
SELECT  
    skills[1] AS first_skill,
    skills[2] AS second_skill,
    skills[3] AS third_skill
FROM
    skills_array;


-- STRUCT
SELECT { skill: 'python', type: 'programming' } AS skill_struct; -- type is a reserved keyword in SQL

WITH skill_struct AS (
    SELECT 
        STRUCT_PACK(
            skill := 'python',
            type  := 'programming'
        ) AS s
)
SELECT 
    s.skill,
    s.type
FROM skill_struct;

WITH skill_table AS (
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL 
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT 
    STRUCT_PACK(
        skill := skills,
        type  := types
    )
FROM skill_table;



-- ARRAY OF STRUCTS
SELECT [
    { skill: 'python', type: 'programming'    },
    { skill: 'sql'   , type: 'query_language' }
] AS skills_array_of_structs;


WITH skill_table AS (
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL 
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
), skills_array_struct AS (
    SELECT 
        ARRAY_AGG(
            STRUCT_PACK(
                skill := skills,
                type  := types
            )
            ORDER BY skills
        ) array_struct
    FROM skill_table
)
SELECT
    array_struct[1].skill,
    array_struct[2].type,
    array_struct[3]
FROM skills_array_struct;



-- MAP
WITH skill_map AS (
    SELECT MAP {'skill' : 'python', 'type':'programming'} AS skill_type
)
SELECT
    skill_type['skill'], -- similar to working with dictionaries in Python
    skill_type['type']
FROM
 skill_map;




-- JSON
-- many ways to process json data from text to usable format for analysis
WITH raw_skill_json AS (
    SELECT 
    -- TO_JSON('{"skill":"python", "type":"programming"}') AS skill_json
    '{"skill":"python", "type":"programming"}'::JSON AS skill_json
)
SELECT skill_json
FROM raw_skill_json;


WITH raw_skill_json AS (
    SELECT 
    -- TO_JSON('{"skill":"python", "type":"programming"}') AS skill_json
    '{"skill":"python", "type":"programming"}'::JSON AS skill_json
)
SELECT
    STRUCT_PACK(
        skill := json_extract_string(skill_json, '$.skill'),
        type  := json_extract_string(skill_json, '$.type' )
    )
FROM raw_skill_json;









-- Arrays — Final Example
-- Build a flat skill table for co-workers to access job titles, salary info, and skills in one table
CREATE OR REPLACE TEMP TABLE job_skills_array AS
    SELECT
        jpf.job_id,
        jpf.job_title_short,
        jpf.salary_year_avg,
        ARRAY_AGG(sd.skills) AS skills_array
    FROM
        job_postings_fact AS jpf
        LEFT JOIN skills_job_dim AS sjd 
            ON jpf.job_id = sjd.job_id 
        LEFT JOIN skills_dim AS sd
            ON sd.skill_id = sjd.skill_id
    GROUP BY ALL; -- ALL keyword may not be accepted by all SQL dialects


-- WITH skills AS (
--     SELECT 'python' AS skill 
--     UNION ALL 
--     SELECT 'sql'
--     UNION ALL
--     SELECT 'r'
-- ), skills_array AS (
--     SELECT ARRAY_AGG(skill) AS skills
--     FROM skills
-- )
-- SELECT  
--     UNNEST(skills) -- example for unnesting an array
-- FROM
--     skills_array;


-- From the perspective of a Data Analyst, analyze the median salary per skill
WITH flat_skills AS (
    SELECT 
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_array) AS skill
    FROM 
        job_skills_array
)
SELECT
    skill,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skills
GROUP BY skill
ORDER BY median_salary DESC;



-- ARRAY OF STRUCTS — Final Example
-- build a flat skill & type for co-workers to access job titles, salary info, skills, and type in one table
-- SELECT 
--     * 
-- FROM 
--     skills_dim;

CREATE OR REPLACE TEMP TABLE job_skills_array_struct AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(
        STRUCT_PACK(
            skill_type  := sd.type,
            skill       := sd.skills
        )
    ) AS skills_type
FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd 
        ON jpf.job_id = sjd.job_id 
    LEFT JOIN skills_dim AS sd
        ON sd.skill_id = sjd.skill_id
GROUP BY ALL;

-- From the perspective of Data Analyst, analyze the median salary per type of skill
SELECT 
    job_id,
    job_title_short,
    salary_year_avg,
    UNNEST(skills_type).skill_type AS skill_type,
    UNNEST(skills_type).skill      AS skill_name
FROM 
    job_skills_array_struct;

WITH flat_skills AS (
    SELECT 
        job_id, 
        job_title_short,
        salary_year_avg,
        UNNEST(skills_type).skill_type AS skill_type,
        UNNEST(skills_type).skill      AS skill_name 
    FROM 
        job_skills_array_struct
)
SELECT
    skill_type,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skills
GROUP BY skill_type;