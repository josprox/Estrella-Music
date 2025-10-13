import android.content.res.Configuration
import android.util.Log
import androidx.compose.foundation.background
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.WindowInsetsSides
import androidx.compose.foundation.layout.asPaddingValues
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.only
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.systemBars
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Pause
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Repeat
import androidx.compose.material.icons.filled.RepeatOne
import androidx.compose.material.icons.filled.Replay
import androidx.compose.material.icons.filled.SkipNext
import androidx.compose.material.icons.filled.SkipPrevious
import androidx.compose.material.icons.outlined.FavoriteBorder
import androidx.compose.material.icons.rounded.Lyrics
import androidx.compose.material.icons.rounded.Videocam
import androidx.compose.material.icons.rounded.VideocamOff
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilledIconButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Slider
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.blur
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.lerp
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.core.graphics.drawable.toBitmap
import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import androidx.navigation.NavController
import androidx.palette.graphics.Palette
import coil.compose.AsyncImage
import coil.imageLoader
import coil.request.ImageRequest
import coil.size.Size
import com.zionhuang.innertube.YouTube
import com.zionhuang.innertube.models.YouTubeClient
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.constants.DarkModeKey
import com.zionhuang.music.constants.PlayerBackgroundStyle
import com.zionhuang.music.constants.PlayerMode
import com.zionhuang.music.constants.PureBlackKey
import com.zionhuang.music.constants.QueuePeekHeight
import com.zionhuang.music.constants.ShowLyricsKey
import com.zionhuang.music.constants.ShowVideoPlayerKey
import com.zionhuang.music.constants.SliderStyle
import com.zionhuang.music.constants.SliderStyleKey
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.extensions.toggleRepeatMode
import com.zionhuang.music.models.MediaMetadata
import com.zionhuang.music.ui.component.BottomSheet
import com.zionhuang.music.ui.component.BottomSheetState
import com.zionhuang.music.ui.component.rememberBottomSheetState
import com.zionhuang.music.ui.player.MiniPlayer
import com.zionhuang.music.ui.player.Queue
import com.zionhuang.music.ui.screens.settings.DarkMode
import com.zionhuang.music.utils.makeTimeString
import com.zionhuang.music.utils.rememberEnumPreference
import com.zionhuang.music.utils.rememberPreference
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.withContext
import me.saket.squiggles.SquigglySlider
import timber.log.Timber
import kotlin.math.abs

