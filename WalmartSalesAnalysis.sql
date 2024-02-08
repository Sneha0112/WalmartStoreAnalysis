create database walmart;
use walmart;

select * from walmart;

--Calculate the average temperature for each year.

select year(date) year_ , avg(temperature) avg_temperature
from Walmart
group by year(date)

--Retrieve the sales data for the week of holidays in 2012.
select count(*) Holidays
from Walmart
where Holiday_Flag=0 and year(date)=2012

--Find the top 3 store with the highest sales in a given week.

select top 3 store , sum(weekly_sales) highest_sales
from walmart
group by store
order by highest_sales desc

--Calculate the total sales during holiday weeks in 2011.

select sum(weekly_sales) as total_sales
from Walmart
where year(date)=2011 and Holiday_Flag=0

--Identify weeks where the Unemployment rate was above the average Unemployment rate.
SELECT *
FROM Walmart
WHERE Unemployment > (SELECT AVG(Unemployment) FROM Walmart);

--Find the store with the highest average sales across all weeks
SELECT top 1 Store, round(AVG(Weekly_Sales),2) AS AvgSales
FROM Walmart
GROUP BY Store
ORDER BY AvgSales DESC

--Calculate the percentage change in fuel prices from the previous
--week for each store.

SELECT date, Store, Fuel_Price,
       LAG(Fuel_Price) OVER (PARTITION BY Store ORDER BY Date) AS PrevWeekFuelPrice,
       ((Fuel_Price - LAG(Fuel_Price) OVER (PARTITION BY Store ORDER BY Date)) / LAG(Fuel_Price) OVER (PARTITION BY Store ORDER BY Date)) * 100 AS PercentageChange
FROM Walmart;


--Total Sales for each year
SELECT YEAR(Date) AS Year, round(SUM(Weekly_Sales),2) AS TotalSales
FROM walmart
GROUP BY Year(date);

--Average Sales per store
SELECT Store, round(AVG(Weekly_Sales),2) AS AvgSalesPerStore
FROM Walmart
GROUP BY Store
order by store

--Yearly Sales Growth Rate

SELECT
    Year,
    (totalsales - LAG(TotalSales) OVER (ORDER BY Year)) / 
	LAG(TotalSales) OVER (ORDER BY Year) * 100 AS GrowthRate
FROM (
    SELECT YEAR(Date) AS Year, SUM(Weekly_Sales) AS TotalSales
    FROM Walmart
    GROUP BY Year(date)
) AS YearlySales;

--Sales Contribution Percentage by Each Store
SELECT
    Store,
    SUM(Weekly_Sales) / (SELECT SUM(Weekly_Sales) FROM Walmart) * 100 AS SalesContributionPercentage
FROM Walmart
GROUP BY Store;

--Corelation and covariance between fuel price and sales

SELECT
Store,
AVG(1.0 * Fuel_Price * Weekly_Sales) - AVG(Fuel_Price) * AVG(Weekly_Sales) AS Covariance,
STDEVP(Fuel_Price) * STDEVP(Weekly_Sales) AS Correlation
FROM Walmart
GROUP BY Store;

--Count the number of holiday weeks and non-holiday weeks
SELECT Holiday_Flag, COUNT(*) AS WeekCount
FROM walmart
GROUP BY Holiday_Flag;

--Calculate average sales for holiday and non-holiday weeks
SELECT Holiday_Flag, AVG(Weekly_Sales) AS AvgSales
FROM walmart
GROUP BY Holiday_Flag;

--Find the week with the highest temperature
SELECT MAX(Temperature) AS MaxTemperature
FROM walmart;

--Calculate average temperature for each store
SELECT Store, AVG(Temperature) AS AvgTemperature
FROM walmart
GROUP BY Store
order by store
















