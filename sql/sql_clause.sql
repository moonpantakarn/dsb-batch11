# SELECT COLUMNS
  --- select all columns from customers
  SELECT *  FROM CUSTOMERS;

  --- select firstname, lastname, email columns from customers table
  SELECT
    firstname, 
    lastname,
    email
  FROM customers; 

  --- pipe operator
  SELECT
    firstname,
    lastname,
    firstname || ' ' || lastname AS fullname
  FROM customers; 
  
  --- substrings
  SELECT
    firstname,
    lastname,
    firstname || ' ' || lastname AS fullname,
    firstname || '.' || SUBSTR(lastname, 1, 3) || '@gmail.com' AS email_company
FROM customers;
  
# WHERE CLAUSE
  --- in operator
  SELECT
    customerid,
    firstname,
    lastname,
    country
  FROM customers
  WHERE LOWER(country) IN ('usa', 'canada','france');
  
  --- not in operator
  SELECT
    customerid,
    firstname,
    lastname,
    country
  FROM customers
  WHERE LOWER(country) NOT IN ('usa', 'canada','france');
  
  --- or operator
  SELECT
    customerid,
    firstname,
    lastname,
    country
  FROM customers
  WHERE LOWER(country) = 'usa' OR LOWER(country) = 'canada' OR LOWER(country) = 'france');

  --- like operator
  --- % = match any characters or _ = match single character
  SELECT 
    customerid,
    firstname,
    lastname,
    country,
    email
  FROM customers
  WHERE email LIKE 'E%';

  --- Between and
  SELECT 
    * 
  FROM INVOICES
  WHERE invoicedate BETWEEN '2009-01-01' AND '2009-01-31';

# JOIN
  --- inner join, if you want left or full join, just change in join lines
  SELECT
    genres.name,
    count(*) AS count_genres
  FROM genres
  JOIN tracks
    ON genres.GenreId = tracks.GenreId;

# GROUP BY
  SELECT
	  genres.name,
    count(*) AS count_genres
  FROM genres
  JOIN tracks
	  ON genres.GenreId = tracks.GenreId
  GROUP BY genres.name;
  
# HAVING
  --- filter values
  SELECT
   genres.name,
   count(*) AS count_genres
  FROM genres
  JOIN tracks
    ON genres.GenreId = tracks.GenreId
  GROUP BY genres.name
  HAVING count(*) >= 100;

# ORDER BY
  --- sort by ascending or descending
  SELECT
   genres.name,
   count(*) AS count_genres
  FROM genres
  JOIN tracks
    ON genres.GenreId = tracks.GenreId
  GROUP BY genres.name
  ORDER BY count(*) DESC;

# LIMIT
  --- show limit rows by n
  SELECT
   genres.name,
   count(*) AS count_genres
  FROM genres
  JOIN tracks
    ON genres.GenreId = tracks.GenreId
  GROUP BY genres.name
  ORDER BY count(*) DESC
  LIMIT 3;





