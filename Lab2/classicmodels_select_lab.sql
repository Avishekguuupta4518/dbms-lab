/* =========================================================
   Classic Models Database
   Lab: Understanding SELECT Queries in MySQL
   Database: classicmodels
   ========================================================= */


/* ---------------------------------------------------------
1. Retrieve all columns and all rows from employees table
   Purpose: View complete employee data
--------------------------------------------------------- */
SELECT * 
FROM employees;


/* ---------------------------------------------------------
2. Retrieve only last name, first name, and job title
   Purpose: Display basic employee identity and role
--------------------------------------------------------- */
SELECT lastName, firstName, jobTitle
FROM employees;


/* ---------------------------------------------------------
3. Find employees whose job title is President
   Purpose: Identify top-level management
--------------------------------------------------------- */
SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'President';


/* ---------------------------------------------------------
4. Retrieve unique job titles from employees
   Purpose: List distinct roles in the organization
--------------------------------------------------------- */
SELECT DISTINCT jobTitle
FROM employees;


/* ---------------------------------------------------------
5. Sort employees by first name (ascending)
   and job title (descending)
   Purpose: Ordered presentation of employee data
--------------------------------------------------------- */
SELECT firstName, lastName, jobTitle
FROM employees
ORDER BY firstName ASC, jobTitle DESC;


/* ---------------------------------------------------------
6. Retrieve distinct city and state from customers
   Purpose: Identify unique customer locations
--------------------------------------------------------- */
SELECT DISTINCT city, state
FROM customers;


/* ---------------------------------------------------------
7. Retrieve first 5 employees
   Purpose: Limit result set for preview/testing
--------------------------------------------------------- */
SELECT firstName, lastName
FROM employees
LIMIT 5;


/* ---------------------------------------------------------
8. Retrieve 5 employees starting from the 11th record
   Purpose: Demonstrate pagination (OFFSET = 10)
--------------------------------------------------------- */
SELECT firstName, lastName
FROM employees
LIMIT 10, 5;


/* ---------------------------------------------------------
9. Retrieve offices located in USA or France
   Purpose: Filter data using IN clause
--------------------------------------------------------- */
SELECT officeCode, city, phone
FROM offices
WHERE country IN ('USA', 'France');


/* ---------------------------------------------------------
10. Same as Query 9 (duplicate query)
    Purpose: Reinforces use of IN operator
--------------------------------------------------------- */
SELECT officeCode, city, phone
FROM offices
WHERE country IN ('USA', 'France');


/* ---------------------------------------------------------
11. Find order numbers where total order value > 60000
    Purpose: Identify high-value orders using GROUP BY
--------------------------------------------------------- */
SELECT orderNumber
FROM orderDetails
GROUP BY orderNumber
HAVING SUM(quantityOrdered * priceEach) > 60000;


/* ---------------------------------------------------------
12. Retrieve details of high-value orders (> 60000)
    Purpose: Subquery usage with IN clause
--------------------------------------------------------- */
SELECT orderNumber, customerNumber, status, shippedDate
FROM orders
WHERE orderNumber IN (
    SELECT orderNumber
    FROM orderDetails
    GROUP BY orderNumber
    HAVING SUM(quantityOrdered * priceEach) > 60000
);


/* ---------------------------------------------------------
13. Find employees whose first name starts with 'A'
    Purpose: Pattern matching using LIKE
--------------------------------------------------------- */
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'A%';


/* ---------------------------------------------------------
14. Find employees whose last name ends with 'on'
    Purpose: Suffix pattern search
--------------------------------------------------------- */
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName LIKE '%on';


/* ---------------------------------------------------------
15. Find employees whose last name does NOT start with 'B'
    Purpose: Exclusion using NOT LIKE
--------------------------------------------------------- */
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName NOT LIKE 'B%';


/* ---------------------------------------------------------
16. Combine customer and employee names using UNION
    Purpose: Merge data from different tables
--------------------------------------------------------- */
SELECT customerNumber AS id, contactLastName AS name
FROM customers
UNION
SELECT employeeNumber AS id, firstName AS name
FROM employees;


/* ---------------------------------------------------------
17. UNION with ORDER BY
    Purpose: Sorted combined result set
--------------------------------------------------------- */
(
  SELECT customerNumber AS id, contactLastName AS name
  FROM customers
)
UNION
(
  SELECT employeeNumber AS id, firstName AS name
  FROM employees
)
ORDER BY name, id;


/* ---------------------------------------------------------
18. UNION without aliases, ordered by columns
    Purpose: Demonstrates column-based ordering
--------------------------------------------------------- */
(
  SELECT customerNumber, contactLastName
  FROM customers
)
UNION
(
  SELECT employeeNumber, firstName
  FROM employees
)
ORDER BY contactLastName, customerNumber;


/* ---------------------------------------------------------
19. INNER JOIN between products and orderDetails
    Purpose: Show which products appear in which orders
--------------------------------------------------------- */
SELECT p.productCode, p.productName, o.orderNumber
FROM products p
INNER JOIN orderDetails o
ON p.productCode = o.productCode;


/* ---------------------------------------------------------
20. LEFT JOIN customers with orders
    Purpose: Show all customers including those
             who have not placed any orders
--------------------------------------------------------- */
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers c
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber;
