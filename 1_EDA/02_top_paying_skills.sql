/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.salary_year_avg) AS demand_count,
    ROUND(
        (COUNT(jpf.salary_year_avg)/SUM(COUNT(jpf.salary_year_avg)) 
        OVER())*100, 1
        )::VARCHAR || '%' AS demand_percent
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.salary_year_avg) >= 10
    AND COUNT(sd.skills)>=100
ORDER BY
    median_salary DESC
LIMIT 25;

/*
Key insights:
1. Top pay: Rust ($210k), Golang/Terraform ($184k), Spring ($175.5k) – all low volume except Terraform (n=193)
2. Best pay + demand combo: Terraform (n=193, 1.7%), Kubernetes (n=147, 1.3%), Airflow (n=386, 3.4%), Kafka (n=292, 2.6%)
3. Spark leads volume (n=503, 4.5%) at $140k – solid but not top-tier pay
4. Git appears ($140k, n=208, 1.9%) – version control as a paid skill? Unusual but data reflects remote DE roles

Takeaway: Prioritize Terraform, Airflow, Kafka for high pay + opportunity. Spark for volume. Rust/Golang for niche premium roles.
┌────────────┬───────────────┬──────────────┬────────────────┐
│   skills   │ median_salary │ demand_count │ demand_percent │
│  varchar   │    double     │    int64     │    varchar     │
├────────────┼───────────────┼──────────────┼────────────────┤
│ rust       │      210000.0 │           23 │ 0.2%           │
│ golang     │      184000.0 │           39 │ 0.3%           │
│ terraform  │      184000.0 │          193 │ 1.7%           │
│ spring     │      175500.0 │           33 │ 0.3%           │
│ neo4j      │      170000.0 │           11 │ 0.1%           │
│ gdpr       │      169616.0 │           22 │ 0.2%           │
│ zoom       │      168438.0 │           12 │ 0.1%           │
│ graphql    │      167500.0 │           28 │ 0.2%           │
│ mongo      │      162250.0 │           14 │ 0.1%           │
│ c          │      151500.0 │           23 │ 0.2%           │
│ typescript │      151000.0 │           39 │ 0.3%           │
│ kubernetes │      150500.0 │          147 │ 1.3%           │
│ node       │      150000.0 │           22 │ 0.2%           │
│ ruby       │      150000.0 │           48 │ 0.4%           │
│ css        │      150000.0 │           13 │ 0.1%           │
│ airflow    │      150000.0 │          386 │ 3.4%           │
│ redis      │      149000.0 │           17 │ 0.2%           │
│ ansible    │      148798.0 │           14 │ 0.1%           │
│ jupyter    │      147500.0 │           15 │ 0.1%           │
│ kafka      │      145000.0 │          292 │ 2.6%           │
│ go         │      140000.0 │          113 │ 1.0%           │
│ outlook    │      140000.0 │           11 │ 0.1%           │
│ spark      │      140000.0 │          503 │ 4.5%           │
│ word       │      140000.0 │           92 │ 0.8%           │
│ git        │      140000.0 │          208 │ 1.9%           │
└────────────┴───────────────┴──────────────┴────────────────┘
*/