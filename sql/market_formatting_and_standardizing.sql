SELECT *
FROM dbo.engagement_data -- Table containing engagement data (likes) on the marketing content types (e.g., Blog or Video)

-- Quick glance at the table shows some obvious formatting issues (e.g., zeros, casing, spacing)
-- ***********************
-- ***********************

SELECT
	EngagementID,
	ContentID,
	CampaignID,
	ProductID, -- Selecting the various IDs first
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType, -- Replaces 'Socialmedia' with 'SocialMedia' and capitalizes all other content types
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views, -- Left part of the ViewsClicksCombined column is the total Views
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks, -- Right part of the ViewsClicksCombined column is the total Clicks
	Likes,
	FORMAT(CONVERT(DATE, EngagementDate), 'MM/dd/yyyy') AS EngagementDate -- Converts and formats the date as mm.dd.yyyy
FROM

	dbo.engagement_data;
