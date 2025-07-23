import android.content.res.Configuration
import android.util.Log
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material.icons.outlined.FavoriteBorder
import androidx.compose.material.icons.rounded.Lyrics
import androidx.compose.material.icons.rounded.Videocam
import androidx.compose.material.icons.rounded.VideocamOff
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.blur
import androidx.compose.ui.draw.clip
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
import androidx.compose.ui.util.fastForEachIndexed
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
import com.zionhuang.music.constants.*
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
    // Main loop to update the UI progress bar from the audio player
    LaunchedEffect(isPlaying, playbackState) {
        while (isActive && isPlaying && playbackState == Player.STATE_READY) {
            position = audioPlayer.currentPosition
            duration = audioPlayer.duration
            delay(200)
        }
        position = audioPlayer.currentPosition
        duration = audioPlayer.duration
    }

    // Fetches video URL and prepares the video player
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

            // <<< El listener correcto para saber si el video está listo.
            val listener = object : Player.Listener {
                override fun onPlaybackStateChanged(playbackState: Int) {
                    if (playbackState == Player.STATE_READY) {
                        Timber.tag("PlayerSync").d("Video player is now in STATE_READY.")
                        isVideoReady = true
                        // Sincronizamos la posición una vez que está listo.
                        exoPlayer.seekTo(audioPlayer.currentPosition)
                        exoPlayer.removeListener(this) // El listener solo se necesita una vez.
                    }
                }
            }
            exoPlayer.addListener(listener)
        }
        Log.d("BottomSheetPlayer", "Video URL for $songId: $videoUrl")
    }

    // Efecto de sincronización activa
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

    // Syncs seeking between players
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
        val controlsContent: @Composable ColumnScope.(MediaMetadata) -> Unit = { mediaMetadata ->
            val playPauseRoundness by animateDpAsState(
                targetValue = if (isPlaying) 24.dp else 36.dp,
                animationSpec = tween(durationMillis = 100, easing = LinearEasing),
                label = "playPauseRoundness"
            )

            // Estado para controlar la visibilidad del pop-up de artistas
            var showArtistsPopup by remember { mutableStateOf(false) }

            Row(
                horizontalArrangement = Arrangement.Start,
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = PlayerHorizontalPadding)
            ) {
                // Song Title and Artist
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = mediaMetadata.title,
                        style = MaterialTheme.typography.titleLarge,
                        fontWeight = FontWeight.Bold,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                        modifier = Modifier
                            .basicMarquee(iterations = Int.MAX_VALUE, initialDelayMillis = 3000, velocity = 30.dp)
                            .clickable(enabled = mediaMetadata.album != null) {
                                navController.navigate("album/${mediaMetadata.album!!.id}")
                                state.collapseSoft()
                            }
                    )
                    Row {
                        val artistString = remember(mediaMetadata.artists) {
                            mediaMetadata.artists.joinToString(", ") { it.name }
                        }
                        Text(
                            text = artistString,
                            style = MaterialTheme.typography.titleMedium,
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis,
                            modifier = Modifier
                                .basicMarquee(iterations = Int.MAX_VALUE, initialDelayMillis = 3000, velocity = 30.dp)
                                .clickable(enabled = mediaMetadata.artists.isNotEmpty()) {
                                    if (mediaMetadata.artists.size == 1 && mediaMetadata.artists.first().id != null) {
                                        // Si es un solo artista y tiene ID, navegar directamente a su página
                                        navController.navigate("artist/${mediaMetadata.artists.first().id}")
                                        state.collapseSoft()
                                    } else if (mediaMetadata.artists.size > 1) {
                                        // Si son varios artistas, mostrar el pop-up
                                        showArtistsPopup = true
                                    }
                                }
                        )
                    }
                }

                Spacer(modifier = Modifier.width(16.dp))

                // Video Toggle Button
                IconButton(onClick = { showVideoPlayer = !showVideoPlayer }) {
                    Icon(
                        imageVector = if (showVideoPlayer) Icons.Rounded.VideocamOff else Icons.Rounded.Videocam,
                        contentDescription = "Toggle Video",
                        tint = contentColor
                    )
                }

                // Favorite Button
                IconButton(onClick = playerConnection::toggleLike) {
                    Icon(
                        imageVector = if (currentSong?.song?.liked == true) Icons.Filled.Favorite else Icons.Outlined.FavoriteBorder,
                        contentDescription = "Favorite",
                        tint = contentColor
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            // Seek Bar
            when (sliderStyle) {
                SliderStyle.DEFAULT -> Slider(
                    value = (sliderPosition ?: position).toFloat(),
                    valueRange = 0f..(if (duration == C.TIME_UNSET) 0f else duration.toFloat()),
                    onValueChange = { sliderPosition = it.toLong() },
                    onValueChangeFinished = {
                        sliderPosition?.let { seekTo(it) }
                        sliderPosition = null
                    },
                    modifier = Modifier.padding(horizontal = PlayerHorizontalPadding)
                )
                SliderStyle.SQUIGGLY -> SquigglySlider(
                    value = (sliderPosition ?: position).toFloat(),
                    valueRange = 0f..(if (duration == C.TIME_UNSET) 0f else duration.toFloat()),
                    onValueChange = { sliderPosition = it.toLong() },
                    onValueChangeFinished = {
                        sliderPosition?.let { seekTo(it) }
                        sliderPosition = null
                    },
                    squigglesSpec = SquigglySlider.SquigglesSpec(
                        amplitude = if (isPlaying) 2.dp else 0.dp,
                        strokeWidth = 4.dp,
                    ),
                    modifier = Modifier.padding(horizontal = PlayerHorizontalPadding),
                )
            }

            Spacer(Modifier.height(4.dp))

            // Time Indicators
            Row(
                horizontalArrangement = Arrangement.SpaceBetween,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = PlayerHorizontalPadding + 4.dp)
            ) {
                Text(
                    text = makeTimeString(sliderPosition ?: position),
                    style = MaterialTheme.typography.labelMedium,
                )
                Text(
                    text = if (duration != C.TIME_UNSET) makeTimeString(duration) else "",
                    style = MaterialTheme.typography.labelMedium,
                )
            }

            Spacer(Modifier.height(12.dp))

            // Control Buttons
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceAround,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = PlayerHorizontalPadding)
            ) {
                IconButton(onClick = { showLyrics = !showLyrics }) {
                    Icon(
                        imageVector = Icons.Rounded.Lyrics,
                        contentDescription = "Lyrics",
                        tint = contentColor,
                        modifier = Modifier.alpha(if (showLyrics) 1f else 0.5f)
                    )
                }

                IconButton(onClick = playerConnection::seekToPrevious, enabled = canSkipPrevious) {
                    Icon(Icons.Filled.SkipPrevious, "Skip Previous", tint = contentColor, modifier = Modifier.size(32.dp))
                }

                // Play/Pause Button
                Box(
                    modifier = Modifier
                        .size(72.dp)
                        .clip(RoundedCornerShape(playPauseRoundness))
                        .background(MaterialTheme.colorScheme.secondaryContainer)
                        .clickable {
                            if (playbackState == Player.STATE_ENDED) {
                                seekTo(0)
                                audioPlayer.playWhenReady = true
                            } else {
                                audioPlayer.togglePlayPause()
                            }
                        }
                ) {
                    val playPauseIcon = when {
                        playbackState == Player.STATE_ENDED -> Icons.Filled.Replay
                        isPlaying -> Icons.Filled.Pause
                        else -> Icons.Filled.PlayArrow
                    }
                    Icon(
                        imageVector = playPauseIcon,
                        contentDescription = "Play/Pause",
                        tint = MaterialTheme.colorScheme.onSecondaryContainer,
                        modifier = Modifier.align(Alignment.Center).size(36.dp)
                    )
                }

                IconButton(onClick = playerConnection::seekToNext, enabled = canSkipNext) {
                    Icon(Icons.Filled.SkipNext, "Skip Next", tint = contentColor, modifier = Modifier.size(32.dp))
                }

                IconButton(
                    onClick = audioPlayer::toggleRepeatMode,
                    modifier = Modifier.alpha(if (repeatMode == Player.REPEAT_MODE_OFF) 0.5f else 1f)
                ) {
                    Icon(
                        imageVector = if (repeatMode == Player.REPEAT_MODE_ONE) Icons.Filled.RepeatOne else Icons.Filled.Repeat,
                        contentDescription = "Repeat Mode",
                        tint = contentColor
                    )
                }
            }

            // Pop-up de Artistas
            if (showArtistsPopup) {
                AlertDialog(
                    onDismissRequest = { showArtistsPopup = false },
                    title = { Text("Artistas") },
                    text = {
                        Column {
                            mediaMetadata.artists.forEach { artist ->
                                if (artist.id != null) {
                                    Text(
                                        text = artist.name,
                                        style = MaterialTheme.typography.bodyLarge,
                                        fontWeight = FontWeight.Bold,
                                        modifier = Modifier
                                            .fillMaxWidth()
                                            .clickable {
                                                navController.navigate("artist/${artist.id}")
                                                state.collapseSoft() // Colapsar el reproductor
                                                showArtistsPopup = false // Cerrar el pop-up
                                            }
                                            .padding(vertical = 8.dp)
                                    )
                                } else {
                                    Text(
                                        text = artist.name,
                                        style = MaterialTheme.typography.bodyLarge,
                                        modifier = Modifier.padding(vertical = 8.dp)
                                    )
                                }
                            }
                        }
                    },
                    confirmButton = {
                        TextButton(onClick = { showArtistsPopup = false }) {
                            Text("Cerrar")
                        }
                    }
                )
            }
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
                // Main Content (Thumbnail/Video + Controls)
                if (LocalConfiguration.current.orientation == Configuration.ORIENTATION_LANDSCAPE) {
                    Row(
                        modifier = Modifier
                            .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Horizontal))
                            .padding(bottom = queueSheetState.collapsedBound)
                    ) {
                        Box(contentAlignment = Alignment.Center, modifier = Modifier.weight(1f)) {
                            Thumbnail(
                                exoPlayer = exoPlayer,
                                showVideoPlayer = showVideoPlayer,
                                isVideoReady = isVideoReady,
                                sliderPositionProvider = { sliderPosition },
                                backgroundStyle = backgroundStyle,
                                modifier = Modifier.nestedScroll(state.preUpPostDownNestedScrollConnection)
                            )
                        }
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                            modifier = Modifier
                                .weight(1f)
                                .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Top))
                        ) {
                            Spacer(Modifier.weight(1f))
                            mediaMetadata?.let { controlsContent(it) }
                            Spacer(Modifier.weight(1f))
                        }
                    }
                } else { // ORIENTATION_PORTRAIT
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally,
                        modifier = Modifier
                            .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Horizontal))
                            .padding(bottom = queueSheetState.collapsedBound)
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