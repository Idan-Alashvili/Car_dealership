/* 
Question 6:
We have discovered that shipping is delayed due to the weather and it’s possible
they will take up to 3 days to arrive.
Can you get me a list of affected orders?
*/
SELECT * ,date_add(shippeddate , interval 3 day) AS latetest_arrival,
CASE WHEN date_add(shippeddate , interval 3 day) > requiredDate then 1 else 0 end AS late_flag
FROM orders
WHERE (CASE WHEN date_add(shippeddate , interval 3 day) > requiredDate then 1 else 0 end) = 1;