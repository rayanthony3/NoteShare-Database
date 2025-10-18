
-- 1. Get all songs along with their album and artist details
SELECT 
    s.SongName AS Song_Name,
    s.Genre AS Genre,
    s.Length AS Song_Length,
    s.Rank AS Song_Rank,
    s.ReleaseDate AS Release_Date,
    s.BPM AS Beats_Per_Minute,
    al.AlbumName AS Album_Name,
    ar.ArtistName AS Artist_Name
FROM 
    Song s
JOIN 
    Album al ON s.AlbumID = al.AlbumID
JOIN 
    Artist ar ON al.ArtistID = ar.ArtistID;

-- 2. Get all playlists along with the count of songs in each playlist
SELECT 
    pl.PlaylistName AS Playlist_Name,
    COUNT(ps.SongID) AS Song_Count
FROM 
    Playlist pl
LEFT JOIN 
    Playlist_Songs ps ON pl.PlaylistID = ps.PlaylistID
GROUP BY 
    pl.PlaylistID, pl.PlaylistName;

-- 3. Get the top 5 users with the most playlists
SELECT TOP 5
    u.UserName AS User_Name,
    COUNT(up.PlaylistID) AS Playlist_Count
FROM 
    AppUser u
LEFT JOIN 
    User_Playlists up ON u.UserID = up.UserID
GROUP BY 
    u.UserID, u.UserName
ORDER BY 
    Playlist_Count DESC;
-- INSERT, UPDATE, and DELETE statements

-- Insert a new song
INSERT INTO Song (SongID, SongName, AlbumID, Genre, Length, Rank, ReleaseDate, BPM)
VALUES
    (31, 'Stargazing', 5, 'Hip Hop/Rap', '00:04:30', 5, '2018-06-29', 100);

-- Update a song's rank
UPDATE Song
SET Rank = 6
WHERE SongID = 31;

-- Delete a song from a playlist
DELETE FROM Playlist_Songs
WHERE PlaylistID = 1 AND SongID = 27;