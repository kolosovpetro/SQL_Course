--Task 1: Display the names of all clients and actors. Order the results by last name.
SELECT first_name, last_name FROM clients
UNION
SELECT first_name, last_name FROM actors
ORDER BY last_name;

--Task 2: Display titles of movies in which both De Niro and Reno played.
SELECT title
FROM actors
NATURAL JOIN starring
JOIN movies m ON m.movie_id = starring.movie_id
WHERE last_name LIKE 'De Niro'
INTERSECT
SELECT title
FROM actors
NATURAL JOIN starring
JOIN movies m ON m.movie_id = starring.movie_id
WHERE last_name LIKE 'Reno';

--Task 3: Display titles of movies that were rented by both Gary Goodspeed and Brian Griffin
SELECT title
FROM rentals
JOIN copies cop ON cop.copy_id=rentals.copy_id
JOIN movies m ON m.movie_id=cop.movie_id
NATURAL JOIN clients
WHERE first_name LIKE 'Gary' AND last_name LIKE 'Goodspeed'
INTERSECT
SELECT title
FROM rentals
JOIN copies cop ON cop.copy_id=rentals.copy_id
JOIN movies m ON m.movie_id=cop.movie_id
NATURAL JOIN clients
WHERE first_name LIKE 'Brian' AND last_name LIKE 'Griffin';

--Task 5: Display names of actors that played in 'Terminator' but never played in 'Ghostbusters'
SELECT first_name, last_name
FROM actors
JOIN starring s ON s.actor_id=actors.actor_id
NATURAL JOIN movies
WHERE title = 'Terminator'
EXCEPT
SELECT first_name, last_name
FROM actors
JOIN starring s ON s.actor_id=actors.actor_id
NATURAL JOIN movies
WHERE title = 'Ghostbusters';

--Task 6: Display the price of the most expensive movie in the store
SELECT MAX(price)
FROM movies;

--Task 7: Display the number of movies produced in 1984
SELECT COUNT(year)
FROM movies
WHERE year = 1984;

--Task 8: How many time movie ’Taxi Driver’ was rented?
SELECT COUNT(title)
FROM rentals
JOIN copies c ON c.copy_id = rentals.copy_id
JOIN movies m ON m.movie_id = c.movie_id
WHERE title = 'Taxi Driver';

SELECT COUNT(*)
FROM movies
WHERE year = 1984
GROUP BY year
HAVING year = 1984;

--Task 9: For every year of production, display the average price of the movie. Order the results by year
SELECT AVG(price), year
FROM movies
GROUP BY year
ORDER BY year;

--Task 10: What was the average rental time of ’Ronin’?
SELECT AVG(date_of_return - date_of_rental), EXTRACT (hour FROM AVG(date_of_return - date_of_rental))
FROM rentals
JOIN copies c ON c.copy_id = rentals.copy_id
JOIN movies m ON m.movie_id = c.movie_id
WHERE title = 'Ronin';

--Task 11: For each movie display its title, minimum, maximum and average rental
--time, as well as number of times it was rented. Order the results from most popular
--movie to least one.
SELECT title, MIN(date_of_return - date_of_rental), MAX(date_of_return - date_of_rental), AVG(date_of_return - date_of_rental)
FROM rentals r
JOIN copies c ON c.copy_id = r.copy_id
JOIN movies m ON m.movie_id = c.movie_id
GROUP BY title
ORDER BY COUNT(*) DESC;

--Task 12: For every client display its first, last name and number of rentals. Order the results by last names
SELECT first_name, last_name, COUNT(*)
FROM clients c
JOIN rentals r ON r.client_id = c.client_id
GROUP BY first_name, last_name;

--Task 13: For every actor display the number of movies in which he/she played. Skip actors, that played in only one movie
SELECT last_name, COUNT(*)
FROM actors a
JOIN starring s ON s.actor_id = a.actor_id
JOIN movies m ON s.movie_id = m.movie_id
GROUP BY last_name
HAVING COUNT (*) > 1;

--Task 14: For every client display the total amount of money he or she spent on renting movies
SELECT first_name, last_name, SUM(price)
FROM clients c
JOIN rentals r ON r.client_id = c.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
GROUP BY first_name, last_name
