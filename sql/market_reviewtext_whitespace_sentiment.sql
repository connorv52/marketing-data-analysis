SELECT *
FROM dbo.customer_reviews -- Table containing reviews given by customers on their purchased products

-- Easily noticed that the ReviewText column contains double spacing; can be fixed with the REPLACE function
-- ***********************
-- ***********************

-- Query to clean whitespace issues in the ReviewText column
SELECT
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	REPLACE(ReviewText, '  ', ' ') AS ReviewText -- Cleans the ReviewText column by replacing double spaces with single spaces, thus standardizing the column
FROM
	dbo.customer_reviews;
	
-- Will perform sentiment analysis on the ReviewText column with Python packages