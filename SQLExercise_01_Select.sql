--Task 1: Fetch titles of all movies produced in 1998 or 1999
SELECT title
FROM movies
WHERE year IN ('1998', '1999');

--Task 2: Fetch title and price of all movies with price exceeding 9. Order results ascending by price.
SELECT price, title
FROM movies
WHERE price > 9
ORDER BY price ASC;

--Task 3: Fetch last names of all clients with first name ’Lisa’
SELECT last_name
FROM clients
WHERE first_name = 'Lisa';

--Task 4: Fetch first and last names of all clients with last name longer by at least three characters than first name
SELECT first_name, last_name
FROM clients
WHERE LENGTH(last_name) - LENGTH(first_name) > 2;

--Task 5: Display last names of all actors with first names Arnold, Tom and Jodie. 
--Results should be presented in descending order
SELECT last_name
FROM actors
WHERE first_name IN ('Arnold', 'Tom', 'Jodie')
ORDER BY last_name DESC;

--Task 5 (Longer version 1)
SELECT last_name
FROM actors
WHERE first_name = 'Arnold' OR first_name = 'Tom' OR first_name = 'Jodie'
ORDER BY last_name DESC;

--Task 5 (Longer version 2)
SELECT last_name
FROM actors
WHERE first_name LIKE 'Arnold' OR first_name LIKE 'Tom' OR first_name LIKE 'Jodie'
ORDER BY last_name DESC;

--Task 6: Display IDs of all movies with copies available for rent. Eliminate duplicates. 
--Present the results in ascending order
SELECT DISTINCT copy_id
FROM copies
WHERE available IS true
ORDER BY copy_id ASC;

--Task 7: Display the IDs of all copies, that were rented between 2005-07-15 and 2005-07-22. 
--Eliminate duplicates. Present the results in ascending order
SELECT copy_id
FROM rentals
WHERE date_of_rental BETWEEN '2005-07-15' AND '2005-07-22'
ORDER BY copy_id ASC;

--Task 8: Display IDs and rent time (in days) of all copies, that were rented for more than one day.
SELECT copy_id, AGE(date_of_return, date_of_rental) AS rent_time
FROM rentals
WHERE AGE(date_of_return, date_of_rental) > '1 day';

--Task 9: Display all actors in the following form: first letter of first name, dot, space, last name
SELECT SUBSTRING(first_name, 1, 1) || '. ' || last_name AS actor_name
FROM actors;

--Task 10: Display titles of all movies, ordered from shortest to longest title
SELECT title
FROM movies
ORDER BY LENGTH(title) ASC;

--Task 11: Display title and price of three newest movies
SELECT title, price, year
FROM movies
ORDER BY year DESC
LIMIT 3;

--Task 12: For all clients display: first name, first letter of first name, last letter of first name. 
--Columns should have titles as below
SELECT first_name, 
SUBSTRING(first_name, 1, 1) AS first_letter_of_name, 
SUBSTRING(first_name, LENGTH(first_name), LENGTH(first_name)) AS first_letter_of_lastname
FROM clients;

--Task 13: Display the names of clients, whose first and last letter of name are the same. Ignore the case, eliminate duplicates
SELECT first_name
FROM clients
WHERE LOWER(SUBSTRING(first_name, 1, 1)) = LOWER(SUBSTRING(first_name, LENGTH(first_name), LENGTH(first_name)));

--Task 14: Display movie titles, with second to last letter ’o’
SELECT title
FROM movies
WHERE SUBSTRING(title, LENGTH(title) - 1, 1) = 'o';

--Task 14: POSITION approach
SELECT title
FROM movies
WHERE POSITION('o' IN title) > LENGTH(title) - 3;

--Task 15: For every client display its email address constructed in the following way: lowercase first name, dot, lowercase last name, ’@wsb.pl’
SELECT LOWER(first_name) || '.' || LOWER(last_name) || '@wsb.pl' AS client_email
FROM clients;

--Task 15: CONCAT approach. Here comma can be placed anywhere
SELECT CONCAT(LOWER(first_name) || '.', LOWER(last_name) || '@wsb.pl') AS client_email
FROM clients;