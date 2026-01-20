use adventure_works_cycles;
select * from sales;




-- 3.calcuate the following fields from the Orderdatekey field ( First Create a Date Field from Orderdatekey)
alter table sales add column Dates date;
UPDATE sales SET dates = STR_TO_DATE(orderdatekey, '%Y%m%d');
select dates from sales order by dates;



-- A.Year
alter table sales add column Years int;
update sales set years=year(dates);
select dates,years from sales order by years;


-- B.Monthno
alter table sales add column Month_no int;
update sales set Month_no=month(dates);
select dates,Month_no from sales order by month_no;


-- C.Monthfullname
alter table sales add column Month_Name varchar(12);
update sales set Month_Name= monthname(dates);
select dates,Month_name from sales order by Month_name;


-- D.Quarter(Q1,Q2,Q3,Q4)
alter table sales add column Quarters varchar(12);
update sales set Quarters=quarter(dates);
update sales set Quarters=concat('Q',Quarters);
select dates,Quarters from sales order by quarters;


-- E. YearMonth ( YYYY-MMM)
alter table sales add column YearMonth varchar(20);
update sales set YearMonth = date_format(dates,'%Y-%b');
select dates,yearmonth from sales order by yearmonth;


-- F. Weekdayno counted week monthly
alter table sales add column Weekday_No int;
update sales set Weekday_no=weekday(dates)+1;
select dates,weekday_no from sales;


-- G.Weekdayname 
alter table sales add column Weekday_name varchar(12);
update sales set Weekday_Name=dayname(dates);
select dates,weekday_Name from sales;
 
 
-- H.FinancialMOnth month name financial year wise
alter table sales add column Financial_Month_Name varchar(15);
update sales set Financial_Month_Name=DATE_FORMAT(DATE_ADD(dates, INTERVAL 3 MONTH),'%M');
select dates,Financial_Month_Name from sales;
select dates,month_name,Financial_Month_Name from sales;


-- I. Financial Quarter 
alter table sales add column Financial_quarter varchar(2);
update sales set Financial_quarter= CONCAT('Q',QUARTER(DATE_ADD(dates, INTERVAL 9 MONTH)));
select dates,Financial_quarter from sales;
select dates,quarters,Financial_quarter from sales;





-- que 4.Calculate the Sales amount uning the columns(unit price,order quantity,unit discount)
alter table sales add column Sellingprice decimal(10,2);
update sales set Sellingprice=OrderQuantity*UnitPrice-DiscountAmount;
select sellingprice from sales;
select round(sum(sellingprice)/1000000,2) as Sellingprice from sales;



-- 5.Calculate the Productioncost uning the columns(unit cost ,order quantity
alter table sales add column Productioncost decimal(10,2);
update sales set Productioncost=ProductStandardCost*OrderQuantity;
select productioncost from sales;
select round(sum(productioncost)/1000000,2) as Productioncost from sales;



-- 6.Calculate the Netprofit.
alter table sales add column Netprofit decimal(10,2);
update sales set Netprofit=OrderQuantity*UnitPrice-DiscountAmount-ProductStandardCost*OrderQuantity-Taxamt-Freight;
select netprofit from sales;
select round(sum(Netprofit)/1000000,2) as Netprofit from sales;



-- 7.Create a Pivot table for month and sales (provide the Year as filter to select a particular Year)
SELECT productkey,years,month_name,COUNT(*) AS sales_count,sum(sellingprice) as sellingprice FROM sales
GROUP BY productkey,years,month_name ORDER BY ProductKey,years;



-- 8.Create a Bar chart to show yearwise Sales
select years,sum(sellingprice) as sellingprice from sales group by years order by years;



-- 9.Create a Line Chart to show Monthwise sales
select month_name,sum(sellingprice) as sellingprice from sales group by month_name order by month(str_to_date(month_name,'%M')) asc;



-- 10.Create a Pie chart to show Quarterwise sales 
select Quarters,sum(sellingprice) as sellingprice from sales group by quarters order by quarters;


 
-- 11.Create a combinational chart (bar and Line) to show Salesamount and Productioncost together
select years,sum(sellingprice) as sellingprice ,sum(productioncost) as productioncost from sales group by years order by years;



-- 12.additional kpi  Calculation for Net profit margin.
alter table sales add column Netprofit_margin decimal(10,2);
update sales set Netprofit_margin=((OrderQuantity*UnitPrice-DiscountAmount-ProductStandardCost*OrderQuantity-Taxamt-Freight)/(OrderQuantity*UnitPrice-DiscountAmount))*100;
select round(avg(Netprofit_margin),2) as Netprofit_margin from sales;



-- 13 customer full name
alter table sales add column Customer_fullname varchar(255);
update sales set customer_fullname= concat(trim(customerfirstname),' ',trim(customerlastname));
select customer_fullname from sales;


-- 13.1 top 5 customers
select customer_fullname,sum(sellingprice) as sellingprice from sales group by customer_fullname order by sellingprice desc limit 5;










use adventure_works_cycles;
-- que 3.calcuate the following fields from the Orderdatekey field ( First Create a Date Field from Orderdatekey)
select dates from sales order by dates;

-- A.Year
select dates,years from sales order by years;
-- B.Monthno
select dates,Month_no from sales order by month_no;
-- C.Monthfullname
select dates,Month_name from sales order by Month_name;
-- D.Quarter(Q1,Q2,Q3,Q4)
select dates,Quarters from sales order by quarters;
-- E. YearMonth ( YYYY-MMM) 
select dates,yearmonth from sales order by yearmonth;
-- F. Weekdayno 
select dates,weekday_no from sales;
-- G.Weekdayname 
select dates,weekday_Name from sales;
-- H.FinancialMOnth month name financial year wise
select dates,Financial_Month_Name from sales;
-- I. Financial Quarter 
select dates,Financial_quarter from sales;


-- que 4.Calculate the Sales amount uning the columns(unit price,order quantity,unit discount)
select sellingprice from sales;
select round(sum(sellingprice)/1000000,2) as Sellingprice from sales;

-- 5.Calculate the Productioncost uning the columns(unit cost ,order quantity)
select productioncost from sales;
select round(sum(productioncost)/1000000,2) as Productioncost from sales;

-- 6.Calculate the netprofit.                                    
select netprofit from sales;
select round(sum(Netprofit)/1000000,2) as Netprofit from sales;

-- 7.Create a Pivot table for month and sales (provide the Year as filter to select a particular Year)
SELECT years,month_name,sum(sellingprice) as sellingprice FROM sales
GROUP BY productkey,years,month_name ORDER BY ProductKey,years;


-- 8.Create a Bar chart to show yearwise Sales
select years,sum(sellingprice) as sellingprice from sales group by years order by years;

-- 9.Create a Line Chart to show Monthwise sales
select month_name,sum(sellingprice) as sellingprice from sales group by month_name order by month(str_to_date(month_name,'%M')) asc;

-- 10.Create a Pie chart to show Quarterwise sales 
select Quarters,sum(sellingprice) as sellingprice from sales group by quarters order by quarters;

-- 11.Create a combinational chart (bar and Line) to show Salesamount and Productioncost together
select years,sum(sellingprice) as sellingprice ,sum(productioncost) as productioncost from sales group by years order by years;

-- 12.additional kpi  Calculation for Net profit margin.
select round(avg(Netprofit_margin),2) as Netprofit_margin from sales;

-- 13 customer full name
select customer_fullname from sales;

-- 13.1 top 5 customers
select customer_fullname,sum(sellingprice) as sellingprice from sales group by customer_fullname order by sellingprice desc limit 5;
