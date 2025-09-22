-- ============================================================
-- ADVANCED SQL FEATURES
--
-- This section demonstrates my ability to implement advanced 
-- database functionality beyond basic CRUD operations:
--
--   • TRIGGERS (AFTER INSERT) 
--       - Auto-create albums when new artists are added.
--       - Auto-create songs when new albums are added.
--
--   • TRIGGERS (AFTER DELETE) 
--       - Archive deleted songs into a 'deleted_songs' table 
--         for tracking purposes.
--
--   • EVENTS (SCHEDULER)
--       - Automatically clean up archived songs after 30 days.
--       - Includes a test event (1 minute) to simulate behavior.
--
--   • STORED PROCEDURES 
--       - (Planned) Procedures to search for songs by ID/keyword 
--
-- Purpose:
--   To showcase automation, auditing, and maintenance logic at 
--   the database level using triggers, scheduled events, and 
--   stored procedures.
-- ============================================================

-- TRIGGERS (AFTER INSERT)
-- Artists to Albums
CREATE TRIGGER artist_insert
	AFTER INSERT ON artists
    FOR EACH ROW
	INSERT INTO albums(artist_id, name, created_at, updated_at)
	VALUES(NEW.artist_id, NEW.name, NOW(), NOW());

-- Albums to songs
CREATE TRIGGER album_insert
    AFTER INSERT ON albums
    FOR EACH ROW
	INSERT INTO songs(album_id, artist_id, created_at, updated_at)
    VALUES(NEW.album_id, NEW.artist_id, NOW(), NOW());

INSERT INTO artists(artist_id, name)
VALUES(99907, 'Supergirl');

SELECT * 
FROM albums;
SELECT * 
FROM songs;

-- TRIGGERS (AFTER DELETE)
-- Creating a table where after deleting a song, a deleted song will be stored there
CREATE TABLE deleted_songs(
	deleted_song INT AUTO_INCREMENT PRIMARY KEY,
    song_id INT,
    title VARCHAR(50),
    deleted_on DATETIME
);

ALTER TABLE deleted_songs 
AUTO_INCREMENT = 505050;

-- A trigger where once I delete a song from songs table, it will automatically store it to deleted_songs table I just created
CREATE TRIGGER after_song_delete
	AFTER DELETE ON songs
    FOR EACH ROW
    INSERT INTO deleted_songs(song_id, title, deleted_on)
    VALUES(OLD.song_id, OLD.title, NOW());
   
DELETE FROM songs
WHERE song_id = 999992;
   
SELECT *
FROM  deleted_songs;

-- EVENTS
-- Creating an event where after 30 days, the deleted songs in deleted_songs table will be removed

SET GLOBAL event_scheduler = ON;
SHOW VARIABLES LIKE 'event_scheduler';

CREATE EVENT delete_song_after_30_days
	ON SCHEDULE EVERY 30 DAY
	DO 
    DELETE FROM deleted_songs
    WHERE deleted_on < NOW() - INTERVAL 30 DAY;
    
-- TEST
CREATE EVENT test_delete_song_after_1_minute
ON SCHEDULE EVERY 1 MINUTE
DO 
  DELETE FROM deleted_songs
  WHERE deleted_on < NOW() - INTERVAL 30 SECOND;

SELECT *
FROM deleted_songs;

-- STORED PROCEDURES
-- Creating a stored procedure where I will search a song by ID or by keyword
CREATE PROCEDURE search_song(IN keyword VARCHAR(50))
	SELECT song_id, artist_id, title, lyrics
    FROM songs
    WHERE title LIKE CONCAT('%', keyword, '%');

CALL search_song('Will');



