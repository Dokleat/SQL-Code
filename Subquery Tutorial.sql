-- Subquery in a SELECT clause: Calculates the total number of orders for each customer
SELECT 
    FirstName, 
    LastName, 
    (SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.ID) AS TotalOrders
FROM 
    Customers;

-- Subquery in a FROM clause: Uses a subquery as a derived table to aggregate data before selecting
SELECT 
    CustomerData.FirstName, 
    CustomerData.LastName, 
    CustomerData.TotalOrders
FROM 
    (SELECT 
         Customers.ID, 
         Customers.FirstName, 
         Customers.LastName, 
         COUNT(Orders.ID) AS TotalOrders
     FROM 
         Customers
     JOIN 
         Orders ON Customers.ID = Orders.CustomerID
     GROUP BY 
         Customers.ID) AS CustomerData;

-- Subquery in a WHERE clause: Selects all products with a price above the average price
SELECT 
    *
FROM 
    Products
WHERE 
    Price > (SELECT AVG(Price) FROM Products);

-- Using PARTITION BY in window functions: Ranks sales employees within their respective departments based on sales
-- Note: This example assumes the existence of a hypothetical SalesEmployees table
SELECT 
    FirstName, 
    LastName, 
    Sales, 
    RANK() OVER (PARTITION BY Department ORDER BY Sales DESC) AS RankInDepartment
FROM 
    SalesEmployees;
