use films;

select * from film;
select * from film_category;
select * from category;
select * from language;

/* 1 */
select distinct
t1.film_id, t1.title, t1.release_year, t1.description,
t2.category_id,
t3.name

from 
film as t1,
film_category as t2,
category as t3

where t1.film_id = t2.film_id and 
t2.category_id = t3.category_id and 
t3.name like "Animation" and
t1.release_year <= 2010
order by t1.release_year desc;

/* 2 */
select distinct
t1.film_id, t1.title, t1.language_id,
t2.category_id,
t3.name,
t4.name

from 
film as t1,
film_category as t2,
category as t3,
language as t4

where t1.film_id = t2.film_id and 
t2.category_id = t3.category_id and 
t2.category_id = t3.category_id and
t1.language_id= t4.language_id and
t3.name like "Music" and t4.name like "French";

/* 3 */
select distinct 
t1.film_id, t1.title, t1.length

from 
film as t1

order by length desc limit 3;

/* 4 */
select distinct
t1.film_id, t1.title, t1.language_id,
t2.category_id,
t3.name,
t4.name

from 
film as t1,
film_category as t2,
category as t3,
language as t4

where t1.film_id = t2.film_id and 
t2.category_id = t3.category_id and 
t2.category_id = t3.category_id and
t1.language_id= t4.language_id and
t4.name like "Japanese";

/* 5 */
select distinct
-- t1.film_id,
-- t2.category_id,
t3.name as Categorias,
-- t4.name
COUNT(*) as "Total de filmes"

from 
film as t1,
film_category as t2,
category as t3,
language as t4

WHERE t1.film_id = t2.film_id and 
t2.category_id = t3.category_id

GROUP BY t3.category_id;

/* 6 */
select distinct
t1.film_id, t1.title, t1.release_year,
-- t2.category_id,
-- t3.name
-- t4.name
t5.actor_id,
t6.first_name, t6.last_name

from 
film as t1,
-- film_category as t2,
-- category as t3,
-- language as t4
film_actor as t5,
actor as t6

where
t1.film_id = t5.film_id and
t5.actor_id = t6.actor_id AND
t6.first_name LIKE "JENNIFER%" AND
t6.last_name LIKE "%DAVIS"

ORDER BY t1.release_year;

/* 7 */
select distinct
t1.film_id, t1.title, t1.release_year
-- t2.category_id,
-- t3.name
-- t4.name
-- t5.actor_id,
-- t6.first_name, t6.last_name

from 
film as t1
-- film_category as t2,
-- category as t3,
-- language as t4
-- film_actor as t5,
-- actor as t6

ORDER by t1.film_id;

/* 7 */
select distinct
t1.film_id, t1.title,/* t1.release_year,*/
-- t2.category_id,
-- t3.name
-- t4.name
t5.actor_id,
t6.first_name, t6.last_name

from
film as t1,
-- film_category as t2,
-- category as t3,
-- language as t4
-- film_actor as t5,
actor as t6

LEFT JOIN
film_actor as t5 on t6.actor_id = t5.actor_id

where
-- t1.film_id = t5.film_id AND -- Vincula o ID do filme com os atores que participaram dele
-- t5.actor_id = t6.actor_id AND -- link actor_id com first_name e last_name
t1.film_id = 1 AND t5.actor_id is not NULL

ORDER BY t1.title, t5.actor_id;

/* 8 */

