
                               --- Analytical Quesitions 
             -- ⁄œœ «·„»Ì⁄«  ·ﬂ· ›∆Â 
Select P.Category ,Sum(S.Sales)as Total_Sale  from Products P
Inner join Sales S
On P.Product_ID=S.Product_ID
Group by P.Category
Order by Total_Sale Desc;
              
  ---„« ÂÌ ›∆«  «·„‰ Ã«  «· Ì  Õﬁﬁ √⁄·Ï ÿ·»Ì« ° ÊﬂÌ› Ì „  Ê“Ì⁄ «·ÿ·»«  »Ì‰ „Œ ·› «·›∆«  «·›—⁄Ì…ø  
Select P.Category,P.Sub_Category,count(O.OrderID)as Num_Orders,
Sum(S.Sales)as Total_Sales
from Products P
Inner Join Sales S 
On P.Product_ID=S.Product_ID 
Inner Join Orders O 
On O.OrderID=S.OrderID
Group by P.Category,P.Sub_Category
Order by Num_Orders desc

  
 ---„« ÂÌ ›∆«  «·„‰ Ã«  «· Ì  Õﬁﬁ √⁄·Ï „»Ì⁄« ° ÊﬂÌ› Ì „  Ê“Ì⁄ «·ÿ·»«  »Ì‰ „Œ ·› «·›∆«  «·›—⁄Ì…ø  
Select P.Category,P.Sub_Category,count(O.OrderID)as Num_Orders,
Sum(S.Sales)as Total_Sales
from Products P
Inner Join Sales S 
On P.Product_ID=S.Product_ID 
Inner Join Orders O 
On O.OrderID=S.OrderID
Group by P.Category,P.Sub_Category
Order by Total_Sales desc

          --«⁄·Ì «·„‰«ÿﬁ ÿ·»« 

select Top 10 C.State,C.City,Count(O.OrderID)as Num_Orders,Sum(S.Sales)As Total_Sales from Customers C
Inner join Sales S 
On S.Customer_ID=C.Customer_ID
Inner Join Orders O
On O.OrderID=S.OrderID
Group By C.State,C.City
Order by Num_Orders DESC;

          -- «⁄·Ì «·„‰«ÿﬁ „»Ì⁄«  

select Top 10 C.State,C.City,Sum(S.Sales)As Total_Sales from Customers C
Inner join Sales S 
On S.Customer_ID=C.Customer_ID
Inner Join Orders O
On O.OrderID=S.OrderID
Group By C.State,C.City
Order by Total_Sales DESC;

     
	--·„»Ì⁄«  «·„— »ÿ… »√⁄·Ï orderID›Ì ﬂ· ›∆…

SElect P.Category,Count(S.OrderID) ,Sum(S.Sales)as Total_Sales  From Products P
Inner Join Sales S
On P.Product_ID=S.Product_ID
Group by P.Category
    
	         -- -«·«— »«ÿ »Ì‰ orderID Ê«·› —«  «·“„‰Ì…
SElect YEAR(O.Order_Date)As Years,MONTH(O.Order_Date)as Mounths,
Count(S.OrderID)as Total_invoice,Sum(S.Sales)as Total_Sales  from Orders O 
Inner Join Sales S
On O.OrderID=S.OrderID
Group by YEAR(O.Order_Date),MONTH(O.Order_Date)
Order by Total_Sales DESC;

            --Õ·Ì· „⁄œ· «·„»Ì⁄«  Õ”» „‰ÿﬁ… «·‘Õ‰ √Ê ›∆… «·‘Õ‰

Select O.Ship_Mode,C.Region,count(O.OrderID)as Total_Invoice,Sum(S.Sales)as Total_Sales   
from Orders O
Inner join Sales S
On O.OrderID=S.OrderID
Inner Join Customers C 
On C.Customer_ID=S.Customer_ID
Group by O.Ship_Mode,C.Region
Order by Total_Sales DESC;


           --- Õ·Ì· «·“»«∆‰ «·–Ì‰ Ì”«Â„Ê‰ »√⁄·Ï ‰”»… „‰ «·„»Ì⁄« 
