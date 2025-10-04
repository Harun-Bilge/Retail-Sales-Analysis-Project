# Retail Sales Analysis Project

## Overview
This project explores retail sales data using **SQL** and **Power BI**.  
It focuses on understanding sales trends, product performance, regional revenue, and the impact of discounts.  
The goal is to turn raw data into meaningful business insights through clean SQL logic and clear visualization.

---

## Objectives
- Build a relational retail database (`RetailDB`)
- Run analytical SQL queries for sales and product insights
- Create reusable **views** to connect with BI tools
- Design an interactive **Power BI dashboard** with key performance metrics (KPIs)

---

## Tools & Technologies
| Tool | Purpose |
|------|----------|
| **SQL Server** | Data modeling and analysis |
| **Mockaroo** | Synthetic data generation |
| **Power BI** | Data visualization and dashboard design |
| **DAX** | Dynamic measures and KPI calculations |

---

## Database Structure
**Database:** `RetailDB`

**Tables:**
- `Products` — Product information (ID, Name, Category)
- `Sales` — Transactional data (Quantity, Price, Discount, Date, Region, Payment Method)

**Analytical Views:**
1. `v_TopSellingProducts` – Top-selling products  
2. `v_TotalRevenueByCategory` – Total revenue by product category  
3. `v_AOVByRegion` – Average order value per region  
4. `v_DiscountVsSales` – Discount range vs sales quantity  
5. `v_MonthlySalesTrends` – Monthly revenue trends  
6. `v_MostProfitableProducts` – Highest revenue products  
7. `v_TotalSalesByPaymentMethod` – Revenue by payment method  
8. `v_RegionCategorySales` – Revenue by region–category  
9. `v_SalesByWeekday` – Sales distribution by weekday  
10. `v_ProductRegionRevenue` – Product–region revenue combinations

---

## SQL Example
```sql
SELECT 
    Products.product_name AS Product,
    SUM(Sales.quantity) AS Total_Quantity_Sold
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id
GROUP BY Products.product_name
ORDER BY Total_Quantity_Sold DESC;
