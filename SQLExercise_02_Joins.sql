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

