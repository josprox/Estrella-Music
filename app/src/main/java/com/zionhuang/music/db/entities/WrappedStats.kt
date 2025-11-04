package com.zionhuang.music.db.entities

data class ArtistStats(
    val id: String,
    val name: String,
    val thumbnailUrl: String?,
    val playCount: Int
)

data class SongStats(
    val id: String,
    val title: String,
    val thumbnailUrl: String?,
    val duration: Int,
    val albumId: String?,
    val albumName: String?,
    val playCount: Int
)

data class SimpleWrappedData(
    val topArtists: List<ArtistStats>,
    val topSongs: List<SongStats>,
    val uniqueArtistsCount: Int,
    val uniqueSongsCount: Int,
    val totalListeningTime: Long,
    val period: String
)