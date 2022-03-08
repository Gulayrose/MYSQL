--- march5
---list product with category names
---Select product ID, product name, category ID and category names

SELECT A.product_id,A.product_name , B.category_id,B.category_name
FROM product.product A 
INNER JOIN product.category B ON A.category_id = B.category_id

---list employees of stores with their store information
--- select employee name,surname,storename

SELECT A.first_name,A.last_name,B.store_name
From sale.staff A
INNER JOIN sale.store B ON A.store_id = B.store_id


--Write a query that returns count of orders of the states by months.

SELECT A.[state], YEAR(B.order_date) YEAR1,
MONTH(B.order_date) MOUNTH1,
COUNT(DISTINCT order_id) NUM_COUNT
from sale.customer A, sale.orders B 
WHERE A.customer_id = B.customer_id
GROUP BY A.[state],YEAR(B.order_date),MONTH(B.order_date)



SELECT 
    A.state,
    YEAR(B.order_date) YEAR1,
    MONTH(B.order_date) MONTH1,
    COUNT(DISTINCT order_id) NUM_COUNT
FROM sale.customer A 
INNER JOIN sale.orders B
ON A.customer_id = B.customer_id
GROUP BY 
    A.state,
    YEAR(B.order_date),
    MONTH(B.order_date);

---LEFT JOIN
-- Write a query that returns products that have never been ordered
--Select product ID, product name, orderID
--(Use Left Join)

SELECT
    A.product_id,
    A.product_name,
    B.order_id
FROM product.product A
LEFT JOIN sale.order_item B 
ON A.product_id = B.product_id
WHERE B.order_id IS NULL;


--Report the stock status of the products that product id greater than 310 in the stores.
--Expected columns: Product_id, Product_name, Store_id, quantity

SELECT a.product_id,
       a.product_name,
       b.store_id,
       b.quantity
FROM product.product a 
LEFT JOIN product.stock b 
ON a.product_id = b.product_id
WHERE a.product_id > 310;

--
--RIGHT join

--Report the stock status of the products that product id greater than 310 in the stores.
--Expected columns: Product_id, Product_name, Store_id, quantity

SELECT b.product_id , b.product_name, a.*
FROM product.stock a 
RIGHT JOIN product.product b 
ON a.product_id = b.product_id
WHERE b.product_id > 310;


--- -------Report the orders information made by all staffs.
--Expected columns: Staff_id, first_name, last_name, all the information about orders

SELECT b.staff_id,b.first_name,b.last_name ,a.*
FROM sale.orders a 
RIGHT JOIN sale.staff b 
ON a.staff_id=b.staff_id;

--- FULL OUTER JOIN 

--Write a query that returns stock and order information together for all products . (TOP 100)
--Expected columns: Product_id, store_id, quantity, order_id, list_price

SELECT TOP 100 a.product_id,b.store_id,b.quantity ,c.order_id,c.list_price
from product.product a 
FULL OUTER JOIN product.stock b 
ON a.product_id = b.product_id 
FULL OUTER JOIN sale.order_item c 
ON a.product_id = c.product_id


SELECT TOP 100 a.product_id,b.store_id,b.quantity ,c.order_id,c.list_price
from product.product a 
FULL OUTER JOIN product.stock b 
ON a.product_id = b.product_id 
FULL OUTER JOIN sale.order_item c 
ON a.product_id = c.product_id
ORDER BY store_id

---CROSS JOIN
/*
In the stocks table, there are not all products held on the product table and you 
want to insert these products into the stock table.

You have to insert all these products for every three stores with "0" quantity.

Write a query to prepare this data.
*/





--self join
--Write a query that returns the staffs with their managers.
--Expected columns: staff first name, staff last name, manager name

SELECT a.first_name,b.first_name manager_name 
FROM sale.staff a 
JOIN sale.staff b ON a.manager_id = b.staff_id


--2.way

SELECT A.first_name AS Staff_Name, A.last_name AS Staff_Last, B.first_name AS Manager
FROM sale.staff A, sale.staff B
WHERE  A.manager_id = B.staff_id


----
-------Write a query that returns the 1st and 2nd degree managers of all staff

SELECT a.first_name, b.first_name manager_name, c.first_name director
FROM sale.staff a 
JOIN sale.staff b ON a.manager_id = b.staff_id
JOIN sale.staff c ON b.manager_id = c.staff_id




----view olusturma
CREATE VIEW CUSTOMER_PRODUCT
AS
SELECT	distinct D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'



SELECT *
FROM [dbo].[CUSTOMER_PRODUCT]