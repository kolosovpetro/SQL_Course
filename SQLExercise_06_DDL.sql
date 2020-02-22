--Task 1: Create a relation Books, with the following columns: book id (integer),
--title (varchar (300)), author (varchar(100)), date of publish (date)
CREATE TABLE Books (
book_id INTEGER ,
title VARCHAR (30) ,
author VARCHAR (30) ,
date_of_publish DATE );

--Task 2: Insert two rows into the books relations: 
--(1, 'Harry Potter', 'J.K. Rowling', '1997-06-26'), 
--(2, 'The Fellowship of the Ring', 'J.R.R. Tolkien', '1954-07-29')
INSERT INTO books
(book_id, title, author, date_of_publish)
VALUES
(1, 'Harry Potter', 'J.K. Rowling', '1997-06-26'),
(2, 'The Fellowship of the Ring', 'J.R.R. Tolkien', '1954-07-29');

--Task 3: Add new column to table books: publisher as VARCHAR(300), with
--default value 'Unknown'
ALTER TABLE books ADD COLUMN publisher VARCHAR(300) DEFAULT 'Unknown'; 
UPDATE books SET publisher = DEFAULT;

--Task 4: Rename column author to author fullname
ALTER TABLE books RENAME COLUMN author TO author_fullname;

--Task 5: Change column date of publish to column year of publish as INTEGER.
--As the value a year from the original date should be taken
ALTER TABLE books ALTER COLUMN date_of_publish TYPE INTEGER USING EXTRACT(year FROM date_of_publish);
ALTER TABLE books RENAME COLUMN date_of_publish TO year_of_publish;

--Task 6: Change column book id to auto-increment column
CREATE SEQUENCE books_seq;
SELECT setval('books_seq', (SELECT MAX(book_id) FROM books));
ALTER TABLE books ALTER COLUMN book_id SET DEFAULT nextval('books_seq');

--Task 7: Insert two new rows into the books table: ('Mort', 'T. Pratchett', '1987'), ('A Game of Thrones', 'G.R.R. Martin', 1996)
INSERT INTO books (title, author_fullname, year_of_publish)
VALUES  
('Mort', 'T. Pratchett', '1987'), 
('A Game of Thrones', 'G.R.R. Martin', 1996);

--Task 8: Set column book id as primary key of the relation
ALTER TABLE books ADD PRIMARY KEY (book_id);

--Task 9: List all tables in ’public’ schema of our database
SELECT table_catalog, table_schema, table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

----Task 10: Display details of all columns of table 'books'
SELECT column_name, column_default, is_nullable, data_type
FROM information_schema.columns
WHERE table_name = 'books';

--Task 11: Display all primary keys of tables in our database
SELECT table_catalog, table_schema, table_name, constraint_name 
FROM information_schema.table_constraints 
WHERE table_schema = 'public' AND constraint_type = 'PRIMARY KEY';

--Task 12: Drop table books and corresponding sequence
DROP TABLE books; 
DROP SEQUENCE books_seq;
