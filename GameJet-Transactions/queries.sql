-- Project: GameJet Transactions (Free-to-Play Monetization Analysis)
-- Author: Daniyal Tariq Butt
-- Datasets: game_jet.users, game_jet.sessions, game_jet.iaps
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT COUNT(*) AS num_users FROM game_jet.users;

-- Query 2
SELECT COUNT(DISTINCT udid) AS num_session_users FROM game_jet.sessions;

-- Query 3
SELECT udid, COUNT(*) AS num_sessions
FROM game_jet.sessions
GROUP BY udid
ORDER BY num_sessions DESC;

-- Query 4
SELECT udid, COUNT(*) AS num_sessions
FROM game_jet.sessions
GROUP BY udid
HAVING COUNT(*) > 32.1
ORDER BY num_sessions DESC;

-- Query 5
SELECT COUNT(DISTINCT udid) AS purchasers FROM game_jet.iaps;

-- Query 6
SELECT u.udid, SUM(i.rev) AS total_rev_cents
FROM game_jet.users u
LEFT JOIN game_jet.iaps i USING (udid)
GROUP BY u.udid
ORDER BY total_rev_cents DESC NULLS LAST;

-- Query 7
WITH spend AS (
  SELECT u.udid, SUM(i.rev) AS total_rev_cents
  FROM game_jet.users u
  LEFT JOIN game_jet.iaps i USING (udid)
  GROUP BY u.udid
)
SELECT udid, total_rev_cents,
       CASE
         WHEN COALESCE(total_rev_cents, 0) = 0 THEN 'free player'
         WHEN total_rev_cents < 2000 THEN 'minnow'
         WHEN total_rev_cents < 10000 THEN 'dolphin'
         ELSE 'whale'
       END AS persona
FROM spend;

-- Query 8
WITH spend AS (
  SELECT u.udid, SUM(i.rev) AS total_rev_cents
  FROM game_jet.users u
  LEFT JOIN game_jet.iaps i USING (udid)
  GROUP BY u.udid
),
personas AS (
  SELECT udid,
         COALESCE(total_rev_cents, 0) AS total_rev_cents,
         CASE
           WHEN COALESCE(total_rev_cents, 0) = 0 THEN 'free player'
           WHEN total_rev_cents < 2000 THEN 'minnow'
           WHEN total_rev_cents < 10000 THEN 'dolphin'
           ELSE 'whale'
         END AS persona
  FROM spend
)
SELECT persona, SUM(total_rev_cents) / 100.0 AS revenue_usd
FROM personas
WHERE persona <> 'free player'
GROUP BY persona
ORDER BY revenue_usd DESC;

-- Query 9
WITH diffs AS (
  SELECT i.udid, (i.date - u.install_date) AS days_from_install
  FROM game_jet.iaps i
  JOIN game_jet.users u USING (udid)
),
firsts AS (
  SELECT udid, MIN(days_from_install) AS days_to_first_purchase
  FROM diffs
  GROUP BY udid
)
SELECT days_to_first_purchase, COUNT(*) AS users
FROM firsts
GROUP BY days_to_first_purchase
ORDER BY days_to_first_purchase;

