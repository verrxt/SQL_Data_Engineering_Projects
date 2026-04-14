/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count,
    ROUND(
        (COUNT(jpf.*)/SUM(COUNT(jpf.*)) 
        OVER())*100, 1
        )::VARCHAR || '%' AS demand_percent
FROM
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
Key takeaways:
1. SQL & Python dominate (20.2% combined) – essential foundation.
2. Cloud platforms (AWS 6.2%, Azure 4.9%, GCP 2.2%) – remote roles favor cloud-native skills.
3. Big data & orchestration: Spark (4.4%), Airflow (3.5%) – critical for pipelines.
4. Modern data platforms: Snowflake (3.0%), Databricks (2.8%) – rapidly growing.
5. Java (2.5%) – still relevant for JVM-based tools like Spark/Kafka.

The top 10 skills cover ~49.7% of all skill mentions in remote Data Engineer postings.
┌────────────┬──────────────┬────────────────┐
│   skills   │ demand_count │ demand_percent │
│  varchar   │    int64     │    varchar     │
├────────────┼──────────────┼────────────────┤
│ sql        │        29221 │ 10.2%          │
│ python     │        28776 │ 10.0%          │
│ aws        │        17823 │ 6.2%           │
│ azure      │        14143 │ 4.9%           │
│ spark      │        12799 │ 4.4%           │
│ airflow    │         9996 │ 3.5%           │
│ snowflake  │         8639 │ 3.0%           │
│ databricks │         8183 │ 2.8%           │
│ java       │         7267 │ 2.5%           │
│ gcp        │         6446 │ 2.2%           │
└────────────┴──────────────┴────────────────┘
*/