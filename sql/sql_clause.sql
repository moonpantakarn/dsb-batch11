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
    firstname || SUBSTR(lastname, 1, 1) || 'gmail.com' AS email_company
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



  
# JOIN
# GROUP BY
# ORDER BY
# HAVING
