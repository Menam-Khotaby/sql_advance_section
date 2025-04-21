with skills_demand as (
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        count(job_postings_fact.job_id) as demand_skills
    from job_postings_fact
    inner JOIN skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg is not null
    GROUP BY
        skills_dim.skill_id
),salary_avg as (
    select 
        skills_job_dim.skill_id,
        Round(AVG(salary_year_avg)) as salary_average
    from job_postings_fact
    inner JOIN skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'AND
        salary_year_avg is not null AND
        job_location = 'Anywhere'
    GROUP BY
        skills_job_dim.skill_id
)

select 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_skills,
    salary_avg.salary_average
from skills_demand
inner JOIN salary_avg on skills_demand.skill_id = salary_avg.skill_id
order BY
    demand_skills desc,
    salary_average desc
LIMIT 25;
    






-- CHAT GPT CODE MAKING IT MORE CONCISE  
-- WITH skills_stats AS (
--     SELECT 
--         sd.skill_id,
--         sd.skills,
--         COUNT(jf.job_id) AS demand_skills,
--         ROUND(AVG(jf.salary_year_avg)) AS salary_average
--     FROM job_postings_fact jf
--     JOIN skills_job_dim sjd ON sjd.job_id = jf.job_id
--     JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
--     WHERE 
--         jf.job_title_short = 'Data Analyst' AND
--         jf.job_location = 'Anywhere' AND
--         jf.salary_year_avg IS NOT NULL
--     GROUP BY 
--         sd.skill_id, sd.skills
-- )

-- SELECT 
--     skill_id,
--     skills,
--     demand_skills,
--     salary_average
-- FROM skills_stats
-- ORDER BY 
--     demand_skills DESC,
--     salary_average DESC
-- LIMIT 25;
