# COALESCE
SELECT
  company,
  COALESCE(company,'end_customer') AS company_clean
FROM Customers;


# CASE_WHEN
SELECT
  company,
  CASE
    WHEN company IS NULL THEN 'end_customer'
    ELSE 'Corporate'
  END AS Segment
FROM Customers;

# STRFTIME
SELECT
	invoicedate,
	CAST(STRFTIME('%Y', invoicedate)AS INT) AS year,
	STRFTIME('%m', invoicedate) AS month,
	STRFTIME('%d', invoicedate) AS day,
	STRFTIME('%Y-%m', invoicedate) AS year_month
FROM invoices;

# EXTRACT

# DATEDIFF

# NOW / CURRENT_DATE

# INTERVAL

# WITH_clauses
WITH usa_customers AS (
  SELECT * FROM customers
	WHERE country = 'USA'
), invoice_january_2009 AS (
   SELECT * FROM invoices
  WHERE invoicedate BETWEEN '2009-01-01' AND '2009-12-31'
)

SELECT
	SUM(Total) AS revenue_2009
FROM usa_customers AS t1
JOIN invoice_january_2009 AS t2
	ON t1.customerid = t2.customerid;

# SUBQUERIES
SELECT firstname, lastname, country FROM(SELECT *
					FROM customers
					WHERE lower(country) = 'usa'
																				
  
# CREATE_VIEW
CREATE VIEW invoice_jan_2009 AS
SELECT 
	invoicedate,
  billingaddress,
  billingcity,
  total,
  ROUND(total * 0.07,2) AS VAT
FROM invoices
WHERE invoicedate BETWEEN '2009-01-01' AND '2009-01-31';






















