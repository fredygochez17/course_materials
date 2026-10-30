-------------------------------- ORDER OF EXECUTION ------------------------------------
/*
    remeber to attach Luke's database hosted on Mother Duck when launching DuckDB CLI:
        $ duckdb MD:data_jobs_luke <-------------- Note: routine within ~/.bashrc
*/

SELECT DISTINCT
    job_title_short,
    job_country
FROM
    job_postings_fact
WHERE
    job_country = 'Spain'