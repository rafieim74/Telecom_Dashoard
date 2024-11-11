USE master
GO
ALTER DATABASE RightelTEST1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE RightelTEST1
GO
CREATE DATABASE RightelTEST1
GO
USE RightelTEST1
 --DEFINE Customers TABLE

DROP TABLE IF EXISTS Customers
CREATE TABLE Customers(

CustomerID INT  PRIMARY KEY IDENTITY(1000,5) ,
Name NVARCHAR(50)  NOT NULL ,
Gender NVARCHAR(10)  NOT NULL,
Age TINYINT  NOT NULL,
Address NVARCHAR(100)  NOT NULL,
City NVARCHAR(40)  NOT NULL,
SignupDate DATETIME  NOT NULL
)
GO 1
 -- GENERATE 1000 FAKE RECORDS FOR Customers TABLE
 DECLARE @FnameRand INT =FLOOR(RAND()*46+1)
 DECLARE @Fname NVARCHAR(30)=CHOOSE(@FnameRand,N'علی',N'سارا',N'محمود',N'طاها',N'عسل',N'غزل',
 N'مهدی',N'علی',N'علیرضا',N'سارا',N'مریم',N'میثم',N'مسلم',N'ساناز',N'محمد',N'محمدرضا',
 N'فریبا',N'فلور',N'فرانک',N'معین',N'امین',N'محسن',N'میلاد',N'بهزاد',N'سلیمان',
 N'اصغر',N'اکبر',N'احمد',N'سینا',N'رضا',N'اشکان',N'ساسان',N'فریده',N'حمیده',N'انجل'
 ,N'هلما',N'هاکان',N'دنیز',N'محمد جواد',N'محمد طاها',N'محمد علی',N'محمد حسین',N'محمد حسن',
 N'مینا',N'مبینا',N'سیاوش')

 DECLARE @LnameRand INT =FLOOR(RAND()*46+1)
 DECLARE @Lname NVARCHAR(30)=CHOOSE(@FnameRand,N'رفیعی',N'صبوری',N'صبری',N'سبزی',N'مسلمی',
 N'گلزار',N'حمدی',N'حمیدی',N'کامرانی',N'محمدی',
 N'محمدی ها',N'گلمحمدی',N'مینایی',N'نیمافر',N'سلیمانی',N'معصومی',N'رفیعی نژاد',N'زاکانی',
 N'مظفری',N'ظفرقندی',N'محسنی',N'حسنی',N'خزایی',N'زرابادی',N'خداوردی',N'عزیزی',N'مهاجر',
 N'مستوری',N'غلامی',N'اخوان',N'سلطان ابادی',N'منشوری',N'اردکانی',N'قزوینی',N'تهرانی',
 N'اصفهانی',N'شیرازی',N'زنجانی',N'شبیری',N'خراسانی',N'مشهدی',N'زاکانی',N'رییسی',N'اصغری',
 N'نیمایی',N'سلیمی')

 DECLARE @GenderRand INT =FLOOR(RAND()*2+1)
 DECLARE @Gender NVARCHAR(10)=CHOOSE(@GenderRand,N'زن',N'مرد')

 DECLARE @AgeRand INT =FLOOR(RAND()*80+18)



 DECLARE @AddressRand INT =FLOOR(RAND()*20+1)
 DECLARE @Address NVARCHAR(50)=CHOOSE(@AddressRand,N'خ طالقانی-ک وحدت',N'خ نظری-ک صدارت',
 N'خ منتظری-ک احمدی',N'خ باریک بین- ک شهید مرتضوی',N'خ سپه- ک شهید محمدی',N'خ پونک- ک 13',
 N'خ گل اقایی- ک بهار',N'خ ولیعصر- ک شیرمحمدی',N'خ ازادی- ک گلها',
 N'خ انقلاب- ک شهید صدرالدین',N'خ زعفرانیه- ک محلایی',N'خ پارک وی- ک ظفری',
 N'خ استاد معین- ک معینی',N'خ بهاران- ک گل رز',N'خ اردیبهشت- ک 75',
 N'خ پانزده خرداد- ک احمدی',N'خ راه اهن- ک شهید مرندی',N'خ صادقیه- ک امینی ها',
 N'خ نواب صفوی- ک 25',N'خ کارگر- ک شهید رفیعی')

 DECLARE @CityRand INT =FLOOR(RAND()*30+1)
 DECLARE @City NVARCHAR(50)=CHOOSE(@CityRand,N'قزوین',N'تهران',N'زنجان',N'اصفهان',N'بوشهر',
 N'خرمدره',N'اردبیل',N'شیراز',
 N'مشهد',N'سبزوار',N'سیرجان',N'انزلی',N'کرمان',N'کرمانشاه',N'بندرگناوه',N'بندرعباس',
 N'آبادان',N'گرمسار',N'آشتیان',N'آمل',N'قشم',N'کیش',N'ساری',N'کردستان',N'ایلام',
 N'خوزستان',N'آستارا',N'تهران',N'تبریز',N'ارومیه')

 DECLARE @Offset INT =FLOOR(RAND()*5477)
 DECLARE @Date DATETIME=DATEADD(DAY,@Offset,'2010-01-01 12:00AM') 

 INSERT INTO 
 Customers(NAME,Gender,Age,Address,City,SignupDate)
 VALUES
 (@Fname+' '+@Lname,@Gender,@AgeRand,@Address,@City,@Date)

 GO 1000

 SELECT *
 FROM Customers

 ---------------------------------------------------------------------------------------
 -- DEFINE Calls TABLE

