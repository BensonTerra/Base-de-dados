-- ==========================================
-- Stored Procedures e Triggers Exemplo
-- ==========================================

-- --------------------------------------
-- 1) Query para Listar filmes da categoria "Animation" 
-- e com data de realização (release_year) anterior a 2010
-- --------------------------------------

SELECT DISTINCT
    t1.film_id, t1.title, t1.release_year, t1.description,
    t2.category_id,
    t3.name AS category_name
FROM 
    film AS t1
INNER JOIN film_category AS t2 ON t1.film_id = t2.film_id
INNER JOIN category AS t3 ON t2.category_id = t3.category_id
WHERE t3.name LIKE "Animation"  -- Filtra pelos filmes da categoria "Animation"
  AND t1.release_year <= 2010  -- Filtra pelos filmes lançados até 2010
ORDER BY t1.release_year DESC;  -- Ordena os filmes por ano de lançamento de forma decrescente


-- --------------------------------------
-- 2) Query para Listar filmes na língua "French"
-- e com a categoria "Music"
-- --------------------------------------

SELECT DISTINCT
    t1.film_id, t1.title, t1.language_id,
    t2.category_id,
    t3.name AS category_name,
    t4.name AS language_name
FROM 
    film AS t1
INNER JOIN film_category AS t2 ON t1.film_id = t2.film_id
INNER JOIN category AS t3 ON t2.category_id = t3.category_id
INNER JOIN language AS t4 ON t1.language_id = t4.language_id
WHERE t3.name LIKE "Music"  -- Filtra pelos filmes da categoria "Music"
  AND t4.name LIKE "French";  -- Filtra pelos filmes na língua "French"


-- --------------------------------------
-- 3) Query para Listar o título dos 3 filmes com maior duração (length)
-- --------------------------------------

SELECT DISTINCT 
    t1.film_id, t1.title, t1.length
FROM 
    film AS t1
ORDER BY t1.length DESC  -- Ordena os filmes por duração de forma decrescente
LIMIT 3;  -- Limita a seleção aos 3 filmes com maior duração


-- --------------------------------------
-- 4) Query para Remover filmes com a língua "Japanese"
-- --------------------------------------

DELETE FROM film
WHERE language_id = (
    SELECT language_id FROM language WHERE name = "Japanese"  -- Encontra o ID da língua "Japanese"
);

-- --------------------------------------
-- 5) Query para Obter o nº de filmes por categoria
-- --------------------------------------

SELECT 
    t3.name AS category_name,
    COUNT(*) AS total_films
FROM 
    film AS t1
INNER JOIN film_category AS t2 ON t1.film_id = t2.film_id
INNER JOIN category AS t3 ON t2.category_id = t3.category_id
GROUP BY t3.category_id  -- Agrupa os resultados por categoria
ORDER BY total_films DESC;  -- Ordena pela quantidade de filmes em cada categoria


-- --------------------------------------
-- 6) Query para Listar filmes com a atriz "JENNIFER DAVIS"
-- --------------------------------------

SELECT DISTINCT
    t1.film_id, t1.title, t1.release_year,
    t5.actor_id,
    t6.first_name, t6.last_name
FROM 
    film AS t1
INNER JOIN film_actor AS t5 ON t1.film_id = t5.film_id
INNER JOIN actor AS t6 ON t5.actor_id = t6.actor_id
WHERE t6.first_name LIKE "JENNIFER%"  -- Filtra pela atriz com o primeiro nome "Jennifer"
  AND t6.last_name LIKE "%DAVIS"  -- Filtra pela atriz com o sobrenome "Davis"
ORDER BY t1.release_year, t1.title;  -- Ordena por ano e título do filme


-- --------------------------------------
-- 7) Query para Listar atores que não entram em nenhum filme
-- --------------------------------------

SELECT 
    t1.actor_id, t1.first_name, t1.last_name
FROM 
    actor AS t1
LEFT JOIN film_actor AS t5 ON t1.actor_id = t5.actor_id
WHERE t5.film_id IS NULL;  -- Filtra para atores que não têm filmes associados


-- --------------------------------------
-- 8) Query para Obter o filme mais curto (menor duração)
-- --------------------------------------

SELECT 
    t1.film_id, t1.title, t1.length
FROM 
    film AS t1
ORDER BY t1.length ASC  -- Ordena os filmes pela duração de forma crescente
LIMIT 1;  -- Limita o resultado ao filme com a menor duração


-- --------------------------------------
-- 9) Query para Listar filmes produzidos entre 2009 e 2010, ordenados por ano
-- --------------------------------------

SELECT 
    t1.film_id, t1.title, t1.release_year
FROM 
    film AS t1
WHERE t1.release_year BETWEEN 2009 AND 2010  -- Filtra os filmes entre 2009 e 2010
ORDER BY t1.release_year DESC, t1.title;  -- Ordena por ano de lançamento e título do filme


-- ==========================================
-- Stored Procedures e Triggers
-- ==========================================

-- --------------------------------------
-- 1) Stored Procedure: GetFilmsByCategory
-- Cria a stored procedure que retorna os filmes de uma determinada categoria.
-- O parâmetro de entrada é o nome da categoria (category_name).
-- --------------------------------------

DELIMITER $$

CREATE PROCEDURE GetFilmsByCategory(IN category_name VARCHAR(255))
BEGIN
    -- Seleciona os filmes com base na categoria fornecida como parâmetro.
    SELECT DISTINCT
        t1.film_id, t1.title, t1.release_year, t1.description,
        t2.category_id,
        t3.name AS category_name
    FROM 
        film AS t1
    INNER JOIN film_category AS t2 ON t1.film_id = t2.film_id
    INNER JOIN category AS t3 ON t2.category_id = t3.category_id
    WHERE t3.name = category_name  -- Filtra pelos filmes que pertencem à categoria fornecida.
    ORDER BY t1.release_year DESC; -- Ordena os filmes por ano de lançamento em ordem decrescente.
