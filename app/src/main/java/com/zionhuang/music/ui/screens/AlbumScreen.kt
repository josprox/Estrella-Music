package com.zionhuang.music.ui.screens

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.drawable.BitmapDrawable
import androidx.activity.compose.BackHandler
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
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
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

/**
 * Función auxiliar para extraer de forma asíncrona el color dominante de una URL de imagen.
 * No altera ninguna lógica, solo es una herramienta visual.
 */
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
fun AlbumScreen(
    navController: NavController,
    viewModel: AlbumViewModel = hiltViewModel(),
) {
    // --- LÓGICA ORIGINAL (INTACTA) ---
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

    val listState = rememberLazyListState()

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

    // --- NUEVOS ESTADOS DE UI ---
    val defaultColor = MaterialTheme.colorScheme.surface
    var dominantColor by remember { mutableStateOf(defaultColor) }
    val animatedBackgroundColor by animateColorAsState(dominantColor, tween(500))

    LaunchedEffect(albumWithSongs?.album?.thumbnailUrl) {
        dominantColor = fetchDominantColor(context, albumWithSongs?.album?.thumbnailUrl, defaultColor)
    }

    val showTopBarTitle by remember {
        derivedStateOf { listState.firstVisibleItemIndex > 0 }
    }

    // --- NUEVA ESTRUCTURA DE UI ---
    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Brush.verticalGradient(listOf(animatedBackgroundColor.copy(alpha = 0.4f), MaterialTheme.colorScheme.surface)))
    ) {
        val albumData = albumWithSongs

        // Ahora el Shimmer/Skeleton vive en su propio Composable para mayor claridad.
        if (albumData == null || albumData.songs.isEmpty()) {
            AlbumScreenSkeleton()
        } else {
            // El contenido principal de la pantalla
            LazyColumn(
                state = listState,
                contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
            ) {
                // Cabecera del Álbum
                item {
                    AlbumHeader(
                        albumEntity = albumData.album,
                        artists = albumData.artists,
                        navController = navController,
                        listState = listState
                    )
                }

                // Controles de Acción (Play, Shuffle, Like, etc.)
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

                // Lista de canciones (lógica de click y menú intacta)
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

                // Otras versiones
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

        // --- Barra de Título Personalizada que se superpone ---
        CollapsingTopAppBar(
            albumTitle = albumWithSongs?.album?.title.orEmpty(),
            showTitle = showTopBarTitle,
            inSelectMode = inSelectMode,
            selectionCount = selection.size,
            allSelected = albumWithSongs?.songs?.size == selection.size,
            backgroundColor = animatedBackgroundColor,
            onNavIconClick = {
                if (inSelectMode) onExitSelectionMode()
                else navController.navigateUp()
            },
            onNavIconLongClick = { if (!inSelectMode) navController.backToMain() },
            onSelectAllClick = {
                albumWithSongs?.let {
                    if (selection.size == it.songs.size) selection.clear()
                    else selection.addAll(it.songs.indices)
                }
            },
            onSelectionMenuClick = {
                menuState.show {
                    SongSelectionMenu(
                        selection = selection.mapNotNull { albumWithSongs?.songs?.getOrNull(it) },
                        onDismiss = menuState::dismiss,
                        onExitSelectionMode = onExitSelectionMode
                    )
                }
            }
        )
    }
}


// --- NUEVOS COMPONENTES DE UI ---

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
                overflow = TextOverflow.Ellipsis
            )
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
                    color = MaterialTheme.colorScheme.onSurfaceVariant
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
                Text(albumTitle, maxLines = 1, overflow = TextOverflow.Ellipsis)
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

/**
 * Un esqueleto de carga que imita la nueva UI de la pantalla del álbum.
 */
@Composable
private fun AlbumScreenSkeleton() {
    ShimmerHost {
        // Usamos LazyColumn para que el comportamiento del scroll sea consistente
        // con la pantalla cargada, especialmente en dispositivos pequeños.
        LazyColumn(
            contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
        ) {
            // Placeholder para AlbumHeader
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
                    TextPlaceholder() // Title
                    Spacer(Modifier.height(8.dp))
                    TextPlaceholder() // Artist
                }
            }

            // Placeholder para ActionControls
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

            // Placeholders para la lista de canciones
            items(7) {
                ListItemPlaceHolder(modifier = Modifier.padding(horizontal = 8.dp))
            }
        }
    }
}