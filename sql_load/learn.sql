select *
from (
    select *
    from job_postings_fact
    WHERE EXTRACT(month from job_posted_date) = 1
) as january_jobs;

with fabruary_jobs as(
    select *
    from job_postings_fact
    WHERE EXTRACT(month from job_posted_date) = 2
)
select *
from fabruary_jobs;

select * from fabreuary;

select name as company_name
from company_dim
where company_id IN(select 
    company_id
from
    job_postings_fact
where
    job_no_degree_mention = true);

with company_job_count as(
    select 
        company_id,
        count(*) as total_jobs
    from
        job_postings_fact
    GROUP BY 
        company_id
)
select company_dim.name as company_name, company_job_count.total_jobs
from company_dim
left join company_job_count on company_job_count.company_id = company_dim.company_id
where total_jobs >= 2
order by 
    total_jobs 
;


with skill_job_postings as (
    select 
        skills_job_dim.skill_id, count(*) as total_jobs
    from 
        skills_job_dim
    inner join 
        job_postings_fact on job_postings_fact.job_id = skills_job_dim.job_id
    where job_postings_fact.job_work_from_home = True and job_postings_fact.job_title_short LIKE '%Data Analyst%'
    group by 
        skill_id
)
select skills_dim.skills, skills_dim.skill_id, skill_job_postings.total_jobs
from skills_dim
inner join skill_job_postings on skill_job_postings.skill_id = skills_dim.skill_id
order by 
    total_jobs desc
LIMIT 5
;

select skills, skill_id from skills_dim
where skills = 'deno';

select job_location from job_postings_fact;

with salary_first_quarter as (
    select 
    job_title_short,
    job_location,
    company_id,
    salary_year_avg
from 
    january

UNION ALL

select 
    job_title_short,
    job_location,
    company_id,
    salary_year_avg
from 
    fabreuary

UNION ALL

select 
    job_title_short,
    job_location,
    company_id,
    salary_year_avg
from
    march
)
select
    job_title_short,
    salary_year_avg
from
    salary_first_quarter
where salary_year_avg>70000;

select 
    first_quarter_of_the_year.job_title_short,
    first_quarter_of_the_year.job_location,
    first_quarter_of_the_year.salary_year_avg,
    first_quarter_of_the_year.job_posted_date::date
from(
    select *
    from january
    union ALL
    select *
    from fabreuary
    union ALL
    select *
    from march
) as first_quarter_of_the_year
where first_quarter_of_the_year.salary_year_avg > 70000 and 
    job_title_short = 'Data Analyst'
order BY
    first_quarter_of_the_year.salary_year_avg desc
;