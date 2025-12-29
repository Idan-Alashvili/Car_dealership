/* 
Question 1:
Can you please give me an overview of sales for 2004?
I would like to see a breakdown by product, country and city and please include the
sales value, cost of sales and net profit.
*/
SELECT o1.orderDate , o1.orderNumber, quantityOrdered, priceEach, productName, productLine, buyPrice, city, country
FROM orders o1
INNER JOIN orderdetails od1
ON o1.orderNumber = od1.orderNumber
INNER JOIN products p1
ON od1.productCode = p1.productCode
INNER JOIN customers c1
ON o1.customerNumber = c1.customerNumber
WHERE YEAR(orderDate) = 2004;
-- This query intentionally returns row-level data for downstream Excel analysis.
