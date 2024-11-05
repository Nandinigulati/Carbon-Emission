SELECT * 
FROM Carbon_Emission


-- Checking for null values

SELECT * 
FROM Carbon_Emission
WHERE CO2_emission_estimates IS NULL
   OR Year IS NULL
   OR Series IS NULL
   OR Value IS NULL;


SELECT DISTINCT Series
FROM Carbon_Emission

SELECT MIN(Year), MAX(Year)
FROM Carbon_Emission

SELECT MIN(Value), MAX(Value)
FROM Carbon_Emission
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)'

SELECT MIN(Value), MAX(Value)
FROM Carbon_Emission
WHERE Series = 'Emissions per capita (metric tons of carbon dioxide)'


CREATE TABLE emissions
(Country nvarchar(50),
Year int, 
Series nvarchar(100), 
Value float)


INSERT INTO emissions
SELECT * FROM Carbon_Emission
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)'

SELECT * 
FROM emissions


CREATE TABLE perCapital
(Country nvarchar(50),
Year int, 
Series nvarchar(100), 
Value float)


INSERT INTO perCapital
SELECT * FROM Carbon_Emission
WHERE Series = 'Emissions per capita (metric tons of carbon dioxide)'


SELECT * 
FROM perCapital

 

-- Carbon Emissions per capital in India

SELECT MIN(Value) as min_value, MAX(Value) as Max_value 
FROM perCapital
WHERE Country = 'India'
--- The min value is 0.3 and the max value is 1.614

SELECT Year
FROM perCapital
WHERE Country = 'India'
AND Value IN (1.614, 0.3)
--- the year for the min value is 1975 and the year for the max value is 2017. 


;WITH value1975 AS 
(SELECT Country, Value as old_value
FROM perCapital
WHERE Year = 1975), 
value2017 AS 
(SELECT Country, Value as new_value 
FROM perCapital
WHERE Year = 2017)

SELECT DISTINCT perCapital.Country, ROUND((value2017.new_value - value1975.old_value)/value1975.old_value,2) AS changes 
FROM 
value1975
INNER JOIN value2017 ON value1975.Country = value2017.Country --ensures only countries present in both year are in the data
INNER JOIN perCapital ON value1975.Country = perCapital.Country
ORDER BY changes DESC
 
---- Oman is the country that has the highest rate of increasing 16.25. 
--- Dem. People's Rep. Korea has the lowest rate of decreasing  -0.84



SELECT * 
FROM emissions


SELECT * 
FROM emissions
WHERE Country = 'United States of America'

SELECT MAX(Value), Min(Value)
FROM emissions
WHERE Country = 'United States of America'

SELECT * 
FROM emissions
WHERE Value = 5703220.175 -- 2005 
OR Value = 4355839.181 -- 1975


SELECT TOP 5 Country, Sum(Value) as sum_value
FROM emissions
GROUP BY Country
ORDER BY sum_value DESC --China, USA, India, Russia, and Japan. 








