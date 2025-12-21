package com.zionhuang.music.ui.menu

import android.content.Intent
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.Alignment
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.material3.Text
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import com.zionhuang.music.constants.ModernDesignKey
import com.zionhuang.music.utils.rememberPreference
import coil.compose.AsyncImage
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.asPaddingValues
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.systemBars
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.zionhuang.music.LocalDatabase
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.constants.ArtistSongSortType
import com.zionhuang.music.db.entities.Artist
import com.zionhuang.music.extensions.toMediaItem
import com.zionhuang.music.playback.queues.ListQueue
import com.zionhuang.music.ui.component.ArtistListItem
import com.zionhuang.music.ui.component.GridMenu
import com.zionhuang.music.ui.component.GridMenuItem
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

@Composable
fun ArtistMenu(
    originalArtist: Artist,
    coroutineScope: CoroutineScope,
    onDismiss: () -> Unit,
) {
    val context = LocalContext.current
    val database = LocalDatabase.current
    val playerConnection = LocalPlayerConnection.current ?: return
    val modernDesign by rememberPreference(ModernDesignKey, defaultValue = true)
    val artistState = database.artist(originalArtist.id).collectAsState(initial = originalArtist)
    val artist = artistState.value ?: originalArtist

    if (modernDesign) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 24.dp, horizontal = 16.dp)
        ) {
            Box(contentAlignment = Alignment.BottomEnd) {
                AsyncImage(
                    model = artist.artist.thumbnailUrl,
                    contentDescription = null,
                    contentScale = ContentScale.Crop,
                    modifier = Modifier
                        .size(160.dp)
                        .clip(CircleShape) // Circle for artists usually
                )
                // Favorite Button Overlay
                IconButton(
                    onClick = {
                        database.transaction {
                            update(artist.artist.toggleLike())
                        }
                    },
                    modifier = Modifier
                        .padding(0.dp) // Adjust based on alignment
                        .background(MaterialTheme.colorScheme.surface.copy(alpha = 0.7f), CircleShape)
                        .size(40.dp)
                        .align(Alignment.BottomEnd)
                ) {
                    Icon(
                        painter = painterResource(if (artist.artist.bookmarkedAt != null) R.drawable.favorite else R.drawable.favorite_border),
                        tint = if (artist.artist.bookmarkedAt != null) MaterialTheme.colorScheme.error else MaterialTheme.colorScheme.onSurface,
                        contentDescription = null,
                        modifier = Modifier.size(24.dp)
                    )
                }
            }
            Text(
                text = artist.artist.name,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center,
                maxLines = 2,
                overflow = TextOverflow.Ellipsis
            )
        }
    } else {
        ArtistListItem(
            artist = artist,
            badges = {},
            trailingContent = {
                IconButton(
                    onClick = {
                        database.transaction {
                            update(artist.artist.toggleLike())
                        }
                    }
                ) {
                    Icon(
                        painter = painterResource(if (artist.artist.bookmarkedAt != null) R.drawable.favorite else R.drawable.favorite_border),
                        tint = if (artist.artist.bookmarkedAt != null) MaterialTheme.colorScheme.error else LocalContentColor.current,
                        contentDescription = null
                    )
                }
            }
        )

        HorizontalDivider()
    }

    GridMenu(
        contentPadding = PaddingValues(
            start = 8.dp,
            top = 8.dp,
            end = 8.dp,
            bottom = 8.dp + WindowInsets.systemBars.asPaddingValues().calculateBottomPadding()
        )
    ) {
        if (artist.songCount > 0) {
            GridMenuItem(
                icon = R.drawable.play,
                title = R.string.play
            ) {
                coroutineScope.launch {
                    val songs = withContext(Dispatchers.IO) {
                        database.artistSongs(artist.id, ArtistSongSortType.CREATE_DATE, true).first()
                            .map { it.toMediaItem() }
                    }
                    playerConnection.playQueue(
                        ListQueue(
                            title = artist.artist.name,
                            items = songs
                        )
                    )
                }
                onDismiss()
            }
            GridMenuItem(
                icon = R.drawable.shuffle,
                title = R.string.shuffle
            ) {
                coroutineScope.launch {
                    val songs = withContext(Dispatchers.IO) {
                        database.artistSongs(artist.id, ArtistSongSortType.CREATE_DATE, true).first()
                            .map { it.toMediaItem() }
                            .shuffled()
                    }
                    playerConnection.playQueue(
                        ListQueue(
                            title = artist.artist.name,
                            items = songs
                        )
                    )
                }
                onDismiss()
            }
        }
        if (artist.artist.isYouTubeArtist) {
            GridMenuItem(
                icon = R.drawable.share,
                title = R.string.share
            ) {
                // +++ LÓGICA CORREGIDA +++

                // 1. Prepara el Intent con la URL correcta.
                val intent = Intent().apply {
                    action = Intent.ACTION_SEND
                    type = "text/plain"
                    // Arreglamos la interpolación del String y usamos una URL estándar.
                    putExtra(Intent.EXTRA_TEXT, "https://jossmusic.com/channel/${artist.id}")
                }

                // 2. Inicia la actividad de compartir PRIMERO.
                context.startActivity(Intent.createChooser(intent, null))

                // 3. Descarta el menú DESPUÉS.
                onDismiss()
            }
        }
    }
}