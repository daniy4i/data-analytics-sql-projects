-- Project: YouTube Trending Analysis
-- Author: Daniyal Tariq Butt
-- Dataset: youtube.trending
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending;

-- Query 2
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY likes DESC
LIMIT 1;

-- Query 3
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY dislikes DESC
LIMIT 1;

-- Query 4
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY comment_count DESC
LIMIT 1;

-- Query 5
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY comment_count DESC
LIMIT 10;

-- Query 6
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY comment_count DESC
LIMIT 1 OFFSET 99;

-- Query 7
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY comment_count DESC
LIMIT 1 OFFSET 999;

-- Query 8
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY likes DESC
LIMIT 10;

-- Query 9
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY dislikes DESC
LIMIT 10;

-- Query 10
SELECT title, channel_title, views, likes, dislikes, comment_count
FROM youtube.trending
ORDER BY views DESC
LIMIT 10;

