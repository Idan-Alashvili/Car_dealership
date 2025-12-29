/* 
Question 2:
Can you give me a breakdown of what products are commonly purchased together,
and any products that are rarely purchased together?
*/
with prod_sales as
(
SELECT orderNumber , t1.productCode, productLine
FROM orderdetails t1
INNER JOIN products p1
ON t1.productCode = p1.productCode
)
SELECT DISTINCT t1.orderNumber, t1.productLine AS product_one, t2.productLine AS product_two 
FROM prod_sales t1
LEFT JOIN prod_sales t2
ON t1.orderNumber = t2.orderNumber AND t1.productLine != t2.productLine;