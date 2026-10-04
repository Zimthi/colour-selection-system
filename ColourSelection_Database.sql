-- PROJECT NAME: B2B Textile Inventory and Sales Management System
-- ORGANIZATION: Colour Selection


-- Create and use the specific database for the organization
CREATE DATABASE ColourSelectionDB;
GO
USE ColourSelectionDB;
GO


-- PART 1: DATA DEFINITION LANGUAGE (DDL) - TABLE CREATION & CONSTRAINTS


-- Creating the CUSTOMER table to store client contact information
CREATE TABLE CUSTOMER(
	CustomerID INT PRIMARY KEY, -- Unique identifier for each customer
	CustomerName VARCHAR(100) NOT NULL,
	Phone VARCHAR(10),
	Email VARCHAR(100),
	Address VARCHAR(100)
);

-- Creating the SUPPLIER table to track where raw materials are sourced from
CREATE TABLE SUPPLIER(
	SupplierID INT PRIMARY KEY,
	SupplierName VARCHAR(100) NOT NULL,
	PHONE VARCHAR(10),
	Email VARCHAR(100),
	Address VARCHAR(100)
);

-- Creating the WAREHOUSE table to manage different storage locations
CREATE TABLE WAREHOUSE(
	WarehouseID INT PRIMARY KEY,
	WarehouseName VARCHAR(100) NOT NULL,
	Location VARCHAR(150),
	Capacity INT -- Maximum storage capacity of the warehouse
);

-- Creating the PRODUCT table, linked to the Supplier who provides it
CREATE TABLE PRODUCT (
    ProductID INT PRIMARY KEY,
    SupplierID INT,
    ProductName VARCHAR(100) NOT NULL,
    ProductType VARCHAR(50),
    UnitPrice DECIMAL(10, 2),
    Color VARCHAR(30),
    Size VARCHAR(20),
    FOREIGN KEY (SupplierID) REFERENCES SUPPLIER(SupplierID) -- Relates Product to its Supplier
);

