--Task 1: For every copy display it’s ID and title of the movie. 
--Order the results by copy ID
SELECT copy_id, title
FROM movies m
JOIN copies c ON c.movie_id = m.movie_id
ORDER BY copy_id ASC;

--Task 1: Different approach
SELECT copy_id, title
FROM movies m, copies c
WHERE m.movie_id = c.movie_id
ORDER BY copy_id ASC;

--Task 2: Display the titles of all the movies with copies available in the rental store.
--Eliminate duplicates
SELECT DISTINCT title
FROM movies m
JOIN copies c ON c.movie_id = m.movie_id
WHERE available IS true;

--Task 2: Different approach
SELECT DISTINCT title
FROM movies m, copies c
WHERE m.movie_id = c.movie_id
AND available IS true;

--Task 3: Display IDs of copies of movies produced in 1984
SELECT copy_id
FROM movies m
JOIN copies c ON c.movie_id = m.movie_id
WHERE year = '1984';

--Task 3: Different approach
SELECT copy_id
FROM movies m, copies c
WHERE m.movie_id = c.movie_id
AND year = '1984';

--Task 4: For every rental display date of rental, date of return and name of client that made the rental
SELECT date_of_rental, date_of_return, last_name
FROM rentals r
JOIN clients cl ON cl.client_id = r.client_id;

--Task 4: Different approach
SELECT date_of_rental, date_of_return, last_name
FROM rentals r, clients cl
WHERE r.client_id = cl.client_id;

--Task 5: For every rental display name of the client that made the rental and title of the rented movie
SELECT first_name, title
FROM rentals r
JOIN clients cl ON cl.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id;

--Task 5: Different approach
SELECT first_name, title
FROM rentals r, clients cl, copies cop, movies m
WHERE cl.client_id = r.client_id
AND cop.copy_id = r.copy_id
AND m.movie_id = cop.movie_id;

--Task 6: Display titles and years of production of all the movies rented by Gary Goodspeed
SELECT title, year
FROM rentals r
JOIN clients cl ON cl.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE first_name = 'Gary' AND last_name = 'Goodspeed';

--Task 6: Different approach
SELECT title, year
FROM rentals r, clients cl, copies cop, movies m
WHERE cl.client_id = r.client_id
AND cop.copy_id = r.copy_id
AND m.movie_id = cop.movie_id
AND first_name = 'Gary' 
AND last_name = 'Goodspeed';

--Task 7: Display name of the client, that made the first rental in the history
SELECT first_name
FROM rentals r
JOIN clients cl ON cl.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
ORDER BY date_of_rental ASC
LIMIT 1;

--Task 7: Different approach
SELECT first_name
FROM rentals r, clients cl, copies cop, movies m
WHERE cl.client_id = r.client_id
AND cop.copy_id = r.copy_id
AND m.movie_id = cop.movie_id
ORDER BY date_of_rental ASC
LIMIT 1;

--Task 8: Display last names of actors, that played in ’Terminator’
SELECT last_name
FROM movies m
JOIN starring s ON s.movie_id = m.movie_id
JOIN actors act ON act.actor_id = s.actor_id
WHERE title = 'Terminator';

--Task 8: Different approach
SELECT last_name
FROM movies m, starring s, actors act
WHERE s.movie_id = m.movie_id
AND act.actor_id = s.actor_id
AND title = 'Terminator';

--Task 9: Display titles of all movies that starred Robert De Niro
SELECT title
FROM movies m
JOIN starring s ON s.movie_id = m.movie_id
JOIN actors act ON act.actor_id = s.actor_id
WHERE first_name = 'Robert' AND last_name = 'De Niro';

--Task 9: Different approach
SELECT title
FROM movies m, starring s, actors act
WHERE s.movie_id = m.movie_id
AND act.actor_id = s.actor_id
AND first_name = 'Robert' 
AND last_name = 'De Niro';

--Task 10: Display the movie title, that was rented for the longest time
SELECT title
FROM rentals r
JOIN clients cl ON cl.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
ORDER BY date_of_return - date_of_rental DESC
LIMIT 1;

--Task 10: Different approach
SELECT title
FROM rentals r, clients cl, copies cop, movies m
WHERE cl.client_id = r.client_id
AND cop.copy_id = r.copy_id
AND m.movie_id = cop.movie_id
ORDER BY date_of_return - date_of_rental DESC
LIMIT 1;

--Task 11: Display last names of clients that made rentals between '2005-07-15' and '2005-07-20'. 
--Eliminate duplicates
SELECT first_name, last_name
FROM rentals r
JOIN clients cl ON cl.client_id = r.client_id
WHERE date_of_rental BETWEEN '2005-07-15' AND '2005-07-20';

--Task 11: Different approach
SELECT DISTINCT first_name, last_name
FROM rentals r, clients cl, copies cop, movies m
WHERE cl.client_id = r.client_id
AND date_of_rental BETWEEN '2005-07-15' AND '2005-07-20';

--Task 12: Display titles of movies rented between '2005-07-15' and '2005-07-25'.
--Eliminate duplicates
SELECT DISTINCT title
FROM rentals r
JOIN clients cl ON cl.client_id = r.client_id
JOIN copies cop ON cop.copy_id = r.copy_id
JOIN movies m ON m.movie_id = cop.movie_id
WHERE date_of_rental BETWEEN '2005-07-15' AND '2005-07-25';
