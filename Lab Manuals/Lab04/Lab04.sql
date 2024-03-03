create database lab04
go
create table Users
(
userID int primary key,
Name varchar(25) not NULL,
phoneNo varchar(12),
city varchar(25)
)

create table cardTypes
(
cardTypeID int primary key,
name varchar(10) not NULL,
Description varchar(50)
)

create table Cardss(
cardNo int primary key,
cardTypeID int foreign key references cardTypes(cardTypeID),
PIN int not NULL,
expiry Date not NULL,
balance int
)

create table UserCardsss
(
userID int foreign key references users(userID),
cardNo int primary key foreign key references Cardss(cardNo),
)

create table Transactionss(
transID int primary key,
transDate date,
cardNo int foreign key references Cardss(cardNo),
amount int not NULL
)

INSERT INTO Users
VALUES ( 1, 'Ali', '03036067000', 'Narowal'),
  ( 2, 'Ahmed', '03036047000', 'Lahore'),
  ( 3, 'Aqeel', '03036063000', 'Karachi'),
  ( 4, 'Usman', '03036062000', 'Sialkot'),
  ( 5, 'Hafeez', '03036061000', 'Lahore')

SELECT * FROM Users

INSERT INTO Cardss
VALUES ( 1234, 1, 1770, '2022-07-04',43025 ),
  ( 1235, 1, 9234, '2020-03-02', 14425),
  ( 1236, 1, 1234, '2019-02-06', 34325),
  ( 1237, 2, 1200, '2021-02-05', 24325 ),
  ( 1238, 2,9004, '2020-09-02', 34025)

Select * FROM Cardss

INSERT INTO cardTypes
VALUES (1, 'Debit', 'Spend Now, Pay Now'),
(2, 'Credit', 'Spend Now, Pay Later')

Select * FROM cardTypes

INSERT INTO UserCardsss
VALUES (1, 1234),
		(1, 1235),
		(2, 1236),
		(3, 1238)

Select * FROM UserCardsss

INSERT INTO Transactionss
VALUES (1, '2017-02-02', 1234, 500),
(2, '2018-02-03', 1235, 3000),
(3, '2017-05-06', 1236, 2500),
(4, '2016-09-09', 1238, 2000),
(5, '2015-02-10', 1234, 6000)

Select * FROM Transactionss

-----
SELECT * FROM Users
Select * FROM Cardss
Select * FROM cardTypes
Select * FROM UserCardsss
Select * FROM Transactionss

--1
SELECT ct.name AS cardType, COUNT(DISTINCT uc.userID) AS numUniqueUsers
FROM cardTypes ct
JOIN Cardss c ON c.cardTypeID = ct.cardTypeID
JOIN UserCardsss uc ON uc.cardNo = c.cardNo
GROUP BY ct.name

--2
SELECT c.cardNo, u.Name
FROM Cardss c
JOIN UserCardsss uc ON uc.cardNo = c.cardNo
JOIN Users u ON uc.userID = u.userID
WHERE c.balance BETWEEN 20000 AND 40000

--3a
SELECT Name
FROM Users
WHERE userID NOT IN (
    SELECT userID
    FROM UserCardsss
)

--3b
SELECT u.Name
FROM Users u
LEFT JOIN UserCardsss uc ON u.userID = uc.userID
WHERE uc.userID IS NULL

--4a
SELECT c.cardNo, ct.name, u.Name
FROM Cardss c
JOIN cardTypes ct ON c.cardTypeID = ct.cardTypeID
JOIN UserCardsss uc ON uc.cardNo = c.cardNo
JOIN Users u ON uc.userID = u.userID
WHERE c.cardNo NOT IN (
    SELECT cardNo
    FROM Transactionss
    WHERE transDate >= '2018-01-01' AND transDate < '2019-01-01'
)
--4b
SELECT c.cardNo, ct.name, u.Name
FROM Cardss c
JOIN cardTypes ct ON c.cardTypeID = ct.cardTypeID
JOIN UserCardsss uc ON uc.cardNo = c.cardNo
JOIN Users u ON uc.userID = u.userID
LEFT JOIN Transactionss t ON c.cardNo = t.cardNo
WHERE t.transDate IS NULL OR t.transDate < '2018-01-01' OR t.transDate >= '2019-01-01'

--5
SELECT ct.name AS cardType, COUNT(*) AS numCardsWithTotalOver6000
FROM cardTypes ct
JOIN Cardss c ON c.cardTypeID = ct.cardTypeID
JOIN Transactionss t ON t.cardNo = c.cardNo
WHERE t.transDate >= '2015-01-01' AND t.transDate < '2018-01-01'
GROUP BY ct.name
HAVING SUM(t.amount) > 6000

--6
SELECT u.userID, u.Name, u.phoneNo, u.city, c.cardNo, ct.name AS cardType
FROM Users u
JOIN UserCardsss uc ON u.userID = uc.userID
JOIN Cardss c ON c.cardNo = uc.cardNo
JOIN cardTypes ct ON c.cardTypeID = ct.cardTypeID
WHERE c.expiry >= DATEADD(month, -3, GETDATE())
AND c.expiry < DATEADD(month, 3, GETDATE())

--7
SELECT u.userID, u.Name
FROM Users u
JOIN UserCardsss uc ON u.userID = uc.userID
JOIN Cardss c ON c.cardNo = uc.cardNo
GROUP BY u.userID, u.Name
HAVING SUM(c.balance) >= 5000

--8
SELECT c1.cardNo AS cardNo1, c2.cardNo AS cardNo2, YEAR(c1.expiry) AS expiryYear
FROM Cardss c1
INNER JOIN Cardss c2 ON YEAR(c1.expiry) = YEAR(c2.expiry) AND c1.cardNo <> c2.cardNo
ORDER BY expiryYear, c1.cardNo, c2.cardNo

--9
SELECT u1.Name, u2.Name
FROM Users u1
INNER JOIN Users u2 ON u1.userID <> u2.userID
WHERE SUBSTRING(u1.Name, 1, 1) = SUBSTRING(u2.Name, 1, 1)

--10
SELECT u.Name, u.userID
FROM Users u
JOIN UserCardsss uc ON u.userID = uc.userID
JOIN Cardss c ON c.cardNo = uc.cardNo
WHERE c.cardTypeID IN (
  SELECT cardTypeID
  FROM cardTypes
  WHERE name IN ('Credit', 'Debit')
)
GROUP BY u.Name, u.userID
HAVING COUNT(DISTINCT c.cardTypeID) = 2

--11
SELECT u.city, COUNT(DISTINCT u.userID) AS numUsers, SUM(t.amount) AS totalTransacted
FROM Users u
LEFT JOIN UserCardsss uc ON u.userID = uc.userID
LEFT JOIN Cardss c ON c.cardNo = uc.cardNo
LEFT JOIN Transactionss t ON t.cardNo = c.cardNo
GROUP BY u.city
ORDER BY totalTransacted DESC, numUsers DESC
