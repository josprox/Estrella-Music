import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.Crossfade
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectHorizontalDragGestures
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.ui.PlayerView
import coil.compose.AsyncImage
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.constants.PlayerBackgroundStyle
import com.zionhuang.music.constants.PlayerHorizontalPadding
import com.zionhuang.music.constants.ShowLyricsKey
import com.zionhuang.music.constants.ThumbnailCornerRadius
import com.zionhuang.music.ui.component.Lyrics
import com.zionhuang.music.ui.player.PlaybackError
import com.zionhuang.music.utils.rememberPreference

@Composable
fun Thumbnail(
    exoPlayer: ExoPlayer,
    showVideoPlayer: Boolean,
    isVideoReady: Boolean,
    sliderPositionProvider: () -> Long?,
    backgroundStyle: PlayerBackgroundStyle,
    modifier: Modifier = Modifier,
) {
    val playerConnection = LocalPlayerConnection.current ?: return
    val currentView = LocalView.current
    val context = LocalContext.current

    val mediaMetadata by playerConnection.mediaMetadata.collectAsState()
    val error by playerConnection.error.collectAsState()

    val showLyrics by rememberPreference(ShowLyricsKey, false)
    var dragAmount by remember { mutableStateOf(0f) }

    DisposableEffect(showLyrics) {
        currentView.keepScreenOn = showLyrics
        onDispose {
            currentView.keepScreenOn = false
        }
    }

    Box(
        modifier = modifier
            .fillMaxSize()
            .padding(horizontal = PlayerHorizontalPadding)
            .statusBarsPadding(),
        contentAlignment = Alignment.Center
    ) {
        // Crossfade se encarga de la animación entre Letras / Contenido Principal
        Crossfade(targetState = showLyrics, label = "LyricsCrossfade") { lyricsVisible ->
            if (lyricsVisible) {
                Lyrics(
                    sliderPositionProvider = sliderPositionProvider,
                    backgroundStyle = backgroundStyle
                )
            } else {
                // Contenido principal: Video o Carátula
                Box(contentAlignment = Alignment.Center) {
                    // Muestra el PlayerView si el modo video está activo
                    if (showVideoPlayer) {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .aspectRatio(16f / 9f)
                                .clip(RoundedCornerShape(ThumbnailCornerRadius))
                                .background(Color.Black)
                        ) {
                            // Video Player
                            AndroidView(
                                factory = { PlayerView(context).apply { player = exoPlayer; useController = false } },
                                modifier = Modifier
                                    .fillMaxSize()
                                    .alpha(if (isVideoReady) 1f else 0f) // Aparece cuando está listo
                            )

                            // Placeholder: Muestra la carátula o un indicador mientras el video carga
                            AnimatedVisibility(
                                visible = !isVideoReady,
                                enter = fadeIn(),
                                exit = fadeOut(),
                                modifier = Modifier.fillMaxSize()
                            ) {
                                if (mediaMetadata?.thumbnailUrl != null) {
                                    AsyncImage(
                                        model = mediaMetadata?.thumbnailUrl,
                                        contentDescription = "Cargando video",
                                        contentScale = ContentScale.Crop,
                                        modifier = Modifier.fillMaxSize()
                                    )
                                }
                                Box(
                                    modifier = Modifier.fillMaxSize().background(Color.Black.copy(alpha = 0.5f)),
                                    contentAlignment = Alignment.Center
                                ) {
                                    CircularProgressIndicator(color = Color.White)
                                }
                            }
                        }
                    } else {
                        // Muestra la carátula por defecto
                        AsyncImage(
                            model = mediaMetadata?.thumbnailUrl,
                            contentDescription = "Carátula del álbum",
                            contentScale = ContentScale.Crop,
                            modifier = Modifier
                                .fillMaxWidth()
                                .aspectRatio(1f)
                                .clip(RoundedCornerShape(ThumbnailCornerRadius))
                                .pointerInput(Unit) {
                                    detectHorizontalDragGestures(
                                        onDragEnd = {
                                            if (dragAmount < -50) playerConnection.seekToNext()
                                            if (dragAmount > 50) playerConnection.seekToPrevious()
                                            dragAmount = 0f
                                        },
                                        onHorizontalDrag = { _, dragDelta ->
                                            dragAmount += dragDelta
                                        }
                                    )
                                }
                        )
                    }
                }
            }
        }

        // Capa de error (si ocurre)
        AnimatedVisibility(
            visible = error != null,
            enter = fadeIn(),
            exit = fadeOut(),
            modifier = Modifier
                .padding(32.dp)
                .align(Alignment.Center)
        ) {
            error?.let {
                PlaybackError(
                    error = it,
                    retry = playerConnection.player::prepare
                )
            }
        }
    }
}