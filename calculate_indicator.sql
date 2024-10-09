CREATE TEMP TABLE creation AS
SELECT 
    lead_id,
    created_at AS creation_date
FROM 
    lead

CREATE TEMP TABLE approval AS
SELECT 
    lead_id,
    created_at AS approved_date
FROM 
    event
WHERE 
	event_type = 'doc.subscriptionContract.approved'

CREATE TABLE app_indicators AS
SELECT 
    creation.lead_id,
    creation.creation_date,
    approval.approved_date,
	EXTRACT( DAY FROM approval.approved_date - creation.creation_date) AS approval_time
FROM 
    creation
LEFT JOIN 
    approval
ON 
   	creation.lead_id = approval.lead_id;

CREATE TABLE app_year AS
SELECT
	EXTRACT(YEAR FROM creation_date) AS years,
	COUNT(creation_date) AS creation,
	COUNT(approved_date) AS approved,
	ROUND(COUNT(approved_date) *100 / COUNT(creation_date),1) AS APP
FROM
	app_indicators
GROUP BY 
	years
ORDER BY
	years;

SELECT
	TO_CHAR(COUNT(approved_date) *100 / COUNT(creation_date), 'FM999999.00') AS APP
FROM
	app_indicators;


CREATE TABLE app_time AS
SELECT
	EXTRACT(YEAR FROM creation_date) AS years,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY approval_time) AS median,
	PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY approval_time) AS Q95
FROM
	app_indicators
WHERE approval_time > 0
GROUP BY 
	years
ORDER BY
	years;

SELECT 
	*	
FROM app_time;

SELECT
	*
FROM
	app_year;

DROP TABLE app_indicators;