// Se define el padding horizontal como una constante para mantener la consistencia.
private val PlayerHorizontalPadding = 24.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BottomSheetPlayer(
    state: BottomSheetState,
    navController: NavController,
    modifier: Modifier = Modifier,
) {
    val playerConnection = LocalPlayerConnection.current ?: return
    val context = LocalContext.current
    val audioPlayer = playerConnection.player

    var showVideoPlayer by rememberPreference(ShowVideoPlayerKey, false)

    //region Background and Color Logic
    val isSystemInDarkTheme = isSystemInDarkTheme()
    val darkTheme by rememberEnumPreference(DarkModeKey, defaultValue = DarkMode.AUTO)
    val pureBlack by rememberPreference(PureBlackKey, defaultValue = false)
    val useBlackBackground = remember(isSystemInDarkTheme, darkTheme, pureBlack) {
        val useDarkTheme = if (darkTheme == DarkMode.AUTO) isSystemInDarkTheme else darkTheme == DarkMode.ON
        useDarkTheme && pureBlack
    }
    val backgroundStyle by rememberEnumPreference(
        key = PlayerMode,
        defaultValue = PlayerBackgroundStyle.DEFAULT
    )
    var gradientColors by remember { mutableStateOf<List<Color>>(emptyList()) }
    val mediaMetadata by playerConnection.mediaMetadata.collectAsState()
    val defaultGradientColors = listOf(MaterialTheme.colorScheme.surface, MaterialTheme.colorScheme.surfaceVariant)

    LaunchedEffect(mediaMetadata, backgroundStyle) {
        if (backgroundStyle == PlayerBackgroundStyle.GRADIENT && mediaMetadata?.thumbnailUrl != null) {
            try {
                val request = ImageRequest.Builder(context)
                    .data(mediaMetadata?.thumbnailUrl)
                    .size(Size(128, 128))
                    .allowHardware(false)
                    .build()

                val result = context.imageLoader.execute(request).drawable
                if (result != null) {
                    val bitmap = result.toBitmap()
                    val palette = withContext(Dispatchers.Default) { Palette.from(bitmap).generate() }
                    val dominantColor = palette.dominantSwatch?.rgb?.let { Color(it) }
                    val vibrantColor = palette.vibrantSwatch?.rgb?.let { Color(it) }

                    gradientColors = if (dominantColor != null && vibrantColor != null) {
                        listOf(vibrantColor, dominantColor)
                    } else {
                        defaultGradientColors
                    }
                }
            } catch (e: Exception) {
                gradientColors = defaultGradientColors
                e.printStackTrace()
            }
        }
    }

    val backgroundColor = when (backgroundStyle) {
        PlayerBackgroundStyle.BLUR, PlayerBackgroundStyle.GRADIENT -> Color.Transparent
        else -> {
            if (useBlackBackground && state.value > state.collapsedBound) {
                when (backgroundStyle) {
                    PlayerBackgroundStyle.TRANSPARENT -> lerp(
                        MaterialTheme.colorScheme.surfaceContainer,
                        Color.Black.copy(alpha = 0.85f),
                        state.progress
                    )
                    else -> lerp(MaterialTheme.colorScheme.surfaceContainer, Color.Black, state.progress)
                }
            } else {
                when (backgroundStyle) {
                    PlayerBackgroundStyle.TRANSPARENT -> MaterialTheme.colorScheme.surfaceContainer.copy(alpha = 0.95f)
                    else -> MaterialTheme.colorScheme.surfaceContainer
                }
            }
        }
    }

    val contentColor = if (backgroundStyle == PlayerBackgroundStyle.BLUR || backgroundStyle == PlayerBackgroundStyle.GRADIENT) {
        Color.White
    } else {
        LocalContentColor.current
    }
    //endregion

    //region Player State
    val sliderStyle by rememberEnumPreference(SliderStyleKey, defaultValue = SliderStyle.DEFAULT)
    val playbackState by playerConnection.playbackState.collectAsState()
    val isPlaying by playerConnection.isPlaying.collectAsState()
    val repeatMode by playerConnection.repeatMode.collectAsState()
    val currentSong by playerConnection.currentSong.collectAsState(initial = null)
    var showLyrics by rememberPreference(ShowLyricsKey, defaultValue = false)
    val canSkipPrevious by playerConnection.canSkipPrevious.collectAsState()
    val canSkipNext by playerConnection.canSkipNext.collectAsState()
    var position by rememberSaveable { mutableLongStateOf(audioPlayer.currentPosition) }
    var duration by rememberSaveable { mutableLongStateOf(audioPlayer.duration) }
    var sliderPosition by remember { mutableStateOf<Long?>(null) }
    //endregion

    //region Video Player Logic
    var videoUrl by remember { mutableStateOf<String?>(null) }
    var isVideoReady by remember { mutableStateOf(false) }

    val exoPlayer = remember {
        ExoPlayer.Builder(context).build().apply {
            trackSelectionParameters = trackSelectionParameters
                .buildUpon()
                .setTrackTypeDisabled(C.TRACK_TYPE_AUDIO, true)
                .build()
        }
    }

    DisposableEffect(Unit) {
        onDispose {
            exoPlayer.release()
        }
    }
    //endregion

    //region Player Synchronization
    LaunchedEffect(isPlaying, playbackState) {
        while (isActive && isPlaying && playbackState == Player.STATE_READY) {
            position = audioPlayer.currentPosition
            duration = audioPlayer.duration
            delay(200)
        }
        position = audioPlayer.currentPosition
        duration = audioPlayer.duration
    }

    LaunchedEffect(currentSong) {
        val songId = currentSong?.song?.id
        if (songId == null) {
            videoUrl = null
            return@LaunchedEffect
        }

        isVideoReady = false
        exoPlayer.stop()
        exoPlayer.clearMediaItems()

        videoUrl = withContext(Dispatchers.IO) {
            val playerResponse = YouTube.player(songId, client = YouTubeClient.MOBILE).getOrNull()
            playerResponse?.streamingData?.adaptiveFormats
                ?.firstOrNull { it.mimeType?.startsWith("video/mp4") == true && it.qualityLabel == "360p" }?.url
                ?: playerResponse?.streamingData?.adaptiveFormats
                    ?.firstOrNull { it.mimeType?.startsWith("video") == true }?.url
        }

        val url = videoUrl
        if (!url.isNullOrEmpty()) {
            exoPlayer.setMediaItem(MediaItem.fromUri(url))
            exoPlayer.prepare()

            val listener = object : Player.Listener {
                override fun onPlaybackStateChanged(playbackState: Int) {
                    if (playbackState == Player.STATE_READY) {
                        Timber.tag("PlayerSync").d("Video player is now in STATE_READY.")
                        isVideoReady = true
                        exoPlayer.seekTo(audioPlayer.currentPosition)
                        exoPlayer.removeListener(this)
                    }
                }
            }
            exoPlayer.addListener(listener)
        }
        Log.d("BottomSheetPlayer", "Video URL for $songId: $videoUrl")
    }

    LaunchedEffect(showVideoPlayer, isPlaying, isVideoReady) {
        if (showVideoPlayer && isPlaying && isVideoReady) {
            exoPlayer.playWhenReady = true
            while (isActive) {
                val audioPosition = audioPlayer.currentPosition
                val videoPosition = exoPlayer.currentPosition
                if (abs(audioPosition - videoPosition) > 500) {
                    Log.d("PlayerSync", "Resyncing video from $videoPosition to $audioPosition")
                    exoPlayer.seekTo(audioPosition)
                }
                delay(1000)
            }
        } else {
            exoPlayer.playWhenReady = false
        }
    }

    val seekTo: (Long) -> Unit = { newPosition ->
        audioPlayer.seekTo(newPosition)
        if (showVideoPlayer && isVideoReady) {
            exoPlayer.seekTo(newPosition)
        }
        position = newPosition
    }
    //endregion

    val queueSheetState = rememberBottomSheetState(
        dismissedBound = QueuePeekHeight + WindowInsets.systemBars.asPaddingValues().calculateBottomPadding(),
        expandedBound = state.expandedBound,
    )

    BottomSheet(
        state = state,
        modifier = modifier,
        backgroundColor = backgroundColor,
        onDismiss = {
            audioPlayer.stop()
            audioPlayer.clearMediaItems()
            exoPlayer.stop()
            exoPlayer.clearMediaItems()
        },
        collapsedContent = {
            MiniPlayer(
                position = position,
                duration = duration,
                backgroundStyle = backgroundStyle,
                contentColor = contentColor,
                gradientColors = gradientColors
            )
        }
    ) {
        // La UI principal se divide en componentes más pequeños
        val controlsContent: @Composable ColumnScope.(MediaMetadata) -> Unit = { metadata ->
            PlayerHeader(
                mediaMetadata = metadata,
                showVideoPlayer = showVideoPlayer,
                isLiked = currentSong?.song?.liked == true,
                contentColor = contentColor,
                onVideoToggle = { showVideoPlayer = !showVideoPlayer },
                onLikeToggle = playerConnection::toggleLike,
                onTitleClick = {
                    metadata.album?.id?.let {
                        navController.navigate("album/$it")
                        state.collapseSoft()
                    }
                },
                onArtistClick = { artists ->
                    if (artists.size == 1 && artists.first().id != null) {
                        navController.navigate("artist/${artists.first().id}")
                        state.collapseSoft()
                    }
                }
            )

            Spacer(Modifier.height(16.dp))

            PlayerSeekBar(
                position = sliderPosition ?: position,
                duration = duration,
                sliderStyle = sliderStyle,
                isPlaying = isPlaying,
                onValueChange = { sliderPosition = it },
                onValueChangeFinished = {
                    sliderPosition?.let { seekTo(it) }
                    sliderPosition = null
                }
            )

            Spacer(Modifier.height(16.dp))

            PlayerControls(
                isPlaying = isPlaying,
                playbackState = playbackState,
                showLyrics = showLyrics,
                repeatMode = repeatMode,
                canSkipPrevious = canSkipPrevious,
                canSkipNext = canSkipNext,
                contentColor = contentColor,
                onPlayPauseToggle = {
                    if (playbackState == Player.STATE_ENDED) {
                        seekTo(0)
                        audioPlayer.playWhenReady = true
                    } else {
                        audioPlayer.togglePlayPause()
                    }
                },
                onLyricsToggle = { showLyrics = !showLyrics },
                onSkipPrevious = playerConnection::seekToPrevious,
                onSkipNext = playerConnection::seekToNext,
                onRepeatModeToggle = audioPlayer::toggleRepeatMode
            )
        }

        Box(modifier = Modifier.fillMaxSize()) {
            // Background Layer
            when {
                backgroundStyle == PlayerBackgroundStyle.BLUR && mediaMetadata?.thumbnailUrl != null -> {
                    AsyncImage(
                        model = mediaMetadata?.thumbnailUrl,
                        contentDescription = "Blurred background",
                        contentScale = ContentScale.Crop,
                        modifier = Modifier.fillMaxSize().blur(radius = 25.dp)
                    )
                    Box(modifier = Modifier.fillMaxSize().background(Color.Black.copy(alpha = 0.4f)))
                }
                backgroundStyle == PlayerBackgroundStyle.GRADIENT && gradientColors.isNotEmpty() -> {
                    Box(modifier = Modifier.fillMaxSize().background(Brush.verticalGradient(colors = gradientColors)))
                    Box(modifier = Modifier.fillMaxSize().background(Color.Black.copy(alpha = 0.2f)))
                }
            }

            CompositionLocalProvider(LocalContentColor provides contentColor) {
                if (LocalConfiguration.current.orientation == Configuration.ORIENTATION_LANDSCAPE) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically,
                        modifier = Modifier
                            .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Horizontal))
                            .padding(bottom = queueSheetState.collapsedBound)
                            .fillMaxSize()
                    ) {
                        Box(
                            contentAlignment = Alignment.Center,
                            modifier = Modifier
                                .weight(1f)
                                .padding(12.dp)
                        ) {
                            Thumbnail(
                                exoPlayer = exoPlayer,
                                showVideoPlayer = showVideoPlayer,
                                isVideoReady = isVideoReady,
                                sliderPositionProvider = { sliderPosition },
                                backgroundStyle = backgroundStyle,
                                modifier = Modifier
                                    .fillMaxHeight()
                                    .aspectRatio(1f)
                                    .nestedScroll(state.preUpPostDownNestedScrollConnection)
                            )
                        }
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.Center,
                            modifier = Modifier
                                .weight(1f)
                                .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Top))
                        ) {
                            mediaMetadata?.let { controlsContent(it) }
                        }
                    }
                } else { // ORIENTATION_PORTRAIT
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally,
                        modifier = Modifier
                            .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Horizontal))
                            .padding(bottom = queueSheetState.collapsedBound)
                            .fillMaxSize()
                    ) {
                        Box(
                            contentAlignment = Alignment.Center,
                            modifier = Modifier.weight(1f, fill = true)
                        ) {
                            Thumbnail(
                                exoPlayer = exoPlayer,
                                showVideoPlayer = showVideoPlayer,
                                isVideoReady = isVideoReady,
                                sliderPositionProvider = { sliderPosition },
                                backgroundStyle = backgroundStyle,
                                modifier = Modifier.nestedScroll(state.preUpPostDownNestedScrollConnection)
                            )
                        }
                        mediaMetadata?.let { controlsContent(it) }
                        Spacer(Modifier.height(24.dp))
                    }
                }
            }

            // Queue Layer
            Queue(
                state = queueSheetState,
                playerBottomSheetState = state,
                backgroundColor = MaterialTheme.colorScheme.surfaceContainer.copy(alpha = 0.95f),
                navController = navController,
            )
        }
    }
}

