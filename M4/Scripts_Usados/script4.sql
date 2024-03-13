use sakila;
select * from film;
select * from language;
select * from category;
-- films in French
-- how many films per language
	select language.name as Language, count(*) as "Number of films"
    from film, language
    where film.language_id=language.language_id
    group by language.language_id;
-- actors (first name, last name) of the french films
-- how many horror films in the database
-- how many horror films per country
-- category most represented in the database
-- actor that made more comedy fils