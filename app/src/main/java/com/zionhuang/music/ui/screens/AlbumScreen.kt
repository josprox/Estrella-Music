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
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
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
import androidx.compose.ui.util.fastForEachIndexed
import androidx.core.net.toUri
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.media3.exoplayer.offline.Download
import androidx.media3.exoplayer.offline.DownloadRequest
import androidx.media3.exoplayer.offline.DownloadService
import androidx.navigation.NavController
import androidx.palette.graphics.Palette
import coil.compose.AsyncImage
import coil.request.ImageRequest
import coil.size.Size
import com.zionhuang.music.LocalDatabase
import com.zionhuang.music.LocalDownloadUtil
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.db.entities.Album
import com.zionhuang.music.db.entities.AlbumEntity
import com.zionhuang.music.db.entities.ArtistEntity
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.playback.ExoDownloadService
import com.zionhuang.music.playback.queues.LocalAlbumRadio
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.LocalMenuState
import com.zionhuang.music.ui.component.NavigationTitle
import com.zionhuang.music.ui.component.SongListItem
import com.zionhuang.music.ui.component.YouTubeGridItem
import com.zionhuang.music.ui.component.shimmer.ListItemPlaceHolder
import com.zionhuang.music.ui.component.shimmer.ShimmerHost
import com.zionhuang.music.ui.component.shimmer.TextPlaceholder
import com.zionhuang.music.ui.menu.AlbumMenu
import com.zionhuang.music.ui.menu.SongMenu
import com.zionhuang.music.ui.menu.SongSelectionMenu
import com.zionhuang.music.ui.menu.YouTubeAlbumMenu
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.viewmodels.AlbumViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

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