/**
 * Componente para mostrar el título, artista y botones de acción secundarios.
 */
@Composable
private fun PlayerHeader(
    mediaMetadata: MediaMetadata,
    showVideoPlayer: Boolean,
    isLiked: Boolean,
    contentColor: Color,
    onVideoToggle: () -> Unit,
    onLikeToggle: () -> Unit,
    onTitleClick: () -> Unit,
    onArtistClick: (List<MediaMetadata.Artist>) -> Unit,
    modifier: Modifier = Modifier
) {
    // Estado para controlar el diálogo de artistas múltiples
    var showArtistsDialog by remember { mutableStateOf(false) }

    Row(
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = PlayerHorizontalPadding)
    ) {
        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = mediaMetadata.title,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                modifier = Modifier
                    .basicMarquee(iterations = Int.MAX_VALUE, initialDelayMillis = 3000, velocity = 30.dp)
                    .clickable(enabled = mediaMetadata.album != null, onClick = onTitleClick)
            )

            val artistString = remember(mediaMetadata.artists) {
                mediaMetadata.artists.joinToString(", ") { it.name }
            }
            Text(
                text = artistString,
                style = MaterialTheme.typography.bodyLarge,
                color = LocalContentColor.current.copy(alpha = 0.8f),
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                modifier = Modifier
                    .basicMarquee(iterations = Int.MAX_VALUE, initialDelayMillis = 3000, velocity = 30.dp)
                    .clickable(enabled = mediaMetadata.artists.isNotEmpty()) {
                        if (mediaMetadata.artists.size > 1) {
                            showArtistsDialog = true
                        } else {
                            onArtistClick(mediaMetadata.artists)
                        }
                    }
            )
        }

        Spacer(modifier = Modifier.width(16.dp))

        // Botones de acción
        Row {
            IconButton(onClick = onVideoToggle) {
                Icon(
                    imageVector = if (showVideoPlayer) Icons.Rounded.VideocamOff else Icons.Rounded.Videocam,
                    contentDescription = "Toggle Video",
                    tint = contentColor
                )
            }
            IconButton(onClick = onLikeToggle) {
                Icon(
                    imageVector = if (isLiked) Icons.Filled.Favorite else Icons.Outlined.FavoriteBorder,
                    contentDescription = "Favorite",
                    tint = if (isLiked) MaterialTheme.colorScheme.primary else contentColor
                )
            }
        }
    }

    if (showArtistsDialog) {
        ArtistsDialog(
            artists = mediaMetadata.artists,
            onDismiss = { showArtistsDialog = false },
            onArtistSelected = { artist ->
                showArtistsDialog = false
            }
        )
    }
}

