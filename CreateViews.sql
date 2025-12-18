-- Creating view for Analytical DB/ star schema for PowerBI
-- fact table

CREATE VIEW v_FactSalesGlobal AS
SELECT 
    s.sales_ID,
    s.productkey,
    s.customerkey,
    s.territorykey,
    s.orderdate,
    s.orderquantity,
    p.productname
    s.orderquantity * p.productprice AS revenue,
    CASE WHEN h.date IS NOT NULL THEN TRUE ELSE FALSE END AS is_holiday,
    h.name AS holiday_name,
    h.country_code,
    p.productsubcategorykey,
    sc.productcategorykey
FROM Sales s
JOIN Products p ON s.productkey = p.productkey
JOIN Product_Subcategories sc ON p.productsubcategorykey = sc.productsubcategorykey
JOIN Territories t ON s.territorykey = t.salesterritorykey
LEFT JOIN Holidays_Global h 
    ON DATE(s.orderdate) = h.date
    AND t.country = CASE 
                      WHEN h.country_code = 'AU' THEN 'Australia'
                      WHEN h.country_code = 'US' THEN 'United States'
                      WHEN h.country_code = 'DE' THEN 'Germany'
                      WHEN h.country_code = 'FR' THEN 'France'
                      WHEN h.country_code = 'CA' THEN 'Canada'
                      WHEN h.country_code = 'GB' THEN 'United Kingdom'
                    END;

-- dim table for product category

CREATE VIEW v_DimProductCategory AS
SELECT 
    productcategorykey,
    categoryname
FROM Product_Categories;

-- dim table for product subcategory
CREATE VIEW v_DimProductSubcategory AS
SELECT 
    productsubcategorykey,
    subcategoryname,
    productcategorykey
FROM Product_Subcategories;

-- dim table for country
CREATE VIEW v_DimCountry AS
SELECT DISTINCT
    t.salesterritorykey AS territorykey,
    t.country,
    t.region,
    t.continent,
    CASE 
        WHEN t.country = 'Australia' THEN 'AU'
        WHEN t.country = 'United States' THEN 'US'
        WHEN t.country = 'Germany' THEN 'DE'
        WHEN t.country = 'France' THEN 'FR'
        WHEN t.country = 'Canada' THEN 'CA'
        WHEN t.country = 'United Kingdom' THEN 'GB'
        ELSE NULL
    END AS country_code
FROM Territories t
JOIN Sales s ON s.territorykey = t.salesterritorykey;
 
