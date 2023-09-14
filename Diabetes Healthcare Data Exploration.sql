/*Diabetes Healthcare Data Exploration */

create table diabetes 
(Id numeric,
Pregnancies numeric,
Glucose numeric,
BloodPressure numeric,
SkinThickness numeric,
Insulin numeric,
BMI numeric,
DiabetesPedigreeFunction numeric,
Age numeric,
Outcome numeric,
DiabetesOutcome varchar (100) )



copy diabetes from 'C:\Users\Renee Veleva\Documents\diabetes.csv' csv header

select * from diabetes


select * from diabetes order by diabetesoutcome desc

--Average health indicators based on whether person has diabetes or not--

select diabetesoutcome, avg(pregnancies) as avg_pregnancies, avg(glucose) as avg_glucose, 
avg(bloodpressure) as avg_bloodpressure, avg(insulin) as avg_insulin, avg(bmi) as avg_bmi
from diabetes
group by diabetesoutcome

--Total diabetics in dataset
select count(diabetesoutcome) as totaldiabetics 
from diabetes
where diabetesoutcome = 'Diabetes Present' 

--Total diabetics and nondiabetics in dataset
select diabetesoutcome, count(diabetesoutcome) as total
from diabetes
group by diabetesoutcome

 --Analyze correlation between bmi, weight class, and diabetes outcome
select bmi, diabetesoutcome, case 
when bmi > 30 then 'Obese'
when bmi between 25 and 30 then 'Overweight'
when bmi < 25 then 'Healthy Weight'
end as bmi_category
from diabetes
where bmi <>0
order by bmi_category

select 
case 
when bmi > 30 then 'Obese'
when bmi between 25 and 30 then 'Overweight'
when bmi < 25 then 'Healthy Weight'
end as bmi_category, count(diabetesoutcome), diabetesoutcome 
from diabetes
where bmi <>0
group by case 
when bmi > 30 then 'Obese'
when bmi between 25 and 30 then 'Overweight'
when bmi < 25 then 'Healthy Weight'
end, diabetesoutcome
order by bmi_category

--analyze age onset of diabetes
select age, DiabetesOutcome, 
case 
when age >60 then 'Old'
when age between 40 and 60 then 'Middle Age'
when age between 30 and 40 then 'Adult'
when age between 20 and 30 then 'Young Adult'
when age < 20 then 'Young'
end as age_category
from diabetes

select age, DiabetesOutcome, 
case 
when age >60 then 'Old'
when age between 40 and 60 then 'Middle Age'
when age between 30 and 40 then 'Adult'
when age between 20 and 30 then 'Young Adult'
when age < 20 then 'Young'
end as age_category
from diabetes
where diabetesoutcome= 'Diabetes Present'
order by age_category

select
case 
when age >60 then 'Old'
when age between 40 and 60 then 'Middle Age'
when age between 30 and 40 then 'Adult'
when age between 20 and 30 then 'Young Adult'
when age < 20 then 'Young'
end as age_category, diabetesoutcome,
count(DiabetesOutcome) as outcome_count
from diabetes
group by case when age >60 then 'Old'
when age between 40 and 60 then 'Middle Age'
when age between 30 and 40 then 'Adult'
when age between 20 and 30 then 'Young Adult'
when age < 20 then 'Young'
end, diabetesoutcome
order by age_category

/* Analyze Blood Pressure Levels (diastolic mm Hg) and 
Glucose Levels (Plasma Glucose Levels over 2 hours in an oral glucose tolerance test) 
in correlation to diabetes */
select 
case 
when bmi > 30 then 'Obese'
when bmi between 25 and 30 then 'Overweight'
when bmi < 25 then 'Healthy Weight'
end as bmi_category, count(diabetesoutcome), diabetesoutcome 
from diabetes
where bmi <>0
group by case 
when bmi > 30 then 'Obese'
when bmi between 25 and 30 then 'Overweight'
when bmi < 25 then 'Healthy Weight'
end, diabetesoutcome
order by bmi_category

