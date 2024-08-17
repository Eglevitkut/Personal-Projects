WITH CampaignData AS (
SELECT
Adsense_Monthly.Month,
Adsense_Monthly.Campaign,
Adsense_Monthly.Impressions,
Adsense_Monthly.Clicks,
Adsense_Monthly.Cost,
COUNT(DISTINCT Raw_Events.user_pseudo_id) AS UniqueUsers
FROM
turing_data_analytics.adsense_monthly Adsense_Monthly
LEFT JOIN
turing_data_analytics.raw_events Raw_Events ON Adsense_Monthly.Campaign = Raw_Events.Campaign
AND Raw_Events.Event_Name = 'page_view'
WHERE
Adsense_Monthly.Campaign IN ('NewYear_V1', 'NewYear_V2', 'BlackFriday_V1', 'BlackFriday_V2')
AND Adsense_Monthly.Clicks IS NOT NULL
AND NOT (Adsense_Monthly.Campaign = 'BlackFriday_V1' AND Adsense_Monthly.Month = 202111)
GROUP BY
Adsense_Monthly.Month, Adsense_Monthly.Campaign, Adsense_Monthly.Impressions, Adsense_Monthly.Clicks, Adsense_Monthly.Cost
)

SELECT
Month,
Campaign,
Impressions,
UniqueUsers AS Clicks, 
ROUND(Cost, 2) AS Cost
FROM
CampaignData
ORDER BY
Month, Campaign;