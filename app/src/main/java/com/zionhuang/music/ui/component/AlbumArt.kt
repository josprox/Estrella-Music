// Crea un nuevo archivo: AlbumArt.kt
package com.zionhuang.music.ui.component

import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import com.zionhuang.music.constants.ThumbnailCornerRadius

@Composable
fun AlbumArt(
    thumbnailUrl: String?,
    modifier: Modifier = Modifier,
    size: androidx.compose.ui.unit.Dp = 120.dp
) {
    AsyncImage(
        model = thumbnailUrl,
        contentDescription = "Carátula del álbum",
        modifier = modifier
            .size(size)
            .clip(RoundedCornerShape(ThumbnailCornerRadius))
    )
}

@Composable
fun ArtistArt(
    thumbnailUrl: String?,
    modifier: Modifier = Modifier,
    size: androidx.compose.ui.unit.Dp = 120.dp
) {
    AsyncImage(
        model = thumbnailUrl,
        contentDescription = "Foto del artista",
        modifier = modifier
            .size(size)
            .clip(RoundedCornerShape(50)) // Circular para artistas
    )
}