--Task 1: Display the names of all clients and actors. Order the results by last name.
SELECT first_name FROM clients
UNION
SELECT first_name FROM actors;

--Task 2: Display titles of movies in which both De Niro and Reno played.
SELECT title
FROM movies m
JOIN starring str ON str.movie_id = m.movie_id
JOIN actors act ON act.actor_id = str.actor_id
WHERE last_name = 'De Niro'
INTERSECT
SELECT title
FROM movies m
JOIN starring str ON str.movie_id = m.movie_id
JOIN actors act ON act.actor_id = str.actor_id
WHERE last_name = 'Reno';

--Task 3: Display titles of movies that were rented by both Gary Goodspeed and Brian Griffin
SELECT title
FROM rentals r
JOIN clients c ON c.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE first_name = 'Gary' AND last_name = 'Goodspeed'
INTERSECT
SELECT title
FROM rentals r
JOIN clients c ON c.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE first_name = 'Brian' AND last_name = 'Griffin';

--Task 4: Display titles of movies that were rented by Gary Goodspeed and were never rented by Brian Griffin
SELECT title
FROM rentals r
JOIN clients c ON c.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE first_name = 'Gary' AND last_name = 'Goodspeed'
EXCEPT
SELECT title
FROM rentals r
JOIN clients c ON c.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE first_name = 'Brian' AND last_name = 'Griffin';

--Task 5: Display names of actors that played in 'Terminator' but never played in 'Ghostbusters'
SELECT first_name, last_name
FROM movies m
JOIN starring str ON str.movie_id = m.movie_id
JOIN actors act ON act.actor_id = str.actor_id
WHERE title = 'Terminator'
EXCEPT
SELECT first_name, last_name
FROM movies m
JOIN starring str ON str.movie_id = m.movie_id
JOIN actors act ON act.actor_id = str.actor_id
WHERE title = 'Ghostbusters';

--Task 6: Display the price of the most expensive movie in the store
SELECT MAX(price)
FROM movies;

--Task 7: Display the number of movies produced in 1984
SELECT COUNT(*) AS count
FROM movies
WHERE year = '1984';

--Task 8: How many time movie 'Taxi Driver' was rented?
SELECT COUNT(*) AS rented_count
FROM rentals r
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE title = 'Taxi Driver';

--Task 9: For every year of production, display the average price of the movie.
--Order the results by year
SELECT year, AVG(price) AS avg
FROM movies
GROUP BY year
ORDER BY year ASC;

--Task 10: What was the average rental time of 'Ronin'?
SELECT title, AVG(date_of_return - date_of_rental) AS avg_rental_time
FROM rentals r
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE title = 'Ronin'
GROUP BY title;

--Task 11: For each movie display its title, minimum, maximum and average rental
--time, as well as number of times it was rented. Order the results from most popular
--movie to least one.
SELECT title, 
MIN(date_of_return - date_of_rental) AS min_rental_time,
MAX(date_of_return - date_of_rental) AS max_rental_time,
AVG(date_of_return - date_of_rental) AS avg_rental_time
FROM rentals r
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
GROUP BY title
ORDER BY max_rental_time DESC;

--Task 12: For every client display his first, last name and number of rentals. 
--Order the results by last names
SELECT first_name, last_name, COUNT(first_name) AS number_of_rentals
FROM clients c
JOIN rentals r ON r.client_id = c.client_id
GROUP BY first_name, last_name
ORDER BY last_name ASC;

--Task 13: For every actor display the number of movies in which he/she played.
--Skip actors, that played in only one movie
SELECT first_name, last_name, COUNT(last_name) AS number_of_movies
FROM actors act
JOIN starring str ON str.actor_id = act.actor_id
JOIN movies mov ON mov.movie_id = str.movie_id
GROUP BY act. first_name, act.last_name
HAVING COUNT(last_name) > 1;

--Task 14: For every client display the total amount of money he or she spent on
--renting movies
SELECT first_name, last_name, SUM(price) AS total_money_spent
FROM clients cl
JOIN rentals r ON r.client_id = cl.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies mov ON mov.movie_id = cop.movie_id
GROUP BY first_name, last_name;
