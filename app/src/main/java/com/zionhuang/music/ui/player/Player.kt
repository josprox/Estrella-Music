package com.zionhuang.music.ui.player

import android.content.res.Configuration
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.tween
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
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.only
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.systemBars
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.foundation.shape.RoundedCornerShape
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
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Slider
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
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
import androidx.media3.common.Player
import androidx.navigation.NavController
import androidx.palette.graphics.Palette
import coil.compose.AsyncImage
import coil.imageLoader
import coil.request.ImageRequest
import coil.size.Size
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.constants.DarkModeKey
import com.zionhuang.music.constants.PlayerBackgroundStyle
import com.zionhuang.music.constants.PlayerHorizontalPadding
import com.zionhuang.music.constants.PlayerMode
import com.zionhuang.music.constants.PureBlackKey
import com.zionhuang.music.constants.QueuePeekHeight
import com.zionhuang.music.constants.ShowLyricsKey
import com.zionhuang.music.constants.SliderStyle
import com.zionhuang.music.constants.SliderStyleKey
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.extensions.toggleRepeatMode
import com.zionhuang.music.models.MediaMetadata
import com.zionhuang.music.ui.component.BottomSheet
import com.zionhuang.music.ui.component.BottomSheetState
import com.zionhuang.music.ui.component.rememberBottomSheetState
import com.zionhuang.music.ui.screens.settings.DarkMode
import com.zionhuang.music.utils.makeTimeString
import com.zionhuang.music.utils.rememberEnumPreference
import com.zionhuang.music.utils.rememberPreference
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.withContext
import me.saket.squiggles.SquigglySlider

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BottomSheetPlayer(
    state: BottomSheetState,
    navController: NavController,
    modifier: Modifier = Modifier,
) {
    val playerConnection = LocalPlayerConnection.current ?: return
    val context = LocalContext.current
    // val menuState = LocalMenuState.current

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
                    else -> lerp(
                        MaterialTheme.colorScheme.surfaceContainer,
                        Color.Black,
                        state.progress
                    )
                }
            } else {
                when (backgroundStyle) {
                    PlayerBackgroundStyle.TRANSPARENT -> MaterialTheme.colorScheme.surfaceContainer.copy(alpha = 0.95f)
                    else -> MaterialTheme.colorScheme.surfaceContainer
                }
            }
        }
    }

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
                    val palette = withContext(Dispatchers.Default) {
                        Palette.from(bitmap).generate()
                    }
                    val dominantColor = palette.dominantSwatch?.rgb?.let { Color(it) }
                    val vibrantColor = palette.vibrantSwatch?.rgb?.let { Color(it) }

                    if (dominantColor != null && vibrantColor != null) {
                        gradientColors = listOf(vibrantColor, dominantColor)
                    } else {
                        gradientColors = defaultGradientColors
                    }
                }
            } catch (e: Exception) {
                gradientColors = defaultGradientColors
                e.printStackTrace()
            }
        }
    }

    val contentColor = if (backgroundStyle == PlayerBackgroundStyle.BLUR || backgroundStyle == PlayerBackgroundStyle.GRADIENT) {
        Color.White
    } else {
        LocalContentColor.current
    }

    // val playerTextAlignment by rememberEnumPreference(PlayerTextAlignmentKey, defaultValue = PlayerTextAlignment.CENTER)
    val sliderStyle by rememberEnumPreference(SliderStyleKey, defaultValue = SliderStyle.DEFAULT)
    val playbackState by playerConnection.playbackState.collectAsState()
    val isPlaying by playerConnection.isPlaying.collectAsState()
    val repeatMode by playerConnection.repeatMode.collectAsState()
    val currentSong by playerConnection.currentSong.collectAsState(initial = null)
    var showLyrics by rememberPreference(ShowLyricsKey, defaultValue = false)
    val canSkipPrevious by playerConnection.canSkipPrevious.collectAsState()
    val canSkipNext by playerConnection.canSkipNext.collectAsState()
    var position by rememberSaveable(playbackState) { mutableLongStateOf(playerConnection.player.currentPosition) }
    var duration by rememberSaveable(playbackState) { mutableLongStateOf(playerConnection.player.duration) }
    var sliderPosition by remember { mutableStateOf<Long?>(null) }

    LaunchedEffect(playbackState) {
        if (playbackState == Player.STATE_READY) {
            while (isActive) {
                delay(100)
                position = playerConnection.player.currentPosition
                duration = playerConnection.player.duration
            }
        }
    }

    val queueSheetState = rememberBottomSheetState(
        dismissedBound = QueuePeekHeight + WindowInsets.systemBars.asPaddingValues().calculateBottomPadding(),
        expandedBound = state.expandedBound,
    )

    BottomSheet(
        state = state,
        modifier = modifier,
        backgroundColor = backgroundColor,
        onDismiss = {
            playerConnection.player.stop()
            playerConnection.player.clearMediaItems()
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
            Row(
                horizontalArrangement = Arrangement.Start,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = PlayerHorizontalPadding)
            ) {
                Row {
                    Box(
                        modifier = Modifier
                            .weight(1f)
                    ) {
                        Text(
                            text = mediaMetadata.title,
                            style = MaterialTheme.typography.titleLarge,
                            fontWeight = FontWeight.Bold,
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis,
                            modifier = Modifier
                                .basicMarquee(
                                    iterations = 1,
                                    initialDelayMillis = 3000
                                )
                                .clickable(enabled = mediaMetadata.album != null) {
                                    navController.navigate("album/${mediaMetadata.album!!.id}")
                                    state.collapseSoft()
                                }
                        )

                        Row(
                            modifier = Modifier.offset(y = 25.dp)
                        ) {
                            mediaMetadata.artists.fastForEachIndexed { index, artist ->
                                Text(
                                    text = artist.name,
                                    style = MaterialTheme.typography.titleMedium,
                                    maxLines = 1,
                                    modifier = Modifier.clickable(enabled = artist.id != null) {
                                        navController.navigate("artist/${artist.id}")
                                        state.collapseSoft()
                                    }
                                )

                                if (index != mediaMetadata.artists.lastIndex) {
                                    Text(
                                        text = ", ",
                                        style = MaterialTheme.typography.titleMedium,
                                    )
                                }
                            }
                        }
                    }

                    Spacer(modifier = Modifier.width(10.dp))

                    Box(
                        modifier = Modifier
                            .offset(y = 5.dp)
                            .size(36.dp)
                            .clip(RoundedCornerShape(24.dp))
                            .background(MaterialTheme.colorScheme.primary)
                    ) {
                        IconButton(
                            onClick = playerConnection::toggleLike,
                            modifier = Modifier.align(Alignment.Center)
                        ) {
                            Icon(
                                imageVector = if (currentSong?.song?.liked == true) Icons.Filled.Favorite else Icons.Outlined.FavoriteBorder,
                                contentDescription = "Favorite",
                                tint = MaterialTheme.colorScheme.onPrimary,
                                modifier = Modifier.size(24.dp)
                            )
                        }
                    }
                }
            }

            Spacer(Modifier.height(12.dp))

            when (sliderStyle) {
                SliderStyle.DEFAULT -> {
                    Slider(
                        value = (sliderPosition ?: position).toFloat(),
                        valueRange = 0f..(if (duration == C.TIME_UNSET) 0f else duration.toFloat()),
                        onValueChange = {
                            sliderPosition = it.toLong()
                        },
                        onValueChangeFinished = {
                            sliderPosition?.let {
                                playerConnection.player.seekTo(it)
                                position = it
                            }
                            sliderPosition = null
                        },
                        modifier = Modifier.padding(horizontal = PlayerHorizontalPadding)
                    )
                }

                SliderStyle.SQUIGGLY -> {
                    SquigglySlider(
                        value = (sliderPosition ?: position).toFloat(),
                        valueRange = 0f..(if (duration == C.TIME_UNSET) 0f else duration.toFloat()),
                        onValueChange = {
                            sliderPosition = it.toLong()
                        },
                        onValueChangeFinished = {
                            sliderPosition?.let {
                                playerConnection.player.seekTo(it)
                                position = it
                            }
                            sliderPosition = null
                        },
                        squigglesSpec = SquigglySlider.SquigglesSpec(
                            amplitude = if (isPlaying) 2.dp else 0.dp,
                            strokeWidth = 4.dp,
                        ),
                        modifier = Modifier.padding(horizontal = PlayerHorizontalPadding),
                    )
                }
            }
            Spacer(Modifier.height(4.dp))

            Row(
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = PlayerHorizontalPadding + 4.dp)
            ) {
                Text(
                    text = makeTimeString(sliderPosition ?: position),
                    style = MaterialTheme.typography.labelMedium,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                )

                Text(
                    text = if (duration != C.TIME_UNSET) makeTimeString(duration) else "",
                    style = MaterialTheme.typography.labelMedium,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                )
            }

            Spacer(Modifier.height(12.dp))

            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = PlayerHorizontalPadding)
            ) {
                Box(modifier = Modifier.weight(1f)) {
                    IconButton(onClick = { showLyrics = !showLyrics }) {
                        Icon(
                            imageVector = Icons.Rounded.Lyrics,
                            contentDescription = "Lyrics",
                            tint = contentColor,
                            modifier = Modifier.alpha(if (showLyrics) 1f else 0.5f)
                        )
                    }
                }

                Box(modifier = Modifier.weight(1f)) {
                    // MODIFICADO: Reemplazado ResizableIconButton
                    IconButton(
                        onClick = playerConnection::seekToPrevious,
                        enabled = canSkipPrevious,
                        modifier = Modifier.align(Alignment.Center)
                    ) {
                        Icon(
                            imageVector = Icons.Filled.SkipPrevious,
                            contentDescription = "Skip Previous",
                            tint = contentColor,
                            modifier = Modifier.size(32.dp)
                        )
                    }
                }

                Spacer(Modifier.width(8.dp))

                Box(
                    modifier = Modifier
                        .size(72.dp)
                        .clip(RoundedCornerShape(playPauseRoundness))
                        .background(MaterialTheme.colorScheme.secondaryContainer)
                        .clickable {
                            if (playbackState == Player.STATE_ENDED) {
                                playerConnection.player.seekTo(0, 0)
                                playerConnection.player.playWhenReady = true
                            } else {
                                playerConnection.player.togglePlayPause()
                            }
                        }
                ) {
                    // MODIFICADO: Reemplazado Image por Icon
                    val playPauseIcon = when {
                        playbackState == Player.STATE_ENDED -> Icons.Filled.Replay
                        isPlaying -> Icons.Filled.Pause
                        else -> Icons.Filled.PlayArrow
                    }
                    Icon(
                        imageVector = playPauseIcon,
                        contentDescription = "Play/Pause",
                        tint = if (backgroundStyle == PlayerBackgroundStyle.BLUR || backgroundStyle == PlayerBackgroundStyle.GRADIENT) contentColor else MaterialTheme.colorScheme.onSurface,
                        modifier = Modifier
                            .align(Alignment.Center)
                            .size(36.dp)
                    )
                }

                Spacer(Modifier.width(8.dp))

                Box(modifier = Modifier.weight(1f)) {
                    // MODIFICADO: Reemplazado ResizableIconButton
                    IconButton(
                        onClick = playerConnection::seekToNext,
                        enabled = canSkipNext,
                        modifier = Modifier.align(Alignment.Center)
                    ) {
                        Icon(
                            imageVector = Icons.Filled.SkipNext,
                            contentDescription = "Skip Next",
                            tint = contentColor,
                            modifier = Modifier.size(32.dp)
                        )
                    }
                }

                Box(modifier = Modifier.weight(1f)) {
                    IconButton(
                        onClick = playerConnection.player::toggleRepeatMode,
                        modifier = Modifier
                            .align(Alignment.Center)
                            .alpha(if (repeatMode == Player.REPEAT_MODE_OFF) 0.5f else 1f)
                    ) {
                        Icon(
                            imageVector = when (repeatMode) {
                                Player.REPEAT_MODE_ONE -> Icons.Filled.RepeatOne
                                else -> Icons.Filled.Repeat
                            },
                            contentDescription = "Repeat Mode",
                            tint = contentColor,
                            modifier = Modifier
                                .size(32.dp)
                                .padding(4.dp)
                        )
                    }
                }
            }
        }

        Box(modifier = Modifier.fillMaxSize()) {
            when {
                backgroundStyle == PlayerBackgroundStyle.BLUR && mediaMetadata?.thumbnailUrl != null -> {
                    AsyncImage(
                        model = mediaMetadata?.thumbnailUrl,
                        contentDescription = "Blurred background",
                        contentScale = ContentScale.Crop,
                        modifier = Modifier
                            .fillMaxSize()
                            .blur(radius = 25.dp)
                    )
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(Color.Black.copy(alpha = 0.4f))
                    )
                }
                backgroundStyle == PlayerBackgroundStyle.GRADIENT && gradientColors.isNotEmpty() -> {
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(Brush.verticalGradient(colors = gradientColors))
                    )
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(Color.Black.copy(alpha = 0.2f))
                    )
                }
            }

            CompositionLocalProvider(LocalContentColor provides contentColor) {
                when (LocalConfiguration.current.orientation) {
                    Configuration.ORIENTATION_LANDSCAPE -> {
                        Row(
                            modifier = Modifier
                                .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Horizontal))
                                .padding(bottom = queueSheetState.collapsedBound)
                        ) {
                            Box(
                                contentAlignment = Alignment.Center,
                                modifier = Modifier.weight(1f)
                            ) {
                                Thumbnail(
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
                    }

                    else -> { // ORIENTATION_PORTRAIT
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                            modifier = Modifier
                                .windowInsetsPadding(WindowInsets.systemBars.only(WindowInsetsSides.Horizontal))
                                .padding(bottom = queueSheetState.collapsedBound)
                        ) {
                            Box(
                                contentAlignment = Alignment.Center,
                                modifier = Modifier.weight(1f)
                            ) {
                                Thumbnail(
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
            }

            Queue(
                state = queueSheetState,
                playerBottomSheetState = state,
                backgroundColor = MaterialTheme.colorScheme.surfaceContainer.copy(alpha = 0.95f),
                navController = navController,
            )
        }
    }
}