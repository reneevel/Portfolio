/* Covid-19 Data Exploration using PostgresSQL

Skills Used: Joins, CTE's, Temp Tables, Windows Function, Aggregate Functions, Views, Converting Data Types

*/

--create covid deaths table 

create table coviddeath
(iso_code varchar (50),
 continent varchar (50),
 location varchar (100),
 dates DATE,
 population bigint,
 total_cases numeric,
 new_cases NUMERIC,
 new_cases_smoothed numeric,
 total_deaths numeric,	
 new_deaths numeric,
 new_deaths_smoothed numeric,
 total_cases_per_million numeric,
 new_cases_per_million numeric,
 new_cases_smoothed_per_million numeric,
 total_deaths_per_million numeric,
 new_deaths_per_million	numeric,
 new_deaths_smoothed_per_million numeric,
 reproduction_rate numeric,
 icu_patients numeric, 
 icu_patients_per_million numeric,
 hosp_patients	numeric,
 hosp_patients_per_million numeric,
 weekly_icu_admissions numeric,
 weekly_icu_admissions_per_million	numeric,
 weekly_hosp_admissions	numeric,
 weekly_hosp_admissions_per_million	 numeric,
 total_tests numeric)
 
 select * from coviddeaths

copy coviddeath from 
'C:\Users\Renee Veleva\Documents\coviddeaths.csv' delimiter
',' csv header;

--create covidvaccinations table

 Create table covidvaccination
(iso_code varchar (50),
 continent varchar (50),
 location varchar (100),
 dates DATE, 
 total_tests numeric,	
 new_tests numeric,
 total_tests_per_thousand numeric,
 new_tests_per_thousand	numeric,
 new_tests_smoothed	numeric,
 new_tests_smoothed_per_thousand numeric,
 positive_rate	numeric,
 tests_per_case numeric,
 tests_units varchar(100),
 total_vaccinations numeric,
 people_vaccinated numeric,
 people_fully_vaccinated numeric,
 total_boosters	numeric,
 new_vaccinations numeric,
 new_vaccinations_smoothed numeric,
 total_vaccinations_per_hundred	numeric,
 people_vaccinated_per_hundred	numeric,
 people_fully_vaccinated_per_hundred	numeric,
 total_boosters_per_hundred	 numeric,
 new_vaccinations_smoothed_per_million	numeric,
 new_people_vaccinated_smoothed	numeric,
 new_people_vaccinated_smoothed_per_hundred	 numeric,
 stringency_index numeric,
 population_density	numeric,
 median_age	numeric,
 aged_65_older	numeric,
 aged_70_older numeric,
 gdp_per_capita	numeric,
 extreme_poverty numeric,
 cardiovasc_death_rate	numeric,
 diabetes_prevalence	numeric,
 female_smokers	numeric,
 male_smokers numeric,
 handwashing_facilities	numeric,
 hospital_beds_per_thousand	numeric,
 life_expectancy	numeric,
 human_development_index numeric,
 excess_mortality_cumulative_absolute numeric,
 excess_mortality_cumulative numeric,
 excess_mortality numeric,
 excess_mortality_cumulative_per_million numeric)
 
  copy covidvaccination from 'C:\Users\Renee Veleva\Documents\covidvaccinations.csv'
 delimiter ',' csv header;
 
/*total cases vs total deaths
 Death percentage is likelihood of dying if you contract covid in your country */

 select location, dates, total_cases, total_deaths, 
 (total_deaths/total_cases)*100 as death_percentage
 from coviddeath
order by 1, 2

 select location, dates, total_cases, total_deaths, 
 (total_deaths/total_cases)*100 as death_percentage
 from coviddeath
 where location = 'United States'
order by 1, 2

/* total cases vs population
Shows percentage of population who were confirmed infected with covid */

 select location, dates, population, total_cases,  
 (total_cases/population)*100 as percentpopulationinfected
 from coviddeath
order by 1, 2

 select location, dates, population, total_cases,  
 (total_cases/population)*100 as percentpopulationinfected
 from coviddeath
 where location = 'Bulgaria'
order by 1, 2

--countries with highest infection rates compared to population

 select location, population, max(total_cases) as highestinfectioncounty,  
 max((total_cases/population))*100 as percentpopulationinfected
 from coviddeath
 group by population, location
order by percentpopulationinfected desc

--countries with the highest death count per population

select location, max(total_deaths) as totaldeathcounts
from coviddeath 
group by location
order by totaldeathcounts desc

--need to cast to integer data TYPE

