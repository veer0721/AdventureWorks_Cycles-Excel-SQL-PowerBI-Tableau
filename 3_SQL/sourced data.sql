use adventure_works_cycles;
create table Sales(
ProductKey int,
OrderDateKey int,
DueDateKey varchar(12),
ShipDateKey int,
CustomerKey int,
PromotionKey int,
CurrencyKey int,
ProductCategoryKey int,
ProductSubcategoryKey int,
SalesTerritoryKey int,
OrderDate int,
DueDate int,
ShipDate int,
SalesOrderNumber varchar(10),
OrderQuantity int,
UnitPrice decimal(10,2),
ExtendedAmount decimal(10,2),
DiscountAmount decimal(10,2),
ProductStandardCost decimal(10,2),
TotalProductCost decimal(10,2),
SalesAmount decimal(10,2),
TaxAmt decimal(10,2),
Freight decimal(10,2),
ProductName varchar(255),
ProductCategoryName varchar(255),
ProductSubcategoryName varchar(255),
CustomerFirstName varchar(16),
CustomerMiddleName varchar(16),
CustomerLastName varchar(16),
Region varchar(25),
Country varchar(25),
ProductUnitPrice decimal(10,2));
desc Sales;
select @@secure_file_priv;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Totalsales.csv'
into table Sales
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
select * from Sales;







