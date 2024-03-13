-- select all records in the country table
select * from country;

-- get country name and continent from country
select Name, Continent from country;

-- get country name, continent and surface from country
select Name, Continent, SurfaceArea from country;

-- Regions in country table 
select Region from country;

-- Regions in country table without repetitions
select distinct Region from country;

-- 12- select countries which are in Europe or Asia
select Name, Continent from country where Continent ='Europe' or Continent='Asia';
select Name, Continent from country where Continent in ('Europe','Asia');

-- 19- select countries which are NOT in Europe or Asia
select Name, Continent from country where Continent !='Europe' and Continent !='Asia';
select Name, Continent from country where Continent not in ('Europe','Asia');

-- 20-countries (just name) without indication of independence year
select Name from country where IndepYear is null;

-- Countries (name and population) whose population is greater than 500,000 and 1,000,000
select Name, Population from country where Population between 500000 and 1000000;

-- 22- Countries which are a Republic
select Name, GovernmentForm from country where GovernmentForm='Republic';
select Name, GovernmentForm from country where GovernmentForm like '%Republic%'; 

--  23- Countries that are not in America
select Name,Continent from country where Continent not like '%America%';

--  26- Countries whose name end in 'stan'
select Name from country where Name like '%stan';

-- 29-number of countries
select count(*) from country;

-- 29-number of countries in Europe
select count(*) from country
where Continent like 'Europe';

-- 30- number of regions
select count(distinct(Region)) from country;

-- 31- rename columns
select count(distinct(Region)) as 'Number of Regions' from country;

-- 32- total population of Europe
select sum(Population) from country
where Continent='Europe';

-- 33-average life expectancy in Europe
select avg(LifeExpectancy) as 'Average life expectancy' from country 
where Continent='Europe';

-- 34 biggest and smallest (area) countries in Europe
Select max(SurfaceArea) as 'Biggest', min(SurfaceArea) as 'Smallest' from country where Continent='Europe';
-- select Name from country where SurfaceArea=Max(SurfaceArea);
-- 36-average life expectancy per continent
select Continent, avg(LifeExpectancy) as 'Average life expectancy' from country 
group by Continent;

select Continent, avg(LifeExpectancy) as 'Average life expectancy', avg(SurfaceArea) from country 
group by Continent;

select Continent, avg(LifeExpectancy) as 'Average life expectancy', max(LifeExpectancy), min(LifeExpectancy) from country 
group by Continent;

-- 39- average lfe axpectancy in north and south america
select Continent, avg(LifeExpectancy) as 'Average life expectancy' from country 
where SurfaceArea<200000
group by Continent
having Continent like '%America%';

select Name, SurfaceArea, Continent, LifeExpectancy from country 
where SurfaceArea>200000
and Continent like '%America%';

-- 42- countries and their area ordered frm the biggest to the smallest
select Name, SurfaceArea 
from country
order by Surfacearea desc;

select Name, Continent, SurfaceArea 
from country
order by Continent asc, SurfaceArea desc;

-- 42- top 10 countries and their area ordered frm the biggest to the smallest
select Name, SurfaceArea 
from country
order by Surfacearea desc
limit 10;


select Name, c.Continent, SurfaceArea 
from country as c,
	(select distinct(Continent) from country) as cnt
where c.Continent = cnt.Continent
order by Surfacearea desc;

-- the country with the biggest area in each continent
select c.Continent, Name, SurfaceArea
from country as c,
(select Continent, max(SurfaceArea) as area
from country
group by Continent) as cnt
where SurfaceArea=area
order by SurfaceArea desc;
 