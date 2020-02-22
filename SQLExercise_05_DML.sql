--Task 1: Insert new row into relation movies with the following data: movie id
--equal to 11, title ’Madagascar’, year of production 2005 and price 10.5
INSERT INTO movies
(movie_id, title, year, price)
VALUES
(11, 'Madagascar', '2005', 10.5);

--Task 2: Remove all movies produced in 2005
DELETE FROM movies
WHERE year = '2005';

--Task 3: Increase price of all movies produced before 1980 by 0.5
UPDATE movies
SET price = price + 0.5
WHERE year < '1980';

--Task 4: Insert new row into relation movies with the following data: movie id
--equal to 12, title ’The Incredibles’, year of production 2004 and price 9.5
INSERT INTO movies
(movie_id, title, year, price)
VALUES
(12, 'The Incredibles', '2004', 9.5);

--Task 5: Delete all the movies in which no actor played

--main query
DELETE FROM movies
WHERE title IN (SELECT title
		FROM movies
		EXCEPT
		SELECT title
		FROM movies m
		JOIN starring str ON str.movie_id = m.movie_id
		JOIN actors act ON act.actor_id = str.movie_id);

--subquery
SELECT title
FROM movies
EXCEPT
SELECT title
FROM movies m
JOIN starring str ON str.movie_id = m.movie_id
JOIN actors act ON act.actor_id = str.movie_id;

--Task 6: Set the price of movie 'Taxi Driver' to 5
UPDATE movies
SET price = 5
WHERE title = 'Taxi Driver';

--Task 7: Increase by 1 price of all movies, that were rented more than twice

--main query
UPDATE movies
SET price = price + 1
WHERE movie_id IN (SELECT movie_id
		   FROM rentals r
		   JOIN copies c ON c.copy_id = r.copy_id
		   GROUP BY movie_id
		   HAVING COUNT(movie_id) > 1);

--subquery
SELECT movie_id
FROM rentals r
JOIN copies c ON c.copy_id = r.copy_id
GROUP BY movie_id
HAVING COUNT(movie_id) > 1;

--Task 8: Insert new copy of a movie 'Platoon' into the relation. 
--Do not explicitly write movie id or assign copy id, instead try getting 
--them from some query

--main query
INSERT INTO movies (movie_id, title, year, price, age_restriction)
VALUES(
11,
(SELECT title FROM movies WHERE title = 'Platoon'),
(SELECT year FROM movies WHERE title = 'Platoon'),
(SELECT price FROM movies WHERE title = 'Platoon'),
(SELECT age_restriction FROM movies WHERE title = 'Platoon')
);

--subquery
SELECT movie_id FROM movies WHERE title = 'Platoon';

--Task 9: For every movie that has only one copy, create another one.
INSERT INTO copies(movie_id, copy_id, available)
SELECT movie_id, 
		(SELECT MAX(copy_id) FROM copies) +  row_number() over() AS copy_id, 
		true AS available
FROM copies
GROUP BY movie_id
HAVING count(*) = 1;

--check query
SELECT * FROM movies;