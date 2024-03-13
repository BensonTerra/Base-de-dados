-- get the name, country and population of the cities in the database
select Name, CountryCode, Population
from city;

-- get the name, country and population of the cities in the database 
-- that are from Portugal (identified by CountryCode PRT)
select Name, CountryCode, Population
from city
where CountryCode='PRT';

-- get the name, country and population of the cities in the database 
-- that are from Portugal (identified by CountryCode PRT)
-- whose population exceeds 100,000 persons
select Name, CountryCode, Population
from city
where CountryCode='PRT'
and Population>100000;

-- get the name, country and population of the cities in the database 
-- that are from Portugal (identified by CountryCode PRT)
-- whose population exceeds 100,000 persons
-- ordered by city name
select Name, CountryCode, Population
from city
where CountryCode='PRT'
and Population>100000
order by Name;

-- get all the information from table country
Select * from country order by code;

-- get a list of cities in Spain and their population ordered by crescent size of population
Select city.Name, city.Population
from city, country
where city.CountryCode=country.Code
and country.Name='Spain'
and city.Population>100000
order by city.Population asc;

select Code, Name 
from country
where Code='AFG'
order by Name;

select CountryCode, count(*) from countrylanguage group by CountryCode;

Select * from countrylanguage;

select * 
from countrylanguage 
where Language='Portuguese' 
and IsOfficial='T';

-- Which languages are sponken in Afghanistan
Select Language 
from countrylanguage, country
where CountryCode=Code
and Name='Afghanistan';

-- In which cities of which countries can I speak Portuguese as an official language?
Select city.name as 'City', country.name as 'Country'
from city, country, countrylanguage
where city.CountryCode=country.Code
and country.Code=countrylanguage.CountryCode
and Language='Portuguese'
and IsOfficial='T';