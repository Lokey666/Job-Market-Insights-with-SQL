WITH skill_demand AS ( 
    SELECT 
        skills_dim.skills,
        skills_job_dim.skill_id,
        COUNT(job_postings_fact.job_id) AS demand_count
    FROM
        job_postings_fact
    JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg is NOT NULL AND
        job_work_from_home = 'true'
    GROUP BY
        skills_job_dim.skill_id, skills_dim.skills
), 
average_salary AS ( 
    SELECT 
        skills_dim.skills,
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM
        job_postings_fact
    JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = 'true'
    GROUP BY
        skills_job_dim.skill_id, skills_dim.skills
)
SELECT
    skill_demand.skill_id,
    skill_demand.skills,
    skill_demand.demand_count,
    average_salary.avg_salary
FROM
    skill_demand
JOIN 
    average_salary ON skill_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER by  
    avg_salary DESC,
    demand_count DESC
LIMIT 25



/-- can also be done in smaller query

SELECT skills_dim.skill_id,
    skills_dim.skills,
    count(job_postings_fact.job_id) AS demand_count,
    round(AVG(salary_year_avg), 2) AS avg_salary
from
     job_postings_fact
join 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
join 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' and
    salary_year_avg is not NULL and 
    job_work_from_home ='true'
GROUP by
    skills_dim.skill_id, 
    skills_dim.skills
having
    count(job_postings_fact.job_id)> 10
ORDER by 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
