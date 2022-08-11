-- Week 5 - Wednesday Questions



-- 1. List all customers who live in Texas(address.district) (use JOINs)
SELECT * FROM customer;
SELECT * FROM address;
-- Inner Join (customer.address_id)/(address.address_id)
SELECT first_name, last_name, customer.customer_id, district, city_id, postal_code
FROM customer 
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- Answer: The following customers live in Texas...
-- Customer Name - Customer ID: Kim Cruz - 118, Richard Mccrary - 305, Jennifer Davis - 6, Bryan Hardison - 400, Ian Still - 561



-- 2. Get all payments above $6.99 with the Customer’s full name
SELECT * FROM customer;
SELECT * FROM payment;
-- Inner Join (customer.customer_id)/(payment.customer_id)
SELECT first_name, last_name, amount, customer.customer_id, loyalty_member
FROM customer 
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;
-- Answer: There are a total of 1406 payments with an amount greater than $6.99. That's a lot of full names!



-- 3. Show all customer names who have made payments over $175 (use subqueries)
SELECT * FROM customer;
SELECT * FROM payment;
-- Inner Join (customer.customer_id)/(payment.customer_id)
SELECT first_name, last_name, amount, customer.customer_id
FROM customer 
JOIN payment
ON customer.customer_id = payment.customer_id;

SELECT customer_id
FROM payment
GROUP BY customer_id (
	SELECT customer_id
	FROM payment
	 (
		SELECT customer_id
		FROM customer 
		JOIN payment
		GROUP BY customer_id
		ON customer.customer_id = payment.customer_id 
	) AS foo
);

SELECT SUM(num_payments)
FROM (
	SELECT amount
	FROM payment
	GROUP BY customer_id 
) AS num_payments;

SELECT *
FROM customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id(
		SELECT SUM(num_payments)
		FROM (
			SELECT amount 
			FROM payment
			GROUP BY customer_id
		) AS num_payments
	)
);

SELECT payment.customer_id
FROM payment
JOIN customer 
ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id;
-- Answer: 



-- 4. List all customers that live in Argentina (use the country table)
SELECT * FROM customer;
SELECT * FROM country;
-- Inner Join (customer.last_update)/(country.last_update)
SELECT first_name, last_name, country, customer.last_update
FROM customer 
JOIN country
ON customer.last_update = country.last_update
WHERE country = 'Argentina';
-- Answer: 



-- 5. Which film category has the most movies in it (show with the count)?
SELECT * FROM film;
SELECT * FROM film_category;
-- Inner Join (film.film_id)/(film_category.film_id)

SELECT film.film_id, title, category_id
FROM film
JOIN film_category
ON film.film_id = film_category.film_id;

SELECT film.film_id, title, category_id
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
GROUP BY category_id;
-- Answer:



-- 6. What film had the most actors in it (show film info)?
SELECT * FROM film;
SELECT * FROM film_actor;
-- Inner Join (film.film_id)/(film_actor.film_id)
SELECT film.film_id, actor_id, title
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id;

SELECT film.film_id, actor_id, title
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY actor_id;
-- Answer:



-- 7. Which actor has been in the least movies?
SELECT * FROM film;
SELECT * FROM film_actor;
-- Inner Join (film.film_id)/(film_actor.film_id)
SELECT film.film_id, actor_id, title
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY actor_id DESC;
-- Answer:



-- 8. Which country has the most cities?
SELECT * FROM country;
SELECT * FROM city;
-- Inner Join (country.country_id)/(city.country_id)
SELECT country.country_id, country, city
FROM country
JOIN city
ON country.country_id = city.country_id;

SELECT country.country_id, country, city
FROM country
JOIN city
ON country.country_id = city.country_id
GROUP BY county_id;



-- 9. List the actors who have been in more than 3 films but less than 6.
SELECT * FROM film;
SELECT * FROM film_actor;
-- Inner Join (film.film_id)/(film_actor.film_id)
SELECT film.film_id, actor_id, title
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id;

SELECT film.film_id, actor_id, title
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY actor_id, COUNT(*) AS counting
WHERE counting BETWEEN 3 AND 6;
-- Answer:



-- Having trouble nesting SubQueries with SQL, can get idea's on how to solve solution (can NOT translate ideas into WORKING code)
-- Review lecture again/read-up on SQL SubQueries
-- SQL needed for back-end and full-stack development (so get good at it!)