SELECT *
FROM covid_deaths
ORDER BY 3,4;
/*
select *
from covid_vaccinations
order by 3,4;
*/

/* Select the data to be used */
SELECT location, `date`, total_cases, new_cases, total_deaths, population
  FROM covid_deaths;