select location, 
max(cast(total_deaths as integer)) as totaldeathcounts
from coviddeath 
where continent is not NULL
group by location
order by totaldeathcounts desc

--resolve issue with grouping continent

select * from coviddeath
where continent is not NULL
order by 3, 4

--BREAK DOWN BY CONTIENT

--countries with highest death counts per population

select continent, 
max(cast(total_deaths as integer)) as totaldeathcounts
from coviddeath 
where continent is not NULL
--and location not like '%income%'
group by continent
order by totaldeathcounts desc

--global numbers for new cases  and new deaths

 select dates, 
 sum( new_cases) as totalnewcases,
 sum(cast(new_deaths as integer)) as totalnewdeaths
 from coviddeath
 where continent is not NULL
 group by dates
order by 1, 2

--death percentage GLOBALLY

 select dates, 
 sum(new_cases) as totalnewcases,
 sum(new_deaths) as totalnewdeaths,
sum(new_deaths)/sum(nullif(new_cases,0))*100 as deathpercentage
from coviddeath
 group by dates
 order by dates
 
 --total global
 
  select
 sum(new_cases) as totalnewcases,
 sum(new_deaths) as totalnewdeaths,
sum(new_deaths)/sum(nullif(new_cases,0))*100 as deathpercentage
from coviddeath
--group by dates
-- order by dates

--join TABLES

select * from covidvaccination as vac
join coviddeath as dea
on 
vac.location=dea.location 
and vac.dates=dea.dates

/* total population vs vaccination
specify what table to pull from */

select dea.continent, dea.location, dea.dates, 
dea.population, vac.new_vaccinations
from coviddeath as dea
join covidvaccination as vac
on 
vac.location=dea.location 
and vac.dates=dea.dates
where dea.continent is not null
order by 1, 2, 3

--to calculate total vaccinations per country

select dea.continent, dea.location, dea.dates, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as integer)) over (partition by dea.location)
from coviddeath as dea
join covidvaccination as vac
on 
vac.location=dea.location 
and vac.dates=dea.dates
where dea.continent is not null
order by 2, 3

--to add up every DAY
select dea.continent, dea.location, dea.dates, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as integer)) 
over (partition by dea.location order by dea.location, dea.dates) as rollingpeoplevaccinated
from coviddeath as dea
join covidvaccination as vac
on 
vac.location=dea.location 
and vac.dates=dea.dates
where dea.continent is not null
order by 2, 3

--new vaccinations vs population

with popvsvac (continent, location, dates, population, new_vaccinations, rollingpeoplevaccinated)
as
(select dea.continent, dea.location, dea.dates, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as integer)) 
over (partition by dea.location order by dea.location, dea.dates) as rollingpeoplevaccinated
from coviddeath as dea
join covidvaccination as vac
on 
vac.location=dea.location 
and vac.dates=dea.dates
where dea.continent is not null
order by 2, 3)

--Using CTE to perform Calculation on Partition By in previous query
with popvsvac (continent, location, dates, population, new_vaccinations, rollingpeoplevaccinated)
as
(
	select dea.continent, dea.location, dea.dates, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as integer)) 
over (partition by dea.location order by dea.location, dea.dates) as rollingpeoplevaccinated
from coviddeath as dea
join covidvaccination as vac
on 
vac.location=dea.location 
and vac.dates=dea.dates
where dea.continent is not null
--order by 2, 3
)
select *, (rollingpeoplevaccinated/population)*100 from popvsvac

--Using Temp Table to perform Calculation on Partition By in previous query

drop table if exists percentpopulationvaccinated
 
create table percentpopulationvaccinated
(continent varchar (255),
location varchar (255),
dates date,
population numeric,
new_vaccinations numeric,
rollingpeoplevaccinated numeric)

insert into percentpopulationvaccinated
	select dea.continent, dea.location, dea.dates, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as integer)) 
over (partition by dea.location order by dea.location, dea.dates) as rollingpeoplevaccinated
from coviddeath as dea
join covidvaccination as vac
on 
vac.location=dea.location 
and vac.dates=dea.dates
where dea.continent is not null
--order by 2, 3

select *, (rollingpeoplevaccinated/population)*100 from percentpopulationvaccinated

--VIEW to store data for later visualizations
create view percentpopulationvaccinatedd as
select dea.continent, dea.location, dea.dates, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as integer)) 
over (partition by dea.location order by dea.location, dea.dates) as rollingpeoplevaccinated
from coviddeath as dea
join covidvaccination as vac
on 
vac.location=dea.location 
and vac.dates=dea.dates
where dea.continent is not null
--order by 2, 3
