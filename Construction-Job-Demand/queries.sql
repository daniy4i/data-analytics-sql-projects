-- Project: Construction Job Demand (Weather-Driven Demand Signal)
-- Author: Daniyal Tariq Butt
-- Datasets: hover.jobs, hover.weather, weekly_weather_events
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT DATE_TRUNC('month', job_first_upload_complete_datetime) AS month, COUNT(*) AS total_jobs
FROM hover.jobs
GROUP BY DATE_TRUNC('month', job_first_upload_complete_datetime)
ORDER BY month;

-- Query 2
SELECT DATE_PART('month', job_first_upload_complete_datetime) AS month,
       COUNT(DISTINCT DATE_TRUNC('month', job_first_upload_complete_datetime)) AS month_count
FROM hover.jobs
GROUP BY DATE_PART('month', job_first_upload_complete_datetime)
ORDER BY month;

-- Query 3
SELECT DATE_TRUNC('month', datetime) AS month, COUNT(*) AS total_weather_events
FROM hover.weather
GROUP BY DATE_TRUNC('month', datetime)
ORDER BY month;

-- Query 4
SELECT DATE_TRUNC('month', datetime) AS month, COUNT(*) AS total_weather_events
FROM hover.weather
WHERE datetime >= '2016-09-01'
GROUP BY DATE_TRUNC('month', datetime)
ORDER BY month;

-- Query 5
SELECT DATE_TRUNC('month', datetime) AS month, COUNT(*) AS num_weather_events
FROM hover.weather
WHERE datetime >= '2016-09-01'
  AND state IN (SELECT DISTINCT job_location_region_code FROM hover.jobs)
GROUP BY DATE_TRUNC('month', datetime)
ORDER BY month;

-- Query 6
SELECT j.job_deliverable, j.job_location_region_code,
       DATE_TRUNC('week', j.job_first_upload_complete_datetime) AS job_ts,
       w.n_weather_events
FROM hover.jobs j
INNER JOIN weekly_weather_events w
  ON DATE_TRUNC('week', j.job_first_upload_complete_datetime) = w.weather_ts
 AND j.job_location_region_code = w.state;

-- Query 7
WITH joined AS (
  SELECT j.job_location_region_code,
         DATE_TRUNC('week', j.job_first_upload_complete_datetime) AS job_ts,
         w.n_weather_events
  FROM hover.jobs j
  INNER JOIN weekly_weather_events w
    ON DATE_TRUNC('week', j.job_first_upload_complete_datetime) = w.weather_ts
   AND j.job_location_region_code = w.state
)
SELECT job_location_region_code AS state, job_ts,
       COUNT(*) AS total_jobs,
       SUM(n_weather_events) AS total_weather_events
FROM joined
GROUP BY state, job_ts
ORDER BY state, job_ts;

