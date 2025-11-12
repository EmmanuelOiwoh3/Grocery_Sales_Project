/* 
=======================================================================================
  Purpose: Quality checks in the Gold Layer, which checks for duplicates in the primary
  and null Values
=======================================================================================


Select ProductID, Count(*) From (
Select 
p.ProductID,
p.ProductName,
p.Price,
p.CategoryID,
p.Class,
p.ModifyDate,
p.Resistant,
p.IsAllegic,
p.VitalityDays,
c.CategoryName
from silver.products p
Left Join silver.categories c
on p.CategoryID = c.CategoryID
)t
Group by ProductID
Having Count(*) > 1 -- Quality checks for no duplicates

Select CustomerID, Count(*) From (
Select 
c.CustomerID,
C.CustomerName,
c.Address,
c.CityID,
ci.CityName,
ci.CountryID,
ci.Zipcode,
co.CountryName,
co.CountryCode
from silver.customers c
Left Join Silver.cities ci
on	c.CityID = ci.CityID
Left Join Silver.countries co
on	ci.CountryID = co.CountryID
)t
Group by CustomerID
Having Count(*) > 1 -- Quality Checks for no duplicates

--Checking the quality of the Gold Layer

Select * from Gold.fact_Sales f
Left Join Gold.dim_Customer c
on f.Customer_ID = c.Customer_ID
Left Join Gold.dim_Product p
on	f.Product_ID = p.Product_ID
Where p.Product_ID IS NULL
