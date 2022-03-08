---march 7


--cross join hw

--In the stocks table, there are not all products held on the product table and you
--want to insert these products into the stock table.
--You have to insert all these products for every three stores with “0” quantity.
--Write a query to prepare this data.

-- stok da olamayip produck ta olan  ve quantityleri 0 olan 


SELECT b.store_id, a.product_id ,0 AS QUANTITY 
FROM product.product a 
CROSS JOIN sale.store b
WHERE a.product_id NOT IN (
    SELECT product_id
    FROM product.stock
   )
ORDER BY a.product_id , b.store_id   


-----ADVANCED GROUP OPERATION

---Write a query that checks if any product id is repeated in more than one row in the product table

SELECT product_id , COUNT(product_id) num_of_rows
FROM product.product
GROUP BY product_id
HAVING COUNT(product_id) > 1  --sonucu bos cikacak demekki tekrar eden row yokmus 




---WRITE a query that returns category ids with a max list price above 4000  or a min list price below 500.

SELECT category_id , list_price
FROM product.product
ORDER BY category_id , list_price



SELECT category_id ,  MAX(list_price) > 4000 AS max_price ,  MIN(list_price) < 500 AS min_price 
FROM product.product
GROUP BY category_id 
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500

SELECT category_id, MAX(list_price) as max_price, MIN(list_price) as min_price
FROM product.product
GROUP BY category_id
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500

--find the average product price of the brands.
-- as a result of the query,the average prices should be displayed in descending order.


SELECT B.brand_name , AVG(list_price) as avg_list_price
FROM product.product A 
JOIN product.brand  B 
ON A.brand_id = B.brand_id
GROUP BY B.brand_name 

ORDER BY avg_list_price DESC; --kisitlama vermedigi icin having kullanmadik.filtreme vermedigi icin 
--2.yol
SELECT B.brand_name, AVG(list_price) avg_list_price
FROM product.product A, product.brand B
WHERE A.brand_id = B.brand_id
GROUP BY B.brand_name
ORDER BY avg_list_price DESC


--write a query that returns BRANDS with an average product price of more than 1000
--yukardsaki sonun aynisi ama bu sefer 1000 den fazla olmasi kisiti koymus 

SELECT B.brand_name, AVG(list_price) avg_list_price
FROM product.product A, product.brand B
WHERE A.brand_id = B.brand_id
GROUP BY B.brand_name
HAVING AVG(A.list_price) > 1000
ORDER BY AVG(A.list_price) DESC; 

---homework
---write a query that returns the net price paid by the customer for each order(dont neglect discount an quantities) 
--bir siparişin toplam net tutarını getiriniz. (müşterinin sipariş için ödediği tutar)
--discount' ı ve quantity' yi ihmal etmeyiniz.

---quantity * list_price * (1-discount) 

select order_id,sum(quantity * list_price * (1-discount))  as net_price
from sale.order_item
GROUP BY order_id






SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sale.sales_summary

FROM	sale.order_item A, product.product B, product.brand C, product.category D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year




---GROUPING SETS 

SELECT *
FROM sale.sales_summary 


 --1.Calculate the total sales price


SELECT SUM(total_sales_price)
FROM sale.sales_summary

--2. calculate the total sales price of teh brands  

SELECT Brand ,SUM(total_sales_price) total
FROM sale.sales_summary
GROUP BY Brand

---3.calculate the total sales price of the categories

SELECT Category , SUM(total_sales_price) TOTAL1
FROM sale.sales_summary
GROUP BY Category 

---4.calculate the total sales price by brands and categories.

SELECT Brand , Category, SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY Brand , Category

--- grouping set ile yukardaki 4 kodu birlestirme

SELECT Brand , Category, SUM(total_sales_price) TOTAL
FROM sale.sales_summary
GROUP BY 
    GROUPING SETS(
       (),(Brand),(Category),(Brand,Category)
    )
ORDER BY Brand,Category    



---ROLLUP

--Generate difeerent grouping variations that can be produced with the brand and category columns using 'ROLLUP'
--Claculate sum total_sales_price

-----brand, category, model_year sütunları için Rollup kullanarak total sales hesaplaması yapın.
--üç sütun için 4 farklı gruplama varyasyonu üretiyor

--*/Roll up
--önce 3 lü grupluyor
--sonra 2 li grupluyor
--sonra 1,li grupluyor
--sonra da hepsinin aggregate'ni aliyor