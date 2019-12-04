--Task 1: Insert new row into relation movies with the following data: 
--movieid equal to 11, title ’Madagascar’, year of production 2005 and price 10.5
SELECT * FROM movies;

--INSERT INTO movies
--VALUES
--('Madagascar', 1976, 12, 11, 10.5);

--Task 2: Remove all movies produced in 2005
--DELETE FROM movies
--WHERE year = 2005;

--Task 3: Increase price of all movies produced before 1980 by 0.5
UPDATE movies
SET price = price + 0.5
WHERE year < 1980;

--Insert new row into relation movies 
--with the following data: movieidequal to 12, title ’The Incredibles’, year of production 2004 and price 9.5

--INSERT INTO movies (movie_id, title, year, price)
--VALUES
--(12, 'The Invredibles', 2004, 9.5);

--Task 5: Delete all the movies in which no actor played
SELECT *
FROM movies m
LEFT JOIN starring s ON s.movie_id = m.movie_id
LEFT JOIN actors a ON a.actor_id = s.actor_id
WHERE first_name IS NULL;

DELETE FROM movies
WHERE movie_id IN (SELECT m.movie_id
FROM movies m
LEFT JOIN starring s ON s.movie_id = m.movie_id
LEFT JOIN actors a ON a.actor_id = s.actor_id
WHERE first_name IS NULL);

--Task 6: Set the price of movie ’Taxi Driver’ to 5
UPDATE movies
SET price = 5
WHERE movie_id = (SELECT movie_id FROM movies WHERE title = 'Taxi Driver')