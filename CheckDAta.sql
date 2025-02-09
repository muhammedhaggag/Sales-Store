  
                          --- Check Data 
						  
			---- Úãá ÇÌÑÇÁ ÇáÊÔííß Úáí ÇáÍŞæá ÇáİÇÑÛå Úáí ßÇİÉ ÇáÇÚãÏÉ İí ßá ÇáÌÏÇæá 

Select *from Sales
Where Sales is null

                            -- ÃÚáí æÇŞá Şíãå 
Select Max(Sales)from Sales;
Select MIN(Sales)From Sales;

                      -- ÇáÈÍË İí ÇáÈíÇäÇÊ Úáí æÌæÏ Şíã ÈåÇ ÇäÍÑÇİ ãÚíÇÑí 

Select *from Sales
Where Sales < 0.44 OR Sales > 22638.48;


                        -- ÚÏÏ ÇáØáÈÇÊ áßá ÔåÑ İí ÚÇã 2016
SELECT MONTH(Order_Date) AS Order_Month, COUNT(OrderID) AS Total_Orders
FROM Orders
where YEAR(order_date)='2016'
GROUP BY MONTH(order_date)
ORDER BY Order_Month;
               
			    -- ÇÚáÇ 10 ÚãáÇÁ İí ÇáãÈíÚÇÊ 

Select Top 10 C.Customer_Name,C.Region,Sum(S.Sales)as Total_Sales  From Customers C 
inner join Sales S 
On C.Customer_ID=S.Customer_ID
Group by C.Customer_Name ,C.Region
Order by Total_Sales Desc;



