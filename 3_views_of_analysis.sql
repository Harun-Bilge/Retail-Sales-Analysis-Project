USE RetailDB;
GO

/* 
Analiz 1 - En Çok Satan Ürünler
Bu view, her ürünün toplam satýþ miktarýný gösterir.
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
Analiz 2 - Kategori Bazýnda Toplam Gelir
Bu view, her ürün kategorisi için toplam geliri hesaplar.
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
Analiz 3 - Bölgelere Göre Ortalama Sipariþ Deðeri
Bu view, her bölgenin ortalama sipariþ deðerini gösterir.
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
Analiz 4 - Ýndirim Oraný ile Satýþ Miktarý Ýliþkisi
Bu view, indirim aralýklarýna göre toplam satýþ miktarýný gösterir.
VIEW 4: v_DiscountVsSales
Shows total sales quantity grouped by discount ranges.
*/
CREATE VIEW v_DiscountVsSales AS
SELECT 
    CASE 
        WHEN Sales.discount BETWEEN 0 AND 0.05 THEN '0–5%'
        WHEN Sales.discount BETWEEN 0.05 AND 0.10 THEN '5–10%'
        WHEN Sales.discount BETWEEN 0.10 AND 0.15 THEN '10–15%'
        WHEN Sales.discount BETWEEN 0.15 AND 0.20 THEN '15–20%'
        ELSE '20–25%'
    END AS Discount_Range,
    SUM(Sales.quantity) AS Total_Quantity
FROM Sales
GROUP BY 
    CASE 
        WHEN Sales.discount BETWEEN 0 AND 0.05 THEN '0–5%'
        WHEN Sales.discount BETWEEN 0.05 AND 0.10 THEN '5–10%'
        WHEN Sales.discount BETWEEN 0.10 AND 0.15 THEN '10–15%'
        WHEN Sales.discount BETWEEN 0.15 AND 0.20 THEN '15–20%'
        ELSE '20–25%'
    END;
GO


/* 
Analiz 5 - Aylýk Satýþ Trendleri
Bu view, yýl ve ay bazýnda toplam satýþ gelirini gösterir.
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
Analiz 6 - En Karlý Ürünler
Bu view, ürün bazýnda toplam geliri hesaplar.
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
Analiz 7 - Ödeme Yöntemlerine Göre Toplam Satýþ
Bu view, her ödeme yöntemine göre toplam geliri gösterir.
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
Analiz 8 - Bölge–Kategori Çifti Bazýnda Satýþ
Bu view, bölge ve ürün kategorisi kombinasyonlarýna göre toplam geliri gösterir.
VIEW 8: v_RegionCategorySales
Shows total revenue by region–category combination.
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
Analiz 9 - Haftanýn Günlerine Göre Satýþ
Bu view, haftanýn günlerine göre toplam satýþ gelirini hesaplar.
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
Analiz 10 - Ürün–Bölge Kombinasyonu Bazýnda Gelir
Bu view, ürün ve bölge kombinasyonlarýna göre toplam geliri gösterir.
VIEW 10: v_ProductRegionRevenue
Shows total revenue by product–region combination.
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