@OptIn(ExperimentalFoundationApi::class)
@Composable
fun AlbumScreen(
    navController: NavController,
    viewModel: AlbumViewModel = hiltViewModel(),
) {
    val haptic = LocalHapticFeedback.current
    val context = LocalContext.current
    val menuState = LocalMenuState.current
    val database = LocalDatabase.current
    val playerConnection = LocalPlayerConnection.current ?: return
    val scope = rememberCoroutineScope()
    val isPlaying by playerConnection.isPlaying.collectAsState()
    val mediaMetadata by playerConnection.mediaMetadata.collectAsState()
    val albumWithSongs by viewModel.albumWithSongs.collectAsState()
    val otherVersions by viewModel.otherVersions.collectAsState()

    var downloadState by remember { mutableIntStateOf(Download.STATE_STOPPED) }
    val downloadUtil = LocalDownloadUtil.current

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

    LaunchedEffect(albumWithSongs) {
        val songs = albumWithSongs?.songs?.map { it.id }
        if (songs.isNullOrEmpty()) return@LaunchedEffect
        downloadUtil.downloads.collect { downloads ->
            downloadState =
                if (songs.all { downloads[it]?.state == Download.STATE_COMPLETED }) Download.STATE_COMPLETED
                else if (songs.any { it in downloads && (downloads[it]!!.state == Download.STATE_QUEUED || downloads[it]!!.state == Download.STATE_DOWNLOADING) }) Download.STATE_DOWNLOADING
                else Download.STATE_STOPPED
        }
    }

    val defaultColor = MaterialTheme.colorScheme.surface
    var dominantColor by remember { mutableStateOf(defaultColor) }
    val animatedBackgroundColor by animateColorAsState(dominantColor, tween(500))

    LaunchedEffect(albumWithSongs?.album?.thumbnailUrl) {
        dominantColor = fetchDominantColor(context, albumWithSongs?.album?.thumbnailUrl, defaultColor)
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Brush.verticalGradient(listOf(animatedBackgroundColor.copy(alpha = 0.4f), MaterialTheme.colorScheme.surface)))
    ) {
        val albumData = albumWithSongs

        if (albumData == null || albumData.songs.isEmpty()) {
            AlbumScreenSkeleton()
        } else {
            BoxWithConstraints {
                val isExpanded = maxWidth > 600.dp

                if (isExpanded) {
                    Row(Modifier.fillMaxSize()) {
                        LandscapeHeader(
                            albumEntity = albumData.album,
                            artists = albumData.artists,
                            navController = navController,
                            modifier = Modifier.weight(0.4f),
                            inSelectMode = inSelectMode,
                            selectionCount = selection.size,
                            allSelected = albumData.songs.size == selection.size,
                            onNavIconClick = {
                                if (inSelectMode) onExitSelectionMode()
                                else navController.navigateUp()
                            },
                            onSelectAllClick = {
                                if (selection.size == albumData.songs.size) selection.clear()
                                else selection.addAll(albumData.songs.indices)
                            },
                            onSelectionMenuClick = {
                                menuState.show {
                                    SongSelectionMenu(
                                        selection = selection.mapNotNull { albumData.songs.getOrNull(it) },
                                        onDismiss = menuState::dismiss,
                                        onExitSelectionMode = onExitSelectionMode
                                    )
                                }
                            }
                        )

                        LazyColumn(
                            state = rememberLazyListState(),
                            modifier = Modifier.weight(0.6f),
                            contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
                        ) {
                            item {
                                ActionControls(
                                    downloadState = downloadState,
                                    isLiked = albumData.album.bookmarkedAt != null,
                                    onPlayClick = { playerConnection.playQueue(LocalAlbumRadio(albumData)) },
                                    onShuffleClick = { playerConnection.playQueue(LocalAlbumRadio(albumData.copy(songs = albumData.songs.shuffled()))) },
                                    onLikeClick = { database.query { update(albumData.album.toggleLike()) } },
                                    onDownloadClick = {
                                        albumData.songs.forEach { song ->
                                            val request = DownloadRequest.Builder(song.id, song.id.toUri()).setCustomCacheKey(song.id).setData(song.song.title.toByteArray()).build()
                                            DownloadService.sendAddDownload(context, ExoDownloadService::class.java, request, false)
                                        }
                                    },
                                    onRemoveDownloadClick = {
                                        albumData.songs.forEach { song ->
                                            DownloadService.sendRemoveDownload(context, ExoDownloadService::class.java, song.id, false)
                                        }
                                    },
                                    onMenuClick = {
                                        menuState.show {
                                            AlbumMenu(
                                                originalAlbum = Album(albumData.album, albumData.artists),
                                                navController = navController,
                                                onDismiss = menuState::dismiss
                                            )
                                        }
                                    }
                                )
                            }
                            itemsIndexed(items = albumData.songs, key = { _, song -> song.id }) { index, song ->
                                val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(index) else selection.remove(index) }
                                SongListItem(
                                    song = song,
                                    albumIndex = index + 1,
                                    isActive = song.id == mediaMetadata?.id,
                                    isPlaying = isPlaying,
                                    showInLibraryIcon = true,
                                    trailingContent = {
                                        if (inSelectMode) {
                                            Checkbox(checked = index in selection, onCheckedChange = onCheckedChange)
                                        } else {
                                            IconButton(onClick = { menuState.show { SongMenu(originalSong = song, navController = navController, onDismiss = menuState::dismiss) } }) {
                                                Icon(painterResource(R.drawable.more_vert), null)
                                            }
                                        }
                                    },
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .combinedClickable(
                                            onClick = {
                                                if (inSelectMode) onCheckedChange(index !in selection)
                                                else if (song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                                else playerConnection.playQueue(LocalAlbumRadio(albumData, startIndex = index))
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
                            if (otherVersions.isNotEmpty()) {
                                item { NavigationTitle(title = stringResource(R.string.other_versions)) }
                                item {
                                    LazyRow(contentPadding = PaddingValues(horizontal = 16.dp)) {
                                        items(items = otherVersions, key = { it.id }) { item ->
                                            YouTubeGridItem(
                                                item = item,
                                                isActive = mediaMetadata?.album?.id == item.id,
                                                isPlaying = isPlaying,
                                                coroutineScope = scope,
                                                modifier = Modifier.combinedClickable(
                                                    onClick = { navController.navigate("album/${item.id}") },
                                                    onLongClick = {
                                                        haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                        menuState.show {
                                                            YouTubeAlbumMenu(albumItem = item, navController = navController, onDismiss = menuState::dismiss)
                                                        }
                                                    },
                                                ).animateItem()
                                            )
                                        }
                                    }
                                }
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
                            AlbumHeader(
                                albumEntity = albumData.album,
                                artists = albumData.artists,
                                navController = navController,
                                listState = portraitListState
                            )
                        }
                        item {
                            ActionControls(
                                downloadState = downloadState,
                                isLiked = albumData.album.bookmarkedAt != null,
                                onPlayClick = { playerConnection.playQueue(LocalAlbumRadio(albumData)) },
                                onShuffleClick = { playerConnection.playQueue(LocalAlbumRadio(albumData.copy(songs = albumData.songs.shuffled()))) },
                                onLikeClick = { database.query { update(albumData.album.toggleLike()) } },
                                onDownloadClick = {
                                    albumData.songs.forEach { song ->
                                        val request = DownloadRequest.Builder(song.id, song.id.toUri()).setCustomCacheKey(song.id).setData(song.song.title.toByteArray()).build()
                                        DownloadService.sendAddDownload(context, ExoDownloadService::class.java, request, false)
                                    }
                                },
                                onRemoveDownloadClick = {
                                    albumData.songs.forEach { song ->
                                        DownloadService.sendRemoveDownload(context, ExoDownloadService::class.java, song.id, false)
                                    }
                                },
                                onMenuClick = {
                                    menuState.show {
                                        AlbumMenu(
                                            originalAlbum = Album(albumData.album, albumData.artists),
                                            navController = navController,
                                            onDismiss = menuState::dismiss
                                        )
                                    }
                                }
                            )
                        }
                        itemsIndexed(items = albumData.songs, key = { _, song -> song.id }) { index, song ->
                            val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(index) else selection.remove(index) }
                            SongListItem(
                                song = song,
                                albumIndex = index + 1,
                                isActive = song.id == mediaMetadata?.id,
                                isPlaying = isPlaying,
                                showInLibraryIcon = true,
                                trailingContent = {
                                    if (inSelectMode) {
                                        Checkbox(checked = index in selection, onCheckedChange = onCheckedChange)
                                    } else {
                                        IconButton(onClick = { menuState.show { SongMenu(originalSong = song, navController = navController, onDismiss = menuState::dismiss) } }) {
                                            Icon(painterResource(R.drawable.more_vert), null)
                                        }
                                    }
                                },
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .combinedClickable(
                                        onClick = {
                                            if (inSelectMode) onCheckedChange(index !in selection)
                                            else if (song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                            else playerConnection.playQueue(LocalAlbumRadio(albumData, startIndex = index))
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
                        if (otherVersions.isNotEmpty()) {
                            item { NavigationTitle(title = stringResource(R.string.other_versions)) }
                            item {
                                LazyRow(contentPadding = PaddingValues(horizontal = 16.dp)) {
                                    items(items = otherVersions, key = { it.id }) { item ->
                                        YouTubeGridItem(
                                            item = item,
                                            isActive = mediaMetadata?.album?.id == item.id,
                                            isPlaying = isPlaying,
                                            coroutineScope = scope,
                                            modifier = Modifier.combinedClickable(
                                                onClick = { navController.navigate("album/${item.id}") },
                                                onLongClick = {
                                                    haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                    menuState.show {
                                                        YouTubeAlbumMenu(albumItem = item, navController = navController, onDismiss = menuState::dismiss)
                                                    }
                                                },
                                            ).animateItem()
                                        )
                                    }
                                }
                            }
                        }
                    }
                    val showTopBarTitle by remember {
                        derivedStateOf { portraitListState.firstVisibleItemIndex > 0 }
                    }
                    CollapsingTopAppBar(
                        albumTitle = albumData.album.title,
                        showTitle = showTopBarTitle,
                        inSelectMode = inSelectMode,
                        selectionCount = selection.size,
                        allSelected = albumData.songs.size == selection.size,
                        backgroundColor = animatedBackgroundColor,
                        onNavIconClick = {
                            if (inSelectMode) onExitSelectionMode()
                            else navController.navigateUp()
                        },
                        onNavIconLongClick = { if (!inSelectMode) navController.backToMain() },
                        onSelectAllClick = {
                            if (selection.size == albumData.songs.size) selection.clear()
                            else selection.addAll(albumData.songs.indices)
                        },
                        onSelectionMenuClick = {
                            menuState.show {
                                SongSelectionMenu(
                                    selection = selection.mapNotNull { albumData.songs.getOrNull(it) },
                                    onDismiss = menuState::dismiss,
                                    onExitSelectionMode = onExitSelectionMode
                                )
                            }
                        }
                    )
                }
            }
        }
    }
}


@Composable
private fun LandscapeHeader(
    albumEntity: AlbumEntity,
    artists: List<ArtistEntity>,
    navController: NavController,
    modifier: Modifier = Modifier,
    inSelectMode: Boolean,
    selectionCount: Int,
    allSelected: Boolean,
    onNavIconClick: () -> Unit,
    onSelectAllClick: () -> Unit,
    onSelectionMenuClick: () -> Unit,
) {
    Column(
        modifier = modifier
            .fillMaxHeight()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        LandscapeActionBar(
            inSelectMode = inSelectMode,
            selectionCount = selectionCount,
            allSelected = allSelected,
            onNavIconClick = onNavIconClick,
            onSelectAllClick = onSelectAllClick,
            onSelectionMenuClick = onSelectionMenuClick
        )

        Column(
            modifier = Modifier
                .weight(1f)
                .verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            AsyncImage(
                model = albumEntity.thumbnailUrl,
                contentDescription = "Album Art",
                contentScale = ContentScale.Crop,
                modifier = Modifier
                    .fillMaxWidth(0.8f)
                    .aspectRatio(1f)
                    .clip(RoundedCornerShape(12.dp))
                    .shadow(elevation = 8.dp, shape = RoundedCornerShape(12.dp))
            )
            Spacer(Modifier.height(24.dp))
            Text(
                text = albumEntity.title,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center,
                maxLines = 3,
                overflow = TextOverflow.Ellipsis,
                // MODIFICADO: Color primario del tema
                color = MaterialTheme.colorScheme.primary
            )
            Spacer(Modifier.height(8.dp))
            // MODIFICADO: El texto de los artistas ya usaba el color primario, lo mantenemos.
            Text(
                text = buildAnnotatedString {
                    artists.fastForEachIndexed { index, artist ->
                        val link = LinkAnnotation.Clickable(artist.id) { navController.navigate("artist/${artist.id}") }
                        withLink(link) { withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(artist.name) } }
                        if (index < artists.lastIndex) append(", ")
                    }
                },
                style = MaterialTheme.typography.bodyLarge,
                textAlign = TextAlign.Center,
                maxLines = 3,
                overflow = TextOverflow.Ellipsis
            )
            albumEntity.year?.let {
                Spacer(Modifier.height(4.dp))
                Text(
                    text = it.toString(),
                    style = MaterialTheme.typography.bodyMedium,
                    // MODIFICADO: Color primario del tema
                    color = MaterialTheme.colorScheme.primary
                )
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun LandscapeActionBar(
    inSelectMode: Boolean,
    selectionCount: Int,
    allSelected: Boolean,
    onNavIconClick: () -> Unit,
    onSelectAllClick: () -> Unit,
    onSelectionMenuClick: () -> Unit,
) {
    AnimatedContent(
        targetState = inSelectMode,
        label = "ActionBarAnimation",
        modifier = Modifier
            .fillMaxWidth()
            .height(56.dp)
    ) { mode ->
        if (mode) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = onNavIconClick) {
                    Icon(painterResource(R.drawable.close), null)
                }
                Spacer(Modifier.width(8.dp))
                Text(
                    text = pluralStringResource(R.plurals.n_selected, selectionCount, selectionCount),
                    modifier = Modifier.weight(1f)
                )
                Checkbox(checked = allSelected, onCheckedChange = { onSelectAllClick() })
                IconButton(enabled = selectionCount > 0, onClick = onSelectionMenuClick) {
                    Icon(painterResource(R.drawable.more_vert), null)
                }
            }
        } else {
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically
            ) {
                TextButton(onClick = onNavIconClick) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                        contentDescription = stringResource(R.string.back)
                    )
                    Spacer(Modifier.width(8.dp))
                    Text(stringResource(id = R.string.back))
                }
            }
        }
    }
}

@SuppressLint("FrequentlyChangedStateReadInComposition")
@OptIn(ExperimentalFoundationApi::class)
@Composable
private fun AlbumHeader(
    albumEntity: AlbumEntity,
    artists: List<ArtistEntity>,
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
            model = albumEntity.thumbnailUrl,
            contentDescription = "Album Art",
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
                text = albumEntity.title,
                style = MaterialTheme.typography.headlineSmall,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                // MODIFICADO: Color primario del tema
                color = MaterialTheme.colorScheme.primary
            )
            // MODIFICADO: El texto de los artistas ya usaba el color primario, lo mantenemos.
            Text(
                text = buildAnnotatedString {
                    artists.fastForEachIndexed { index, artist ->
                        val link = LinkAnnotation.Clickable(artist.id) { navController.navigate("artist/${artist.id}") }
                        withLink(link) { withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(artist.name) } }
                        if (index < artists.lastIndex) append(", ")
                    }
                },
                style = MaterialTheme.typography.bodyLarge,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
            albumEntity.year?.let {
                Text(
                    text = it.toString(),
                    style = MaterialTheme.typography.bodyMedium,
                    // MODIFICADO: Color primario del tema
                    color = MaterialTheme.colorScheme.primary
                )
            }
        }
    }
}


@Composable
private fun ActionControls(
    downloadState: Int,
    isLiked: Boolean,
    onPlayClick: () -> Unit,
    onShuffleClick: () -> Unit,
    onLikeClick: () -> Unit,
    onDownloadClick: () -> Unit,
    onRemoveDownloadClick: () -> Unit,
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
            IconButton(onClick = onLikeClick) {
                Icon(
                    painter = painterResource(if (isLiked) R.drawable.favorite else R.drawable.favorite_border),
                    contentDescription = "Like",
                    tint = if (isLiked) MaterialTheme.colorScheme.error else LocalContentColor.current
                )
            }
            when (downloadState) {
                Download.STATE_COMPLETED -> IconButton(onClick = onRemoveDownloadClick) {
                    Icon(painterResource(R.drawable.offline), "Downloaded", tint = MaterialTheme.colorScheme.primary)
                }
                Download.STATE_DOWNLOADING -> IconButton(onClick = onRemoveDownloadClick) {
                    CircularProgressIndicator(Modifier.size(24.dp), strokeWidth = 2.dp)
                }
                else -> IconButton(onClick = onDownloadClick) {
                    Icon(painterResource(R.drawable.download), "Download")
                }
            }
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
private fun CollapsingTopAppBar(
    albumTitle: String,
    showTitle: Boolean,
    inSelectMode: Boolean,
    selectionCount: Int,
    allSelected: Boolean,
    backgroundColor: Color,
    onNavIconClick: () -> Unit,
    onNavIconLongClick: () -> Unit,
    onSelectAllClick: () -> Unit,
    onSelectionMenuClick: () -> Unit,
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
                    albumTitle,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    // MODIFICADO: Color primario del tema
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
                IconButton(enabled = selectionCount > 0, onClick = onSelectionMenuClick) {
                    Icon(painterResource(R.drawable.more_vert), null)
                }
            }
        },
        colors = TopAppBarDefaults.topAppBarColors(containerColor = Color.Transparent)
    )
}

