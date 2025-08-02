SELECT *
FROM dbo.customer_journey -- This table describes what each customer did on the firm's retail site and how long they remained on there

-- This table also has some issues with standardization, namely the many NULL values and possible duplicates
-- ***********************
-- ***********************

-- Query that utilizes a Common Table Expression (CTE) to identify and tag duplicate records
WITH DuplicateRecords AS (
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,

		ROW_Number() OVER(
			PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action -- PARTITION BY groups the rows based on the specified columns (which should be unique observations)
			ORDER BY JourneyID -- ORDER BY lets us order the rows within each partition (helps to use a unique identifer like JourneyID)
		) AS row_num -- This creates a new column 'row_num' that numbers each row within its partition
	FROM
		dbo.customer_journey

) -- Ends the CTE; the CTE above makes it so that each observation with the same CustomerID, ProductID, VisitDate, Stage, and Action are flagged as duplicates

-- Query that selects all recorsd from the CTE where row_num > 1, which should indicate a duplicate observation
SELECT *
FROM DuplicateRecords
WHERE row_num > 1 -- Filters out the first occurrence (row_num = 1, meaning not a duplicate) and only shows the duplicates (row_num > 1)
ORDER BY JourneyID;

-- Outer query that selects the final cleaned and standardized data (no duplicates)
SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, avg_duration) AS Duration -- Replaces missing durations (NULLS) with the average duration for the corresponding date
FROM
	( -- Subquery that further processes and cleans the data
		SELECT
			JourneyID,
			CustomerID,
			ProductID,
			VisitDate,
			UPPER(Stage) AS Stage, -- Since we've recognized that some observations in the 'stage' column are lowercase
			Action,
			Duration,
			AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration, -- Computes the average duration for each date, using the VisitDate column
			ROW_NUMBER() OVER (
				PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action -- Groups these columns to identify duplicates
				ORDER BY JourneyID -- Order by JourneyID to keep the first instance of each duplicate
			) AS row_num -- Assigns a row number to each row within the partition to identify duplicates
		FROM
			dbo.customer_journey
		) AS subquery -- names the subquery for reference in the outer query
	WHERE
		row_num = 1 -- Keeps only the first instance of each duplicate group identified in the subquery