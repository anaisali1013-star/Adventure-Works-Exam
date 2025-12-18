# Adventure-Works-Exam
-- TABLE 1: product_categories ( AdventureWorks_Product_Categories.csv)
CREATE TABLE product_categories (
    ProductCategoryKey INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- TABLE 2: product_subcategories ( AdventureWorks_Product_Subcategories.csv)
CREATE TABLE product_subcategories (
    ProductSubcategoryKey INT PRIMARY KEY,
    SubcategoryName VARCHAR(100),
    ProductCategoryKey INT -- Nessuna FK definita
);

-- TABLE 3: products ( AdventureWorks_Products.csv)
CREATE TABLE products (
    ProductKey INT PRIMARY KEY,
    ProductSubcategoryKey INT,
    ProductSKU VARCHAR(25),
    ProductName VARCHAR(100),
    ModelName VARCHAR(100),
    ProductDescription TEXT,
    ProductColor VARCHAR(15),
    ProductSize VARCHAR(15),
    ProductStyle CHAR(1),
    ProductCost NUMERIC(10, 2),
    ProductPrice NUMERIC(10, 2)
);

-- TABLE 4: territories ( AdventureWorks_Territories.csv)
CREATE TABLE territories (
    SalesTerritoryKey INT PRIMARY KEY,
    Region VARCHAR(50),
    Country VARCHAR(50),
    Continent VARCHAR(50)
);

-- TABLE 5: customers ( AdventureWorks_Customers.csv )
CREATE TABLE customers (
  CustomerKey INT PRIMARY KEY,
  Title VARCHAR(10),
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  BirthDate DATE,
  Gender VARCHAR(10),          
  MaritalStatus VARCHAR(10),  
  EmailAddress VARCHAR(100),
  AnnualIncome NUMERIC(12,2),
  TotalChildren INT,
  Education VARCHAR(100),
  Occupation VARCHAR(100),
  HomeOwnerFlag BOOLEAN
);
-- TABLE 6: returns ( AdventureWorks_Returns.csv)
CREATE TABLE returns (
    ReturnDate DATE,
    TerritoryKey INT, 
    ProductKey INT,
    ReturnQuantity INT
);

-- TABLE 7: sales ( AdventureWorks_Sales_2015.csv & 2016,2017)
CREATE TABLE sales
    OrderDate DATE,
    StockDate DATE,
    OrderNumber VARCHAR(20),
    ProductKey INT, 
    CustomerKey INT, 
    TerritoryKey INT, 
    OrderLineItem INT,
    OrderQuantity INT
);


--- adding primary keys to sales and returns:

ALTER TABLE sales ADD COLUMN sales_id SERIAL PRIMARY KEY;
ALTER TABLE returns ADD COLUMN returns_id SERIAL PRIMARY KEY;

-- creating Foreign Keys- connecting tables
-- 1) Subcategory → Category
ALTER TABLE product_subcategories
ADD CONSTRAINT fk_subcategory_category
FOREIGN KEY (productcategorykey)
REFERENCES product_categories(productcategorykey);

-- 2) Product → Subcategory
ALTER TABLE products
ADD CONSTRAINT fk_product_subcategories
FOREIGN KEY (productsubcategorykey)
REFERENCES product_subcategories(productsubcategorykey);

-- 3) Sales → Product
ALTER TABLE sales
ADD CONSTRAINT fk_sales_product
FOREIGN KEY (productkey)
REFERENCES products(productkey);

-- 4) Sales → Customer
ALTER TABLE sales
ADD CONSTRAINT fk_sales_customer
FOREIGN KEY (customerkey)
REFERENCES customer(customerkey);

-- 5) Sales → Territory
ALTER TABLE sales
ADD CONSTRAINT fk_sales_territory
FOREIGN KEY (territorykey)
REFERENCES territories(salesterritorykey);

-- 6) Returns → Territory
ALTER TABLE returns
ADD CONSTRAINT fk_returns_territory
FOREIGN KEY (territorykey)
REFERENCES territories(salesterritorykey);

-- 7) Returns → Product
ALTER TABLE returns
ADD CONSTRAINT fk_returns_product
FOREIGN KEY (productkey)
REFERENCES products(productkey);

