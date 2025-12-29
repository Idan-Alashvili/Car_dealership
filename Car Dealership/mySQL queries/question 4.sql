/* 
Question 4:
Can I have a view showing customers sales and include a column which shows the
difference in value from their previous sale? I want to see if new customers who
make their first purchase are likely to spend more.
*/
with main_cte AS
(
SELECT ordernumber, orderdate, customernumber, SUM(sales_value) AS sales_value
FROM
(SELECT o1.orderNumber,o1.orderDate,o1.customerNumber,productCode, quantityOrdered * priceEach AS sales_value
FROM orders o1
INNER JOIN orderdetails od1
ON o1.orderNumber = od1.orderNumber) main
GROUP BY ordernumber, orderdate,customernumber
),
sales_query as
(
SELECT t1.* , customername, row_number() OVER (partition by customername order by orderdate) as purchase_number, 
lag(sales_value) over (partition by customername order by orderdate) as prev_sales_value
FROM main_cte t1
INNER JOIN customers t2
ON t1.customernumber = t2.customernumber
)
SELECT * , sales_value - prev_sales_value as purchase_value_change
FROM sales_query
WHERE prev_sales_value is not null;