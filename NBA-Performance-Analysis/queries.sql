-- Project: NBA Performance Analysis (2004–2020)
-- Author: Daniyal Tariq Butt
-- Dataset: nba.games
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT COUNT(*) AS num_games, MIN(season) AS first_season, MAX(season) AS last_season FROM nba.games;

-- Query 2
SELECT AVG(pts_home) AS avg_pts_home, AVG(pts_away) AS avg_pts_away, AVG(home_team_win) AS home_win_rate FROM nba.games;

-- Query 3
SELECT season, AVG(pts_home) AS avg_pts_home, AVG(pts_away) AS avg_pts_away, AVG(home_team_win) AS home_win_rate
FROM nba.games
GROUP BY season
ORDER BY season;

-- Query 4
SELECT season,
       AVG(pts_home) AS avg_pts_home, AVG(pts_away) AS avg_pts_away,
       AVG(home_team_win) AS home_win_rate,
       AVG(pct_3p_home) AS avg_3p_home, AVG(pct_3p_away) AS avg_3p_away
FROM nba.games
GROUP BY season
ORDER BY season;

-- Query 5
SELECT team_home, season, AVG(home_team_win) AS avg_home_win_rate, AVG(pct_3p_home) AS avg_3p_home
FROM nba.games
GROUP BY team_home, season
ORDER BY team_home, season;

-- Query 6
SELECT team_home, season, AVG(home_team_win) AS avg_home_win_rate, AVG(pct_3p_home) AS avg_3p_home
FROM nba.games
WHERE season >= '2018'
GROUP BY team_home, season
ORDER BY team_home, season;

-- Query 7
SELECT team_home, season, AVG(home_team_win) AS avg_home_win_rate, AVG(pct_3p_home) AS avg_3p_home
FROM nba.games
WHERE season >= '2018'
GROUP BY team_home, season
HAVING AVG(pct_3p_home) >= 0.37
ORDER BY team_home, season;

-- Query 8
SELECT team_home, season, AVG(home_team_win) AS avg_home_win_rate, AVG(pct_3p_home) AS avg_3p_home
FROM nba.games
WHERE season >= '2018'
GROUP BY team_home, season
HAVING AVG(pct_3p_home) >= 0.37 AND AVG(home_team_win) < 0.5
ORDER BY team_home, season;

-- Query 9
SELECT team_home, season, AVG(home_team_win) AS avg_home_win_rate, AVG(pct_3p_home) AS avg_3p_home
FROM nba.games
WHERE season >= '2018'
GROUP BY team_home, season
HAVING AVG(pct_3p_home) <= 0.34
ORDER BY team_home, season;

-- Query 10
SELECT team_home AS team, season,
       AVG(pts_home) AS avg_home_pts, AVG(pct_3p_home) AS avg_home_3p, SUM(home_team_win) AS home_wins
FROM nba.games
GROUP BY team_home, season
ORDER BY team, season;

-- Query 11
SELECT team_away AS team, season,
       AVG(pts_away) AS avg_away_pts, AVG(pct_3p_away) AS avg_away_3p,
       SUM(CASE WHEN home_team_win = 0 THEN 1 ELSE 0 END) AS away_wins
FROM nba.games
GROUP BY team_away, season
ORDER BY team, season;

