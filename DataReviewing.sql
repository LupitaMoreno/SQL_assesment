SELECT
	EXTRACT(YEAR FROM created_at) AS years,
	COUNT(lead_id) AS lead_total
FROM
	lead 
GROUP BY 
	years
ORDER BY
	years;

SELECT
	EXTRACT(YEAR FROM created_at) AS years,
	COUNT(lead_id) AS lead_total
FROM
	event
WHERE 
	event_type = 'doc.subscriptionContract.approved'
GROUP BY 
	years
ORDER BY
	years;

SELECT
	lead_id, 
	ARRAY_AGG(created_at ORDER BY created_at) AS date_event
FROM 
	event
WHERE event_type IN ('lead.created','doc.subscriptionContract.approved')
GROUP BY 
	lead_id;


SELECT * 
FROM attribute
LIMIT 10;

SELECT * 
FROM event
WHERE event_type = 'lead.created'
LIMIT 10;

SELECT DISTINCT event_type
FROM event;

SELECT COUNT(DISTINCT lead_id)
FROM lead;

--Creating a table to know the maximun and minimus date
SELECT 
	'lead' AS tabla,
	MIN(created_at) AS minimum, 
	MAX(created_at) AS maximum,
	count(lead_id) AS leads
FROM 
	lead
UNION ALL
SELECT
	'event' AS tabla,
	MIN(created_at) AS minimum, 
	MAX(created_at) AS maximum,
	count(lead_id) AS leads
FROM
	event
WHERE
	event_type = 'lead.created';

-- Reviewing the tables and special cases
SELECT * 
FROM attribute
LIMIT 10;

SELECT *
FROM event
WHERE lead_id = '4034644098856872731';

SELECT * 
FROM attribute
WHERE lead_id = '4034644098856872731';

SELECT DISTINCT name 
FROM attribute;
