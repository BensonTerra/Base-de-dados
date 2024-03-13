-- SCRIPT 3

use world;

-- Subqueries

-- 7 Name of the city with the biggest population
select Name, Population
from city
where Population=
	(select max(Population) 
     from city);

-- 8 cities of Portugal
Select ID,Name
from city
where CountryCode=
	(select Code
    from country
    where Name="Portugal");
    
-- 9 cities and their countries where the official language is English
select city.Name as "City", country.Name as "Country"
from city, country
where city.CountryCode=country.Code
and country.Code in 
    (select CountryCode 
    from countrylanguage 
    where Language="English" and IsOfficial="T")
order by Country, City;
    
-- countries (name and code) where the official language is english
select Code, Name as Country 
from country as c, countrylanguage as cl
where c.Code= cl.CountryCode
and cl.Language = "English"
and cl.IsOfficial ="T";

-- 9 new version
select city.Name as "City", EnglishCountries.Country as "Country"
from city, (select Code, Name as Country 
			from country as c, countrylanguage as cl
			where c.Code= cl.CountryCode
			and cl.Language = "English"
			and cl.IsOfficial ="T") as EnglishCountries
where city.CountryCode= EnglishCountries.Code;

-- 11 Countries which have a city in a district whose name includes South
select Name as Country 
from country 
where exists 
	(select * 
    from city 
    where city.CountryCode=country.Code 
    and District like "%South%");

-- INSERT
-- select max(id) from city;
-- 16 Add a new city
insert into city 
values (9999,"Guimarães", "PRT", "Braga",150000);

-- 17 Add a new city - specific fields
insert into city 
(Name,CountryCode,Population)
values ("Guimarães", "PRT", "140000");

-- UPDATE
-- 18 update the Population of Guimarães
update city
set Population=160000
where Name="Guimarães";

-- DELETE
-- delete the city of Guimarães 
delete from city where Name="Guimarães";


-- VIEWS-------------------------------
-- 5 create a view with the portuguese cities
create view PortugueseCities as
Select ID, Name, CountryCode, District, Population
from city
where CountryCode=
	(select Code
    from country
    where Name="Portugal");

-- use the PortugueseCities view to display data
select * from portuguesecities;

-- 10 View that list the language spoken in Swiss cities
create view SwissLanguages as
select c.name as Country, city.name as City, cl.Language as Language
from country as c, countrylanguage as cl, city
where cl.CountryCode=c.Code
and city.CountryCode=c.Code
and c.Name="Switzerland"
order by Language;

select * from swisslanguages;

drop view swisslanguages;





