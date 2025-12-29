
/* 
Question 5:
Can you show me a view of where the customers of each office are located?
*/
WITH main_cte AS
(
SELECT o1.orderNumber, od1.productCode, od1.quantityOrdered,od1.priceEach, quantityOrdered * priceEach AS sales_value ,c1.city AS customer_city,
c1.country AS customer_country, p1.productLine,o2.city AS office_city, o2.country AS office_country
FROM orders o1
INNER JOIN orderdetails od1
ON o1.orderNumber = od1.orderNumber
INNER JOIN customers c1
ON o1.customerNumber = c1.customerNumber
INNER JOIN products p1
ON od1.productCode = p1.productCode
INNER JOIN employees e1
ON c1.salesRepEmployeeNumber = e1.employeeNumber
INNER JOIN offices o2
ON e1.officeCode = o2.officeCode
)

SELECT ordernumber, customer_city,customer_country, productline, office_city, office_country, SUM(sales_value) AS sales_value
FROM main_cte
GROUP BY ordernumber, customer_city,customer_country, productline, office_city, office_country;
