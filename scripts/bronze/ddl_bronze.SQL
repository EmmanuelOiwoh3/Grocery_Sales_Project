/*
================================================================================================
DDL SCRIPT: Creating the bronze layer tables
================================================================================================
Script Purpose: 
      This script creates tables in the 'bronze' schema. It would drop the table if the table 
      already exists. Thereafter, we would truncate and do a bulk insert to move data from the 
      source system.
Warning: Run the script with caution as it would override if tables already exist in the Database
=================================================================================================
*/

If OBJECT_ID ('bronze.categories', 'U') IS NOT NULL
	Drop Table bronze.categories

create table bronze.categories (
CategoryID            INT Primary Key,
CategoryName          Nvarchar(50)
);
GO

If OBJECT_ID ('bronze.cities', 'U') IS NOT NULL
	Drop table bronze.cities

Create table bronze.cities (
CityID                INT Primary Key,
CityName              Nvarchar(100),
Zipcode               Nvarchar(50),
CountryID             INT
);
Go

If OBJECT_ID ('bronze.countries', 'U') IS NOT NULL
	Drop table bronze.countries

Create table bronze.countries (
CountryID             INT Primary Key,
CountryName           Nvarchar(100),
CountryCode           Nvarchar(50)
);
Go

If OBJECT_ID ('bronze.customers', 'U') IS NOT NULL
	Drop table bronze.customers

Create table bronze.customers (
CustomerID            INT Primary Key,
FirstName             Nvarchar(50),
MiddleInitial         Nvarchar(20),
LastName              Nvarchar(50),
CityID                INT,
Address               Nvarchar(100)
);
Go

If OBJECT_ID ('bronze.employees', 'U') IS NOT NULL
	Drop table bronze.employees

Create table bronze.employees (
EmployeeID            INT Primary Key,
FirstName             Nvarchar(100),
MiddleInitial         Nvarchar(20),
LastName              Nvarchar(100),
BirthDate             Datetime,
Gender                Nvarchar(20),
CityID                INT,
HireDate              Datetime
);
Go

If OBJECT_ID ('bronze.products', 'U') IS NOT NULL
	Drop table bronze.products

Create Table bronze.products (
ProductID             INT Primary Key,
ProductName           Nvarchar(50),
Price                 Float,
CategoryID            INT,
Class                 Nvarchar(50),
ModifyDate            Datetime,
Resistant             Nvarchar(50),
IsAllegic             Nvarchar(50),
VitalityDays          Float
);
Go

If OBJECT_ID ('bronze.sales', 'U') IS NOT NULL
	Drop table bronze.sales

Create table bronze.sales (
SalesID              INT Primary Key,
SalesPersonID        INT,
CustomerID           INT,
ProductID            INT,
Quantity             INT,
Discount             Float,
TotalPrice           INT,
SalesDate            Datetime,
TransactionNumber    Nvarchar(100)
);
Go

/* Carefully look at all files needed to be loaded and ensure the FieldTerminators 
Are correct, Rowterminators are correct, the datatypes are correct, the files are 
CSV and the files' line endings are correct and consistent.
Thereafter, we would Truncate and bulk insert*/

Truncate table bronze.categories
Bulk insert bronze.categories
From 'C:\Users\USER141\Downloads\categories.csv'
With (
		FirstRow = 2,
		FieldTerminator = ',',
		Tablock
	);
Go

Truncate table bronze.cities

Bulk insert bronze.cities
From 'C:\Users\USER141\Downloads\Groc\cities.csv'
With (
		FirstRow = 2,
		FieldTerminator = ',',
		Tablock
	);
Go
 
Truncate Table bronze.countries

Bulk insert bronze.countries
From 'C:\Users\USER141\Downloads\Groc\countries.csv'
With (
		FirstRow = 2,
		FieldTerminator = ',',
		Tablock
	);
Go

Truncate Table bronze.customers

Bulk insert bronze.customers
From 'C:\Users\USER141\Downloads\Groc\customers.csv'
With (
		FirstRow = 2,
		FieldTerminator = ',',
		Tablock
	);
Go

Truncate Table bronze.employees

Bulk insert bronze.employees
From 'C:\Users\USER141\Downloads\Groc\employees.csv'
With (
		FirstRow = 2,
		FieldTerminator = ',',
		Tablock
	);
Go

-- Change datatype for columns ModifyDate and VitalityDays to Time and INT Respectively

Alter table bronze.products
Alter Column ModifyDate Time

Alter table bronze.products
Alter Column VitalityDays INT

Truncate Table bronze.products

Bulk insert bronze.products
From 'C:\Users\USER141\Downloads\products 1.csv'
With (
		FirstRow = 2,
		FieldTerminator = ',',
		Fieldquote = '"',
		Tablock
	);
Go

-- Change the datatype TotalPrice to Float

Alter Table bronze.sales
Alter column TotalPrice float

Truncate Table bronze.sales
Bulk insert bronze.sales
From 'C:\Users\USER141\Downloads\Groc\sales.csv'
With (
		FirstRow = 2,
		FieldTerminator = ',',
		Tablock
	);
Go



Select Top 5 * from bronze.categories
Select Top 5 * from bronze.cities
Select Top 5 * from bronze.countries
Select Top 5 * from bronze.customers
Select Top 5 * from bronze.employees
Select Top 5 * from bronze.products
Select Top 5 * from bronze.sales
