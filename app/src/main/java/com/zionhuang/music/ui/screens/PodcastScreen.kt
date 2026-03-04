package com.zionhuang.music.ui.screens

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.drawable.BitmapDrawable
import androidx.activity.compose.BackHandler
import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.listSaver
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.hapticfeedback.HapticFeedbackType
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalHapticFeedback
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.pluralStringResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.LinkAnnotation
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.text.withLink
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import androidx.palette.graphics.Palette
import coil.compose.AsyncImage
import coil.request.ImageRequest
import coil.size.Size
import com.zionhuang.innertube.models.PodcastItem
import com.zionhuang.innertube.models.EpisodeItem
import com.zionhuang.innertube.models.WatchEndpoint
import com.zionhuang.music.LocalDatabase
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.constants.AppBarHeight
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.models.toMediaMetadata
import com.zionhuang.music.playback.queues.YouTubeQueue
import com.zionhuang.music.ui.component.PetalAdsBanner
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.LocalMenuState
import com.zionhuang.music.ui.component.YouTubeListItem
import com.zionhuang.music.ui.component.shimmer.ListItemPlaceHolder
import com.zionhuang.music.ui.component.shimmer.ShimmerHost
import com.zionhuang.music.ui.component.shimmer.TextPlaceholder
import com.zionhuang.music.ui.menu.YouTubePlaylistMenu
import com.zionhuang.music.ui.menu.YouTubeSongMenu
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.viewmodels.PodcastViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import com.zionhuang.music.constants.ModernDesignKey
import com.zionhuang.music.utils.rememberPreference

private suspend fun fetchDominantColor(context: Context, imageUrl: String?, defaultColor: Color): Color {
    if (imageUrl == null) return defaultColor
    return try {
        val request = ImageRequest.Builder(context)
            .data(imageUrl).size(Size(128, 128)).allowHardware(false)
            .build()
        val bitmap = (coil.ImageLoader(context).execute(request).drawable as? BitmapDrawable)?.bitmap
        bitmap?.let {
            withContext(Dispatchers.Default) { Palette.from(it).generate() }
                .getDominantColor(androidx.core.graphics.ColorUtils.setAlphaComponent(defaultColor.hashCode(), 0))
                .let { colorInt -> Color(colorInt) }
        } ?: defaultColor
    } catch (e: Exception) {
        defaultColor
    }
}

