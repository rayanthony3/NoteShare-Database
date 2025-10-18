SELECT pl.PlaylistName, s.SongName, a.ArtistName, s.Genre, s.Length, s.Rank, s.ReleaseDate, s.BPM
FROM Playlist pl
INNER JOIN Playlist_Songs ps ON pl.PlaylistID = ps.PlaylistID
INNER JOIN Song s ON ps.SongID = s.SongID
INNER JOIN Album al ON s.AlbumID = al.AlbumID
INNER JOIN Artist a ON al.ArtistID = a.ArtistID
ORDER BY pl.PlaylistName, ps.RankInPlaylist;
DECLARE @sql NVARCHAR(MAX) = '';

-- Drop foreign key constraints
SELECT @sql += 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ' DROP CONSTRAINT ' + QUOTENAME(CONSTRAINT_NAME) + ';
'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY';

-- Drop tables
SELECT @sql += 'DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ';
'
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Execute the drop script
EXEC sp_executesql @sql;

-- Create Artist Table
CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY,
    ArtistName VARCHAR(255)
);

-- Create Album Table
CREATE TABLE Album (
    AlbumID INT PRIMARY KEY,
    AlbumName VARCHAR(255),
    ArtistID INT,
    ReleaseDate DATE,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);

-- Create Song Table
CREATE TABLE Song (
    SongID INT PRIMARY KEY,
    SongName VARCHAR(255),
    AlbumID INT,
    Genre VARCHAR(255),
    Length TIME,
    Rank INT,
    ReleaseDate DATE,
    BPM INT,
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)
);

-- Create Features Table
CREATE TABLE Features (
    FeatureID INT PRIMARY KEY,
    SongID INT,
    FeaturedArtist VARCHAR(255),
    FOREIGN KEY (SongID) REFERENCES Song(SongID)
);

-- Create Playlist Table
CREATE TABLE Playlist (
    PlaylistID INT PRIMARY KEY,
    PlaylistName VARCHAR(255)
);

-- Create Playlist_Songs Table
CREATE TABLE Playlist_Songs (
    PlaylistID INT,
    SongID INT,
    RankInPlaylist INT,
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID),
    FOREIGN KEY (SongID) REFERENCES Song(SongID),
    PRIMARY KEY (PlaylistID, SongID)
);

-- Create AppUser Table
CREATE TABLE AppUser (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(255)
);

-- Create User_Playlists Table
CREATE TABLE User_Playlists (
    UserID INT,
    PlaylistID INT,
    FOREIGN KEY (UserID) REFERENCES AppUser(UserID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID),
    PRIMARY KEY (UserID, PlaylistID)
);

-- Insert data into Artist table
INSERT INTO Artist (ArtistID, ArtistName)
VALUES
    (1, 'Ed Sheeran'),
    (2, 'Taylor Swift'),
    (3, 'The Weeknd'),
    (4, 'Ariana Grande'),
    (5, 'Drake');

-- Insert data into Album table
INSERT INTO Album (AlbumID, AlbumName, ArtistID, ReleaseDate)
VALUES
    (1, '÷', 1, '2017-03-03'),
    (2, '1989', 2, '2014-10-27'),
    (3, 'After Hours', 3, '2020-03-20'),
    (4, 'Dangerous Woman', 4, '2016-05-20'),
    (5, 'Scorpion', 5, '2018-06-29');

