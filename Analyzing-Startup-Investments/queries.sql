-- Project: Startup Investment Analysis (Crunchbase)
-- Author: Daniyal Tariq Butt
-- Dataset: crunchbase.companies
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT name, category_code, status, funding_total_usd
FROM crunchbase.companies
WHERE funding_total_usd IS NOT NULL
ORDER BY funding_total_usd DESC
LIMIT 12;

-- Query 2
SELECT name, category_code, status, funding_total_usd
FROM crunchbase.companies
WHERE funding_total_usd IS NOT NULL AND status = 'closed'
ORDER BY funding_total_usd DESC
LIMIT 12;

-- Query 3
SELECT name, category_code, status FROM crunchbase.companies WHERE category_code = 'cleantech';

-- Query 4
SELECT name, category_code, status FROM crunchbase.companies WHERE category_code = 'cleantech' AND status = 'closed';

-- Query 5
SELECT name, category_code
FROM crunchbase.companies
WHERE category_code = 'cleantech'
  AND (name ILIKE '%solar%' OR name ILIKE '%power%' OR name ILIKE '%energy%');

