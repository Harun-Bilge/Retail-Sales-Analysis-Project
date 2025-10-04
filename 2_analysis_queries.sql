-- QUERY 1: En Çok Satan Ürünler / Top-Selling Products
-- Bu sorgu, her ürünün toplam satýþ miktarýný hesaplar.
-- The query calculates the total quantity sold for each product.

USE RetailDB;
GO

SELECT 
    p.product_name AS Product,
    SUM(s.quantity) AS Total_Quantity_Sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Quantity_Sold DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, hangi ürünlerin en çok satýldýðýný gösterir. 
--         Ürün bazýnda toplam miktarlarý hesapladýðýmýz için 
--         stok yönetimi veya en popüler ürünleri belirleme açýsýndan faydalýdýr.
-- English: This query shows which products sold the most.
--          Summing quantities per product helps in understanding top-selling items 
--          and supports inventory or marketing decisions.



-- QUERY 2: Kategori Bazýnda Toplam Gelir / Total Revenue by Category
-- Bu sorgu, her ürün kategorisi için toplam geliri hesaplar.
-- The query calculates total revenue for each product category.

USE RetailDB;
GO

SELECT 
    p.category AS Category,
    ROUND(SUM(s.quantity * s.unit_price * (1 - s.discount)), 2) AS Total_Revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu kategorilere göre toplam geliri gösterir.
--         Ýndirim faktörünü (1 - discount) dahil ederek gerçek geliri hesaplýyoruz.
--         Bu analiz, hangi ürün grubunun finansal olarak en güçlü olduðunu anlamaya yardýmcý olur.
-- English: This query shows total revenue per product category.
--          It includes the discount factor (1 - discount) to calculate the actual revenue.
--          The analysis helps identify which product groups are financially the strongest.



-- QUERY 3: Bölgelere Göre Ortalama Sipariþ Deðeri / Average Order Value by Region
-- Bu sorgu, her bölgedeki ortalama sipariþ tutarýný (AOV) hesaplar.
-- The query calculates the Average Order Value (AOV) for each region.

USE RetailDB;
GO

