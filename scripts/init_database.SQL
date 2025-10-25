/* 

=============================================================================================
Creating Database and Schemas
=============================================================================================

Script Purpose:
This script creates new database "Grocery_Sales Database after checking if it exist. if it exist 
would drop it and recreate the database. This script also creates new Schemas: bronze, silver, and
gold.

Warning:
This script would automatically drop the database "Grocery_Sales" if it exists. Therefore proceed with
Caution while running the script.
*/

Use Master;
Go

-- Drop and recreate new database Grosary_Sales
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = "Grosary_sales")
BEGIN
    ALTER DATABASE Grosary_Sales SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE Grosary_Sales;
END;
GO
  
-- Create new database Grosary_Sales  
Create Database Grosary_Sales;
Go

--Use the Grosary_Sales Database to start creating Schemas
Use Grosary_Sales;
Go

-- Creating new Schemas in the database

Create Schema bronze;
Go

Create Schema silver;
Go

Create Schema Gold;
Go
