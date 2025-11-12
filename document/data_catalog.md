## Data Dictionary for Gold Layer

Overview

### 1. gold.dim_customer


🧾 Purpose: Stores Customers' details with Geographic data
•	Columns

| Column Name   | Data Type       | Description                                                                                                          |
|----------------|-----------------|----------------------------------------------------------------------------------------------------------------------|
| *Customer_ID*   | INT             | Unique Identifier for each Customer                                                                                 |
| *Customer_Name* | NVARCHAR(100)  | Full name of all customers who made purchases, comprising the first name, middle initial, and the last name          |
| *Address*       | NVARCHAR(100)  | Address of each customer                                                                                            |
| *City_Name*     | NVARCHAR(100)  | City of each customer                                                                                               |
| *ZipCode*       | NVARCHAR(50)   | More details on the geographic location — the zipcode of each city                                                  |
| *Country_Name*  | NVARCHAR(100)  | Country of each customer (e.g., United States)                                                                      |
| *Country_Code*  | NVARCHAR(50)   | Country code of each country                                                                                        |

### 2. gold.dim_employee

👔 Purpose: Stores Employee details with additional information like the gender, hire date, and Geographic data
•	Columns

| Column Name      | Data Type       | Description                                                                                                         |
|------------------|-----------------|---------------------------------------------------------------------------------------------------------------------|
| *Employee_ID*   | INT             | Unique Identifier for each employee                                                                                 |
| *Employee_Name* | NVARCHAR(100)  | Full name of all employees who made purchases, comprising the first name, middle initial, and the last name          |
| *Birthdate*     | DATE           | The date of birth of each employee                                                                                  |
| *Gender*        | NVARCHAR(20)   | Gender of each employee is abbreviated, e.g., M for male and F for female                                           |
| *Hire_Date*     | DATETIME       | Date when each employee was employed                                                                                |
| *City_Name*     | NVARCHAR(100)  | City of each employee                                                                                               |
| *ZipCode*       | NVARCHAR(50)   | More details on the geographic location — the zipcode of each city                                                  |
| *Country_Name*  | NVARCHAR(100)  | Country of each employee, e.g., United States                                                                       |
| *Country_Code*  | NVARCHAR(50)   | Country code of each country                                                                                        |

### 3. gold.dim_product

🛒 Purpose: Stores product details with additional information like the price of each product, there are 425 products
•	Columns

| Column Name      | Data Type       | Description                                                                                         |
|------------------|-----------------|-----------------------------------------------------------------------------------------------------|
| *Product_ID*    | INT             | Unique Identifier for each product                                                                  |
| *Product_Name*  | NVARCHAR(50)    | Name of each product                                                                                |
| *Category_Name* | NVARCHAR(50)    | Category of each product                                                                            |
| *Class*         | NVARCHAR(50)    | Class where each product falls into — either High, Medium, or Low                                   |
| *Resistant*     | NVARCHAR(50)    | Product resistance category (e.g., Durable, weak and Unknown)                                                                         |
| *IsAllegic*     | NVARCHAR(50)    | Indicates if a product is an allergen                                                               |
| *Modify_Time*   | TIME            | Last modified time of the data in the system                                                        |
| *Validity_Days* | INT             | Product validity type classification (in days)                                                      |
| *Price*         | FLOAT           | Price per product                                                                                   |

4. gold.fact_sales

💰 Purpose: Stores transactional data for all sales that happened over 4 months, including pricing and quantity of each sale conducted.
•	Columns

| Column Name        | Data Type       | Description                                                                                                                   |
|--------------------|-----------------|-------------------------------------------------------------------------------------------------------------------------------|
| *Sales_ID*         | INT             | Unique Identifier for each sale                                                                                               |
| *Employee_ID*      | INT             | Foreign key used to link to the gold.dim_employee table to get information on the employee making this sale                  |
| *Customer_ID*      | INT             | Foreign key used to link to the gold.dim_customer table to get information on the customer making this purchase              |
| *Product_ID*       | INT             | Foreign key used to link to the gold.dim_product table to get information on the products purchased                          |
| *SalesDate*        | DATETIME        | The date the sale was made                                                                                                   |
| *Sales_Amount*     | FLOAT           | Price for each product purchase                                                                                               |
| *Quantity*         | INT             | Quantity of product sold during each sale                                                                                     |
| *Discount*         | FLOAT           | Discount applied on each sale                                                                                                 |
| *TransactionNumber*| FLOAT           | Unique identifier for each transaction made                                                                                   |
