CREATE DATABASE IF NOT EXISTS supply_chain_db;
USE supply_chain_db;

-- ============================================
-- DIMENSION TABLES
-- ============================================

CREATE TABLE DIM_CUSTOMERS (
    Customer_Id         INT PRIMARY KEY,
    Customer_Fname      VARCHAR(100),
    Customer_Lname      VARCHAR(100),
    Customer_Email      VARCHAR(150),
    Customer_Segment    VARCHAR(50),
    Customer_City       VARCHAR(100),
    Customer_State      VARCHAR(100),
    Customer_Country    VARCHAR(100),
    Customer_Street     VARCHAR(200),
    Customer_Zipcode    VARCHAR(20)
);

CREATE TABLE DIM_CATEGORY (
    Category_Id         INT PRIMARY KEY,
    Category_Name       VARCHAR(100),
    Department_Id       INT,
    Department_Name     VARCHAR(100)
);

CREATE TABLE DIM_PRODUCTS (
    Product_Card_Id         INT PRIMARY KEY,
    Product_Name            VARCHAR(200),
    Product_Price           DECIMAL(10,2),
    Product_Category_Id     INT,
    Product_Status          INT,
    FOREIGN KEY (Product_Category_Id) REFERENCES DIM_CATEGORY(Category_Id)
);

CREATE TABLE DIM_SHIPPING (
    Shipping_Id             INT AUTO_INCREMENT PRIMARY KEY,
    Shipping_Mode           VARCHAR(50),
    Days_Scheduled          INT,
    Delivery_Status         VARCHAR(50)
);

-- ============================================
-- FACT TABLE
-- ============================================

CREATE TABLE FACT_ORDERS (
    Order_Item_Id               INT PRIMARY KEY,
    Order_Id                    INT,
    Order_Customer_Id           INT,
    Product_Card_Id             INT,
    Category_Id                 INT,

    -- Dates
    Order_Date                  DATETIME,
    Shipping_Date               DATETIME,

    -- Shipping & Delivery
    Shipping_Mode               VARCHAR(50),
    Days_Shipping_Real          INT,
    Days_Shipping_Scheduled     INT,
    Delivery_Status             VARCHAR(50),
    Late_Delivery_Risk          INT,

    -- Financials
    Sales_Per_Customer          DECIMAL(10,2),
    Benefit_Per_Order           DECIMAL(10,2),
    Order_Item_Discount         DECIMAL(10,2),
    Order_Item_Discount_Rate    DECIMAL(5,4),
    Order_Item_Product_Price    DECIMAL(10,2),
    Order_Item_Profit_Ratio     DECIMAL(5,4),
    Order_Item_Quantity         INT,
    Sales                       DECIMAL(10,2),
    Order_Item_Total            DECIMAL(10,2),
    Order_Profit_Per_Order      DECIMAL(10,2),

    -- Order Details
    Order_Status                VARCHAR(50),
    Order_Region                VARCHAR(100),
    Order_State                 VARCHAR(100),
    Order_City                  VARCHAR(100),
    Order_Country               VARCHAR(100),
    Order_Zipcode               VARCHAR(20),
    Market                      VARCHAR(50),
    Latitude                    DECIMAL(10,6),
    Longitude                   DECIMAL(10,6),

    -- Foreign Keys
    FOREIGN KEY (Order_Customer_Id) REFERENCES DIM_CUSTOMERS(Customer_Id),
    FOREIGN KEY (Product_Card_Id)   REFERENCES DIM_PRODUCTS(Product_Card_Id),
    FOREIGN KEY (Category_Id)       REFERENCES DIM_CATEGORY(Category_Id)
);

USE supply_chain_db;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE FACT_ORDERS;
TRUNCATE TABLE DIM_CUSTOMERS;
TRUNCATE TABLE DIM_PRODUCTS;
TRUNCATE TABLE DIM_CATEGORY;
SET FOREIGN_KEY_CHECKS = 1;


