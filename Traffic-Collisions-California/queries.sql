-- Project: Traffic Collisions in California (SWITRS)
-- Author: Daniyal Tariq Butt
-- Datasets: switrs.collisions, switrs.parties
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT COUNT(*) AS num_at_fault_parties FROM switrs.parties WHERE at_fault = 'Y';

-- Query 2
SELECT COUNT(*) AS num_at_fault_alcohol FROM switrs.parties WHERE at_fault = 'Y' AND party_sobriety = 'B';

-- Query 3
SELECT COUNT(*) AS num_at_fault_inattention FROM switrs.parties WHERE at_fault = 'Y' AND (oaf_1 = 'F' OR oaf_2 = 'F');

-- Query 4
SELECT day_of_week, COUNT(*) AS collisions
FROM switrs.collisions
GROUP BY day_of_week
ORDER BY day_of_week;

-- Query 5
SELECT COUNT(*) AS joined_rows FROM switrs.collisions c JOIN switrs.parties p ON c.case_id = p.case_id;

-- Query 6
SELECT c.day_of_week, COUNT(*) AS collisions
FROM switrs.collisions c
JOIN switrs.parties p ON c.case_id = p.case_id
WHERE p.at_fault = 'Y' AND (p.oaf_1 = 'F' OR p.oaf_2 = 'F')
GROUP BY c.day_of_week
ORDER BY c.day_of_week;

-- Query 7
SELECT
  COUNT(*) AS total_inattention_accidents,
  SUM(CASE WHEN sp_info_2 IN ('B','1','2') THEN 1 ELSE 0 END) AS cell_phone_accidents,
  SUM(CASE WHEN sp_info_2 IN ('B','1','2') THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS cell_phone_proportion
FROM switrs.parties
WHERE (oaf_1 = 'F' OR oaf_2 = 'F') AND at_fault = 'Y';

