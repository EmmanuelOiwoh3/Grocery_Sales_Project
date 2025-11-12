/*
====================================================================================================
DDL Script: Create Gold Views
====================================================================================================
Purpose of Script:
    This script creates Gold layer views in the datawarehouse.
    We are using the star schema, 1 fact table, and 3 dimension tables
Usage:
    - These views can be querried directly for analytics and reporting.
=====================================================================================================
*/
Use Grosary_Sales

--Building the Gold View for Products

Create View Gold.dim_Product As 
Select 
p.ProductID As Product_ID,
p.ProductName As Product_Name,
c.CategoryName As Category_Name,
p.Class As Class,
p.Resistant,
p.IsAllegic,
p.ModifyDate As Modify_Time,
p.VitalityDays As Vitality_Days,
p.Price
from silver.products p
Left Join silver.categories c
on p.CategoryID = c.CategoryID

Select * from Gold.dim_Product

-- Building the Customers View

Create View Gold.dim_Customer As
Select 
c.CustomerID As Customer_ID,
C.CustomerName As Customer_Name,
c.Address,
ci.CityName As City_Name,
ci.Zipcode,
co.CountryName As Country_Name,
co.CountryCode As Country_Code
from silver.customers c
Left Join Silver.cities ci
on	c.CityID = ci.CityID
Left Join Silver.countries co
on	ci.CountryID = co.CountryID

Select * from Gold.dim_Customer

Create View Gold.dim_Employee As
Select 
e.EmployeeID As Employee_ID,
e.EmployeeName As Employee_Name,
Cast(e.BirthDate As date) BirthDate,
e.Gender,
e.HireDate As Hire_Date,
ci.CityName As City_Name,
ci.Zipcode,
co.CountryName As Country_Name,
co.CountryCode As Country_Code
from Silver.employees e
Left Join Silver.cities ci
on	e.CityID = ci.CityID
Left Join Silver.countries co
on	ci.CountryID = co.CountryID

Select * From Gold.dim_Employee

Create View Gold.fact_Sales As 
Select 
s.SalesID,
s.SalesPersonID As Employee_ID,
s.CustomerID As Customer_ID,
s.ProductID As Product_ID,
s.SalesDate,
p.Price As Sales_Amount,
s.Quantity,
s.Discount,
s.TransactionNumber
From silver.sales s
Left Join Gold.dim_Product p
On	s.ProductID = p.Product_ID

Select * From Gold.fact_Sales




