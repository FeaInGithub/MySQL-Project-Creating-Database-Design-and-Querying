-- ============================================================
-- SQL QUERYING DEMO 
--
-- This section demonstrates my ability to write intermediate 
-- and advanced SQL queries, covering:
--
--   • FILTERING – Applying WHERE conditions, boolean checks, 
--     and NULL handling.
--
--   • SORTING – Ordering results by numeric and string fields.
--
--   • GROUPING – Grouping records and applying aggregate 
--     functions to summarize data.
--
--   • AGGREGATIONS – Using MAX, COUNT, LENGTH, and HAVING 
--     clauses for deeper analysis.
--
--   • JOINING – Combining data across multiple related tables 
--     using INNER JOINs.
--
--   • STRING FUNCTIONS – Practicing manipulation with UPPER, 
--     LOWER, LIKE, CONCAT, REPLACE, and SUBSTRING.
--
-- Purpose:
--   To showcase practical SQL query skills useful for 
--   reporting, analytics, and data exploration within a 
--   relational database.
-- ============================================================

SHOW TABLES FROM koel_database;

-- FILTERING
SELECT *
FROM users
WHERE is_admin = 1;

SELECT * 
FROM interactions
WHERE song_id IS NOT NULL;

SELECT * 
FROM interactions
WHERE play_count < 5;

SELECT * 
FROM interactions
WHERE liked = TRUE;

-- SORTING
SELECT interaction_id, user_id, play_count
FROM interactions
ORDER BY play_count;

SELECT *
FROM interactions
ORDER BY song_id DESC;

SELECT user_id, name, email
FROM users
ORDER BY user_id;

-- GROUPING
SELECT user_id, name, LENGTH(password) AS password_count
FROM users
GROUP BY user_id, name;

SELECT interaction_id, liked, play_count
FROM interactions
GROUP BY interaction_id;

SELECT interaction_id, user_id, COUNT(song_id) AS song_id_count
FROM interactions
GROUP BY interaction_id, user_id
ORDER BY song_id_count DESC;

-- AGGREGATIONS
SELECT user_id, name, LENGTH(email) AS email_length, LENGTH(password) AS password_length
FROM users
GROUP BY user_id, name;

SELECT interaction_id, user_id, MAX(play_count) AS max_playcounts, COUNT(song_id) AS song_counts
FROM interactions
GROUP BY interaction_id
ORDER BY max_playcounts DESC;

SELECT interaction_id, user_id, MAX(play_count) AS max_playcounts
FROM interactions
GROUP BY interaction_id
HAVING max_playcounts < 10
ORDER BY play_count DESC;

-- JOINING
-- checking to see who has connections w each other so it'd be easier to join them
-- was also checking the DB schema from the drawSQL bc it was easier
SELECT 
    table_name, 
    column_name, 
    constraint_name, 
    referenced_table_name, 
    referenced_column_name
FROM information_schema.key_column_usage
WHERE referenced_table_name IS NOT NULL
  AND table_schema = 'koel_database';

SELECT songs.song_id, songs.title, songs.artist_id, albums.name, artists.name
FROM songs 
JOIN albums ON songs.album_id = albums.album_id
JOIN artists ON songs.artist_id = artists.artist_id;

SELECT interactions.interaction_id, interactions.user_id, users.name, interactions.song_id, songs.title, 
	 songs.length, interactions.liked
FROM interactions
JOIN users ON interactions.user_id = users.user_id
JOIN songs ON interactions.song_id = songs.song_id;

-- STRING FUNCTIONS
SELECT user_id, UPPER(name) as upper_name, LOWER(name) AS lower_name
FROM users;

SELECT *
FROM users
WHERE email LIKE '%im%' 
OR email LIKE '%am%';

SELECT name, CONCAT(name, ' iz cool') AS cool_names
FROM users;

SELECT interaction_id, song_id, REPLACE(song_id, 'song', 'Song number ') AS the_numbers
FROM interactions
WHERE song_id IS NOT NULL;

SELECT user_id, email, SUBSTRING_INDEX(email, '@', 1) AS before_the_domain 
FROM users;

SELECT user_id, song_id, SUBSTRING(song_id, -1, 1) AS the_last
FROM interactions
WHERE song_id IS NOT NULL;



