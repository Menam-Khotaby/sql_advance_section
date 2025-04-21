select 
    skills_dim.skills,
    count(job_postings_fact.job_id) as demand_skills
from job_postings_fact
inner JOIN skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
GROUP BY
    skills
order by 
    demand_skills desc
limit 10;
