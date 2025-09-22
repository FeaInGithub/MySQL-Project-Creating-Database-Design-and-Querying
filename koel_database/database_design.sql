-- ============================================================
-- Database Project 1: Koel (MySQL)
-- 
-- This project showcases my ability to design and implement a 
-- relational database schema based on an existing model created 
-- in DrawSQL (Koel - An open source music streaming server).
--
-- Skills demonstrated:
--   • Table creation with appropriate data types
--   • Primary keys, foreign keys, and relationships
--   • Referential integrity with ON DELETE rules
--   • Schema design for real-world applications
-- This schema serves as the foundation for future projects 
-- (e.g., triggers, events, stored procedures, joins, querying)
-- ============================================================

CREATE TABLE personal_access_tokens(
	personal_access_token_id BIGINT PRIMARY KEY,
    tokenable_id BIGINT,
    tokenable_type VARCHAR(50),
    name VARCHAR(50),
    token VARCHAR(64),
    abilities TEXT,
    last_used_at DATETIME,
    created_at DATETIME,
    updated_at DATETIME
);


CREATE TABLE password_resets(
	email VARCHAR(50),
    token VARCHAR(50),
    created_at DATETIME
);

CREATE TABLE settings(
	setting_key VARCHAR(25) PRIMARY KEY,
    value TEXT
);

CREATE TABLE users(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(50),
    is_admin BOOLEAN,
    preferences TEXT,
    remember_token VARCHAR(50),
	created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE interactions(
	interaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    song_id INT, -- foreign id from songs (table has not been created yet)
    liked BOOLEAN,
    play_count INT,
  	created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE songs(
    song_id INT AUTO_INCREMENT KEY, -- for consistency among the primary ids, instead of varchar, i made it into INT
    album_id INT, -- foreign id from albums (table has not been created yet)
	artist_id INT, -- foreign id from artists (table has not been created yet)
    title VARCHAR(50),
    length FLOAT,
    track INT,
    disc INT,
    lyrics TEXT,
    path TEXT,
    mtime INT,
	created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE artists(
	artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    image VARCHAR(50),
	created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE albums(
	album_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT,
	name VARCHAR(50),
    cover VARCHAR(50),
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY(artist_id) REFERENCES artists(artist_id) ON DELETE SET NULL
);

CREATE TABLE playlists(
	playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(50),
    rules TEXT,
	created_at DATETIME,
    updated_at DATETIME,
    folder_id VARCHAR(36),
	FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE playlist_folders(
	playlist_folder_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    user_id INT,
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE playlist_song(
	playlist_song_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_id INT,
    song_id INT,
    FOREIGN KEY(playlist_id) REFERENCES playlists(playlist_id) ON DELETE SET NULL,
    FOREIGN KEY(song_id) REFERENCES songs(song_id) ON DELETE SET NULL
);

-- Altering tables to reference the foreign id
ALTER TABLE interactions
ADD CONSTRAINT fk_song_id
FOREIGN KEY (song_id)
REFERENCES songs(song_id);

ALTER TABLE songs
ADD CONSTRAINT fk_album_id
    FOREIGN KEY (album_id) REFERENCES albums(album_id),
ADD CONSTRAINT fk_artist_id
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id);













