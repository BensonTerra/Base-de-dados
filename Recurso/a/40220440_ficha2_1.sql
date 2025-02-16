select distinct count(title) as movies from film;
select * from customer c left join address a on c.address_id=a.address_id;
select count(address_id), address 
from address 
group by address;

/*
1) How many movies there are in the database?

2) Top 10 cities with most customers

3) Movie with most rentals

4) for that movie, the number of rentals per year (or month)
*/

SELECT COUNT(*) AS total_movies
FROM film;

select city, count(*) as customers
from customer cu 
join address a on cu.address_id=a.address_id 
join city c on c.city_id=a.city_id
group by city
ORDER BY customers DESC
LIMIT 10;

SELECT title, COUNT(*) AS rental_count
FROM rental as r
JOIN inventory as i ON r.inventory_id = i.inventory_id
JOIN film as f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

select 
	year(rental_date) as rental_year, 
    count(*) as rentals
from rental as r
join inventory as i on r.inventory_id=i.inventory_id
where i.film_id=103
group by rental_year;

select 
	year(rental_date) as rental_year, 
    month(rental_date) as rental_month,
    count(*) as rentals
from rental as r
join inventory as i on r.inventory_id=i.inventory_id
where i.film_id=103
group by 
	rental_year, 
    rental_month
order by rental_month desc;