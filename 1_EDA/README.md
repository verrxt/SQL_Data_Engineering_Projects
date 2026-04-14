# 🔍 Exploratory Data Analysis (SQL) — Job Market Breakdown

![EDA Project Overview](../Images\EDA.png)

A SQL-based analysis of the data engineer job market, focused on identifying **which skills actually matter** — not just which ones appear most frequently.

---

## 🧾 Executive Summary

This project analyzes job posting data to separate **high-demand skills from high-value skills**, and identify where they overlap.

- Extracted insights using **multi-table analytical SQL queries**
- Compared **skill demand vs compensation**
- Designed an **“optimal skill score”** combining demand and salary

→ Outcome: A clearer view of **which skills maximize both opportunity and pay**

---

## 🧠 Why I Built This

Most EDA projects stop at counting.

This one focuses on **decision-making**:
- What skills are actually worth learning?
- Which ones are oversaturated vs high-leverage?

The goal was to move from raw data → **practical insight**.

---

## 🧩 Problem & Context

Job market data is noisy — frequency alone doesn’t equal value.

This project answers:

- 🎯 What skills are **most in demand**?
- 💰 Which skills are **highest paying**?
- ⚖️ What is the **best trade-off between demand and salary**?

The dataset is structured as a **star schema**, enabling efficient joins between job postings and their associated skills.

![Data Warehouse Schema](../Images\Data_Warehouse.png)

### Data Model

- **Fact Table:** `job_postings_fact` — core job data (title, salary, location, etc.)
- **Dimension Tables:**
  - `company_dim` — company metadata
  - `skills_dim` — skill definitions
- **Bridge Table:**
  - `skills_job_dim` — resolves many-to-many relationship between jobs and skills

---

## 🧰 Tech Stack

- 🐤 DuckDB — fast local OLAP query engine  
- 🧮 SQL — joins, aggregations, analytical logic  
- 📊 Data Model — star schema (fact + dimension + bridge)  
- 🛠️ VS Code + CLI — development workflow  
- 📦 GitHub — version control  

---

## 📂 Repository Structure

```text
1_EDA/
├── 01_demand_analysis.sql
├── 02_salary_analysis.sql
├── 03_skill_optimization.sql
└── README.md
```

## 🏗 Analysis Overview

### How the Analysis Builds

- **Demand Layer** → Identify the most frequently requested skills  
- **Salary Layer** → Determine which skills command the highest pay  
- **Optimization Layer** → Combine both to evaluate overall skill value  

Each step moves from raw counts → compensation → decision-oriented insight.

---

## 🔑 Key Insights

- 🧠 SQL and Python dominate demand, but function more as **baseline requirements** than differentiators  
- ☁️ Cloud platforms (AWS, Azure) consistently appear in **higher-paying roles**  
- 🧱 Infrastructure tools (Docker, Kubernetes, Terraform) correlate with **premium salaries**  
- 🔥 Apache Spark stands out as a **high-demand, high-pay skill**, making it one of the strongest leverage points  

---

## 💻 SQL Skills Demonstrated

### Query Design

- Multi-table `INNER JOIN` across fact and dimension tables  
- Structured queries for clarity and reuse  

### Data Analysis

- Aggregations using `COUNT()`, `MEDIAN()`, `ROUND()`  
- Filtering with precise `WHERE` conditions  
- Grouping via `GROUP BY` for skill-level insights  
- `HAVING` to filter meaningful aggregates  

### Analytical Techniques

- Log transformation using `LN()` to normalize demand  
- Derived metrics combining demand and salary  
- Ranking and sorting for top-N analysis  

### Advanced SQL Usage

- Applied `OVER()` for window-based analysis 
- Used `::VARCHAR` for explicit and controlled type casting  
- Built formatted outputs using string concatenation (`||`)  

---

## 📌 Key Queries

- [`01_demand_analysis.sql`](.\01_demand_analysis.sql) → Skill demand analysis  
- [`02_salary_analysis.sql`](.\02_salary_analysis.sql) → Salary insights  
- [`03_skill_optimization.sql`](.\03_skill_optimization.sql) → Combined scoring model  

---

## ⚡ Final Takeaway

High demand doesn’t always mean high value.

This project highlights where **demand, salary, and practical relevance intersect** — giving a clearer direction on what skills are actually worth investing in.