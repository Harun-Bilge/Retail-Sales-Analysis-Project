-- Veritabaný oluþturma / Creating the database
-- Eðer 'RetailDB' isimli veritabaný yoksa oluþturur.
-- Creates the 'RetailDB' database only if it doesn’t already exist.
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'RetailDB')
BEGIN
    CREATE DATABASE RetailDB;
END;
GO


-- RetailDB veritabanýný aktif hale getiriyoruz / Activate the RetailDB database
USE RetailDB;
GO


-- Products tablosu / Products table
-- Ürünleri tutar: her ürünün kimliði, ismi ve kategorisi bulunur.
-- Holds product information: each product has an ID, name, and category.
IF OBJECT_ID('Products', 'U') IS NULL
BEGIN
    CREATE TABLE Products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(100),
        category VARCHAR(50)
    );
END;
GO


-- Sales tablosu / Sales table
-- Satýþ kayýtlarýný içerir: tarih, ürün, miktar, fiyat, indirim, bölge ve ödeme tipi.
-- Contains sales records: date, product, quantity, price, discount, region, and payment type.
IF OBJECT_ID('Sales', 'U') IS NULL
BEGIN
    CREATE TABLE Sales (
        sale_id INT PRIMARY KEY,
        date DATE,
        product_id INT,
        quantity INT,
        unit_price DECIMAL(10,2),
        discount DECIMAL(5,2),
        region VARCHAR(50),
        payment_method VARCHAR(50),
        FOREIGN KEY (product_id) REFERENCES Products(product_id)
    );
END;
GO


-- Mockaroo'dan alýnan satýþ verileri Sales tablosuna yüklendi.
-- The sales data generated in Mockaroo is loaded into the Sales table.

-- Products tablosuna manuel veri ekliyoruz / Manually inserting data into Products
-- Küçük tablo olduðu için veriyi tek tek ekliyoruz.
-- Since this table is small, we insert records manually for clarity.
USE RetailDB;
GO

INSERT INTO Products (product_id, product_name, category)
VALUES
(100, 'USB Cable', 'Electronics'),
(101, 'T-Shirt', 'Clothing'),
(102, 'Jeans', 'Clothing'),
(103, 'Hoodie', 'Clothing'),
(104, 'Laptop', 'Electronics'),
(105, 'Headphones', 'Electronics'),
(106, 'Mouse', 'Electronics'),
(107, 'Coffee Mug', 'Home'),
(108, 'Cushion', 'Home'),
(109, 'Book: Data Science', 'Books'),
(110, 'Notebook', 'Stationery');
GO