SELECT 
    Sales.region AS Region,
    ROUND(AVG(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Average_Order_Value
FROM Sales
GROUP BY Sales.region
ORDER BY Average_Order_Value DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, her bölgedeki ortalama sipariþ tutarýný bulur. 
--         Ortalama sipariþ deðeri (AOV), bölgesel alým gücü ve fiyat stratejisini deðerlendirmek için kullanýlýr.
-- English: This query finds the average order value for each region.
--          AOV helps evaluate purchasing power and pricing performance by region.



-- QUERY 4: Ýndirim Oraný ile Satýþ Miktarý Arasýndaki Ýliþki / Relationship Between Discount Rate and Sales Quantity
-- Bu sorgu, indirim aralýklarýna göre toplam satýþ miktarýný hesaplar.
-- The query calculates total sales quantity grouped by discount ranges.

USE RetailDB;
GO

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
    END
ORDER BY Discount_Range;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, indirim oranlarýný belirli aralýklara ayýrarak her aralýktaki toplam satýþ miktarýný gösterir.
--         Böylece indirim arttýkça satýþ hacminin nasýl deðiþtiði gözlemlenebilir.
-- English: This query divides discount rates into ranges and shows the total sales quantity for each range.
--          It helps visualize how sales volume changes as discounts increase.



-- QUERY 5: Aylýk Satýþ Trendleri / Monthly Sales Trends
-- Bu sorgu, her ay için toplam satýþ gelirini hesaplar.
-- The query calculates total monthly revenue to reveal sales trends over time.

USE RetailDB;
GO

SELECT 
    YEAR(Sales.date) AS Year,
    MONTH(Sales.date) AS Month,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Monthly_Revenue
FROM Sales
GROUP BY YEAR(Sales.date), MONTH(Sales.date)
ORDER BY Year, Month;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu zaman serisi mantýðýyla her ayýn toplam gelirini bulur.
--         Satýþlardaki artýþ veya düþüþ dönemlerini görmek, sezonluk veya kampanya bazlý analizler için yararlýdýr.
-- English: This query finds total revenue for each month using a time-series perspective.
--          It helps identify growth or decline periods, useful for seasonal or campaign-based insights.



-- QUERY 6: En Karlý Ürünler / Most Profitable Products
-- Bu sorgu, her ürünün toplam gelirini hesaplar ve en çok kazandýran ürünleri sýralar.
-- The query calculates total revenue for each product and ranks them by profitability.

USE RetailDB;
GO

SELECT 
    Products.product_name AS Product,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Products.product_name
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, ürün bazýnda toplam geliri hesaplayarak en kârlý ürünleri listeler.
--         Hangi ürünlerin þirkete en fazla katkýyý saðladýðýný gösterir ve stok ya da fiyat stratejileri için kullanýlabilir.
-- English: This query lists total revenue per product to identify the most profitable items.
--          It highlights which products contribute most to company earnings and supports pricing or inventory decisions.



-- QUERY 7: Ödeme Yöntemlerine Göre Toplam Satýþ / Total Sales by Payment Method
-- Bu sorgu, her ödeme yönteminin toplam satýþ gelirini hesaplar.
-- The query calculates total revenue generated by each payment method.

USE RetailDB;
GO

SELECT 
    Sales.payment_method AS Payment_Method,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
GROUP BY Sales.payment_method
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, farklý ödeme yöntemlerinden elde edilen toplam geliri gösterir.
--         Müþterilerin alýþveriþ davranýþlarýný anlamak ve hangi ödeme kanallarýnýn öne çýktýðýný belirlemek için kullanýlýr.
-- English: This query shows total revenue by payment method.
--          It helps understand customer behavior and identify which payment channels contribute most to total sales.



-- QUERY 8: En Çok Satýþ Yapan Bölge–Kategori Çifti / Top-Selling Region–Category Combination
-- Bu sorgu, bölge ve ürün kategorisi bazýnda toplam satýþ gelirini hesaplar.
-- The query calculates total revenue by combining region and product category.

USE RetailDB;
GO

SELECT 
    Sales.region AS Region,
    Products.category AS Category,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Sales.region, Products.category
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, her bölge ve ürün kategorisi kombinasyonu için toplam geliri gösterir.
--         Böylece hangi bölge–kategori ikilisinin satýþlarda öne çýktýðý belirlenebilir.
-- English: This query shows total revenue for each region–category pair.
--          It helps identify which region–category combinations perform best in terms of sales.



-- QUERY 9: En Yoðun Gün / Most Active Sales Day
-- Bu sorgu, haftanýn günlerine göre toplam satýþ gelirini hesaplar.
-- The query calculates total revenue for each weekday to identify the busiest sales days.

USE RetailDB;
GO

SELECT 
    DATENAME(WEEKDAY, Sales.date) AS Weekday,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
GROUP BY DATENAME(WEEKDAY, Sales.date)
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, haftanýn hangi günlerinde satýþlarýn yoðunlaþtýðýný gösterir.
--         Kampanyalar, personel planlamasý veya pazarlama zamanlamasý için deðerli içgörüler saðlar.
-- English: This query shows which weekdays generate the most revenue.
--          It offers valuable insights for marketing campaigns, staffing, or scheduling decisions.



-- QUERY 10: En Çok Gelir Getiren Ürün–Bölge Kombosu / Top Revenue-Generating Product–Region Combination
-- Bu sorgu, ürün ve bölge kombinasyonlarýna göre toplam geliri hesaplar.
-- The query calculates total revenue by product–region combination to identify where each product performs best.

USE RetailDB;
GO

SELECT TOP 10
    Products.product_name AS Product,
    Sales.region AS Region,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Products.product_name, Sales.region
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlarý / Analysis Notes:
-- Türkçe: Bu sorgu, her ürünün farklý bölgelerdeki gelir performansýný ölçer ve en yüksek kazanç getiren kombinasyonlarý listeler.
--         Bu bilgi, bölgesel talebi anlamak, kampanya planlamak ve stok daðýlýmýný optimize etmek için kullanýlabilir.
-- English: This query measures each product's revenue performance across regions and lists the top revenue-generating combinations.
--          It helps understand regional demand, plan promotions, and optimize inventory distribution.
