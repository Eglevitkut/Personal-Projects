WITH EventCounts AS (
SELECT
ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS Event_Order,
Event_Name,
COUNTIF(country = 'United States') AS US_Events,
COUNTIF(country = 'India') AS India_Events,
COUNTIF(country = 'Canada') AS Canada_Events
FROM
`turing_data_analytics.raw_events`
WHERE
event_name IN ('page_view', 'scroll', 'add_to_cart', 'add_payment_info', 'purchase')
GROUP BY
event_name 
)

SELECT
Event_Order,
Event_Name,
US_Events,
India_Events,
Canada_Events,
CONCAT(ROUND((US_Events + India_Events + Canada_Events) / SUM(US_Events + India_Events + Canada_Events) OVER () * 100, 2), '%') AS Full_Percentage,
CONCAT(ROUND(US_Events / SUM(US_Events) OVER () * 100, 2), '%') AS US_Perc_Drop,
CONCAT(ROUND(India_Events / SUM(India_Events) OVER () * 100, 2), '%') AS India_Perc_Drop,
CONCAT(ROUND(Canada_Events / SUM(Canada_Events) OVER () * 100, 2), '%') AS Canada_Perc_Drop
FROM
EventCounts
ORDER BY
event_order;