@OptIn(ExperimentalFoundationApi::class, ExperimentalMaterial3Api::class)
@Composable
fun PodcastScreen(
    navController: NavController,
    viewModel: PodcastViewModel = hiltViewModel(),
) {
    val haptic = LocalHapticFeedback.current
    val context = LocalContext.current
    val menuState = LocalMenuState.current
    val database = LocalDatabase.current
    val playerConnection = LocalPlayerConnection.current ?: return
    val isPlaying by playerConnection.isPlaying.collectAsState()
    val mediaMetadata by playerConnection.mediaMetadata.collectAsState()
    val podcastPage by viewModel.podcastPage.collectAsState()
    val modernDesign by rememberPreference(ModernDesignKey, defaultValue = true)

    var inSelectMode by rememberSaveable { mutableStateOf(false) }
    val selection = rememberSaveable(
        saver = listSaver<MutableList<Int>, Int>(save = { it.toList() }, restore = { it.toMutableStateList() })
    ) { mutableStateListOf() }
    val onExitSelectionMode = {
        inSelectMode = false
        selection.clear()
    }
    if (inSelectMode) {
        BackHandler(onBack = onExitSelectionMode)
    }

    val defaultColor = MaterialTheme.colorScheme.surface
    var dominantColor by remember { mutableStateOf(defaultColor) }
    val animatedBackgroundColor by animateColorAsState(dominantColor, tween(500), label = "background_color")

    LaunchedEffect(podcastPage?.podcast?.thumbnail) {
        dominantColor = fetchDominantColor(context, podcastPage?.podcast?.thumbnail, defaultColor)
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Brush.verticalGradient(listOf(animatedBackgroundColor.copy(alpha = 0.4f), MaterialTheme.colorScheme.surface)))
    ) {
        if (podcastPage == null) {
            PodcastScreenSkeleton()
        } else {
            val page = podcastPage!!
            BoxWithConstraints {
                val isExpanded = maxWidth > 600.dp

                if (isExpanded) {
                    Row(Modifier.fillMaxSize()) {
                        PodcastLandscapeHeader(
                            podcast = page.podcast,
                            navController = navController,
                            modifier = Modifier.weight(0.4f),
                            inSelectMode = inSelectMode,
                            selectionCount = selection.size,
                            allSelected = page.episodes.size == selection.size,
                            onNavIconClick = {
                                if (inSelectMode) onExitSelectionMode()
                                else navController.navigateUp()
                            },
                            onSelectAllClick = {
                                if (selection.size == page.episodes.size) selection.clear()
                                else selection.addAll(page.episodes.indices)
                            }
                        )

                        LazyColumn(
                            state = rememberLazyListState(),
                            modifier = Modifier.weight(0.6f),
                            contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
                        ) {
                            item {
                                PodcastActionControls(
                                    podcast = page.podcast,
                                    onPlayClick = {
                                        playerConnection.playQueue(YouTubeQueue(page.podcast.playEndpoint ?: WatchEndpoint(playlistId = page.podcast.id)))
                                    },
                                    onShuffleClick = {
                                        playerConnection.playQueue(YouTubeQueue(page.podcast.shuffleEndpoint ?: WatchEndpoint(playlistId = page.podcast.id, params = "wAEB")))
                                    },
                                    onMenuClick = {
                                        menuState.show {
                                            YouTubePlaylistMenu(
                                                playlist = page.podcast.asPlaylistItem(),
                                                coroutineScope = rememberCoroutineScope(),
                                                onDismiss = menuState::dismiss
                                            )
                                        }
                                    }
                                )
                            }
                            item {
                                PetalAdsBanner(
                                    modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp)
                                )
                            }
                            itemsIndexed(items = page.episodes, key = { _, episode -> episode.id }) { index, episode ->
                                val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(index) else selection.remove(index) }
                                YouTubeListItem(
                                    item = episode,
                                    isActive = episode.id == mediaMetadata?.id,
                                    isPlaying = isPlaying,
                                    trailingContent = {
                                        if (inSelectMode) {
                                            Checkbox(checked = index in selection, onCheckedChange = onCheckedChange)
                                        } else {
                                            IconButton(onClick = {
                                                menuState.show {
                                                    YouTubeSongMenu(
                                                        song = episode.asSongItem(),
                                                        navController = navController,
                                                        onDismiss = menuState::dismiss
                                                    )
                                                }
                                            }) {
                                                Icon(painterResource(R.drawable.more_vert), null)
                                            }
                                        }
                                    },
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .combinedClickable(
                                            onClick = {
                                                if (inSelectMode) onCheckedChange(index !in selection)
                                                else if (episode.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                                else playerConnection.playQueue(YouTubeQueue(episode.endpoint ?: WatchEndpoint(videoId = episode.id), episode.asSongItem().toMediaMetadata()))
                                            },
                                            onLongClick = {
                                                if (!inSelectMode) {
                                                    haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                    inSelectMode = true
                                                    onCheckedChange(true)
                                                }
                                            }
                                        )
                                )
                            }
                        }
                    }
                } else {
                    val portraitListState = rememberLazyListState()
                    LazyColumn(
                        state = portraitListState,
                        contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
                    ) {
                        item {
                            PodcastHeader(
                                podcast = page.podcast,
                                navController = navController,
                                listState = portraitListState
                            )
                        }
                        item {
                            PodcastActionControls(
                                podcast = page.podcast,
                                onPlayClick = {
                                    playerConnection.playQueue(YouTubeQueue(page.podcast.playEndpoint ?: WatchEndpoint(playlistId = page.podcast.id)))
                                },
                                onShuffleClick = {
                                    playerConnection.playQueue(YouTubeQueue(page.podcast.shuffleEndpoint ?: WatchEndpoint(playlistId = page.podcast.id, params = "wAEB")))
                                },
                                onMenuClick = {
                                    menuState.show {
                                        YouTubePlaylistMenu(
                                            playlist = page.podcast.asPlaylistItem(),
                                            coroutineScope = rememberCoroutineScope(),
                                            onDismiss = menuState::dismiss
                                        )
                                    }
                                }
                            )
                        }
                        item(key = "ad_banner") {
                            PetalAdsBanner(modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp))
                        }
                        itemsIndexed(items = page.episodes, key = { _, episode -> episode.id }) { index, episode ->
                            val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(index) else selection.remove(index) }
                            YouTubeListItem(
                                item = episode,
                                isActive = episode.id == mediaMetadata?.id,
                                isPlaying = isPlaying,
                                trailingContent = {
                                    if (inSelectMode) {
                                        Checkbox(checked = index in selection, onCheckedChange = onCheckedChange)
                                    } else {
                                        IconButton(onClick = {
                                            menuState.show {
                                                YouTubeSongMenu(
                                                    song = episode.asSongItem(),
                                                    navController = navController,
                                                    onDismiss = menuState::dismiss
                                                )
                                            }
                                        }) {
                                            Icon(painterResource(R.drawable.more_vert), null)
                                        }
                                    }
                                },
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .combinedClickable(
                                        onClick = {
                                            if (inSelectMode) onCheckedChange(index !in selection)
                                            else if (episode.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                            else playerConnection.playQueue(YouTubeQueue(episode.endpoint ?: WatchEndpoint(videoId = episode.id), episode.asSongItem().toMediaMetadata()))
                                        },
                                        onLongClick = {
                                            if (!inSelectMode) {
                                                haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                inSelectMode = true
                                                onCheckedChange(true)
                                            }
                                        }
                                    )
                            )
                        }
                    }
                    val showTopBarTitle by remember {
                        derivedStateOf { portraitListState.firstVisibleItemIndex > 0 }
                    }
                    PodcastCollapsingTopAppBar(
                        podcastTitle = page.podcast.title,
                        showTitle = showTopBarTitle,
                        inSelectMode = inSelectMode,
                        selectionCount = selection.size,
                        allSelected = page.episodes.size == selection.size,
                        backgroundColor = animatedBackgroundColor,
                        onNavIconClick = {
                            if (inSelectMode) onExitSelectionMode()
                            else navController.navigateUp()
                        },
                        onNavIconLongClick = { if (!inSelectMode) navController.backToMain() },
                        onSelectAllClick = {
                            if (selection.size == page.episodes.size) selection.clear()
                            else selection.addAll(page.episodes.indices)
                        }
                    )
                }
            }
        }
    }
}