@Composable
private fun AlbumScreenSkeleton() {
    BoxWithConstraints {
        val isExpanded = maxWidth > 600.dp
        if (isExpanded) {
            ShimmerHost {
                Row(Modifier.fillMaxSize()) {
                    Column(
                        modifier = Modifier
                            .weight(0.4f)
                            .fillMaxHeight()
                            .padding(16.dp),
                        horizontalAlignment = Alignment.CenterHorizontally,
                    ) {
                        Row(modifier = Modifier
                            .fillMaxWidth()
                            .height(56.dp)) {
                            Spacer(
                                modifier = Modifier
                                    .size(width = 80.dp, height = 32.dp)
                                    .clip(CircleShape)
                                    .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f))
                            )
                        }
                        Column(
                            modifier = Modifier.weight(1f),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.Center
                        ) {
                            Spacer(
                                modifier = Modifier
                                    .fillMaxWidth(0.8f)
                                    .aspectRatio(1f)
                                    .clip(RoundedCornerShape(12.dp))
                                    .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f))
                            )
                            Spacer(Modifier.height(16.dp))
                            TextPlaceholder()
                            Spacer(Modifier.height(8.dp))
                            TextPlaceholder()
                        }
                    }
                    LazyColumn(modifier = Modifier.weight(0.6f), contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()) {
                        item {
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(horizontal = 16.dp, vertical = 8.dp),
                                verticalAlignment = Alignment.CenterVertically,
                                horizontalArrangement = Arrangement.SpaceBetween
                            ) {
                                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                                    Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                    Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                    Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                }
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
        } else {
            ShimmerHost {
                LazyColumn(
                    contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
                ) {
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
                            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                                Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                            }
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
    }
}