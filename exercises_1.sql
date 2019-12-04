--Task 1.1 Fetch titles of all movies produced in 1998 or 1999
SELECT title
FROM movies
WHERE year = 1998 OR year = 1999;

--Task 1.2 Fetch title and price of all movies with price exceeding 9. Order results ascending by price.
SELECT title, price
FROM movies
WHERE price > 9
ORDER BY price;

--Task 1.3 Fetch last names of all clients with first name ’Lisa
SELECT last_name
FROM clients
WHERE first_name LIKE 'Lisa';
--WHERE first_name = 'Lisa';

--Task 1.4 Fetch first and last names of all clients with last name longer by at least three characters than first name
SELECT first_name, last_name
FROM clients
WHERE LENGTH(last_name) - LENGTH(first_name) > 3;

--Task 1.5 Display last names of all actors with first names Arnold, Tom and Jodie. Results should be presented in descending order
SELECT last_name
FROM actors
WHERE first_name IN ('Arnold',  'Jodie',  'Tom');
--WHERE first_name = 'Arnold' OR  first_name = 'Jodie' OR first_name = 'Tom';
--WHERE first_name LIKE 'Arnold' OR first_name LIKE 'Jodie' OR first_name LIKE 'Tom';

--Task 1.6 Display IDs of all movies with copies available for rent. Eliminate duplicates. Present the results in ascending order
SELECT DISTINCT copy_id
FROM copies
WHERE available = TRUE
ORDER BY copy_id;

--Task 1.7  Display the IDs of all copies, that were rented between 2005-07-15 and 2005-07-22. 
--Eliminate duplicates. Present the results in ascending order
SELECT DISTINCT copy_id
FROM rentals
WHERE date_of_rental BETWEEN '2005-07-15' AND '2005-07-22'
--WHERE date_of_rental > '2005-07-15' AND date_of_rental < '2005-07-22 23:59:59'
ORDER BY copy_id ASC;

--Task 1.8 Display IDs and rent time (in days) of all copies, that were rented for more than one day
SELECT copy_id, date_of_return - date_of_rental AS rent_time
FROM rentals
--WHERE date_of_return - date_of_rental > '1 day';
WHERE AGE(date_of_return, date_of_rental) > '1 day';

--Task 1.9 Display all actors in the following form: first letter of first name, dot, space, last name
SELECT SUBSTRING(first_name, 1, 1) || '. ' || last_name AS actor_name
FROM actors;

--Task 1.10 Display titles of all movies, ordered from shortest to longest title
SELECT title
FROM movies
--ORDER BY LENGTH(title) ASC;
ORDER BY CHAR_LENGTH(title) ASC;

--Task 1.11 Display title and price of three newest movies
SELECT title, price
FROM movies
ORDER BY year ASC
LIMIT 3;

--Task 1.12 For all clients display: first name, first letter of first name, last letter of first name. Columns should have titles as below
SELECT first_name AS name, SUBSTRING(first_name, 1, 1) AS first, SUBSTRING(first_name, LENGTH(first_name), LENGTH(first_name)) AS last
FROM clients;

--Task 1.13 Display the names of clients, whose first and last letter of name are the same. Ignore the case, eliminate duplicates
SELECT first_name
FROM clients
WHERE UPPER(SUBSTRING(first_name, 1, 1)) = UPPER(SUBSTRING(first_name, LENGTH(first_name), LENGTH(first_name)));

--Task 1.14 Display movie titles, with second to last letter ’o’ 
SELECT title
FROM movies
WHERE POSITION('o' IN REVERSE(title)) = 2;
--WHERE SUBSTRING(title, LENGTH(title)-1, LENGTH(title)) LIKE 'o_';

--Task 1.15 For every client display its email address constructed in the following way: lowercase first name, dot, lowercase last name, ’@wsb.pl
SELECT CONCAT(LOWER(first_name) || '.' || LOWER(last_name), '@wsb.pl')
--SELECT CONCAT(CONCAT(CONCAT(LOWER(first_name), '.'), LOWER(last_name)), '@wsb.pl')
AS client_email
FROM clients;







