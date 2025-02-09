

CREATE TABLE Orders (
    OrderID int PRIMARY KEY,  -- Order ID
    Order_Date DATETIME,                -- Order Date
    Ship_Date DATETIME,                 -- Ship Date
    Ship_Mode NVARCHAR(255)              -- Ship Mode
);

CREATE TABLE Customers (
    Customer_ID int PRIMARY KEY, -- Customer ID
    Customer_Name NVARCHAR(255),          -- Customer Name
    Segment NVARCHAR(50),                -- Segment
    Country NVARCHAR(50),                -- Country
    City NVARCHAR(50),                   -- City
    State NVARCHAR(50),                  -- State
    Region NVARCHAR(50)                  -- Region
);


CREATE TABLE Products (
    Product_ID int PRIMARY KEY,  -- Product ID
    Category NVARCHAR(50),               -- Category
    Sub_Category NVARCHAR(50),            -- Sub-Category
    Product_Name NVARCHAR(255)            -- Product Name
);


CREATE TABLE Sales (
    RowID int PRIMARY KEY ,      -- Row ID
    OrderID int   ,              -- Order ID
    Product_ID int ,              -- Product ID
    Customer_ID int,              -- Customer ID
    Sales FLOAT,                         -- Sales
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);


---- ‰ﬁ· «·»Ì«‰«  «·Ì «·Ãœ«Ê·      (Insert into )
                 --( Orders )


select*from Orders;
Select count(OrderID) from Orders


------------------------------«·ÿ—ÌﬁÂ «· «‰ÌÂ 



Select Ship_Date from Orders

Select Ship_Date from Data
              --Orders
INSERT INTO Orders (OrderID,Order_Date,Ship_Date,Ship_Mode)
SELECT DISTINCT [OrderID], [Order_Date], [Ship_Date], [Ship_Mode]
FROM Data;
                    
               --Sales 
INSERT INTO Sales(RowID,OrderID,Product_ID,Customer_ID,Sales)
SELECT DISTINCT [RowID], [OrderID], [Product_ID], [Customer_ID],[Amount]
FROM Data;

SELECT Count(RowID)From Sales



					--Customers 

WITH RankedCustomers AS (
    SELECT 
        [Customer_ID], 
        [Customer_Name], 
        Segment, 
        City, 
        State, 
        Region,
        ROW_NUMBER() OVER (PARTITION BY [Customer_ID] ORDER BY [Customer_Name]) AS rn
    FROM Data
)
INSERT INTO Customers (Customer_ID, Customer_Name, Segment, City, State, Region)
SELECT 
    [Customer_ID], 
    [Customer_Name], 
    Segment, 
    City, 
    State, 
    Region
FROM RankedCustomers
WHERE rn = 1;

Select COUNT(Customer_ID) from Customers
  
           -- Products 

WITH RankedProducts AS (
SELECT 
     [Product_ID], 
     [Product_Name], 
     [Category], 
     [Sub-Category], 
        ROW_NUMBER() OVER (PARTITION BY [Product_ID] ORDER BY [Product_Name]) AS rn
    FROM Data
)

INSERT INTO Products (Product_ID, Product_Name, Category, Sub_Category)
SELECT 
    [Product_ID], 
    [Product_Name], 
    [Category], 
   [Sub-Category]
FROM RankedProducts
WHERE rn = 1;  -- «Œ Ì«— «·’› «·√Ê· ›ﬁÿ ·ﬂ· „‰ Ã

Select*from Products;
Select COUNT(Product_ID) from Products

-------------------------------------------------------------------------
---------------------------------------------------------------------
-----------------------------------------------------------------