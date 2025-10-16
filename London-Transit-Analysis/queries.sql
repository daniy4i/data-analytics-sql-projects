-- Project: London Transit (TfL RODS) Analysis
-- Author: Daniyal Tariq Butt
-- Dataset: tfl.rods
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT SUM(daily_journeys) AS total_journeys FROM tfl.rods;

-- Query 2
SELECT entry_zone, SUM(daily_journeys) AS journeys_from_zone
FROM tfl.rods
GROUP BY entry_zone
ORDER BY entry_zone;

-- Query 3
SELECT time_period, SUM(daily_journeys) AS journeys_in_period
FROM tfl.rods
GROUP BY time_period
ORDER BY journeys_in_period DESC;

-- Query 4
SELECT origin_purpose, SUM(daily_journeys) AS journeys
FROM tfl.rods
GROUP BY origin_purpose
ORDER BY journeys DESC;

-- Query 5
SELECT origin_purpose, destination_purpose, SUM(daily_journeys) AS journeys
FROM tfl.rods
GROUP BY origin_purpose, destination_purpose
ORDER BY journeys DESC;

-- Query 6
SELECT origin_purpose, time_period, SUM(daily_journeys) AS journeys
FROM tfl.rods
GROUP BY origin_purpose, time_period
ORDER BY origin_purpose, journeys DESC;

-- Query 7
SELECT entry_zone, origin_purpose, SUM(daily_journeys) AS journeys
FROM tfl.rods
GROUP BY entry_zone, origin_purpose
ORDER BY entry_zone, journeys DESC;

-- Query 8
SELECT origin_purpose, destination_purpose, time_period, SUM(daily_journeys) AS journeys
FROM tfl.rods
WHERE origin_purpose = 'Tourist' OR destination_purpose = 'Tourist'
GROUP BY origin_purpose, destination_purpose, time_period
ORDER BY journeys DESC;

