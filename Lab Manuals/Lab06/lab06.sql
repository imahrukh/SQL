use master
go 
Create database lab06
go 
use lab06
go


create table [UserType](
[userTypeId] int primary key,
[name] varchar(20) not null
)
go

create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[userType] int foreign key references UserType([userTypeId]),
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go

create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go

Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go

create table TransactionType(
[transTypeID] int primary key,
[typeName] varchar(15),
[description] varchar(40) null
)
go

create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null,
transType int foreign key references TransactionType(transTypeID)
)
go

INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (1, N'Silver')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (2, N'Gold')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (3, N'Bronze')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (4, N'Common')
GO

INSERT [dbo].[User] ([userId], [name], [userType],[phoneNum], [city]) VALUES (1, N'Ali',2, N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name],  [userType],[phoneNum], [city]) VALUES (2, N'Ahmed',1, N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (3, N'Aqeel',3, N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (4, N'Usman',4,  N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (5, N'Hafeez',2, N'03036061000', N'Lahore')
GO

INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (3, N'Gift', N'Enjoy')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6569', 3, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3336', 3, N'0234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6566', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6456', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3436', 2, N'0034', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'6569')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'3336')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'6566')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'3436')
GO

INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (1, N'Withdraw')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (2, N'Deposit')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (3, N'Scheduled')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (4, N'Failed')
GO

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (1, CAST(N'2017-02-02' AS Date), N'6569', 500,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (2, CAST(N'2018-02-03' AS Date), N'3436', 3000,3)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (3, CAST(N'2017-05-06' AS Date), N'6566', 2500,2)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (4, CAST(N'2016-09-09' AS Date), N'6566', 2000,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (5, CAST(N'2015-02-10' AS Date), N'3336', 6000,4)
GO

Select * from UserType
Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
Select * from TransactionType

--1-List the card numbers of those cards that are not used for transaction. (Hint: IN)
SELECT Card.cardNum
FROM Card
LEFT JOIN [Transaction] ON Card.cardNum = [Transaction].cardNum
WHERE [Transaction].transId IS NULL

--2-List the name of the user who has maximum balance in his/her card (One person can have more than 1 card, check cards individually for max balance)
SELECT  u.name FROM [User] u INNER JOIN UserCard AS uc ON u.userId = uc.userID 
INNER JOIN (SELECT cardNum, MAX(balance) AS maxBalance
  FROM [Card] GROUP BY cardNum) AS maxBalances
ON uc.cardNum = maxBalances.cardNum


--3- List the user names with their UserType name without using join.
SELECT [User].name, UserType.name AS UserTypeName
FROM [User], UserType
WHERE [User].userType = UserType.userTypeId

--4-List all the users made failed transactions.
SELECT DISTINCT u.name
FROM [User] u
INNER JOIN UserCard uc ON u.userId = uc.userID
INNER JOIN Card c ON uc.cardNum = c.cardNum
INNER JOIN [Transaction] t ON c.cardNum = t.cardNum
INNER JOIN TransactionType tt ON  t.transType=tt.transTypeID
WHERE tt.typeName = 'Failed'

 --5- List the user who has made maximum transactions.
SELECT u.name, COUNT(*) AS transactionCount
FROM [User] u
INNER JOIN UserCard uc ON u.userId = uc.userID
INNER JOIN Card c ON uc.cardNum = c.cardNum
INNER JOIN [Transaction] t ON c.cardNum = t.cardNum
GROUP BY u.name
HAVING count(u.name) = (
  SELECT MAX(transactionCount)
  FROM (
    SELECT [User].name, COUNT(*) AS transactionCount
    FROM [User]
    INNER JOIN UserCard ON [User].userId = UserCard.userID
    INNER JOIN Card ON UserCard.cardNum = Card.cardNum
    INNER JOIN [Transaction] ON Card.cardNum = [Transaction].cardNum
    GROUP BY [User].name
  ) AS transactionCountSubquery
)

--6-List the userTypes of users who have credit cards, in the descending order according to the count of cards.
SELECT ut.name AS userTypeName, COUNT(uc.cardNum) AS cardCount
FROM [UserType] ut
LEFT JOIN [User] u ON ut.userTypeId = u.userType
LEFT JOIN UserCard uc ON u.userId = uc.userID
LEFT JOIN Card c ON uc.cardNum = c.cardNum
WHERE c.cardTypeID IN (SELECT cardTypeID FROM CardType WHERE name = 'Credit')
GROUP BY ut.name
ORDER BY cardCount DESC;

--7-List the cardTypes along with the count of users. (In descending order according to count of users).
SELECT ct.name AS cardTypeName, COUNT(uc.userID) AS userCount
FROM CardType ct
INNER JOIN Card c ON ct.cardTypeID = c.cardTypeID
INNER JOIN UserCard uc ON c.cardNum = uc.cardNum
GROUP BY ct.name
ORDER BY userCount DESC;

--8- Give the user who has second maximum balance. (You may use Query 2).

SELECT u.name
FROM [User] u
INNER JOIN UserCard uc ON u.userId = uc.userID
INNER JOIN Card c ON uc.cardNum = c.cardNum
INNER JOIN (
  SELECT ui.userId, MAX(balance) AS maxBalance
  FROM [User] ui
  INNER JOIN UserCard UIC ON ui.userId = UIC.userID
  INNER JOIN Card ci ON UIC.cardNum = ci.cardNum
  GROUP BY ui.userId
) AS topBalances
ON u.userId = topBalances.userId
WHERE c.balance = (SELECT TOP  2 balance FROM Card
WHERE cardNum IN (SELECT cardNum FROM topBalances)
 ORDER BY balance DESC
)

--9-List the UserTypes whose users have not made withdrawal transactions.
SELECT ut.name AS userTypeName
FROM UserType ut
LEFT JOIN [User] u ON ut.userTypeId = u.userType
LEFT JOIN UserCard uc ON u.userId = uc.userID
LEFT JOIN Card c ON uc.cardNum = c.cardNum
LEFT JOIN [Transaction] t ON c.cardNum = t.cardNum
WHERE t.transType NOT IN (
  SELECT transTypeID FROM TransactionType WHERE typeName = 'Withdrawal'
)
GROUP BY ut.name
HAVING COUNT(t.transId) IS NULL
