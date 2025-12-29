/*
Question 3:
Can you show me a breakdown of sales, but also show their credit limit?
Maybe group the credit limits as I want a high level view to see if we get higher sales
for customers who have a higher credit limit which we would expect.
*/
WITH sales AS (
SELECT o1.orderNumber, o1.customerNumber, productCode, quantityOrdered, priceEach, priceEach * quantityOrdered AS sales_value, creditLimit
FROM orders o1
INNER JOIN orderdetails od1
ON o1.orderNumber = od1.orderNumber
INNER JOIN customers c1
ON o1.customerNumber = c1.customerNumber
)
SELECT ordernumber, customernumber,
CASE WHEN creditlimit < 75000 then 'a: Less than 75k'
WHEN creditlimit BETWEEN 75000 AND 100000 then 'b: 75k - 100k'
WHEN creditlimit BETWEEN 100000 AND 150000 then 'c: 100k - 150k'
WHEN creditlimit > 150000 then 'd: Over 150k'
ELSE 'Other'
END AS creditlimit_group,
SUM(sales_value) as sales_value
FROM sales
GROUP BY ordernumber, customernumber, creditlimit;