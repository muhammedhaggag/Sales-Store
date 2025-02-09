                       --Data Pre-Proccessing

						--1) Order_ID İÕá 
Select *from Data;
 -- ÇÖÇİå ÚãæÏ ÌÏíÏ 
Alter table Data  Add Order_Number int;

--------------------------------------------------------
-- ÊÍÏíË ÇáÚãæÏ ÇáÌÏíÏ ÈÇáŞíãÉ ÇáãİÕæáÉÊÍÏíË ÇáÚãæÏ ÇáÌÏíÏ ÈÇáŞíãÉ ÇáãİÕæáÉ

UPDATE Data
SET Order_number = CAST(SUBSTRING([Order ID], LEN([Order ID]) - CHARINDEX('-', REVERSE([Order ID])) + 2
, LEN([Order ID])) AS INT);

----------------------------------------------------------------
--OrderID ÊÛíÑ ÇÓã ÇáÚãæ Çáí   
EXEC sp_rename 'Data.Order_Number','OrderID','COLUMN';


                            --2) Customer_ID İÕá 
Select *from Data;                      

Alter table Data   --ÇÖÇİå ÚãæÏ ÌÏíÏ 
Add Latters nvarchar(50)
-----------------------------------------
--Customer_ID İÕá ÇáÈíÇäÇÊ ÇáãæÌæÏå İí ÌÏæá 
Update Data
set Latters = LEFT([Customer ID], CHARINDEX('-', [Customer ID]) - 1),
   [Customer ID] = RIGHT([Customer ID], LEN([Customer ID]) - CHARINDEX('-', [Customer ID]))
WHERE [Customer ID] IS NOT NULL;

                  --3) Product_IDİÕá 
Select *from Data;

-- ÇäÔÇÁ CoLumn áİÕá ÇáŞíã ÇáÍÑİíå İíå 
ALTER TABLE Data    
ADD Latters_2 VARCHAR(50);
-----------------------------------------------------
--Product_ID İÕá ÇáÈíÇäÇÊ ÇáãæÌæÏå İí ÌÏæá 

UPDATE Data
SET 
    Latters_2 = LEFT([Product ID], PATINDEX('%[0-9]%',[Product ID]) - 1),
    [Product ID] = SUBSTRING([Product ID], PATINDEX('%[0-9]%', [Product ID]), LEN([Product ID]))
WHERE [Product ID] IS NOT NULL;

    
	--ÍĞİ ÇáãÓÇİÇÊ ÇáãæÌæÏå İí ÇÓãÇÄ ÇáÇÚãÏå 
EXEC sp_rename 'Data.[Order ID]','OrderID','COLUMN';
EXEC sp_rename 'Data.[Order Date]','Order_Date','COLUMN';
EXEC sp_rename 'Data.[Order Date]','Order_Date','COLUMN';
EXEC sp_rename 'Data.[Ship Date]','Ship_Date','COLUMN';
EXEC sp_rename 'Data.[Ship Mode]','Ship_Mode','COLUMN';
EXEC sp_rename 'Data.[Customer ID]','Customer_ID','COLUMN';
EXEC sp_rename 'Data.[Customer Name]','Customer_Name','COLUMN';
EXEC sp_rename 'Data.[Segment]','Segment','COLUMN';
EXEC sp_rename 'Data.[City]','City','COLUMN';
EXEC sp_rename 'Data.[State]','State','COLUMN';
EXEC sp_rename 'Data.[Postal Code]','Postal_Code','COLUMN';
EXEC sp_rename 'Data.[Region]','REgion','COLUMN';
EXEC sp_rename 'Data.[Product ID]','Product_ID','COLUMN';
EXEC sp_rename 'Data.[Product Name]','Product_Name','COLUMN';
EXEC sp_rename 'Data.[Sales]','Amount','COLUMN';
EXEC sp_rename 'Data.[Row ID]','RowID','COLUMN';


              -- United States  ÍĞİ ÇáÚãæÏ 
ALTER TABLE Data
DROP COLUMN Country ;
                 -- Postal_Code  ÍĞİ ÇáÚãæÏ 
Alter table Data
Drop column Postal_code;

Alter table Data
Drop column [Order ID];

Alter table Data 
Drop column [Latters];

Alter table Data 
Drop column [Latters_2];

Select *from Data;

