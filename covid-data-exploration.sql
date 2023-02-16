/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

SELECT *
FROM covid_deaths
ORDER BY 3,4;

/* Select the data to be used */
SELECT location, `date`, total_cases, new_cases, total_deaths, population
  FROM covid_deaths
  WHERE continent IS NOT NULL
  ORDER BY 1,2;
  
  -- Total cases vs Total Deaths
  /* shows liklihood of dying if covid in contracted in your country */
  SELECT location, `date`, total_cases, total_deaths, (total_deaths / total_cases) * 100 AS death_percentage
  FROM covid_deaths
  WHERE location LIKE '%states%'
  ORDER BY 1,2;
  
  -- Total cases vs Population
  /* what percentage of population was infected */
  SELECT location, `date`, total_cases, population, (total_cases / population) * 100 AS infected_percentage
  FROM covid_deaths
  WHERE location LIKE '%states%'
  AND WHERE continent IS NOT NULL
  ORDER BY 1,2;
  
  -- Countries with highest infection rate comapred to population
  SELECT location, MAX(total_cases) AS highest_infection_count, population, MAX((total_cases / population)) * 100 AS infected_percentage
  FROM covid_deaths
  WHERE continent IS NOT NULL
  GROUP BY location, population
  ORDER BY infected_percentage DESC;
  
  -- Countries with hightest death count per population
  SELECT location, MAX(CAST(total_deaths AS DECIMAL)) AS total_death_count
  FROM covid_deaths
  WHERE continent IS NOT NULL
  GROUP BY location
  ORDER BY total_death_count DESC;
  
  -- Break down by continent
  /*
  select location, MAX(cast(total_deaths as DECIMAL)) as total_death_count
  from covid_deaths
  where continent is null
  group by location
  order by total_death_count desc;
  */
  
  -- Continents with highest death count
  SELECT continent, MAX(CAST(total_deaths AS DECIMAL)) AS total_death_count
  FROM covid_deaths
  WHERE continent IS NOT NULL
  GROUP BY continent
  ORDER BY total_death_count DESC;
  
  -- GLOBAL NUMBERS
  SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS DECIMAL)) AS total_deaths, SUM(CAST(new_deaths AS DECIMAL)) / SUM(new_cases) * 100 AS death_percentage
  FROM covid_deaths
  WHERE continent IS NOT NULL
  ORDER BY 1,2;
  /*
  select `date`, sum(new_cases) as total_cases, sum(cast(new_deaths as decimal)) as total_deaths, sum(cast(new_deaths as decimal)) / sum(new_cases) * 100 as death_percentage
  from covid_deaths
  where continent is not null
  group by `date`
  order by 1,2;
  */
  
  -- Total population vs vaccination
  SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
    FROM covid_deaths dea
    JOIN covid_vaccinations vac
      ON dea.location = vac.location
      AND dea.date = vac.date
  WHERE dea.continent IS NOT NULL
  ORDER BY 1,2,3;
  
  
  
  
  
  
  