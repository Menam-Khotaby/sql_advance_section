select 
    skills_dim.skills,
    Round(AVG(salary_year_avg)) as salary_average
from job_postings_fact
inner JOIN skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Machine Learning Engineer' AND
    salary_year_avg is not null
GROUP BY
    skills
order by 
    salary_average desc
limit 25;