--Tableau Visualization can be found at https://public.tableau.com/app/profile/renee.veleva

--1
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From coviddeath
where continent is not null 
order by 1,2

--2
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From coviddeath
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

--3
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  
Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeath
Group by Location, Population
order by PercentPopulationInfected desc

--4
Select Location, Population,dates, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeath
Group by Location, Population, dates
order by PercentPopulationInfected desc
