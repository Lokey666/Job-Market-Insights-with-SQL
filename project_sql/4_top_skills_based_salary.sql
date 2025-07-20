SELECT 
    skills,
    round(AVG(salary_year_avg), 2) AS avg_salary
FROM
     job_postings_fact
JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg is NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
   
/*Cross-functional expertise is highly valued — Data Analysts with skills beyond traditional analytics, such as infrastructure and automation, earn higher salaries.

Specialized or niche technologies like Solidity (blockchain) and Couchbase (NoSQL) command top pay due to low supply and high demand.

Machine learning frameworks such as PyTorch, TensorFlow, Keras, and Hugging Face are common among top-paying skills, reflecting the shift toward AI and data science integration in analyst roles.

DevOps and MLOps tools like Terraform, Airflow, Puppet, and Ansible are increasingly important, showing that deployment and pipeline automation is a growing part of the analyst’s job.

Version control and collaboration platforms like GitLab, Bitbucket, Atlassian, and Notion highlight the need for team-based, reproducible workflows in data projects.

Legacy tools such as SVN and Perl still yield high pay in specific, often consulting-based or migration-focused roles, though they are outliers.

Overall, the highest-paid Data Analysts blend data skills with engineering, machine learning, and systems thinking — showing a clear trend toward technical, hybrid roles