/**
 * Componente para el slider de progreso y los indicadores de tiempo.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PlayerSeekBar(
    position: Long,
    duration: Long,
    sliderStyle: SliderStyle,
    isPlaying: Boolean,
    onValueChange: (Long) -> Unit,
    onValueChangeFinished: () -> Unit,
    modifier: Modifier = Modifier
) {
    val finalDuration = if (duration == C.TIME_UNSET) 0f else duration.toFloat()

    Column(modifier = modifier.padding(horizontal = PlayerHorizontalPadding)) {
        when (sliderStyle) {
            SliderStyle.DEFAULT -> Slider(
                value = position.toFloat(),
                valueRange = 0f..finalDuration,
                onValueChange = { onValueChange(it.toLong()) },
                onValueChangeFinished = onValueChangeFinished
            )
            SliderStyle.SQUIGGLY -> SquigglySlider(
                value = position.toFloat(),
                valueRange = 0f..finalDuration,
                onValueChange = { onValueChange(it.toLong()) },
                onValueChangeFinished = onValueChangeFinished,
                squigglesSpec = SquigglySlider.SquigglesSpec(
                    amplitude = if (isPlaying) 2.dp else 0.dp,
                    strokeWidth = 4.dp,
                )
            )
        }

        Row(
            horizontalArrangement = Arrangement.SpaceBetween,
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 4.dp) // Pequeño padding para alinear con el slider
        ) {
            Text(
                text = makeTimeString(position),
                style = MaterialTheme.typography.labelMedium,
            )
            Text(
                text = if (duration != C.TIME_UNSET) makeTimeString(duration) else "0:00",
                style = MaterialTheme.typography.labelMedium,
            )
        }
    }
}

/**
 * Componente para los controles principales (play/pause, skip, etc.).
 */
