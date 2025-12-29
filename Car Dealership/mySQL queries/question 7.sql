/* 
Question 7:
Please can you send me a breakdown of each customer and their sales, but include
a money owed column as I would like to see if any customers have gone over their
credit limit.
*/
WITH cte_sales as
(
SELECT orderDate, o1.orderNumber, o1.customerNumber, customerName, productCode, creditLimit, quantityOrdered * priceEach AS sales_value
FROM orders o1
INNER JOIN orderdetails od1
ON o1.orderNumber = od1.orderNumber
INNER JOIN customers c1
ON o1.customerNumber = c1.customerNumber
),
running_total_sales_cte AS
(
SELECT * , lead(orderdate) over (partition by customernumber order by orderdate) as next_order_date
FROM
(
SELECT orderdate, ordernumber, customernumber, customername, creditlimit, SUM(sales_value) AS sales_value
FROM cte_sales
GROUP BY orderdate, ordernumber, customernumber, customername, creditlimit
) subquerry)
,
payments_cte AS
(SELECT *
FROM payments),

main_cte AS
(
SELECT t1.*, 
SUM(sales_value) over (partition by t1.customernumber order by orderdate) AS running_total_sales,
SUM(amount) over (partition by t1.customerNumber order by orderdate) AS running_total_payments
FROM running_total_sales_cte t1
LEFT JOIN payments_cte t2
ON t1.customernumber = t2.customernumber and t2.paymentdate BETWEEN t1.orderdate and  CASE WHEN t1.next_order_date is null then current_date else next_order_date end
)

SELECT *, running_total_sales - running_total_payments as money_owed,
creditlimit - (running_total_sales - running_total_payments) as difference
FROM main_cte