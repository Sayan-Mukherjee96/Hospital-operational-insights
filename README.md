🏥 Hospital Operational Insights


📖 Overview
A data analytics project to analyse the pattern of hospital visits, repeat and time duration to optimise the flow and use of resources.

❗ Problem Statement
Hospitals often struggle with overcrowding, long patient encounter durations, frequent repeat visits, and inefficient resource utilization. When decisions are made without data-driven insights, it becomes difficult to identify high-impact patients, peak demand periods, and the services that place the greatest operational strain on the hospital.

This project aims to address these challenges through structured data analysis and evidence-based insights.


🗂️ Dataset

The analysis uses a relational hospital dataset containing five tables:

encounters – Patient visits, encounter class, start & stop time, start & stop date

patients – Patient demographics (age, gender, etc.)

procedures – Medical procedures linked to encounters

organizations – Hospital and healthcare provider details

payers – Insurance and payer information

🛠️ Tools and Technologies

SQL (MySQL) – Data extraction, transformation, and analysis

Excel – Visualization

🧪 Methods

SQL joins across multiple tables

Aggregations and grouping

Window functions (NTILE, COUNT, MAX)

CTE (Common Table Expression)

Subquery

Time‑based analysis using encounter durations

Segmentation of patients by age groups and visit frequency

Percentage contribution analysis (Top 20% patients)

🔍 Key Insights
Assessment and screening procedures account for the highest share of patient encounters.

Emergency and ambulatory encounters show the most extreme variations in encounter duration.

Patients aged 75 and above contribute the highest number of hospital visits.

Patient volume peaked notably in 2014 and 2021, indicating periods of increased demand.

The top 20% of patients account for nearly 68% of all hospital encounters.

Ambulatory and outpatient encounter classes contribute the most to repeat patient visits.

✅ Results & Conclusion
The discussion indicates that a few patients with a high frequency make up a high percentage of the workload of the hospital. The majority of interventions associated with long encounters include emergency and critical care processes. Identifying such patterns assists hospitals in streamlining the patient flow, improving the staffing schedule, and reducing operating pressures.

🔮 Future Work
Predictive modeling for patient inflow forecasting
Deeper analysis of payer and insurance impact

👤 Author & Contact
Author: Sayan Mukherjee
Role: Aspiring Data Analyst | Junior Data Analyst | Business Analyst
Skills: SQL, Data Analysis, Python, Excel, Power BI, Tableau, Data Visualization, Data Storytelling
Email: sayanmukherjee010196@gmail.com
