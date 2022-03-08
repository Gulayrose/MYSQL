create DATABASE LibDatabase;
 USE LibDatabase;
CREATE SCHEMA Book;

CREATE SCHEMA   Person;



CREATE TABLE [Book].[Book](
    [Book_ID] [int] PRIMARY KEY NOT NULL,
	[Book_Name] [nvarchar](50) NOT NULL,
	Author_ID INT NOT NULL,
	Publisher_ID INT NOT NULL

);
CREATE TABLE [Book].[Author](
	[Author_ID] [int],
	[Author_FirstName] [nvarchar](50) Not NULL,
	[Author_LastName] [nvarchar](50) Not NULL
	);

--create Publisher Table
CREATE TABLE [Book].[Publisher](
	[Publisher_ID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Publisher_Name] [nvarchar](100) NULL
	);


CREATE TABLE [Person].[Person](
	[SSN] [bigint] PRIMARY KEY NOT NULL,
	[Person_FirstName] [nvarchar](50) NULL,
	[Person_LastName] [nvarchar](50) NULL
	);

--cretae Person.Person_Phone table
CREATE TABLE [Person].[Person_Phone](
	[Phone_Number] [bigint] PRIMARY KEY NOT NULL,
	[SSN] [bigint] NOT NULL	
	);

--cretae Person.Person_Mail table
CREATE TABLE [Person].[Person_Mail](
	[Mail_ID] INT PRIMARY KEY IDENTITY (1,1),
	[Mail] NVARCHAR(MAX) NOT NULL,
	[SSN] BIGINT UNIQUE NOT NULL	
	);


--create Person.Loan table
CREATE TABLE [Person].[Loan](
	[SSN] BIGINT NOT NULL,
	[Book_ID] INT NOT NULL,
	PRIMARY KEY ([SSN], [Book_ID])
	);



--insert--
INSERT INTO Person.Person(SSN,Person_FirstName,Person_LastName)
  VALUES (75056659595,'Zehra', 'Tekin');


SELECT * FROM Person.Person


INSERT INTO Person.Person(SSN,Person_FirstName)
VALUES (889623212466,'Kerem')

INSERT Person.Person VALUES (15078893526,'Mert','Yetiş')

INSERT Person.Person VALUES (55556698752, 'Esra', Null)


INSERT Person.Person VALUES (35532888963,'Ali','Tekin');-- Tüm tablolara değer atanacağı varsayılmıştır.
INSERT Person.Person VALUES (88232556264,'Metin','Sakin')

INSERT INTO Person.Person_Mail (Mail, SSN) 
VALUES ('zehtek@gmail.com', 75056659595),
	   ('meyet@gmail.com', 15078893526),
	   ('metsak@gmail.com', 35532558963)


select *
from Person.Person_Mail;





SELECT @@IDENTITY

select @@ROWCOUNT

select	*
into	Person.Person2
from	Person.Person

SELECT * 
from Person.Person
WHERE Person_FirstName like 'M%'

insert into Person.Person2
select *
FROM Person.Person
WHERE Person_FirstName like'M%'
 
 select *
 FROM Person.Person2

insert into Book.Publisher
default values;



UPDATE Person.Person2 SET Person_FirstName = 'Default_Name'

select *
FROM Person.Person2


UPDATE Person.Person2 SET Person_FirstName = 'Can'
 WHERE SSN = 75056659595

UPDATE Person.Person2
SET Person_FirstName = B.Person_FirstName
FROM Person.Person2 AS A 
Inner Join Person.Person AS B
ON A.SSN=B.SSN
WHERE B.SSN = 78962212466

--A= person.Person2 B= Person.Person--


SELECT *
FROM Person.Person2 AS A
Inner Join Person.Person as B
ON A.SSN=B.SSN


SELECT *
FROM Person.Person2 AS A
Inner Join Person.Person as B
ON A.SSN=B.SSN
WHERE B.SSN = 75056659595



UPDATE Person.Person2
SET Person_FirstName = B.Person_FirstName
FROM Person.Person2 AS A
Inner Join Person.Person as B
ON A.SSN=B.SSN
WHERE B.SSN = 75056659595



--DELETE--
--TRUNCATE table book.publisher  --buda tablolardaki row lari bosaltir delete gibi--
Delete from Book.Publisher 
 select *
 FROM Book.Publisher

 insert Book.Publisher values ('İLETİŞİM')
insert Book.Publisher values ('BILESIM')


DELETE FROM BOOK.Publisher
WHERE Publisher_Name = 'BILESIM'


DROP TABLE Person.Person2;
TRUNCATE TABLE Person.Person_Mail;
TRUNCATE TABLE Person.Person;
TRUNCATE TABLE Book.Publisher;

ALTER TABLE Book.Book
ADD CONSTRAINT FK_Author
FOREIGN KEY (Author_ID)
REFERENCES Book.Author (Author_ID);

ALTER TABLE Book.Author
ADD CONSTRAINT pk_author
PRIMARY KEY (Author_ID)

ALTER TABLE Book.Author
ALTER COLUMN Author_ID
INT NOT NULL;

ALTER TABLE Person.Loan
ADD CONSTRAINT FK_PERSON
FOREIGN KEY (SSN)
REFERENCES Person.Person (SSN)

ALTER TABLE Person.Loan 
ADD CONSTRAINT FK_book 
FOREIGN KEY (Book_ID) 
REFERENCES Book.Book (Book_ID)

Alter table Person.Person_Mail 
add constraint FK_Person4 
Foreign key (SSN) 
References Person.Person(SSN)