-- Project: Sustainability Impact Analysis for Intel
-- Author: Daniyal Tariq Butt
-- Purpose: Evaluate 2024 repurposing impact by device age, type, and region.
-- Datasets: intel.device_data, intel.impact_data
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT d.*, i.*
FROM intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON i.device_id = d.device_id;

-- Query 2
SELECT d.*, i.*, (2024 - d.model_year) AS device_age
FROM intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON i.device_id = d.device_id;

-- Query 3
SELECT
  d.*, i.*,
  (2024 - d.model_year) AS device_age,
  CASE
    WHEN 2024 - d.model_year <= 3 THEN 'newer'
    WHEN 2024 - d.model_year <= 6 THEN 'mid-age'
    ELSE 'older'
  END AS device_age_bucket
FROM intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON i.device_id = d.device_id;

-- Query 4
WITH joined AS (
  SELECT d.model_year, i.energy_savings_yr, i.co2_saved_kg_yr
  FROM intel.device_data d
  JOIN intel.impact_data i ON i.device_id = d.device_id
)
SELECT
  COUNT(*)                                   AS total_devices,
  AVG(2024 - model_year)::NUMERIC            AS avg_device_age_years,
  AVG(energy_savings_yr)::NUMERIC            AS avg_kwh_saved_per_device_per_year,
  (SUM(co2_saved_kg_yr) / 1000.0)::NUMERIC   AS total_co2_saved_tons_per_year
FROM joined;

-- Query 5
WITH joined AS (
  SELECT d.device_type, i.energy_savings_yr, i.co2_saved_kg_yr
  FROM intel.device_data d
  JOIN intel.impact_data i ON i.device_id = d.device_id
)
SELECT
  device_type,
  COUNT(*) AS devices,
  AVG(energy_savings_yr)::NUMERIC AS avg_kwh_saved,
  (AVG(co2_saved_kg_yr) / 1000.0)::NUMERIC AS avg_co2_saved_tons
FROM joined
GROUP BY device_type
ORDER BY device_type;

-- Query 6
WITH joined AS (
  SELECT i.region, d.device_type, i.energy_savings_yr, i.co2_saved_kg_yr
  FROM intel.device_data d
  JOIN intel.impact_data i ON i.device_id = d.device_id
),
agg AS (
  SELECT region, device_type,
         COUNT(*) AS devices,
         SUM(energy_savings_yr) AS total_kwh_saved,
         SUM(co2_saved_kg_yr) / 1000.0 AS total_co2_tons
  FROM joined
  GROUP BY region, device_type
),
with_totals AS (
  SELECT region, device_type, devices, total_kwh_saved, total_co2_tons,
         SUM(total_kwh_saved) OVER (PARTITION BY region) AS region_kwh_total,
         SUM(total_co2_tons)  OVER (PARTITION BY region) AS region_co2_total
  FROM agg
)
SELECT region, device_type, devices, total_kwh_saved, total_co2_tons,
       ROUND(100.0 * total_kwh_saved / NULLIF(region_kwh_total, 0), 2) AS pct_region_kwh,
       ROUND(100.0 * total_co2_tons / NULLIF(region_co2_total, 0), 2)  AS pct_region_co2
FROM with_totals
ORDER BY region, device_type;

-- Query 7
SELECT i.region,
        COUNT(*) AS devices,
        AVG(i.energy_savings_yr)        AS avg_kwh_saved,
        AVG(i.co2_saved_kg_yr) / 1000.0 AS avg_co2_saved_tons
FROM intel.device_data d
JOIN intel.impact_data i ON d.device_id = i.device_id
GROUP BY i.region
ORDER BY i.region;