END $$

DELIMITER ;

-- Execução da stored procedure para listar os filmes da categoria "Comedy":
CALL GetFilmsByCategory("Comedy");


-- --------------------------------------
-- 2) Trigger: update_last_update
-- Cria o trigger para atualizar o campo 'last_update' com a data e hora atual
-- sempre que um novo filme for inserido na tabela 'film'.
-- --------------------------------------

DELIMITER $$

CREATE TRIGGER update_last_update
BEFORE INSERT ON film
FOR EACH ROW
BEGIN
    -- Define o valor de 'last_update' para a data e hora atual (NOW) sempre que um novo filme é inserido.
    SET NEW.last_update = NOW();
END $$

DELIMITER ;

-- Verifica a criação do trigger
SHOW CREATE TRIGGER update_last_update;

-- Exibe todos os triggers existentes na base de dados
SHOW TRIGGERS;

-- Testando a Trigger: 
-- Quando você inserir um novo filme, o campo 'last_update' será automaticamente 
-- preenchido com a data e hora atual.

INSERT INTO film (
    title, 
    description, 
    release_year, 
    language_id
)
VALUES (
    'New Movie',  -- Nome do filme
    'Description of the new movie',  -- Descrição do filme
    2025,  -- Ano de lançamento
    1  -- ID da língua (ajuste conforme sua tabela 'language')
);


-- --------------------------------------
-- 3) Stored Procedure: GetNumFilmByLang
-- Cria a stored procedure que retorna o número de filmes 
-- de uma determinada língua (parâmetro 'language_name').
-- --------------------------------------

DELIMITER $$

CREATE PROCEDURE GetNumFilmByLang(IN language_name VARCHAR(255))
BEGIN
    -- Conta o número de filmes para a língua fornecida como parâmetro.
    SELECT COUNT(*) AS num_films
    FROM film AS t1
    INNER JOIN language AS t2 ON t1.language_id = t2.language_id
    WHERE t2.name = language_name;  -- Filtra pelos filmes que pertencem à língua fornecida.
END $$

DELIMITER ;

-- Execução da stored procedure para listar o número de filmes na língua "Japanese":
CALL GetNumFilmByLang("Japanese");


-- parte 2

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
SELECT t1.first_name, t1.last_name, t1.email
FROM customer t1
JOIN address t2 ON t1.address_id = t2.address_id
JOIN city t3 ON t2.city_id = t3.city_id
JOIN country t4 ON t3.country_id = t4.country_id
WHERE t3.city = 'Paris' AND t4.country = 'France'
ORDER BY t1.first_name, t1.last_name;

-- f) Número médio de alugueres por dia em 2023:
SELECT AVG(rentals_per_day) AS avg_rentals_per_day
FROM (
    SELECT DATE(t1.rental_date) AS rental_day, COUNT(t1.rental_id) AS rentals_per_day
    FROM rental t1
    WHERE YEAR(t1.rental_date) = 2023
    GROUP BY rental_day
) AS daily_rentals;

-- g) Número de alugueres em cada dia de dezembro de 2023:
SELECT DATE(t1.rental_date) AS rental_day, COUNT(t1.rental_id) AS rentals
FROM rental t1
WHERE YEAR(t1.rental_date) = 2023 AND MONTH(t1.rental_date) = 12
GROUP BY rental_day
ORDER BY rental_day;

-- h) Lista das cidades com mais de 5 lojas e número de lojas em cada uma dessas cidades. Dados ordenados por número decrescente de lojas:
SELECT t2.city, COUNT(t1.store_id) AS num_lojas
FROM store t1
JOIN address t3 ON t1.address_id = t3.address_id
JOIN city t2 ON t3.city_id = t2.city_id
GROUP BY t2.city
HAVING COUNT(t1.store_id) > 5
ORDER BY num_lojas DESC;

-- i) Registar a cidade de Vila do Conde em Portugal:
INSERT INTO city (city, country_id)
VALUES ('Vila do Conde', (SELECT t2.country_id FROM country t2 WHERE t2.country = 'Portugal'));

-- j) Registar que o cliente 1001 fez o pagamento de €4.99 relativamente ao aluguer 54321, tendo sido atendido pelo funcionário 123:
INSERT INTO payment t1 (customer_id, staff_id, rental_id, amount)
VALUES (1001, 123, 54321, 4.99);

-- k) Atualizar todas as lojas de Vila do Conde, Portugal, que passam a ser geridas pelo funcionário "Joe Smith" com o email jsmith@mystore.com:
UPDATE store t1
JOIN address t2 ON t1.address_id = t2.address_id
JOIN city t3 ON t2.city_id = t3.city_id
JOIN staff t4 ON t1.manager_staff_id = t4.staff_id
SET t1.manager_staff_id = (SELECT t5.staff_id FROM staff t5 WHERE t5.first_name = 'Joe' AND t5.last_name = 'Smith' AND t5.email = 'jsmith@mystore.com')
WHERE t3.city = 'Vila do Conde' AND t3.country_id = (SELECT t6.country_id FROM country t6 WHERE t6.country = 'Portugal');

-- l) Eliminar o pagamento de €5.99 relativo ao aluguer 54321, do cliente 1001, registado pelo funcionário 123:
DELETE t1 FROM payment t1
WHERE t1.amount = 5.99 AND t1.rental_id = 54321 AND t1.customer_id = 1001 AND t1.staff_id = 123;