Select Top 10 C.Customer_ID,C.Customer_Name,Count(S.OrderID)as Total_Invoice,Sum(S.Sales)as Total_Sales 
from Customers C
Inner join Sales S
On C.Customer_ID= S.Customer_ID
Group by C.Customer_ID,C.Customer_Name
Order by Total_Sales DESC;
 
 ----------------------------------------------------
Select C.Customer_ID,C.Customer_Name,O.Order_Date,O.Ship_Date,O.Ship_Mode ,Count(S.OrderID)as Total_Invoice,Sum(S.Sales)as Total_Sales 
from Customers C
Inner join Sales S
On C.Customer_ID= S.Customer_ID
Inner join Orders O 
On O.OrderID=S.OrderID
Where C.Customer_Name='Jonathan Doherty' and YEAR(O.Order_Date)=2017;
















WITH YearlyInvoices AS (
    SELECT 
        YEAR(order_date) AS year, 
        COUNT(orderID) AS yearly_invoice_count
    FROM 
        Orders
    GROUP BY 
        YEAR(order_date)

),

MonthlyInvoices AS (
    SELECT 
        YEAR(order_date) AS year, 
        MONTH(order_date) AS month, 
        COUNT(orderID) AS monthly_invoice_count
    FROM 
        Orders
    GROUP BY 
        YEAR(order_date), MONTH(order_date)
)

-- Õ”«» ‰”»… «· €ÌÌ— «·”‰ÊÌ
SELECT 
    a.year AS current_year,
    a.yearly_invoice_count AS current_yearly_count,
    b.yearly_invoice_count AS previous_yearly_count,
    CASE 
        WHEN b.yearly_invoice_count IS NOT NULL THEN 
            ((a.yearly_invoice_count - b.yearly_invoice_count) * 100.0 / b.yearly_invoice_count)
        ELSE 
            NULL 
    END AS yearly_percentage_change,

    -- Õ”«» ‰”»… «· €ÌÌ— «·‘Â—Ì
    c.month AS current_month,
    c.monthly_invoice_count AS current_monthly_count,
    d.monthly_invoice_count AS previous_monthly_count,
    CASE 
        WHEN d.monthly_invoice_count IS NOT NULL THEN 
            ((c.monthly_invoice_count - d.monthly_invoice_count) * 100.0 / d.monthly_invoice_count)
        ELSE 
            NULL 
    END AS monthly_percentage_change
FROM 
    YearlyInvoices a
LEFT JOIN 
    YearlyInvoices b ON a.year = b.year + 1  -- „ﬁ«—‰… «·»Ì«‰«  «·”‰ÊÌ…
LEFT JOIN 
    MonthlyInvoices c ON a.year = c.year      -- —»ÿ «·”‰… „⁄ «·»Ì«‰«  «·‘Â—Ì…
LEFT JOIN 
    MonthlyInvoices d ON c.year = d.year + 1 AND c.month = d.month  -- „ﬁ«—‰… «·»Ì«‰«  «·‘Â—Ì…
ORDER BY 
    a.year, c.month;



	-------Õ”«» ‰”»… «·“Ì«œ… »‰«¡ ⁄·Ï «·›’Ê· (—»⁄ ”‰ÊÌ…)
WITH QuarterlyInvoices AS (
    SELECT 
        YEAR(order_date) AS year, 
        DATEPART(QUARTER, order_date) AS quarter, 
        COUNT(orderID) AS quarterly_invoice_count
    FROM 
        Orders
    GROUP BY 
        YEAR(order_date), DATEPART(QUARTER, order_date)
)

SELECT 
    a.year AS current_year,
    a.quarter AS current_quarter,
    a.quarterly_invoice_count AS current_quarterly_count,
    b.quarterly_invoice_count AS previous_quarterly_count,
    CASE 
        WHEN b.quarterly_invoice_count IS NOT NULL THEN 
            ((a.quarterly_invoice_count - b.quarterly_invoice_count) * 100.0 / b.quarterly_invoice_count)
        ELSE 
            NULL 
    END AS quarterly_percentage_change
FROM 
    QuarterlyInvoices a
LEFT JOIN 
    QuarterlyInvoices b ON a.year = b.year + 1 AND a.quarter = b.quarter  -- „ﬁ«—‰… «·›’Ê· „‰ ”‰… ·√Œ—Ï
ORDER BY 
    a.year, a.quarter;
