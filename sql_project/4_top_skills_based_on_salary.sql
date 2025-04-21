with skills_to_jobs as(
select
    job_id,
    job_title,
    salary_year_avg,
    name as company_name
from
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id  
where
    job_title_short like '%Data Analyst%' AND
    job_location like '%Anywhere%' AND
    salary_year_avg is not null
order by
    salary_year_avg desc
limit 10
)
select 
    skills_dim.skills,
    count(*) as skills_count
from skills_to_jobs
inner JOIN skills_job_dim on skills_job_dim.job_id = skills_to_jobs.job_id
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
    skills_dim.skill_id
ORDER BY
    skills_count DESC
limit 10;
