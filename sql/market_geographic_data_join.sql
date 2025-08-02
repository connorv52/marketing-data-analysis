SELECT * 
FROM dbo.customers -- Table containing customer data


SELECT *
FROM dbo.geography -- Table containing geographic data; GeographyID links to GeographyID in the customers table, allowing us to relate the tables


-- ***********************
-- ***********************

-- Query that will join the customers and geography tables to enrich customer data with geographic information
SELECT
	c.CustomerID,
	c.CustomerName,
	c.Email,
	c.Gender,
	c.Age,
	g.Country,
	g.City -- both country and city are from geography table; to be joined on the customers table
FROM
	dbo.customers as c -- Specifies customers table with an alias 'c'
LEFT JOIN
-- RIGHT JOIN
-- INNER JOIN
-- FULL OUTER JOIN
	dbo.geography as g -- Specifies geography table with an alias 'g'
ON
	c.GeographyID = g.GeographyID; -- Joins the two tables on the GeographyID field to match customers with their geographic information