@Composable
private fun PlayerControls(
    isPlaying: Boolean,
    playbackState: Int,
    showLyrics: Boolean,
    repeatMode: Int,
    canSkipPrevious: Boolean,
    canSkipNext: Boolean,
    contentColor: Color,
    onPlayPauseToggle: () -> Unit,
    onLyricsToggle: () -> Unit,
    onSkipPrevious: () -> Unit,
    onSkipNext: () -> Unit,
    onRepeatModeToggle: () -> Unit,
    modifier: Modifier = Modifier
) {
    val playPauseIcon = when {
        playbackState == Player.STATE_ENDED -> Icons.Filled.Replay
        isPlaying -> Icons.Filled.Pause
        else -> Icons.Filled.PlayArrow
    }

    Row(
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceEvenly,
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = PlayerHorizontalPadding)
    ) {
        // Botón de Letras
        IconButton(onClick = onLyricsToggle) {
            Icon(
                imageVector = Icons.Rounded.Lyrics,
                contentDescription = "Lyrics",
                tint = contentColor.copy(alpha = if (showLyrics) 1f else 0.6f)
            )
        }

        // Botón de Anterior
        IconButton(onClick = onSkipPrevious, enabled = canSkipPrevious) {
            Icon(
                Icons.Filled.SkipPrevious,
                "Skip Previous",
                tint = contentColor,
                modifier = Modifier.size(36.dp)
            )
        }

        // Botón de Play/Pause
        FilledIconButton(
            onClick = onPlayPauseToggle,
            modifier = Modifier.size(72.dp),
            shape = CircleShape,
            colors = IconButtonDefaults.filledIconButtonColors(
                containerColor = MaterialTheme.colorScheme.primaryContainer,
                contentColor = MaterialTheme.colorScheme.onPrimaryContainer
            )
        ) {
            Icon(
                imageVector = playPauseIcon,
                contentDescription = "Play/Pause",
                modifier = Modifier.size(40.dp)
            )
        }

        // Botón de Siguiente
        IconButton(onClick = onSkipNext, enabled = canSkipNext) {
            Icon(
                Icons.Filled.SkipNext,
                "Skip Next",
                tint = contentColor,
                modifier = Modifier.size(36.dp)
            )
        }

        // Botón de Repetir
        IconButton(onClick = onRepeatModeToggle) {
            val (icon, alpha) = when (repeatMode) {
                Player.REPEAT_MODE_ONE -> Icons.Filled.RepeatOne to 1f
                Player.REPEAT_MODE_ALL -> Icons.Filled.Repeat to 1f
                else -> Icons.Filled.Repeat to 0.6f
            }
            Icon(
                imageVector = icon,
                contentDescription = "Repeat Mode",
                tint = contentColor.copy(alpha = alpha)
            )
        }
    }
}

/**
 * Diálogo para mostrar una lista de artistas cuando hay más de uno.
 */
@Composable
private fun ArtistsDialog(
    artists: List<MediaMetadata.Artist>,
    onDismiss: () -> Unit,
    onArtistSelected: (MediaMetadata.Artist) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Artistas") },
        text = {
            Column {
                artists.forEach { artist ->
                    val isClickable = artist.id != null
                    Text(
                        text = artist.name,
                        style = MaterialTheme.typography.bodyLarge,
                        fontWeight = if (isClickable) FontWeight.Medium else FontWeight.Normal,
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable(enabled = isClickable) { onArtistSelected(artist) }
                            .padding(vertical = 12.dp)
                    )
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Cerrar")
            }
        }
    )
}