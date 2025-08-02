SELECT *
FROM dbo.products -- Table containing product data

-- ***********************
-- ***********************

-- Query to categorize products based on price
SELECT
	ProductID, -- Selects the unique identifier for each product
	ProductName, -- Selects te name of each product
	Price, -- Selects the price of each product
	-- Category (Not necessary for our analysis, since all products reside in the 'Sports' category

	CASE -- Function that allows us to categorize products, namely price in this context: Low, Medium, or High
		WHEN Price < 50 THEN 'Low' -- If the price is less than 50, categorize the price of the product as 'Low'
		WHEN Price BETWEEN 50 AND 200 THEN 'Medium' -- If the price is between 50 and 200 (inclusive), categorize the price of the product as 'Medium'
		ELSE 'High' -- If the price is greater than 200, categorize the price of the product as 'High'
	END AS PriceCategory -- ends the CASE function, names the new column as PriceCategory

FROM 
	dbo.products; 