USE supply_chain_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS FACT_ORDERS;
DROP TABLE IF EXISTS DIM_CUSTOMERS;
DROP TABLE IF EXISTS DIM_PRODUCTS;
DROP TABLE IF EXISTS DIM_CATEGORY;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE DIM_CUSTOMERS (
    Customer_Id         INT PRIMARY KEY,
    Customer_Fname      VARCHAR(100),
    Customer_Lname      VARCHAR(100),
    Customer_Email      VARCHAR(150),
    Customer_Segment    VARCHAR(50),
    Customer_City       VARCHAR(100),
    Customer_State      VARCHAR(100),
    Customer_Country    VARCHAR(100),
    Customer_Street     VARCHAR(200),
    Customer_Zipcode    VARCHAR(20)
);

CREATE TABLE DIM_CATEGORY (
    Category_Id         INT PRIMARY KEY,
    Category_Name       VARCHAR(100),
    Department_Id       INT,
    Department_Name     VARCHAR(100)
);

CREATE TABLE DIM_PRODUCTS (
    Product_Card_Id         INT PRIMARY KEY,
    Product_Name            VARCHAR(200),
    Product_Price           DECIMAL(10,2),
    Product_Category_Id     INT,
    Product_Status          INT
);

CREATE TABLE FACT_ORDERS (
    Order_Item_Id               INT PRIMARY KEY,
    Order_Id                    INT,
    Order_Customer_Id           INT,
    Product_Card_Id             INT,
    Category_Id                 INT,
    Order_Date                  DATETIME,
    Shipping_Date               DATETIME,
    Shipping_Mode               VARCHAR(50),
    Days_Shipping_Real          INT,
    Days_Shipping_Scheduled     INT,
    Delivery_Status             VARCHAR(50),
    Late_Delivery_Risk          INT,
    Sales_Per_Customer          DECIMAL(10,2),
    Benefit_Per_Order           DECIMAL(10,2),
    Order_Item_Discount         DECIMAL(10,2),
    Order_Item_Discount_Rate    DECIMAL(5,4),
    Order_Item_Product_Price    DECIMAL(10,2),
    Order_Item_Profit_Ratio     DECIMAL(5,4),
    Order_Item_Quantity         INT,
    Sales                       DECIMAL(10,2),
    Order_Item_Total            DECIMAL(10,2),
    Order_Profit_Per_Order      DECIMAL(10,2),
    Order_Status                VARCHAR(50),
    Order_Region                VARCHAR(100),
    Order_State                 VARCHAR(100),
    Order_City                  VARCHAR(100),
    Order_Country               VARCHAR(100),
    Order_Zipcode               VARCHAR(20),
    Market                      VARCHAR(50),
    Latitude                    DECIMAL(10,6),
    Longitude                   DECIMAL(10,6)
);

SELECT * FROM supply_chain_db.dim_shipping;
create table supply_chain_db.dim_shipping(
order_Item_Id bigint,
order_id bigint,
Shipping_Date datetime,
Shipping_Mode text,
Days_Shipping_Real bigint,
Days_Shipping_Scheduled bigint,
Delivery_Status text,
Late_Delivery_Risk bigint
);
INSERT INTO supply_chain_db.dim_shipping (
    Order_Item_Id,
    order_id,
    Shipping_Date,
    Shipping_Mode,
    Days_Shipping_Real,
    Days_Shipping_Scheduled,
    Delivery_Status,
    Late_Delivery_Risk
)
SELECT
    Order_Item_Id,
    order_id,
    Shipping_Date,
    Shipping_Mode,
    Days_Shipping_Real,
    Days_Shipping_Scheduled,
    Delivery_Status,
    Late_Delivery_Risk
FROM supply_chain_db.fact_orders;

-- checking for duplictes -- 
select * from (
select *,
row_number() over(partition by Category_Id) as rn
from dim_category)t
where rn>1;

select * from (
select *,
row_number() over(partition by Customer_Id) as rn
from dim_customers)t
where rn>1;

select * from (
select *,
row_number() over(partition by Product_Card_Id) as rn
from dim_products)t
where rn>1;