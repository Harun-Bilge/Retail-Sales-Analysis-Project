-- QUERY 1: En �ok Satan �r�nler / Top-Selling Products
-- Bu sorgu, her �r�n�n toplam sat�� miktar�n� hesaplar.
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

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, hangi �r�nlerin en �ok sat�ld���n� g�sterir. 
--         �r�n baz�nda toplam miktarlar� hesaplad���m�z i�in 
--         stok y�netimi veya en pop�ler �r�nleri belirleme a��s�ndan faydal�d�r.
-- English: This query shows which products sold the most.
--          Summing quantities per product helps in understanding top-selling items 
--          and supports inventory or marketing decisions.



-- QUERY 2: Kategori Baz�nda Toplam Gelir / Total Revenue by Category
-- Bu sorgu, her �r�n kategorisi i�in toplam geliri hesaplar.
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

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu kategorilere g�re toplam geliri g�sterir.
--         �ndirim fakt�r�n� (1 - discount) dahil ederek ger�ek geliri hesapl�yoruz.
--         Bu analiz, hangi �r�n grubunun finansal olarak en g��l� oldu�unu anlamaya yard�mc� olur.
-- English: This query shows total revenue per product category.
--          It includes the discount factor (1 - discount) to calculate the actual revenue.
--          The analysis helps identify which product groups are financially the strongest.



-- QUERY 3: B�lgelere G�re Ortalama Sipari� De�eri / Average Order Value by Region
-- Bu sorgu, her b�lgedeki ortalama sipari� tutar�n� (AOV) hesaplar.
-- The query calculates the Average Order Value (AOV) for each region.

USE RetailDB;
GO

SELECT 
    Sales.region AS Region,
    ROUND(AVG(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Average_Order_Value
FROM Sales
GROUP BY Sales.region
ORDER BY Average_Order_Value DESC;

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, her b�lgedeki ortalama sipari� tutar�n� bulur. 
--         Ortalama sipari� de�eri (AOV), b�lgesel al�m g�c� ve fiyat stratejisini de�erlendirmek i�in kullan�l�r.
-- English: This query finds the average order value for each region.
--          AOV helps evaluate purchasing power and pricing performance by region.



-- QUERY 4: �ndirim Oran� ile Sat�� Miktar� Aras�ndaki �li�ki / Relationship Between Discount Rate and Sales Quantity
-- Bu sorgu, indirim aral�klar�na g�re toplam sat�� miktar�n� hesaplar.
-- The query calculates total sales quantity grouped by discount ranges.

USE RetailDB;
GO

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
    END
ORDER BY Discount_Range;

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, indirim oranlar�n� belirli aral�klara ay�rarak her aral�ktaki toplam sat�� miktar�n� g�sterir.
--         B�ylece indirim artt�k�a sat�� hacminin nas�l de�i�ti�i g�zlemlenebilir.
-- English: This query divides discount rates into ranges and shows the total sales quantity for each range.
--          It helps visualize how sales volume changes as discounts increase.



-- QUERY 5: Ayl�k Sat�� Trendleri / Monthly Sales Trends
-- Bu sorgu, her ay i�in toplam sat�� gelirini hesaplar.
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

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu zaman serisi mant���yla her ay�n toplam gelirini bulur.
--         Sat��lardaki art�� veya d���� d�nemlerini g�rmek, sezonluk veya kampanya bazl� analizler i�in yararl�d�r.
-- English: This query finds total revenue for each month using a time-series perspective.
--          It helps identify growth or decline periods, useful for seasonal or campaign-based insights.



-- QUERY 6: En Karl� �r�nler / Most Profitable Products
-- Bu sorgu, her �r�n�n toplam gelirini hesaplar ve en �ok kazand�ran �r�nleri s�ralar.
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

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, �r�n baz�nda toplam geliri hesaplayarak en k�rl� �r�nleri listeler.
--         Hangi �r�nlerin �irkete en fazla katk�y� sa�lad���n� g�sterir ve stok ya da fiyat stratejileri i�in kullan�labilir.
-- English: This query lists total revenue per product to identify the most profitable items.
--          It highlights which products contribute most to company earnings and supports pricing or inventory decisions.



-- QUERY 7: �deme Y�ntemlerine G�re Toplam Sat�� / Total Sales by Payment Method
-- Bu sorgu, her �deme y�nteminin toplam sat�� gelirini hesaplar.
-- The query calculates total revenue generated by each payment method.

USE RetailDB;
GO

SELECT 
    Sales.payment_method AS Payment_Method,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
GROUP BY Sales.payment_method
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, farkl� �deme y�ntemlerinden elde edilen toplam geliri g�sterir.
--         M��terilerin al��veri� davran��lar�n� anlamak ve hangi �deme kanallar�n�n �ne ��kt���n� belirlemek i�in kullan�l�r.
-- English: This query shows total revenue by payment method.
--          It helps understand customer behavior and identify which payment channels contribute most to total sales.



-- QUERY 8: En �ok Sat�� Yapan B�lge�Kategori �ifti / Top-Selling Region�Category Combination
-- Bu sorgu, b�lge ve �r�n kategorisi baz�nda toplam sat�� gelirini hesaplar.
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

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, her b�lge ve �r�n kategorisi kombinasyonu i�in toplam geliri g�sterir.
--         B�ylece hangi b�lge�kategori ikilisinin sat��larda �ne ��kt��� belirlenebilir.
-- English: This query shows total revenue for each region�category pair.
--          It helps identify which region�category combinations perform best in terms of sales.



-- QUERY 9: En Yo�un G�n / Most Active Sales Day
-- Bu sorgu, haftan�n g�nlerine g�re toplam sat�� gelirini hesaplar.
-- The query calculates total revenue for each weekday to identify the busiest sales days.

USE RetailDB;
GO

SELECT 
    DATENAME(WEEKDAY, Sales.date) AS Weekday,
    ROUND(SUM(Sales.quantity * Sales.unit_price * (1 - Sales.discount)), 2) AS Total_Revenue
FROM Sales
GROUP BY DATENAME(WEEKDAY, Sales.date)
ORDER BY Total_Revenue DESC;

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, haftan�n hangi g�nlerinde sat��lar�n yo�unla�t���n� g�sterir.
--         Kampanyalar, personel planlamas� veya pazarlama zamanlamas� i�in de�erli i�g�r�ler sa�lar.
-- English: This query shows which weekdays generate the most revenue.
--          It offers valuable insights for marketing campaigns, staffing, or scheduling decisions.



-- QUERY 10: En �ok Gelir Getiren �r�n�B�lge Kombosu / Top Revenue-Generating Product�Region Combination
-- Bu sorgu, �r�n ve b�lge kombinasyonlar�na g�re toplam geliri hesaplar.
-- The query calculates total revenue by product�region combination to identify where each product performs best.

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

-- Analiz Yorumlar� / Analysis Notes:
-- T�rk�e: Bu sorgu, her �r�n�n farkl� b�lgelerdeki gelir performans�n� �l�er ve en y�ksek kazan� getiren kombinasyonlar� listeler.
--         Bu bilgi, b�lgesel talebi anlamak, kampanya planlamak ve stok da��l�m�n� optimize etmek i�in kullan�labilir.
-- English: This query measures each product's revenue performance across regions and lists the top revenue-generating combinations.
--          It helps understand regional demand, plan promotions, and optimize inventory distribution.
