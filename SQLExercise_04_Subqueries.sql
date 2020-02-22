--Task 1: Display the title of the most expensive movie. Do not use keyword LIMIT.
SELECT title
FROM movies
WHERE price = (SELECT MAX(price) FROM movies);

--Task 2: Display the name of the client that made the first rental in the history. 
--Do not use keyword LIMIT.
SELECT first_name, last_name
FROM clients c
JOIN rentals r ON r.client_id = c.client_id
WHERE date_of_rental = (SELECT MIN(date_of_rental) FROM rentals)
ORDER BY date_of_rental;

--Task 3: Display movie titles that are available for rental. Do not use JOINs.
SELECT title
FROM movies
WHERE movie_id IN (SELECT movie_id FROM copies WHERE available = true);

--Task 4: Display titles of movies, with price greater than price of movie 'Frantic'.
SELECT title
FROM movies
WHERE price > (SELECT price FROM movies WHERE title = 'Frantic');

--Task 5: Display titles of movies, with price greater than price of all the movies
--produced before 1980.

--main query:
SELECT title
FROM movies
WHERE price > (SELECT MAX(price) FROM movies WHERE year < '1980');


--subquery:
SELECT MAX(price)
FROM movies
WHERE year < '1980';

--Task 6: For each client display his last name, count of all the rentals he or she
--made and total number of rentals in the whole rental store. Order results by last
--name.

--main query
SELECT last_name, COUNT(last_name) AS client_rentals,
(SELECT COUNT(*) AS total_rentals FROM rentals)
FROM clients c
JOIN rentals r ON r.client_id = c.client_id
GROUP BY last_name;

--subquery
SELECT COUNT(*)
FROM rentals;

--Task 7: Display names of actors and titles of movies, that starred also Jean Reno.
--Order by movie titles

--main query
SELECT first_name, last_name, title
FROM actors act
JOIN starring str ON str.actor_id = act.actor_id
JOIN movies m ON m.movie_id = str.movie_id
WHERE title IN (SELECT title
                FROM movies m
		JOIN starring str ON str.movie_id = m.movie_id
		JOIN actors act ON act.actor_id = str.actor_id
		WHERE first_name = 'Jean' AND last_name = 'Reno');

--subquery
SELECT title
FROM movies m
JOIN starring str ON str.movie_id = m.movie_id
JOIN actors act ON act.actor_id = str.actor_id
WHERE first_name = 'Jean' AND last_name = 'Reno';

--different approcah
select t1.first_name, t1.last_name, t3.title
from actors as t1
join starring as t2 on t1.actor_id = t2.actor_id
join movies as t3 on t2.movie_id = t3.movie_id
where t1.first_name = 'Jean' and t1.last_name = 'Reno';

--Task 8: Display names and birthdays of clients with age greater than the average
--age. Age can be calculated by subtracting birthday from NOW().

--main query
SELECT first_name, last_name, birthday
FROM clients
WHERE NOW() - birthday > (SELECT AVG(NOW() - birthday) FROM clients);

--sub query (average age of clients)
SELECT AVG(NOW() - birthday)
FROM clients;

--Task 9: Display names of clients that rented the same copies of movies as Brian
--Griffin

--main query
SELECT DISTINCT first_name, last_name
FROM clients c
JOIN rentals r ON r.client_id = c.client_id
WHERE copy_id IN (SELECT copy_id
		  FROM clients c
		  JOIN rentals r ON r.client_id = c.client_id
		  WHERE first_name = 'Brian' AND last_name = 'Griffin');

--subquery
SELECT copy_id
FROM clients c
JOIN rentals r ON r.client_id = c.client_id
WHERE first_name = 'Brian' AND last_name = 'Griffin';