SELECT 
    a.ArtistID,
    a.ArtistName,
    al.AlbumID,
    al.AlbumName,
    al.ReleaseDate AS AlbumReleaseDate,
    s.SongID,
    s.SongName,
    s.Genre,
    s.Length AS SongLength,
    s.Rank AS SongRank,
    s.ReleaseDate AS SongReleaseDate,
    s.BPM,
    f.FeatureID,
    f.FeaturedArtist,
    p.PlaylistID,
    p.PlaylistName,
    u.UserID,
    u.UserName,
    ups.RankInPlaylist AS PlaylistSongRank
FROM 
    Artist a
JOIN 
    Album al ON a.ArtistID = al.ArtistID
JOIN 
    Song s ON al.AlbumID = s.AlbumID
LEFT JOIN 
    Features f ON s.SongID = f.SongID
LEFT JOIN 
    Playlist_Songs ups ON s.SongID = ups.SongID
LEFT JOIN 
    Playlist p ON ups.PlaylistID = p.PlaylistID
LEFT JOIN 
    User_Playlists up ON p.PlaylistID = up.PlaylistID
LEFT JOIN 
    AppUser u ON up.UserID = u.UserID;