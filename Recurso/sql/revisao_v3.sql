-- a) Quais os nomes dos filmes que têm a palavra "super" no título?
SELECT t1.title
FROM film t1
WHERE t1.title LIKE '%super%';

-- b) Quais os filmes (title, release_year) de animação com duração (length) superior a 120 minutos?
SELECT t1.title, t1.release_year
FROM film t1
JOIN film_category t2 ON t1.film_id = t2.film_id
JOIN category t3 ON t2.category_id = t3.category_id
WHERE t3.name = 'Animation' AND t1.length > 120;

-- c) Listar os filmes (title, release_year) em que entra o ator "Henry Fonda":
SELECT t1.title, t1.release_year
FROM film t1
JOIN film_actor t2 ON t1.film_id = t2.film_id
JOIN actor t3 ON t2.actor_id = t3.actor_id
WHERE t3.first_name = 'Henry' AND t3.last_name = 'Fonda';

-- d) Listar as possíveis durações de aluguer (rental_duration) dos filmes registados:
SELECT DISTINCT t1.rental_duration
FROM film t1;

-- e) Lista de clientes (first_name, last_name, email), ordenada alfabeticamente, que moram em Paris, França:
SELECT t1.first_name, t1.last_name, t1.email, t3.city, t4.country
FROM customer t1
JOIN address t2 ON t1.address_id = t2.address_id
JOIN city t3 ON t2.city_id = t3.city_id
JOIN country t4 ON t3.country_id = t4.country_id
WHERE 
-- 	t3.city = 'Paris' AND 
    t4.country = 'France'
ORDER BY t1.first_name, t1.last_name;

-- EXTRA
	select * from rental;
-- f1) Número médio de alugueres por dia em 2005 (considera apenas dias com locações)
SELECT AVG(rentals_per_day) AS avg_rentals_per_day
FROM (
    SELECT DATE(t1.rental_date) AS rental_day, COUNT(t1.rental_id) AS rentals_per_day
    FROM rental t1
    WHERE YEAR(t1.rental_date) = 2005
    GROUP BY rental_day
) AS daily_rentals;
-- Esta consulta calcula a média apenas considerando os dias em que houve locações.
-- Se um dia não teve locações, ele não entra no cálculo, o que pode inflar o valor final.

-- f2) Número médio de alugueres por dia em 2005 (divide pelo ano inteiro)
SELECT COUNT(rental_id) / 365 AS avg_rentals_per_day
FROM rental
WHERE rental_date BETWEEN '2005-01-01' AND '2005-12-31';
-- Esta consulta calcula a média dividindo pelo ano inteiro (365 dias).
-- Se houver muitos dias sem locações, a média será menor, pois inclui os dias sem atividade.

-- Diferença:
-- - f1 calcula a média apenas sobre os dias que tiveram locações, resultando em um valor maior.
-- - f2 considera o ano todo, incluindo dias sem locações, resultando em um valor menor.


-- g) Número de alugueres em cada dia de dezembro de 2023:
SELECT DATE(t1.rental_date) AS rental_day, COUNT(t1.rental_id) AS rentals
FROM rental t1
WHERE YEAR(t1.rental_date) = 2005 AND MONTH(t1.rental_date) = 5
GROUP BY rental_day
ORDER BY rental_day;

-- h) Lista das cidades com mais de 5 lojas e número de lojas em cada uma dessas cidades. Dados ordenados por número decrescente de lojas:
SELECT t2.city, COUNT(t1.store_id) AS num_lojas
FROM store t1
JOIN address t3 ON t1.address_id = t3.address_id
JOIN city t2 ON t3.city_id = t2.city_id
GROUP BY t2.city
HAVING COUNT(t1.store_id) > 0
ORDER BY num_lojas DESC;


select * from country as t1 order by t1.country;

-- i1) Adicionar Portugal à tabela country, se ainda não existir
INSERT INTO country (country)
SELECT 'Portugal'
WHERE NOT EXISTS (SELECT 1 FROM country WHERE country = 'Portugal');

-- i2) Adicionar Vila do Conde à tabela city, associando ao ID de Portugal
INSERT INTO city (city, country_id)
VALUES ('Vila do Conde', (SELECT country_id FROM country WHERE country = 'Portugal'));


-- j) Registar que o cliente 1001 fez o pagamento de €4.99 relativamente ao aluguer 54321, tendo sido atendido pelo funcionário 123:
INSERT INTO payment (customer_id, staff_id, rental_id, amount)
-- VALUES (550, 2, 14018, 4.99);
 VALUES (1001, 123, 54321, 4.99);

-- EXTRA
SELECT 
    t1.payment_id,
    t1.customer_id,
    CONCAT(t2.first_name, ' ', t2.last_name) AS customer_name,
    t1.staff_id,
    CONCAT(t3.first_name, ' ', t3.last_name) AS staff_name,
    t1.rental_id,
    t1.amount,
    t1.payment_date
FROM payment t1
JOIN customer t2 ON t1.customer_id = t2.customer_id
JOIN staff t3 ON t1.staff_id = t3.staff_id
ORDER BY t1.payment_id DESC;


-- k) Atualizar todas as lojas de Vila do Conde, Portugal, que passam a ser geridas pelo funcionário "Joe Smith" com o email jsmith@mystore.com:
UPDATE store t1
JOIN address t2 ON t1.address_id = t2.address_id
JOIN city t3 ON t2.city_id = t3.city_id
JOIN staff t4 ON t1.manager_staff_id = t4.staff_id
SET t1.manager_staff_id = (SELECT t5.staff_id FROM staff t5 WHERE t5.first_name = 'Joe' AND t5.last_name = 'Smith' AND t5.email = 'jsmith@mystore.com')
WHERE t3.city = 'Vila do Conde' AND t3.country_id = (SELECT t6.country_id FROM country t6 WHERE t6.country = 'Portugal');

-- l) Eliminar o pagamento de €5.99 relativo ao aluguer 54321, do cliente 1001, registado pelo funcionário 123:
DELETE t1 FROM payment t1
WHERE 
	t1.payment_id = 16053
	-- t1.amount = 5.99 AND t1.rental_id = 54321 AND t1.customer_id = 1001 AND t1.staff_id = 123;