@Composable
private fun PodcastLandscapeHeader(
    podcast: PodcastItem,
    navController: NavController,
    modifier: Modifier = Modifier,
    inSelectMode: Boolean,
    selectionCount: Int,
    allSelected: Boolean,
    onNavIconClick: () -> Unit,
    onSelectAllClick: () -> Unit,
) {
    Column(
        modifier = modifier
            .fillMaxHeight()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(onClick = onNavIconClick) {
                Icon(painterResource(if (inSelectMode) R.drawable.close else R.drawable.arrow_back), null)
            }
            if (inSelectMode) {
                Spacer(Modifier.width(8.dp))
                Text(
                    text = pluralStringResource(R.plurals.n_selected, selectionCount, selectionCount),
                    modifier = Modifier.weight(1f)
                )
                Checkbox(checked = allSelected, onCheckedChange = { onSelectAllClick() })
            }
        }

        Column(
            modifier = Modifier
                .weight(1f)
                .verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            AsyncImage(
                model = podcast.thumbnail,
                contentDescription = "Podcast Art",
                contentScale = ContentScale.Crop,
                modifier = Modifier
                    .fillMaxWidth(0.5f)
                    .aspectRatio(1f)
                    .clip(RoundedCornerShape(12.dp))
                    .shadow(elevation = 8.dp, shape = RoundedCornerShape(12.dp))
            )
            Spacer(Modifier.height(24.dp))
            Text(
                text = podcast.title,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center,
                maxLines = 3,
                overflow = TextOverflow.Ellipsis,
                color = MaterialTheme.colorScheme.primary
            )
            Spacer(Modifier.height(8.dp))
            podcast.author?.let { author ->
                Text(
                    text = buildAnnotatedString {
                        val link = LinkAnnotation.Clickable(author.id ?: "") { 
                            if (author.id != null) navController.navigate("artist/${author.id}") 
                        }
                        withLink(link) { withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(author.name) } }
                    },
                    style = MaterialTheme.typography.bodyLarge,
                    textAlign = TextAlign.Center,
                    maxLines = 3,
                    overflow = TextOverflow.Ellipsis
                )
            }
            podcast.episodeCountText?.let {
                Spacer(Modifier.height(4.dp))
                Text(
                    text = it,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.primary
                )
            }
        }
    }
}

