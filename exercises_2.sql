--Task 2.1 For every copy display it’s ID and title of the movie. Order the results by copy ID
SELECT copy_id, title
FROM copies
NATURAL JOIN movies
ORDER BY copy_id;

--Task 2.2 Display the titles of all the movies with copies available in the rental store. Eliminate duplicates
SELECT DISTINCT title
FROM movies
NATURAL JOIN copies c
WHERE c.available = TRUE;

--Task 2.3 Display IDs of copies of movies produced in 1984
SELECT copy_id
FROM copies
NATURAL JOIN movies
WHERE year = 1984;

--Task 2.4 For every rental display date of rental, date of return and name of client that made the rental
SELECT date_of_rental, date_of_return, last_name
FROM rentals
NATURAL JOIN clients;

--Task 2.5 For every rental display name of the client that made the rental and title of the rented movie
SELECT last_name, title
FROM rentals r
JOIN clients c ON c.client_id=r.client_id
JOIN copies cop ON cop.copy_id=r.copy_id
JOIN movies m ON m.movie_id=cop.movie_id;

--Task 2.6 Display titles and years of production of all the movies rented by Gary Goodspeed
SELECT title, year
FROM rentals r
JOIN copies cop ON cop.copy_id=r.copy_id
JOIN movies m ON m.movie_id=cop.movie_id
NATURAL JOIN clients
WHERE first_name LIKE 'Gary' AND last_name LIKE 'Goodspeed';

--Task 2.7 Display name of the client, that made the first rental in the history
SELECT first_name, last_name
FROM rentals
NATURAL JOIN clients
ORDER BY date_of_rental
LIMIT 1;

--Task 2.8 Display last names of actors, that played in ’Terminator’
SELECT last_name
FROM actors act
JOIN starring s ON s.actor_id=act.actor_id
NATURAL JOIN movies
WHERE title LIKE 'Terminator';

--Task 2.9 Display titles of all movies that starred Robert De Niro
SELECT title
FROM actors
NATURAL JOIN starring
JOIN movies m ON m.movie_id = starring.movie_id
WHERE first_name LIKE 'Robert' AND last_name LIKE 'De Niro';

--Task 2.10 Display the movie title, that was rented for the longest time
SELECT title
FROM rentals r
JOIN copies cop ON cop.copy_id=r.copy_id
JOIN movies m ON m.movie_id=cop.movie_id
ORDER BY AGE(date_of_rental, date_of_return)
LIMIT 1;

--Task 2.11 Display last names of clients that made rentals between ’2005-07-15’ and ’2005-07-20’. Eliminate duplicates
SELECT DISTINCT last_name
FROM rentals r
JOIN clients c ON c.client_id=r.client_id
WHERE date_of_rental BETWEEN '2005-07-15' AND '2005-07-20';


--Task 2.12 Display titles of movies rented between ’2005-07-15’ and ’2005-07-25’. Eliminate duplicates
SELECT title
FROM rentals r
JOIN copies c ON c.copy_id=r.copy_id
JOIN movies m ON m.movie_id=c.movie_id
WHERE date_of_rental > '2005-07-14 23:59:59' AND date_of_return < '2005-07-25 23:59:59';


--Task 2.13 For clients that have the same first name as one of the actors display: shared first name, last name of actor, last name of client
SELECT c.first_name AS shared_name, act.last_name AS actor, c.last_name AS client
FROM actors act
JOIN clients c ON c.first_name=act.first_name




