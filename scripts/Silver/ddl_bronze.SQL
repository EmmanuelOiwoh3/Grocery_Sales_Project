--Creating the silver layer
======================================================================================================
/* creating the tables with columns, We would Drop table if the table already exist
Warning : Run the script with caution as it would override if tables already exist in Database*/
======================================================================================================

If OBJECT_ID ('silver.categories', 'U') IS NOT NULL
	Drop Table silver.categories

create table silver.categories (
CategoryID            INT Primary Key,
CategoryName          Nvarchar(50),
Create_date           DATE
);
GO

If OBJECT_ID ('silver.cities', 'U') IS NOT NULL
	Drop table silver.cities

Create table silver.cities (
CityID                INT Primary Key,
CityName              Nvarchar(100),
Zipcode               Nvarchar(50),
CountryID             INT,
Create_date           DATE
);
Go

If OBJECT_ID ('silver.countries', 'U') IS NOT NULL
	Drop table silver.countries

Create table silver.countries (
CountryID             INT Primary Key,
CountryName           Nvarchar(100),
CountryCode           Nvarchar(50),
Create_date           DATE
);
Go

If OBJECT_ID ('silver.customers', 'U') IS NOT NULL
	Drop table silver.customers

Create table silver.customers (
CustomerID            INT Primary Key,
FirstName             Nvarchar(50),
MiddleInitial         Nvarchar(20),
LastName              Nvarchar(50),
CityID                INT,
Address               Nvarchar(100),
Create_date           DATE
);
Go

If OBJECT_ID ('silver.employees', 'U') IS NOT NULL
	Drop table silver.employees

Create table silver.employees (
EmployeeID            INT Primary Key,
FirstName             Nvarchar(100),
MiddleInitial         Nvarchar(20),
LastName              Nvarchar(100),
BirthDate             Datetime,
Gender                Nvarchar(20),
CityID                INT,
HireDate              Datetime,
Create_date           DATE
);
Go

If OBJECT_ID ('silver.products', 'U') IS NOT NULL
	Drop table silver.products

Create Table silver.products (
ProductID             INT Primary Key,
ProductName           Nvarchar(50),
Price                 Float,
CategoryID            INT,
Class                 Nvarchar(50),
ModifyDate            time,
Resistant             Nvarchar(50),
IsAllegic             Nvarchar(50),
VitalityDays          INT,
Create_date           DATE
);
Go

If OBJECT_ID ('silver.sales', 'U') IS NOT NULL
	Drop table silver.sales

Create table silver.sales (
SalesID              INT Primary Key,
SalesPersonID        INT,
CustomerID           INT,
ProductID            INT,
Quantity             INT,
Discount             Float,
TotalPrice           INT,
SalesDate            Datetime,
TransactionNumber    Nvarchar(100),
Create_date           DATE
);
Go

-- Truncating and inserting Silver.Categories
Truncate Table Silver.categories

Insert Into Silver.categories (
	CategoryID,
	CategoryName
	)
Select 
CategoryID,
Trim(CategoryName) As CategoryName
from bronze.categories

-- Truncating and inserting Silver.cities
Truncate Table Silver.cities
Insert Into Silver.cities (
   CityID,
   CityName,
   Zipcode,
   CountryID
   )
Select 
CityID,
TRIM(CityName) As CityName,
Zipcode,
CountryID
from bronze.cities

-- Truncating and inserting silver.countries
Truncate Table silver.countries
Insert into silver.countries --(
	CountryID,
	CountryName,
	CountryCode
	)
Select 
CountryID,
Trim(CountryName) As CountryName,
Trim(CountryCode) As CountryCode
from bronze.countries

/* There was an error in the building of the ddl script for the silver.customers table
we only need a column CustomerName instead of the 3 other tables
we need a ddl script to delete the three columns FirstName, MiddleInitial and LastName and
provide only CustomerName */

Alter Table Silver.customers
Add CustomerName       Nvarchar(100)

Alter Table Silver.customers
Drop Column FirstName, MiddleInitial, LastName

-- Truncating and inserting silver.customers
Truncate Table silver.customers

Insert into silver.customers (
	CustomerID,
	CustomerName,
	CityID,
	Address
	)
Select 
CustomerID,
Trim(FirstName)+ ' ' + Trim(MiddleInitial) + ' ' + Trim(LastName) As CustomerName,
CityID,
Address
from bronze.customers

/* There was an error in the building of the ddl script for the silver.employees table
we only need a column CustomerName instead of the 3 other tables
we need a ddl script to delete the three columns FirstName, MiddleInitial and LastName and
provide only EmployeeName */

Alter Table Silver.employees
Drop Column FirstName, MiddleInitial, LastName

Alter Table Silver.employees
Add EmployeeName       Nvarchar(100)

-- Truncating and inserting Silver.employees
Truncate Table Silver.employees

Insert Into Silver.employees (
	EmployeeID,
	EmployeeName,
	BirthDate,
	Gender,
	CityID,
	HireDate
	)
Select 
EmployeeID,
Trim(FirstName)+ ' ' + Trim(MiddleInitial) + ' ' + Trim(LastName) As EmployeeName,
Cast(BirthDate As Date) As Birthdate,
Gender,
CityID,
HireDate
from bronze.employees

-- Truncating and inserting Silver.products
Truncate Table Silver.products

Insert into Silver.products (
	ProductID,
	ProductName,
	Price,
	CategoryID,
	Class,
	ModifyDate,
	Resistant,
	IsAllegic,
	VitalityDays
	)
Select 
ProductID,
Trim(ProductName) As ProductName,
Price,
CategoryID,
Class,
ModifyDate,
Resistant,
Case When IsAllegic = 'Unknown' Then 'N/A'
Else IsAllegic
End As IsAllegic,
VitalityDays
From bronze.products

-- Truncating and inserting silver.sales
Truncate Table silver.sales
Insert into silver.sales (
	SalesID,
	SalesPersonID,
	CustomerID,
	ProductID,
	Quantity,
	Discount,
	TotalPrice,
	SalesDate,
	TransactionNumber
	)
Select *
From bronze.sales