DROP TABLE IF EXISTS Calls
CREATE TABLE Calls(
CallID VARCHAR(11)  PRIMARY KEY NOT NULL ,
CustomerID INT NOT NULL IDENTITY(1000,5) UNIQUE ,  
CallDate DATETIME  NOT NULL  ,
CallDuration INT NOT NULL ,
CallType NVARCHAR(20) NOT NULL ,
CallHost NVARCHAR(20) NOT NULL ,
CallCost BIGINT  ,
FOREIGN KEY (CustomerID)
	REFERENCES Customers(CustomerID)
	--ON DELETE CASCADE
	--ON UPDATE CASCADE
)
GO 1

--GENERATE 1000 FAKE MOBILE NUMBERS

-- Declare a variable to store the random phone number
DECLARE @PhoneNumber VARCHAR(11);

-- Set the variable with a single random phone number STARTS WITH 0920 AND 11 LENGTH
SET @PhoneNumber = (
    SELECT TOP 1 
        '0920' + RIGHT('0000000' + CAST(ABS(CHECKSUM(NEWID())) % 10000000 AS VARCHAR(7)), 7) AS PhoneNumber
    FROM 
        sys.all_objects a, sys.all_objects b
    WHERE LEN('0920' + RIGHT('0000000' + CAST(ABS(CHECKSUM(NEWID())) % 10000000 AS VARCHAR(7)), 7)) = 11
);

--GENERATE 1000 FAKE CALL DATE
-- Declare the variables for start and end dates

DECLARE @StartDate DATETIME = '2010-01-01T00:00:00';
DECLARE @EndDate DATETIME = GETDATE();
DECLARE @RandomDateTime DATETIME;

-- Set the random datetime value
SET @RandomDateTime = DATEADD(SECOND, 
    ABS(CHECKSUM(NEWID())) % DATEDIFF(SECOND, @StartDate, @EndDate), 
    @StartDate);

--GENERATE 1000 FAKE CALL DURATION IN SECOND
DECLARE @DurationRand INT =FLOOR(RAND()*50000+1)

--GENERATE 1000 FAKE CUSTOMERID
DECLARE @CUSTOMERID INT =FLOOR(RAND()*1000+1)

--GENERATE 1000 FAKE CallType
DECLARE @TypeRand INT =FLOOR(RAND()*2+1)
DECLARE @Type NVARCHAR(20)=CHOOSE(@TypeRand,N'INCOMMING',N'OUTGOING')

--GENERATE 1000 FAKE CallHost
DECLARE @HostRand INT =FLOOR(RAND()*3+1)
DECLARE @Host NVARCHAR(20)=CHOOSE(@HostRand,N'IRANCELL',N'HAMRAHEAVVAL',N'RIGHTEL')

---------------- CALLCOST WILL CALCULATE IN POWERBI WITH DAX----------------------

INSERT INTO 
Calls (CallID,CallDate, CallDuration,CallType,CallHost)
VALUES 
(@PhoneNumber ,@RandomDateTime,@DurationRand,@Type,@Host)
GO 1000

SELECT *
 FROM Calls

---------------------------------------------------------------------------------------
-- DEFINE SERVICE PACKAGE TABLE

DROP TABLE IF EXISTS ServicePackage
CREATE TABLE ServicePackage(

PackageID INT  PRIMARY KEY NOT NULL IDENTITY(100,8) ,
PackageName NVARCHAR(20) NOT NULL  ,  
PackageCost INT  NOT NULL  ,
PackageDuration SMALLINT NOT NULL 
)

INSERT INTO 
ServicePackage(PackageName,PackageCost,PackageDuration)
VALUES
('150MINUTES',70000,30),('500MINUTES',190000,30),('800MINUTES',290000,30)
GO

SELECT*
FROM ServicePackage

---------------------------------------------------------------------------------------
-- DEFINE Transction TABLE

DROP TABLE IF EXISTS Transact
CREATE TABLE Transact(

TransactionID INT  PRIMARY KEY IDENTITY(3000,30)  ,
CustomerID INT  ,  
PackageID INT  ,
TransactionDate DATETIME    ,
Amount  INT   

FOREIGN KEY (CustomerID)
	REFERENCES Customers(CustomerID),
FOREIGN KEY (PackageID)
	REFERENCES ServicePackage(PackageID)	
)
GO

 -- GENERATE RANDOM TRANSACTION DATE
 DECLARE @Offset3 INT =FLOOR(RAND()*5477)
 DECLARE @Date2 DATETIME=DATEADD(DAY,@Offset3,'2010-01-01 12:00AM') 

INSERT INTO Transact (CustomerID, PackageID,TransactionDate,Amount)
SELECT TOP 1 CustomerID, PackageID,@Date2,
  CASE 
        WHEN PackageID = 100 THEN 70000
		WHEN PackageID = 108 THEN 190000
        ELSE 290000
    END
FROM Customers
CROSS JOIN ServicePackage
ORDER BY NEWID() 
GO 1000

SELECT *
FROM Transact









