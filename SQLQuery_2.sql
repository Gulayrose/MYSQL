---Built- in functions 

--march 3, 2022

CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
	)

SELECT * FROM t_date_time

SELECT GETDATE()

INSERT t_date_time VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

SELECT * FROM t_date_time

INSERT t_date_time (A_time, A_date, A_smalldatetime, A_datetime, A_datetime2, A_datetimeoffset)
VALUES ('12:00:00', '2021-07-17', '2021-07-17','2021-07-17', '2021-07-17', '2021-07-17' )

SELECT CONVERT(VARCHAR,  GETDATE(),7)

SELECT CONVERT(DATE,'25 OCT 21',6)


   


SELECT	A_date,
		DATENAME(DW, A_date) [DAY],
		DAY (A_date) [DAY2],
		MONTH(A_date),
		YEAR (A_date),
		A_time,
		DATEPART (NANOSECOND, A_time),
		DATEPART (MONTH, A_date)
FROM	t_date_time

----datediff iki zaman arasindaki gun saat hesaplar 

SELECT	A_date,	
		A_datetime
FROM	t_date_time




SELECT	A_date,	
		A_datetime,
		DATEDIFF (DAY, A_date, A_datetime) Diff_day,
		DATEDIFF (MONTH, A_date, A_datetime) Diff_month,
		DATEDIFF (YEAR, A_date, A_datetime) Diff_month,
		DATEDIFF (HOUR, A_smalldatetime, A_datetime) Diff_Hour,
		DATEDIFF (MINUTE, A_smalldatetime, A_datetime) Diff_Hour
FROM	t_date_time

--

SELECT order_date,
       shipped_date, 
       DATEDIFF(DAY , order_date,shipped_date) Diff_dayb -- eger burda order ile shipped day leri yer
                                                          --degistirirsek negatif sonuc aliriz
FROM sale.orders       


---- DATEADD EOMONTH

SELECT * 
FROM [sale].[orders]
  
 SELECT order_date,  
         DATEADD(YEAR,3 ,order_date) new_year, --yillara 3 yil ekledik
         DATEADD(DAY, -5, order_date) new_day  --gunlerden 5 gun cikarttik
  FROM [sale].[orders] 


SELECT order_date,
		DATEADD (YEAR, 3, order_date) [new_year],
		DATEADD (DAY, -5, order_date) [new_day]
FROM [sale].[orders]


--EOMONTH

SELECT EOMONTH(order_date) LAST_DAY, order_date, EOMONTH(order_date, 2) after_2
FROM [sale].[orders]


SELECT EOMONTH(order_date) LAST_DAY, order_date, EOMONTH(order_date, 2) after_2
FROM [sale].[orders]




---ISDATE   BOOL DONDURUR.

SELECT ISDATE('123456')


SELECT ISDATE('2022-03-03')



SELECT order_date,
        DATEADD (YEAR, 3, (DATEADD (DAY, -5, order_date))) [new_date]
FROM [sale].[orders]   -- ayni anda hem gun yil eklenebilir.




--- len/charindex/pathindex


SELECT len (123456)


SELECT len ('wlecome') -- tirnak koymazsak hata verir.

SELECT CHARINDEX('C','CHARACTER')

SELECT CHARINDEX('C','CHARACTER',2)

SELECT CHARINDEX('CT','CHARACTER',2)

---PATIDEX

SELECT PATINDEX('%R','CHARACTER') -- r den once kac tane r kacinci index

SELECT PATINDEX('R%','CHARACTER') -- r den sonra 

SELECT PATINDEX('___R%','CHARACTER')

--% tüm karakterleri temsil ediyor
--(_) bir karakteri temsil ediyor



--LEFT RIGHT-SUBSTRING

SELECT LEFT('CHARACTER', 3)

SELECT LEFT(' CHARACTER', 3)

SELECT RIGHT('CHARACTER', 3)
SELECT RIGHT('CHARACTER ', 3)


SELECT SUBSTRING( 'CHARACTER', 3, 5)

SELECT SUBSTRING( 'CHARACTER', -1, 5)


 ----How to grow the first character of the 'character' word.
 ---- CIKTI: Character

SELECT UPPER(LEFT('character',1)) + LOWER(RIGHT('character',8))

SELECT UPPER()(left('character',1)) + LOWER (RIGHT('character',LEN ('character')-1))
 
 SELECT 'A'+'B' 

 SELECT * FROM STRING_SPLIT ('John, Jeremy, Jack, George', ',')


----LTIRM.RTIRM,TRIM

 SELECT TRIM('   CLARUSWAY')

 SELECT TRIM('   CLARUSWAY   ')

 SELECT TRIM('   CLAR   USWAY   ')



SELECT TRIM('?, ' FROM '    ?SQL Server,    ') AS TrimmedString;

 SELECT LTRIM('   CLARUSWAY   ')


-- REPLACE & STR

SELECT REPLACE('character string',' ','/')


SELECT STR(54536) -- toplamda 10 chacter olmasi gerek oldugu icin bastan 5 hane bos cikti verdi

SELECT STR(123456789)

SELECT STR(163376745583732) -- buda cok oldugu icin * dondurdu

SELECT STR(3647 , 10,5) --toplamda 10 hane getir virgulden sonra 5 hane olsun 

SELECT STR(133215.6746547, 11, 3 ) --toplamda 11 basamak olsun virgulden sonra 3 getir yuvarlayip 

---CAST/CONVERT/COALESCE/NULLIF ROUND

SELECT CAST(456123 AS CHAR)

SELECT CAST (456.123 AS INT)


SELECT CONVERT (INT, 30.60)

SELECT CONVERT (VARCHAR(10), '2020-10-10')

SELECT COALESCE (NULL,NULL,'Hi','Hello',NULL) result;

SELECT NULLIF (10,10)

SELECT NULLIF ('Hello','Hi') result;

SELECT ROUND (432.368, 2, 0) -- 0 yukari yuvarlar 1 asagi yuvarlar

SELECT ROUND (432.368, 2, 1)
SELECT ROUND (432.368, 2) -- yazmazsak birsey direk uste yuvarlar 