@SuppressLint("FrequentlyChangedStateReadInComposition")
@Composable
private fun PodcastHeader(
    podcast: PodcastItem,
    navController: NavController,
    listState: LazyListState
) {
    val scrollOffset = listState.firstVisibleItemScrollOffset.toFloat()
    val headerHeightPx = with(LocalDensity.current) { 300.dp.toPx() }

    val imageTranslationY = -scrollOffset * 0.2f
    val textAlpha = (1f - (scrollOffset / (headerHeightPx / 2))).coerceIn(0f, 1f)

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .height(300.dp)
            .graphicsLayer { translationY = imageTranslationY },
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        AsyncImage(
            model = podcast.thumbnail,
            contentDescription = "Podcast Art",
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .size(200.dp)
                .clip(RoundedCornerShape(12.dp))
                .shadow(elevation = 16.dp, shape = RoundedCornerShape(12.dp))
        )

        Spacer(Modifier.height(16.dp))

        Column(
            modifier = Modifier.graphicsLayer { alpha = textAlpha },
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = podcast.title,
                style = MaterialTheme.typography.headlineSmall,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                color = MaterialTheme.colorScheme.primary
            )
            podcast.author?.let { author ->
                Text(
                    text = buildAnnotatedString {
                        val link = LinkAnnotation.Clickable(author.id ?: "") { 
                            if (author.id != null) navController.navigate("artist/${author.id}") 
                        }
                        withLink(link) { withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(author.name) } }
                    },
                    style = MaterialTheme.typography.bodyLarge,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
            }
            podcast.episodeCountText?.let {
                Text(
                    text = it,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.primary
                )
            }
        }
    }
}

@Composable
private fun PodcastActionControls(
    podcast: PodcastItem,
    onPlayClick: () -> Unit,
    onShuffleClick: () -> Unit,
    onMenuClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Row {
            IconButton(onClick = onMenuClick) {
                Icon(painterResource(R.drawable.more_vert), "More options")
            }
        }

        Row {
            FloatingActionButton(
                onClick = onShuffleClick,
                elevation = FloatingActionButtonDefaults.elevation(0.dp, 0.dp),
                modifier = Modifier.size(48.dp)
            ) {
                Icon(painterResource(R.drawable.shuffle), null)
            }
            Spacer(Modifier.width(16.dp))
            FloatingActionButton(onClick = onPlayClick) {
                Icon(painterResource(R.drawable.play), null)
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PodcastCollapsingTopAppBar(
    podcastTitle: String,
    showTitle: Boolean,
    inSelectMode: Boolean,
    selectionCount: Int,
    allSelected: Boolean,
    backgroundColor: Color,
    onNavIconClick: () -> Unit,
    onNavIconLongClick: () -> Unit,
    onSelectAllClick: () -> Unit,
) {
    val animatedColor by animateColorAsState(
        targetValue = if (showTitle || inSelectMode) backgroundColor.copy(alpha = 0.8f) else Color.Transparent,
        label = "TopBarColorAnim"
    )

    TopAppBar(
        modifier = Modifier.background(animatedColor),
        title = {
            if (showTitle && !inSelectMode) {
                Text(
                    podcastTitle,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    color = MaterialTheme.colorScheme.primary
                )
            }
            if (inSelectMode) {
                Text(pluralStringResource(R.plurals.n_selected, selectionCount, selectionCount))
            }
        },
        navigationIcon = {
            IconButton(onClick = onNavIconClick, onLongClick = onNavIconLongClick) {
                Icon(painterResource(if (inSelectMode) R.drawable.close else R.drawable.arrow_back), null)
            }
        },
        actions = {
            if (inSelectMode) {
                Checkbox(checked = allSelected, onCheckedChange = { onSelectAllClick() })
            }
        },
        colors = TopAppBarDefaults.topAppBarColors(containerColor = Color.Transparent)
    )
}

@Composable
private fun PodcastScreenSkeleton() {
    ShimmerHost {
        LazyColumn(contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()) {
            item {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(300.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center
                ) {
                    Spacer(
                        modifier = Modifier
                            .size(200.dp)
                            .clip(RoundedCornerShape(12.dp))
                            .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f))
                    )
                    Spacer(Modifier.height(16.dp))
                    TextPlaceholder()
                    Spacer(Modifier.height(8.dp))
                    TextPlaceholder()
                }
            }
            item {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 16.dp, vertical = 8.dp),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                    Row(horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
                        Spacer(Modifier.size(48.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                        Spacer(Modifier.size(56.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                    }
                }
            }
            items(7) {
                ListItemPlaceHolder(modifier = Modifier.padding(horizontal = 8.dp))
            }
        }
    }
}