-- Insert data into Song table
INSERT INTO Song (SongID, SongName, AlbumID, Genre, Length, Rank, ReleaseDate, BPM)
VALUES
    (1, 'Shape of You', 1, 'Pop', '00:03:53', 1, '2017-01-06', 96),
    (2, 'Castle on the Hill', 1, 'Pop', '00:04:21', 2, '2017-01-06', 135),
    (3, 'Blank Space', 2, 'Pop', '00:03:51', 1, '2014-10-27', 96),
    (4, 'Style', 2, 'Pop', '00:03:51', 2, '2014-10-27', 95),
    (5, 'Blinding Lights', 3, 'R&B', '00:03:22', 1, '2019-11-29', 171),
    (6, 'Save Your Tears', 3, 'R&B', '00:03:35', 2, '2019-03-20', 118),
    (7, 'Into You', 4, 'Pop', '00:04:04', 1, '2016-05-20', 108),
    (8, 'Side To Side', 4, 'Pop', '00:03:46', 2, '2016-05-20', 159),
    (9, 'God''s Plan', 5, 'Hip Hop/Rap', '00:03:18', 1, '2018-06-29', 77),
    (10, 'In My Feelings', 5, 'Hip Hop/Rap', '00:03:37', 2, '2018-06-29', 91),
    (11, 'Perfect', 1, 'Pop', '00:04:23', 3, '2017-03-03', 95),
    (12, 'Happier', 1, 'Pop', '00:03:27', 4, '2017-03-03', 100),
    (13, 'Wildest Dreams', 2, 'Pop', '00:03:40', 3, '2014-10-27', 69),
    (14, 'Shake It Off', 2, 'Pop', '00:03:39', 4, '2014-10-27', 160),
    (15, 'After Hours', 3, 'R&B', '00:06:01', 3, '2020-03-20', 87),
    (16, 'Blinding Lights', 3, 'R&B', '00:03:22', 4, '2020-03-20', 171),
    (17, 'One Last Time', 4, 'Pop', '00:03:17', 3, '2016-05-20', 125),
    (18, 'No Tears Left to Cry', 4, 'Pop', '00:03:25', 4, '2016-05-20', 122),
    (19, 'Hotline Bling', 5, 'Hip Hop/Rap', '00:04:27', 3, '2018-06-29', 68),
    (20, 'Nonstop', 5, 'Hip Hop/Rap', '00:03:59', 4, '2018-06-29', 154),
    (21, 'I Don''t Care', 1, 'Pop', '00:03:40', 5, '2019-05-10', 102),
    (22, 'Lover', 1, 'Pop', '00:03:41', 6, '2019-08-16', 68),
    (23, 'Love Me Harder', 4, 'Pop', '00:03:56', 5, '2014-08-20', 99),
    (24, 'Be Alright', 4, 'Pop', '00:03:35', 6, '2016-05-20', 145),
    (25, 'Take Care', 5, 'Hip Hop/Rap', '00:04:37', 5, '2011-11-15', 137),
    (26, 'Started From the Bottom', 5, 'Hip Hop/Rap', '00:02:53', 6, '2013-02-01', 86),
    (27, 'Thinking Out Loud', 1, 'Pop', '00:04:41', 7, '2014-06-20', 79),
    (28, 'Photograph', 1, 'Pop', '00:04:19', 8, '2015-06-20', 108),
    (29, 'Starboy', 3, 'R&B', '00:03:50', 5, '2016-09-21', 186),
    (30, 'Can''t Feel My Face', 3, 'R&B', '00:03:36', 6, '2015-06-08', 108);

-- Insert data into Features table for the new songs
INSERT INTO Features (FeatureID, SongID, FeaturedArtist)
VALUES
    (21, 21, 'Justin Bieber'),  -- I Don't Care
    (22, 22, 'Ed Sheeran'),     -- Lover
    (23, 23, 'Ariana Grande'),  -- Love Me Harder
    (24, 24, 'Ariana Grande'),  -- Be Alright
    (25, 25, 'Rihanna'),        -- Take Care
    (26, 26, 'Rihanna'),        -- Started From the Bottom
    (27, 27, NULL),             -- Thinking Out Loud
    (28, 28, NULL),             -- Photograph
    (29, 29, NULL),             -- Starboy
    (30, 30, NULL);             -- Can't Feel My Face

-- Insert data into Playlist table
INSERT INTO Playlist (PlaylistID, PlaylistName)
VALUES
    (1, 'Favorite Hits'),
    (2, 'Chill Vibes'),
    (3, 'R&B Favorites'),
    (4, 'Pop Hits'),
    (5, 'Hip Hop Jams');

-- Insert data into User table
INSERT INTO AppUser (UserID, UserName)
VALUES
    (1, 'John'),
    (2, 'Emily'),
    (3, 'Michael'),
    (4, 'Sophia'),
    (5, 'Daniel');

-- Insert data into User_Playlists table
INSERT INTO User_Playlists (UserID, PlaylistID)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 1),
    (3, 5),
    (4, 2),
    (4, 3),
    (5, 4),
    (5, 5);

-- Insert data into Playlist_Songs table
INSERT INTO Playlist_Songs (PlaylistID, SongID, RankInPlaylist)
VALUES
    (1, 1, 1),
    (1, 2, 2),
    (1, 11, 3),
    (1, 12, 4),
    (1, 21, 5),
    (1, 22, 6),
    (1, 27, 7),
    (1, 28, 8),
    (2, 15, 1),
    (2, 16, 2),
    (2, 23, 3),
    (2, 24, 4),
    (2, 29, 5),
    (2, 30, 6),
    (3, 3, 1),
    (3, 4, 2),
    (3, 13, 3),
    (3, 14, 4),
    (3, 25, 5),
    (3, 26, 6),
    (4, 7, 1),
    (4, 8, 2),
    (4, 17, 3),
    (4, 18, 4),
    (4, 3, 5),
    (4, 4, 6),
    (5, 9, 1),
    (5, 10, 2),
    (5, 19, 3),
    (5, 20, 4),
    (5, 5, 5),
    (5, 6, 6);