-- Creating the INVENTORY table to track how much of each product is in which warehouse
CREATE TABLE INVENTORY(
	InventoryID INT PRIMARY KEY,
	WarehouseID INT,
	ProductID INT,
	QuantityAvailable INT DEFAULT 0,
	LastUpdated Date,
	FOREIGN KEY (WarehouseID) REFERENCES WAREHOUSE(WarehouseID),
	FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

-- Creating the SALES_ORDER table to track customer purchases
CREATE TABLE SALES_ORDER (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderStatus VARCHAR(30),
    TotalAmount DECIMAL(12, 2),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

-- Creating the INVOICE table to manage billing for sales orders
CREATE TABLE INVOICE (
    InvoiceID INT PRIMARY KEY,
    CustomerID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(12, 2),
    Status VARCHAR(30), -- Tracks if the invoice is 'Paid' or 'Unpaid'
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

-- Creating the ORDER_DETAIL table to track individual line items within a sales order
CREATE TABLE ORDER_DETAIL (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2),
    SubTotal DECIMAL(12, 2), -- Calculated as Quantity * UnitPrice
    FOREIGN KEY (OrderID) REFERENCES SALES_ORDER(OrderID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

-- Creating the PAYMENT table to track financial transactions against invoices
CREATE TABLE PAYMENT (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    InvoiceID INT,
    PaymentDate DATE,
    Amount DECIMAL(12, 2) NOT NULL,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(30),
    FOREIGN KEY (OrderID) REFERENCES SALES_ORDER(OrderID),
    FOREIGN KEY (InvoiceID) REFERENCES INVOICE(InvoiceID)
);


-- PART 2: DATA MANIPULATION LANGUAGE (DML) - DATA POPULATION (10 Records Minimum)


-- Insert 10 records into CUSTOMER
INSERT INTO CUSTOMER (CustomerID, CustomerName, Phone, Email, Address) VALUES 
(1, 'Ruzny', '0756076855', 'ruznymoulana98@gmail.com', '103/A/5, Sippikulama,Hambantota'),
(2, 'Lanka Textiles', '0712223334', 'info@lankatex.lk', '10 Galle Road, Colombo'),
(3, 'Kandy Fashions', '0813334445', 'sales@kandyfashions.lk', '45 Dalada Vidiya, Kandy'),
(4, 'Metro Apparel', '0114445556', 'contact@metro.lk', '22 Union Place, Colombo 02'),
(5, 'Galle Garments', '0915556667', 'purchasing@gallegarments.lk', '18 Fort Road, Galle'),
(6, 'Apex Boutique', '0776667778', 'buyer@apex.com', '50 Duplication Rd, Colombo 03'),
(7, 'Island Wear', '0727778889', 'orders@islandwear.lk', '12 Beach Rd, Negombo'),
(8, 'Crest Fabrics', '0118889990', 'admin@crest.lk', '88 High Level Rd, Nugegoda'),
(9, 'Oceanic Styles', '0759990001', 'hello@oceanic.lk', '34 Marine Drive, Colombo 04'),
(10, 'Vertex Clothing', '0761112223', 'supply@vertex.com', '90 Kandy Road, Peliyagoda');

-- Insert 10 records into SUPPLIER
INSERT INTO SUPPLIER (SupplierID, SupplierName, Phone, Email, Address) VALUES 
(1, 'ELEGENT KIDS', '0721455999', 'elegentkids@gmail.com', 'Keyzer Street, Colombo'),
(2, 'Asian Cottons Ltd', '0111231234', 'sales@asiancottons.com', 'Industrial Zone, Biyagama'),
(3, 'Indian Silks Co', '0772342345', 'export@indiansilks.in', 'Chennai, India'),
(4, 'Lanka Dyes & Threads', '0113453456', 'orders@lankadyes.lk', 'Katunayake EPZ'),
(5, 'Euro Fabrics', '0714564567', 'supply@eurofabrics.eu', 'Milan, Italy'),
(6, 'Prime Yarns', '0725675678', 'contact@primeyarns.lk', 'Ratmalana Industrial Estate'),
(7, 'Global Synthetics', '0116786789', 'info@globalsyn.com', 'Free Trade Zone, Seeduwa'),
(8, 'Quality Linens', '0757897890', 'sales@qualitylinens.com', '12 Estate Rd, Horana'),
(9, 'China Weavers', '0768908901', 'export@chinaweavers.cn', 'Guangzhou, China'),
(10, 'Ceylon Textiles', '0779019012', 'admin@ceylontex.lk', 'Avissawella EPZ');

-- Insert 10 records into WAREHOUSE
INSERT INTO WAREHOUSE (WarehouseID, WarehouseName, Location, Capacity) VALUES 
(1, 'Main Hub', 'Hambantota District', 8000),
(2, 'West Wing', 'Colombo 10', 8000),
(3, 'South Depot', 'Galle', 5000),
(4, 'North Hub', 'Kurunegala', 12000),
(5, 'Central Storage', 'Kandy', 7500),
(6, 'Katunayake Transit', 'Katunayake EPZ', 15000),
(7, 'Negombo Store', 'Negombo', 4000),
(8, 'Biyagama Hub', 'Biyagama', 20000),
(9, 'Ratmalana Depot', 'Ratmalana', 6000),
(10, 'Matara Transit', 'Matara', 3500);

-- Insert 10 records into PRODUCT
INSERT INTO PRODUCT (ProductID, SupplierID, ProductName, ProductType, UnitPrice, Color, Size) VALUES 
(1, 1, 'Boys T-Shirt', 'Fabric', 850.00, 'Mixed', 'S,M,L'),
(2, 2, 'Raw Cotton Roll', 'Raw Material', 45.00, 'White', '100 Meters'),
(3, 3, 'Pure Silk', 'Fabric', 200.00, 'Gold', '50 Yards'),
(4, 4, 'Nylon Thread Batch', 'Thread', 15.00, 'Black', '500 Spools'),
(5, 5, 'Premium Linen', 'Fabric', 120.00, 'Beige', '60 Yards'),
(6, 6, 'Polyester Blend', 'Fabric', 65.00, 'Grey', '100 Meters'),
(7, 7, 'Spandex Roll', 'Fabric', 85.00, 'Black', '50 Yards'),
(8, 8, 'Cotton Bedsheet Roll', 'Fabric', 55.00, 'White', '150 Meters'),
(9, 9, 'Denim Fabric', 'Fabric', 95.00, 'Indigo', '100 Yards'),
(10, 10, 'Wool Blend', 'Fabric', 150.00, 'Charcoal', '40 Yards');

-- Insert 10 records into INVENTORY
INSERT INTO INVENTORY (InventoryID, WarehouseID, ProductID, QuantityAvailable, LastUpdated) VALUES 
(1, 1, 1, 100, '2026-09-30'),
(2, 2, 2, 500, '2026-10-01'),
(3, 3, 3, 150, '2026-10-01'),
(4, 4, 4, 1000, '2026-10-01'),
(5, 5, 5, 300, '2026-09-30'),
(6, 6, 6, 800, '2026-09-29'),
(7, 7, 7, 450, '2026-10-01'),
(8, 8, 8, 600, '2026-09-28'),
(9, 9, 9, 250, '2026-09-30'),
(10, 10, 10, 120, '2026-10-01');

-- Insert 10 records into SALES_ORDER
INSERT INTO SALES_ORDER (OrderID, CustomerID, OrderDate, OrderStatus, TotalAmount) VALUES 
(1, 1, '2026-09-10', 'Completed', 15000.00),
(2, 2, '2026-09-15', 'Completed', 4500.00),
(3, 3, '2026-09-18', 'Completed', 10000.00),
(4, 4, '2026-09-20', 'Pending', 750.00),
(5, 5, '2026-09-22', 'Completed', 3600.00),
(6, 6, '2026-09-25', 'Processing', 6500.00),
(7, 7, '2026-09-26', 'Pending', 4250.00),
(8, 8, '2026-09-28', 'Completed', 2750.00),
(9, 9, '2026-09-29', 'Processing', 4750.00),
(10, 10, '2026-09-30', 'Pending', 3000.00);

-- Insert 10 records into INVOICE
INSERT INTO INVOICE (InvoiceID, CustomerID, InvoiceDate, TotalAmount, Status) VALUES 
(1, 1, '2026-09-10', 15000.00, 'Paid'),
(2, 2, '2026-09-15', 4500.00, 'Paid'),
(3, 3, '2026-09-18', 10000.00, 'Paid'),
(4, 4, '2026-09-21', 750.00, 'Unpaid'),
(5, 5, '2026-09-22', 3600.00, 'Paid'),
(6, 6, '2026-09-25', 6500.00, 'Unpaid'),
(7, 7, '2026-09-26', 4250.00, 'Unpaid'),
(8, 8, '2026-09-28', 2750.00, 'Paid'),
(9, 9, '2026-09-30', 4750.00, 'Unpaid'),
(10, 10, '2026-09-30', 3000.00, 'Unpaid');

-- Insert 10 records into ORDER_DETAIL
INSERT INTO ORDER_DETAIL (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice, SubTotal) VALUES 
(1, 1, 1, 50, 850.00, 42500.00),
(2, 2, 2, 100, 45.00, 4500.00),
(3, 3, 3, 50, 200.00, 10000.00),
(4, 4, 4, 50, 15.00, 750.00),
(5, 5, 5, 30, 120.00, 3600.00),
(6, 6, 6, 100, 65.00, 6500.00),
(7, 7, 7, 50, 85.00, 4250.00),
(8, 8, 8, 50, 55.00, 2750.00),
(9, 9, 9, 50, 95.00, 4750.00),
(10, 10, 10, 20, 150.00, 3000.00);

-- Insert 10 records into PAYMENT
INSERT INTO PAYMENT (PaymentID, OrderID, InvoiceID, PaymentDate, Amount, PaymentMethod, PaymentStatus) VALUES 
(1, 1, 1, '2026-09-11', 15000.00, 'Bank Transfer', 'Completed'),
(2, 2, 2, '2026-09-15', 4500.00, 'Bank Transfer', 'Completed'),
(3, 3, 3, '2026-09-18', 10000.00, 'Credit Card', 'Completed'),
(4, 4, 4, NULL, 0.00, 'Pending', 'Pending'),
(5, 5, 5, '2026-09-22', 3600.00, 'Bank Transfer', 'Completed'),
(6, 6, 6, NULL, 0.00, 'Pending', 'Pending'),
(7, 7, 7, NULL, 0.00, 'Pending', 'Pending'),
(8, 8, 8, '2026-09-28', 2750.00, 'Cash', 'Completed'),
(9, 9, 9, NULL, 0.00, 'Pending', 'Pending'),
(10, 10, 10, NULL, 0.00, 'Pending', 'Pending');



-- PART 3: DATA MANIPULATION LANGUAGE (DML) - UPDATE STATEMENTS


-- Update a Customer's details using their Primary Key
UPDATE CUSTOMER 
SET CustomerName = 'Urban Threads', 
    Phone = '0771234567', 
    Email = 'contact@urbanthreads.com', 
    Address = '789 Apparel Boulevard'
WHERE CustomerID = 1;

-- Update a Supplier's details using their Primary Key
UPDATE SUPPLIER 
SET SupplierName = 'Global Cotton Co.', 
    Phone = '0719876543', 
    Email = 'supply@globalcotton.com', 
    Address = '101 Industrial Estate'
WHERE SupplierID = 1;

-- Update a Warehouse location using its Primary Key
UPDATE WAREHOUSE 
SET WarehouseName = 'East Coast Storage', 
    Location = 'Port City Area', 
    Capacity = 10000
WHERE WarehouseID = 1;

-- Modify Product details without altering Foreign Keys
UPDATE PRODUCT 
SET ProductName = 'Organic Cotton Weave', 
    ProductType = 'Raw Material', 
    UnitPrice = 75.50, 
    Color = 'Navy Blue', 
    Size = '100 Meters'
WHERE ProductID = 1;

-- Update Inventory quantity after a stock change
UPDATE INVENTORY 
SET QuantityAvailable = 250, 
    LastUpdated = '2026-10-01'
WHERE InventoryID = 1;



-- PART 4: DATA QUERY LANGUAGE (DQL) - FIVE BASIC SELECT QUERIES


-- 1. Retrieve all contact information for registered customers
SELECT CustomerName, Phone, Email, Address 
FROM CUSTOMER;

-- 2. Filter products to show only items classified specifically as 'Fabric'
SELECT ProductName, UnitPrice, Color, Size 
FROM PRODUCT 
WHERE ProductType = 'Fabric';

-- 3. Identify sales orders that are currently marked as 'Pending' to follow up
SELECT OrderID, CustomerID, OrderDate, TotalAmount 
FROM SALES_ORDER 
WHERE OrderStatus = 'Pending';

-- 4. Display the total storage capacity across all active warehouse,Largest first.
SELECT WarehouseName, Location, Capacity 
FROM WAREHOUSE
ORDER BY Capacity DESC;

-- 5. List all unpaid invoices so the finance team can track pending payments
SELECT InvoiceID, CustomerID, InvoiceDate, TotalAmount 
FROM INVOICE 
WHERE Status = 'Unpaid';



-- PART 5: DATA QUERY LANGUAGE (DQL) - FIVE ADVANCED QUERIES (GROUP BY / HAVING)


-- 1. Identify high-value customers who have ordered more than 4000 in total value
SELECT CustomerID, SUM(TotalAmount) AS TotalOrdered 
FROM SALES_ORDER 
GROUP BY CustomerID 
HAVING SUM(TotalAmount) > 4000 
ORDER BY TotalOrdered DESC;

-- 2. Find product categories where the average unit price exceeds 50
SELECT ProductType, AVG(UnitPrice) AS AveragePrice 
FROM PRODUCT 
GROUP BY ProductType 
HAVING AVG(UnitPrice) > 50 
ORDER BY AveragePrice DESC;

-- 3. Identify large-capacity warehouses currently storing more than 400 items
SELECT WarehouseID, SUM(QuantityAvailable) AS TotalItemsStored 
FROM INVENTORY 
GROUP BY WarehouseID 
HAVING SUM(QuantityAvailable) > 400 
ORDER BY TotalItemsStored DESC;

-- 4. Calculate total quantity sold per product, only showing top-selling items (over 40 units)
SELECT ProductID, SUM(Quantity) AS TotalUnitsSold
FROM ORDER_DETAIL
GROUP BY ProductID
HAVING SUM(Quantity) > 40
ORDER BY TotalUnitsSold DESC;

-- 5. Count how many invoices exist per status, filtering for statuses with at least 3 occurrences
SELECT Status, COUNT(InvoiceID) AS NumberOfInvoices
FROM INVOICE
GROUP BY Status
HAVING COUNT(InvoiceID) >= 3
ORDER BY NumberOfInvoices DESC;



-- PART 6: DATA QUERY LANGUAGE (DQL) - THREE MULTI-TABLE JOIN QUERIES


-- 1. Inventory Location Report: Joins INVENTORY, WAREHOUSE, and PRODUCT 
-- To display which specific products are stored in which warehouse locations
SELECT w.WarehouseName, p.ProductName, p.Color, i.QuantityAvailable
FROM INVENTORY i
JOIN WAREHOUSE w ON i.WarehouseID = w.WarehouseID
JOIN PRODUCT p ON i.ProductID = p.ProductID;

-- 2. Customer Order Report: Joins CUSTOMER and SALES_ORDER 
-- To show the names of customers alongside the specific dates and statuses of their orders
SELECT c.CustomerName, s.OrderID, s.OrderDate, s.OrderStatus, s.TotalAmount
FROM CUSTOMER c
JOIN SALES_ORDER s ON c.CustomerID = s.CustomerID;

-- 3. Detailed Sales Itemization: Joins ORDER_DETAIL and PRODUCT 
-- To show a breakdown of individual items sold, including product names and subtotal calculations
SELECT od.OrderID, p.ProductName, p.UnitPrice, od.Quantity, od.SubTotal
FROM ORDER_DETAIL od
JOIN PRODUCT p ON od.ProductID = p.ProductID;



-- PART 7: DATA CONTROL LANGUAGE (DCL) - SECURITY, USERS & PERMISSIONS


-- 1. Create Logins for Server-level access
CREATE LOGIN TextileManager WITH PASSWORD = 'Manager123!';
CREATE LOGIN TextileClerk WITH PASSWORD = 'Clerk123!';

-- 2. Map Logins to Database Users within ColourSelectionDB
CREATE USER ManagerUser FOR LOGIN TextileManager;
CREATE USER ClerkUser FOR LOGIN TextileClerk;

-- 3. Grant Administrative Permissions for Manager (High-Level Access)
-- Managers receive full CRUD (Create, Read, Update, Delete) rights across all tables.
GRANT SELECT, INSERT, UPDATE, DELETE ON CUSTOMER TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON SUPPLIER TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRODUCT TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON WAREHOUSE TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON INVENTORY TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON SALES_ORDER TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON INVOICE TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON ORDER_DETAIL TO ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON PAYMENT TO ManagerUser;

-- 4. Grant Restricted Operational Permissions for Clerk
-- Clerks can view general static data but cannot modify foundational tables (Products, Warehouses, Suppliers).
GRANT SELECT ON PRODUCT TO ClerkUser;
GRANT SELECT ON WAREHOUSE TO ClerkUser;
GRANT SELECT ON SUPPLIER TO ClerkUser;

-- Clerks process daily transactions, so they are granted Insert and Update rights on operational tables.
GRANT SELECT, INSERT, UPDATE ON CUSTOMER TO ClerkUser;
GRANT SELECT, INSERT, UPDATE ON SALES_ORDER TO ClerkUser;
GRANT SELECT, INSERT, UPDATE ON ORDER_DETAIL TO ClerkUser;
GRANT SELECT, INSERT, UPDATE ON INVOICE TO ClerkUser;
GRANT SELECT, INSERT, UPDATE ON PAYMENT TO ClerkUser;
GRANT SELECT, UPDATE ON INVENTORY TO ClerkUser;

-- 5. Explicitly DENY Permissions (Security Best Practice)
-- Ensure Clerks cannot accidentally or maliciously delete financial/business records.
DENY DELETE ON CUSTOMER TO ClerkUser;
DENY DELETE ON SALES_ORDER TO ClerkUser;
DENY DELETE ON INVOICE TO ClerkUser;
DENY DELETE ON PAYMENT TO ClerkUser;

--A verification query confirms the number of records in each table 
SELECT 'CUSTOMER' AS TableName, COUNT(*) AS Records FROM CUSTOMER UNION ALL
SELECT 'SUPPLIER', COUNT(*) FROM SUPPLIER UNION ALL
SELECT 'WAREHOUSE', COUNT(*) FROM WAREHOUSE UNION ALL
SELECT 'PRODUCT', COUNT(*) FROM PRODUCT UNION ALL
SELECT 'INVENTORY', COUNT(*) FROM INVENTORY UNION ALL
SELECT 'SALES_ORDER', COUNT(*) FROM SALES_ORDER UNION ALL
SELECT 'INVOICE', COUNT(*) FROM INVOICE UNION ALL
SELECT 'ORDER_DETAIL', COUNT(*) FROM ORDER_DETAIL UNION ALL
SELECT 'PAYMENT', COUNT(*) FROM PAYMENT;
