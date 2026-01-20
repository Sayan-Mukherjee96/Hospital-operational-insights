create database Hospital_Db;

Use Hospital_Db;

select * from organizations;

select * from payers;

select * from patients;

select * from procedures;

select * from encounters;

/*Which procedures account for the highest number of patient encounters?*/

select DESCRIPTION as `Procedure`, count(EncounterID) as Total_Patients_Encounter
from procedures
group by DESCRIPTION
order by Total_Patients_Encounter desc
limit 10;

/*How has encounter volume changed year-over-year by procedure type?*/

SELECT EXTRACT(YEAR FROM `START DATE`) AS year, DESCRIPTION as Procedure_Name, COUNT(distinct EncounterID) AS Total_Encounter
FROM procedures
GROUP BY year, DESCRIPTION
ORDER BY  year;

/*Which time periods (year) experience peak patient volume?*/

select extract(YEAR FROM `START DATE`) as Year, count(PatientID) as Total_Patient
from encounters
group by year
order by Total_Patient desc;

/*Which encounters show extreme durations*/

select ENCOUNTERCLASS, Encounter_Time_Duration, Encounter_Duration
from ( select ENCOUNTERCLASS, timestampdiff(Minute,`START TIME`,`STOP TIME`) as Encounter_Time_Duration,
case when timestampdiff(Minute,`START TIME`,`STOP TIME`) between 15 and 50 then 'Standard Duration'
     when timestampdiff(Minute,`START TIME`,`STOP TIME`) between 51 and 97 then 'Expected Duration'
     when timestampdiff(Minute,`START TIME`,`STOP TIME`) between 98 and 389 then 'Average Duration'
     when timestampdiff(Minute,`START TIME`,`STOP TIME`) between 390 and 484 then 'Above-Avg Duration'
     when timestampdiff(Minute,`START TIME`,`STOP TIME`) between 485 and 780 then 'Extreme Duration'
     else 'Outlier Duration'
     end as Encounter_Duration
     from encounters)t
     where Encounter_Duration = 'Extreme Duration';
     
/*Are certain age groups more likely to have frequent visits*/

select case when Age between 0 and 17 then '0 - 17(Child)'
			when Age between 18 and 35 then '18 - 35(Young Adult)'
            when Age between 36 and 59 then '36 - 59(Adult)'
            when Age between 60 and 75 then '60 - 75(Senior)'
			else '+75 (Elderly)'
            end as Age_Group, sum(No_of_Visits) as Total_Visits
from (select p.PatientID, timestampdiff(year, p.BIRTHDATE, curdate()) as Age, count(e.EncounterID) as No_of_Visits
     from encounters as e inner join patients as p on p.PatientID = e.PatientID
     group by p.PatientID, Age
     ) t 
group by Age_Group;

/* Which Procedure are associated with both Patient volume and Extreme encounter duration*/

select DESCRIPTION as Procedure_Name, Encounter_Duration, count(distinct PatientID) as Total_Patient
from(select p.DESCRIPTION, e.PatientID,
case when timestampdiff(Minute,e.`START TIME`,e.`STOP TIME`) between 15 and 50 then 'Standard Duration'
     when timestampdiff(Minute,e.`START TIME`,e.`STOP TIME`) between 51 and 97 then 'Expected Duration'
     when timestampdiff(Minute,e.`START TIME`,e.`STOP TIME`) between 98 and 389 then 'Average Duration'
     when timestampdiff(Minute,e.`START TIME`,e.`STOP TIME`) between 390 and 484 then 'Above-Avg Duration'
     when timestampdiff(Minute,e.`START TIME`,e.`STOP TIME`) between 485 and 780 then 'Extreme Duration'
     else 'Outlier Duration'
     end as Encounter_Duration
from procedures as p join encounters as e on e.EncounterID = p.EncounterID) t
group by DESCRIPTION, Encounter_Duration
having Encounter_Duration = 'Extreme Duration'
order by Total_Patient desc;

/*What Percentage of Encounter come from the top 20% of Patients*/

with patient_encounter as(
select count(EncounterID) as total_encounter, PatientID
from encounters
group by PatientID
), 
ranked_patient as (
select PatientID, total_encounter,
ntile(5) over (order by total_encounter desc)  as patient_group
from patient_encounter
)
select CONCAT(ROUND(100.0 * SUM(case when patient_group = 1 then total_encounter else 0 end) / SUM(total_encounter),2),'%')as percentage_encounter
from ranked_patient;

/*Which encounter class contributes most to repeat patient visits?*/

select ENCOUNTERCLASS, count(*) as Repeat_Encounter
from(select PatientID, ENCOUNTERCLASS
from encounters
group by PatientID, ENCOUNTERCLASS
having count(EncounterID) > 1
) t
group by ENCOUNTERCLASS
order by Repeat_Encounter desc;
