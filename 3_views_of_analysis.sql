USE RetailDB;
GO

/* 
Analiz 1 - En �ok Satan �r�nler
Bu view, her �r�n�n toplam sat�� miktar�n� g�sterir.
VIEW 1: v_TopSellingProducts
Shows total quantity sold per product.
*/
CREATE VIEW v_TopSellingProducts AS
SELECT 
    Products.product_name AS Product,
    SUM(Sales.quantity) AS Total_Quantity_Sold
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Products.product_name;
GO


/* 
Analiz 2 - Kategori Baz�nda Toplam Gelir
Bu view, her �r�n kategorisi i�in toplam geliri hesaplar.
VIEW 2: v_TotalRevenueByCategory
Calculates total revenue by product category.
*/
CREATE VIEW v_TotalRevenueByCategory AS
SELECT 
    Products.category AS Category,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Products.category;
GO


/* 
Analiz 3 - B�lgelere G�re Ortalama Sipari� De�eri
Bu view, her b�lgenin ortalama sipari� de�erini g�sterir.
VIEW 3: v_AOVByRegion
Shows Average Order Value (AOV) by region.
*/
CREATE VIEW v_AOVByRegion AS
SELECT 
    Sales.region AS Region,
    ROUND(AVG(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Average_Order_Value
FROM Sales
GROUP BY Sales.region;
GO


/* 
Analiz 4 - �ndirim Oran� ile Sat�� Miktar� �li�kisi
Bu view, indirim aral�klar�na g�re toplam sat�� miktar�n� g�sterir.
VIEW 4: v_DiscountVsSales
Shows total sales quantity grouped by discount ranges.
*/
CREATE VIEW v_DiscountVsSales AS
SELECT 
    CASE 
        WHEN Sales.discount BETWEEN 0 AND 0.05 THEN '0�5%'
        WHEN Sales.discount BETWEEN 0.05 AND 0.10 THEN '5�10%'
        WHEN Sales.discount BETWEEN 0.10 AND 0.15 THEN '10�15%'
        WHEN Sales.discount BETWEEN 0.15 AND 0.20 THEN '15�20%'
        ELSE '20�25%'
    END AS Discount_Range,
    SUM(Sales.quantity) AS Total_Quantity
FROM Sales
GROUP BY 
    CASE 
        WHEN Sales.discount BETWEEN 0 AND 0.05 THEN '0�5%'
        WHEN Sales.discount BETWEEN 0.05 AND 0.10 THEN '5�10%'
        WHEN Sales.discount BETWEEN 0.10 AND 0.15 THEN '10�15%'
        WHEN Sales.discount BETWEEN 0.15 AND 0.20 THEN '15�20%'
        ELSE '20�25%'
    END;
GO


/* 
Analiz 5 - Ayl�k Sat�� Trendleri
Bu view, y�l ve ay baz�nda toplam sat�� gelirini g�sterir.
VIEW 5: v_MonthlySalesTrends
Displays total monthly revenue for each year-month combination.
*/
CREATE VIEW v_MonthlySalesTrends AS
SELECT 
    YEAR(Sales.date) AS Year,
    MONTH(Sales.date) AS Month,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Monthly_Revenue
FROM Sales
GROUP BY YEAR(Sales.date), MONTH(Sales.date);
GO


/* 
Analiz 6 - En Karl� �r�nler
Bu view, �r�n baz�nda toplam geliri hesaplar.
VIEW 6: v_MostProfitableProducts
Shows total revenue per product.
*/
CREATE VIEW v_MostProfitableProducts AS
SELECT 
    Products.product_name AS Product,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Products.product_name;
GO


/* 
Analiz 7 - �deme Y�ntemlerine G�re Toplam Sat��
Bu view, her �deme y�ntemine g�re toplam geliri g�sterir.
VIEW 7: v_TotalSalesByPaymentMethod
Displays total revenue per payment method.
*/
CREATE VIEW v_TotalSalesByPaymentMethod AS
SELECT 
    Sales.payment_method AS Payment_Method,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
GROUP BY Sales.payment_method;
GO


/* 
Analiz 8 - B�lge�Kategori �ifti Baz�nda Sat��
Bu view, b�lge ve �r�n kategorisi kombinasyonlar�na g�re toplam geliri g�sterir.
VIEW 8: v_RegionCategorySales
Shows total revenue by region�category combination.
*/
CREATE VIEW v_RegionCategorySales AS
SELECT 
    Sales.region AS Region,
    Products.category AS Category,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Sales.region, Products.category;
GO


/* 
Analiz 9 - Haftan�n G�nlerine G�re Sat��
Bu view, haftan�n g�nlerine g�re toplam sat�� gelirini hesaplar.
VIEW 9: v_SalesByWeekday
Displays total revenue per weekday.
*/
CREATE VIEW v_SalesByWeekday AS
SELECT 
    DATENAME(WEEKDAY, Sales.date) AS Weekday,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
GROUP BY DATENAME(WEEKDAY, Sales.date);
GO


/* 
Analiz 10 - �r�n�B�lge Kombinasyonu Baz�nda Gelir
Bu view, �r�n ve b�lge kombinasyonlar�na g�re toplam geliri g�sterir.
VIEW 10: v_ProductRegionRevenue
Shows total revenue by product�region combination.
*/
CREATE VIEW v_ProductRegionRevenue AS
SELECT 
    Products.product_name AS Product,
    Sales.region AS Region,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Products.product_name, Sales.region;
GO