select case when glucose >100 then 'High Glucose'else 'Normal Glucose' end as glucose_levels,
case when bloodpressure > 90 then 'High Blood Pressure' else 'Normal Blood Pressure' end as blood_pressure_levels, 
count(diabetesoutcome) ,diabetesoutcome
from diabetes
where glucose <>0 and bloodpressure <>0
group by case when glucose >100 then 'High Glucose'else 'Normal Glucose' end,
case when bloodpressure > 90 then 'High Blood Pressure' else 'Normal Blood Pressure' end , diabetesoutcome

--Glucose and Insulin 
select case when glucose >100 then 'High Glucose'else 'Normal Glucose' end as glucose_levels,
case when insulin < 25 then 'Normal Insulin Levels' else 'High Insulin Levels' end as insulin_levels, 
count(diabetesoutcome) ,diabetesoutcome
from diabetes
where glucose <>0 and bloodpressure <>0
group by case when glucose >100 then 'High Glucose'else 'Normal Glucose' end,
case when insulin < 25 then 'Normal Insulin Levels' else 'High Insulin Levels' end  , diabetesoutcome

--Analyze correlation between number of pregnancies and diabetes
select pregnancies, bmi, DiabetesOutcome
from diabetes
where pregnancies <>0


select pregnancies, diabetesoutcome, count(DiabetesOutcome)
from diabetes
--where pregnancies <>0
group by pregnancies, diabetesoutcome
order by pregnancies asc

--------------------------------------------------------------------------------------------------------------------

/* Codes used for Tableau */

--"Diabetic Indicators"

select diabetesoutcome, avg(pregnancies) as avg_pregnancies, avg(glucose) as avg_glucose, 
avg(bloodpressure) as avg_bloodpressure, avg(insulin) as avg_insulin, avg(bmi) as avg_bmi
from diabetes
group by diabetesoutcome

--"Body Mass Index"

select 
case 
when bmi > 30 then 'Obese'
when bmi between 25 and 30 then 'Overweight'
when bmi < 25 then 'Healthy Weight'
end as bmi_category, count(diabetesoutcome), diabetesoutcome 
from diabetes
where bmi <>0
group by case 
when bmi > 30 then 'Obese'
when bmi between 25 and 30 then 'Overweight'
when bmi < 25 then 'Healthy Weight'
end, diabetesoutcome
order by bmi_category

--"Age Demographics"

select
case 
when age >60 then 'Old'
when age between 40 and 60 then 'Middle Age'
when age between 30 and 40 then 'Adult'
when age between 20 and 30 then 'Young Adult'
when age < 20 then 'Young'
end as age_category, diabetesoutcome,
count(DiabetesOutcome) as outcome_count
from diabetes
group by case when age >60 then 'Old'
when age between 40 and 60 then 'Middle Age'
when age between 30 and 40 then 'Adult'
when age between 20 and 30 then 'Young Adult'
when age < 20 then 'Young'
end, diabetesoutcome
order by age_category

--"Glucose and Blood Pressure"

select case when glucose >100 then 'High Glucose'else 'Normal Glucose' end as glucose_levels,
case when bloodpressure > 90 then 'High Blood Pressure' else 'Normal Blood Pressure' end as blood_pressure_levels, 
count(diabetesoutcome) ,diabetesoutcome
from diabetes
where glucose <>0 and bloodpressure <>0
group by case when glucose >100 then 'High Glucose'else 'Normal Glucose' end,
case when bloodpressure > 90 then 'High Blood Pressure' else 'Normal Blood Pressure' end , diabetesoutcome

--"Glucose and Insulin"

select case when glucose >100 then 'High Glucose'else 'Normal Glucose' end as glucose_levels,
case when insulin < 25 then 'Normal Insulin Levels' else 'High Insulin Levels' end as insulin_levels, 
count(diabetesoutcome) ,diabetesoutcome
from diabetes
where glucose <>0 and bloodpressure <>0
group by case when glucose >100 then 'High Glucose'else 'Normal Glucose' end,
case when insulin < 25 then 'Normal Insulin Levels' else 'High Insulin Levels' end  , diabetesoutcome

--"Number of Pregnancies"

select pregnancies, diabetesoutcome, count(DiabetesOutcome)
from diabetes
--where pregnancies <>0
group by pregnancies, diabetesoutcome
order by pregnancies asc
