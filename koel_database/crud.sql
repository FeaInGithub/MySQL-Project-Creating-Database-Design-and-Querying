-- ============================================================
-- CRUD OPERATIONS DEMO 
--
-- This section demonstrates basic SQL operations on the database schema:
--
--   • CREATE (INSERT) – Adding users, interactions, songs, 
--     artists, albums, playlists, and folders with sample data.
--
--   • READ (SELECT) – Retrieving full table records to verify 
--     inserted data and relationships.
--
--   • UPDATE – Updating interactions to link users with songs, 
--     and updating songs to connect them with albums/artists.
--
--   • DELETE – Removing users (single and multiple deletions), 
--     then re-inserting to test data integrity.
--
-- Purpose: 
--   To showcase my ability to perform full CRUD cycles on a 
--   relational database while maintaining relationships 
--   between entities.
-- ============================================================

    -- CREATE (INSERT)
	INSERT INTO users(user_id, name, email, password, is_admin, created_at, updated_at)
	VALUES
	(1, 'Dwight', 'dwight@gmail.com', 'identityisatheft', TRUE, NOW(), NOW()),
	(2, 'Jim', 'Jim@gmail.com', 'ragebaiterking', FALSE, NOW(), NOW()),
	(3, 'Pam', 'pam@gmail.com', 'ilikeart', FALSE, NOW(), NOW()),
	(4, 'Erin', 'erin@gmail.com', 'yolo', FALSE, NOW(), NOW()),
	(5, 'Meredith', 'meredith@gmail.com', 'redheaded', FALSE, NOW(), NOW());

	INSERT INTO interactions(interaction_id, user_id, liked, play_count, created_at, updated_at)
	VALUES
	(000001, 1, TRUE, 123, NOW(), NOW()),
	(000002, 2, FALSE, 2, NOW(), NOW()),
	(000003, 3, TRUE, 34, NOW(), NOW()),
	(000004, 4, TRUE, 4, NOW(), NOW()),
	(000005, 5, TRUE, 23, NOW(), NOW());

	INSERT INTO songs(song_id, title, length, lyrics, mtime, created_at, updated_at)
	VALUES 
	(999990, 'I Will', 1.59, "[Verse]
	I will lay me down
	In a bunker underground
	I won't let this happen to my children
	Meet the real world coming out of your shell
	With white elephants, sitting ducks
	I will rise up
	[Outro]
	Little baby's eyes, eyes, eyes, eyes
	Little baby's eyes, eyes, eyes, eyes
	Little baby's eyes, eyes eyes", 1, NOW(), NOW()),

	(999991, 'Highly Evolved', 1.35, "I'm feeling happy, so highly evolved
	My time's a riddle that will never be solved
	Dreamin' for somethin', reachin' for somethin'
	Just waitin' for the sun to carry me in", 1, NOW(), NOW());

	INSERT INTO artists(artist_id, name, created_at, updated_at)
	VALUES
	(99901, 'Radiohead', NOW(), NOW()),
	(99902, 'The Vines', NOW(), NOW());

	INSERT INTO albums(album_id, artist_id, name, created_at, updated_at)
	VALUES
	(1010101, 99901, 'IDK Yet', NOW(), NOW()),
	(1010102, 99902, 'Something', NOW(), NOW());

	INSERT INTO playlists(playlist_id, user_id, name, created_at, updated_at)
	VALUES(696901, 1, 'Great Songs', NOW(), NOW()),
	(696902, 2, 'Wow', NOW(), NOW());
    
	INSERT INTO playlist_song(playlist_song_id, playlist_id, song_id)
	VALUES(111110, 696901, 999990),
    (111111, 696902, 999991);

	INSERT INTO playlist_folders(playlist_folder_id, name, user_id, created_at, updated_at)
	VALUES(12121, 'Folder1', 1, NOW(), NOW()),
	(12122, 'Folder2', 2, NOW(), NOW());

	-- READ
	SHOW TABLES FROM koel_database;
	SELECT * FROM users;
	SELECT * FROM interactions;
	SELECT * FROM albums;
	SELECT * FROM artists;
	SELECT * FROM songs;
	SELECT * FROM playlist_folders;
	SELECT * FROM playlists;
	SELECT * FROM playlist_song;

	-- UPDATE
UPDATE interactions
SET song_id = CASE user_id
   WHEN 1 THEN 999990
   WHEN 2 THEN 999991
END
WHERE user_id IN (1, 2);
SELECT * FROM interactions;

UPDATE songs
	SET album_id = CASE song_id
		WHEN 999990 THEN 1010101
		WHEN 999991 THEN 1010102
	END,
		artist_id = CASE song_id
		WHEN 999990 THEN 99901
		WHEN 999991 THEN 99902
	END
	WHERE song_id IN (999990, 999991);
SELECT * FROM songs;

	-- DELETE
	DELETE FROM users
	WHERE user_id = 5;
	SELECT * FROM users;

	-- multiple delete just for fun!
	DELETE FROM users
	WHERE user_id IN (3,4);

	-- INSERT again
	INSERT INTO users(user_id, name, email, password, is_admin, created_at, updated_at)
	VALUES
	(3, 'Pam', 'pam@gmail.com', 'ilikeart', FALSE, NOW(), NOW()),
	(4, 'Erin', 'erin@gmail.com', 'yolo', FALSE, NOW(), NOW()),
	(5, 'Meredith', 'meredith@gmail.com', 'redheaded', FALSE, NOW(), NOW());

	-- READ
	SELECT * FROM users;





