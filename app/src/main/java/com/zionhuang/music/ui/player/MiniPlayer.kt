package com.zionhuang.music.ui.player

import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.gestures.detectHorizontalDragGestures
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.WindowInsetsSides
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.only
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.systemBars
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.media3.common.PlaybackException
import androidx.media3.common.Player
import coil.compose.AsyncImage
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.constants.MiniPlayerHeight
import com.zionhuang.music.constants.ThumbnailCornerRadius
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.models.MediaMetadata
import androidx.compose.runtime.*
import androidx.compose.material3.*
import androidx.compose.ui.draw.blur
import androidx.compose.ui.layout.ContentScale
import com.zionhuang.music.constants.PlayerBackgroundStyle
import com.zionhuang.music.ui.component.ResizableIconButton

@Composable
fun MiniPlayer(
    position: Long,
    duration: Long,
    backgroundStyle: PlayerBackgroundStyle,
    contentColor: Color,
    modifier: Modifier = Modifier,
) {
    val playerConnection = LocalPlayerConnection.current ?: return
    val isPlaying by playerConnection.isPlaying.collectAsState()
    val playbackState by playerConnection.playbackState.collectAsState()
    val error by playerConnection.error.collectAsState()
    val mediaMetadata by playerConnection.mediaMetadata.collectAsState()

    var dragAmount by remember { mutableStateOf(0f) }
    val currentSong by playerConnection.currentSong.collectAsState(initial = null)

    Box(
        modifier = modifier
            .fillMaxWidth()
            .height(MiniPlayerHeight)
            // Es una buena práctica cortar los bordes para que el blur no se "salga"
            .clip(RoundedCornerShape(topStart = 12.dp, topEnd = 12.dp))
    ) {
        // --- FONDO DINÁMICO ---
        when (backgroundStyle) {
            PlayerBackgroundStyle.BLUR -> {
                // Si el estilo es BLUR, creamos nuestro propio fondo desenfocado
                if (mediaMetadata != null) {
                    AsyncImage(
                        model = mediaMetadata?.thumbnailUrl,
                        contentDescription = "Blurred background",
                        contentScale = ContentScale.Crop, // Rellena el espacio sin deformar
                        modifier = Modifier
                            .fillMaxSize()
                            .blur(radius = 25.dp) // El efecto de desenfoque
                    )
                    // Capa oscura (scrim) para mejorar la legibilidad del texto
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(Color.Black.copy(alpha = 0.4f))
                    )
                }
            }
            PlayerBackgroundStyle.DEFAULT -> {
                // Si el estilo es DEFAULT, usamos un fondo sólido del tema
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(MaterialTheme.colorScheme.surfaceContainer)
                )
            }
            PlayerBackgroundStyle.TRANSPARENT -> {
                // Si es TRANSPARENT, no hacemos nada para que sea transparente
            }
        }

        // --- CONTENIDO DEL REPRODUCTOR ---
        // El contenido (controles, texto, etc.) va encima del fondo
        Box(
            modifier = Modifier
                .fillMaxSize()
                .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Horizontal))
                .pointerInput(Unit) {
                    detectHorizontalDragGestures(
                        onDragEnd = {
                            if (dragAmount < 0) {
                                playerConnection.seekToNext()
                            } else if (dragAmount > 0) {
                                playerConnection.seekToPrevious()
                            }
                            dragAmount = 0f
                        },
                        onHorizontalDrag = { change, dragDelta ->
                            dragAmount += dragDelta
                        }
                    )
                }
        ) {
            LinearProgressIndicator(
                progress = { (position.toFloat() / duration).coerceIn(0f, 1f) },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(3.dp)
                    .align(Alignment.BottomCenter),
            )
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier
                    .fillMaxSize()
                    .padding(end = 6.dp),
            ) {
                Box(Modifier.weight(1f)) {
                    mediaMetadata?.let {
                        MiniMediaInfo(
                            mediaMetadata = it,
                            error = error,
                            textColor = contentColor,
                            modifier = Modifier.padding(horizontal = 6.dp)
                        )
                    }
                }

                CompositionLocalProvider(LocalContentColor provides contentColor) {
                    Box {
                        ResizableIconButton(
                            icon = if (currentSong?.song?.liked == true) R.drawable.favorite else R.drawable.favorite_border,
                            color = if (currentSong?.song?.liked == true) MaterialTheme.colorScheme.error else contentColor,
                            onClick = playerConnection::toggleLike
                        )
                    }

                    IconButton(
                        onClick = {
                            if (playbackState == Player.STATE_ENDED) {
                                playerConnection.player.seekTo(0, 0)
                                playerConnection.player.playWhenReady = true
                            } else {
                                playerConnection.player.togglePlayPause()
                            }
                        }
                    ) {
                        Icon(
                            painter = painterResource(if (playbackState == Player.STATE_ENDED) R.drawable.replay else if (isPlaying) R.drawable.pause else R.drawable.play),
                            contentDescription = null
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun MiniMediaInfo(
    mediaMetadata: MediaMetadata,
    error: PlaybackException?,
    textColor: Color,
    modifier: Modifier = Modifier,
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier
    ) {
        Box(modifier = Modifier.padding(6.dp)) {
            AsyncImage(
                model = mediaMetadata.thumbnailUrl,
                contentDescription = null,
                modifier = Modifier
                    .size(48.dp)
                    .clip(RoundedCornerShape(ThumbnailCornerRadius))
            )
            androidx.compose.animation.AnimatedVisibility(
                visible = error != null,
                enter = fadeIn(),
                exit = fadeOut()
            ) {
                Box(
                    Modifier
                        .size(48.dp)
                        .background(
                            color = Color.Black.copy(alpha = 0.6f),
                            shape = RoundedCornerShape(ThumbnailCornerRadius)
                        )
                ) {
                    Icon(
                        painter = painterResource(R.drawable.info),
                        contentDescription = null,
                        tint = MaterialTheme.colorScheme.error,
                        modifier = Modifier
                            .align(Alignment.Center)
                    )
                }
            }
        }

        Column(
            modifier = Modifier
                .weight(1f)
                .padding(horizontal = 6.dp)
        ) {
            Text(
                text = mediaMetadata.title,
                color = textColor,
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                modifier = Modifier.basicMarquee()
            )
            Text(
                text = mediaMetadata.artists.joinToString { it.name },
                color = textColor.copy(alpha = 0.7f),
                fontSize = 12.sp,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                modifier = Modifier.basicMarquee()
            )
        }
    }
}