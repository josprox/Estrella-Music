package com.zionhuang.music.ui.screens.playlist

import androidx.activity.compose.BackHandler
import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.animateColorAsState
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
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.listSaver
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
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
import androidx.compose.ui.text.TextRange
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.util.fastAny
import androidx.compose.ui.util.fastForEachReversed
import androidx.compose.ui.util.fastSumBy
import androidx.core.net.toUri
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.media3.exoplayer.offline.Download
import androidx.media3.exoplayer.offline.DownloadRequest
import androidx.media3.exoplayer.offline.DownloadService
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.zionhuang.innertube.YouTube
import com.zionhuang.innertube.models.SongItem
import com.zionhuang.innertube.utils.completed
import com.zionhuang.music.LocalDatabase
import com.zionhuang.music.LocalDownloadUtil
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.constants.*
import com.zionhuang.music.db.entities.Playlist
import com.zionhuang.music.db.entities.PlaylistSong
import com.zionhuang.music.db.entities.PlaylistSongMap
import com.zionhuang.music.extensions.move
import com.zionhuang.music.extensions.toMediaItem
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.models.toMediaMetadata
import com.zionhuang.music.playback.ExoDownloadService
import com.zionhuang.music.playback.queues.ListQueue
import com.zionhuang.music.ui.component.*
import com.zionhuang.music.ui.component.shimmer.ListItemPlaceHolder
import com.zionhuang.music.ui.component.shimmer.ShimmerHost
import com.zionhuang.music.ui.component.shimmer.TextPlaceholder
import com.zionhuang.music.ui.menu.SongMenu
import com.zionhuang.music.ui.menu.SongSelectionMenu
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.makeTimeString
import com.zionhuang.music.utils.rememberEnumPreference
import com.zionhuang.music.utils.rememberPreference
import com.zionhuang.music.viewmodels.LocalPlaylistViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import sh.calvin.reorderable.ReorderableItem
import sh.calvin.reorderable.rememberReorderableLazyListState
import java.time.LocalDateTime

@OptIn(ExperimentalFoundationApi::class, ExperimentalMaterial3Api::class)
@Composable
fun LocalPlaylistScreen(
    navController: NavController,
    viewModel: LocalPlaylistViewModel = hiltViewModel(),
) {
    val haptic = LocalHapticFeedback.current
    val context = LocalContext.current
    val menuState = LocalMenuState.current
    val database = LocalDatabase.current
    val playerConnection = LocalPlayerConnection.current ?: return

    val isPlaying by playerConnection.isPlaying.collectAsState()
    val mediaMetadata by playerConnection.mediaMetadata.collectAsState()

    val playlist by viewModel.playlist.collectAsState()
    val songs by viewModel.playlistSongs.collectAsState()
    val mutableSongs = remember { mutableStateListOf<PlaylistSong>() }

    val (sortType, onSortTypeChange) = rememberEnumPreference(PlaylistSongSortTypeKey, PlaylistSongSortType.CUSTOM)
    val (sortDescending, onSortDescendingChange) = rememberPreference(PlaylistSongSortDescendingKey, true)
    var locked by rememberPreference(PlaylistEditLockKey, defaultValue = true)

    val coroutineScope = rememberCoroutineScope()
    val snackbarHostState = remember { SnackbarHostState() }

    var isSearching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable(stateSaver = TextFieldValue.Saver) { mutableStateOf(TextFieldValue()) }
    val filteredSongs = remember(songs, query) {
        if (query.text.isEmpty()) songs
        else songs.filter { song ->
            song.song.title.contains(query.text, ignoreCase = true) ||
                    song.song.artists.fastAny { it.name.contains(query.text, ignoreCase = true) }
        }
    }
    val focusRequester = remember { FocusRequester() }
    LaunchedEffect(isSearching) { if (isSearching) focusRequester.requestFocus() }
    if (isSearching) { BackHandler { isSearching = false; query = TextFieldValue() } }

    var inSelectMode by rememberSaveable { mutableStateOf(false) }
    val selection = rememberSaveable(
        saver = listSaver<MutableList<Int>, Int>({ it.toList() }, { it.toMutableStateList() })
    ) { mutableStateListOf() }
    val onExitSelectionMode = { inSelectMode = false; selection.clear() }
    if (inSelectMode) { BackHandler(onBack = onExitSelectionMode) }

    LaunchedEffect(songs) {
        mutableSongs.apply { clear(); addAll(songs) }
        selection.fastForEachReversed { mapId -> if (songs.find { it.map.id == mapId } == null) selection.remove(mapId) }
    }

    var showEditDialog by remember { mutableStateOf(false) }
    var showRemoveDownloadDialog by remember { mutableStateOf(false) }
    var showLikeAllDialog by remember { mutableStateOf(false) }
    val msg = stringResource(R.string.songsAddedFavorites)

    if (showEditDialog) {
        playlist?.playlist?.let { playlistEntity ->
            TextFieldDialog(
                icon = { Icon(painter = painterResource(R.drawable.edit), contentDescription = null) },
                title = { Text(text = stringResource(R.string.edit_playlist)) },
                onDismiss = { showEditDialog = false },
                initialTextFieldValue = TextFieldValue(playlistEntity.name, TextRange(playlistEntity.name.length)),
                onDone = { name -> database.query { update(playlistEntity.copy(name = name)) } }
            )
        }
    }
    if (showRemoveDownloadDialog) {
        playlist?.let { playlistData ->
            DefaultDialog(
                onDismiss = { showRemoveDownloadDialog = false },
                content = { Text(text = stringResource(R.string.remove_download_playlist_confirm, playlistData.playlist.name), style = MaterialTheme.typography.bodyLarge, modifier = Modifier.padding(horizontal = 18.dp)) },
                buttons = {
                    TextButton(onClick = { showRemoveDownloadDialog = false }) { Text(text = stringResource(android.R.string.cancel)) }
                    TextButton(onClick = {
                        showRemoveDownloadDialog = false
                        songs.forEach { song -> DownloadService.sendRemoveDownload(context, ExoDownloadService::class.java, song.song.id, false) }
                    }) { Text(text = stringResource(android.R.string.ok)) }
                }
            )
        }
    }

    if (showLikeAllDialog) {
        AlertDialog(
            onDismissRequest = { showLikeAllDialog = false },
            icon = { Icon(Icons.Default.Favorite, contentDescription = null) },
            title = { Text(text=stringResource(R.string.addAllLikeSounds)) },
            text = { Text(text=stringResource(R.string.addAllLikeSoundsDesc)) },
            confirmButton = {
                TextButton(
                    onClick = {
                        coroutineScope.launch(Dispatchers.IO) {
                            database.transaction {
                                songs.forEach { playlistSong ->
                                    val songToUpdate = playlistSong.song.song.copy(
                                        liked = true,
                                        inLibrary = LocalDateTime.now()
                                    )
                                    update(songToUpdate)
                                }
                            }
                            snackbarHostState.showSnackbar(msg)
                        }
                        showLikeAllDialog = false
                    }
                ) {
                    Text(text=stringResource(R.string.accept))
                }
            },
            dismissButton = {
                TextButton(onClick = { showLikeAllDialog = false }) {
                    Text(text = stringResource(R.string.cancel))
                }
            }
        )
    }

    Box(modifier = Modifier.fillMaxSize().background(MaterialTheme.colorScheme.surface)) {
        if (playlist == null) {
            LocalPlaylistScreenSkeleton()
        } else {
            val playlistData = playlist!!

            val onSelectAllClick: (Boolean) -> Unit = { shouldSelectAll ->
                selection.clear()
                if (shouldSelectAll) {
                    selection.addAll(songs.map { it.map.id })
                }
            }
            val onSelectionMenuClick = {
                menuState.show {
                    SongSelectionMenu(
                        selection = selection.mapNotNull { mapId -> songs.find { it.map.id == mapId }?.song },
                        onDismiss = menuState::dismiss,
                        onExitSelectionMode = onExitSelectionMode,
                        onRemoveFromQueue = {
                            val sel = selection.toList()
                            database.transaction {
                                val remainingSongs = songs.filterNot { it.map.id in sel }
                                sel.forEach { mapId -> songs.find { it.map.id == mapId }?.let { delete(it.map) } }
                                remainingSongs.forEachIndexed { newIndex, songToUpdate ->
                                    if (songToUpdate.map.position != newIndex) {
                                        update(songToUpdate.map.copy(position = newIndex))
                                    }
                                }
                            }
                        }
                    )
                }
            }

            BoxWithConstraints {
                val isExpanded = maxWidth > 600.dp

                if (isExpanded) {
                    val lazyListState = rememberLazyListState()
                    var dragInfo by remember { mutableStateOf<Pair<Int, Int>?>(null) }
                    val reorderableState = rememberReorderableLazyListState(lazyListState = lazyListState) { from, to ->
                        val headerItemCount = 1
                        if (to.index >= headerItemCount && from.index >= headerItemCount) {
                            val currentDragInfo = dragInfo
                            val finalFrom = from.index - headerItemCount
                            val finalTo = to.index - headerItemCount

                            dragInfo = if (currentDragInfo == null) finalFrom to finalTo
                            else currentDragInfo.first to finalTo
                            mutableSongs.move(finalFrom, finalTo)
                        }
                    }

                    LaunchedEffect(reorderableState.isAnyItemDragging) {
                        if (!reorderableState.isAnyItemDragging) {
                            dragInfo?.let { (from, to) ->
                                database.transaction { move(viewModel.playlistId, from, to) }
                                dragInfo = null
                            }
                        }
                    }

                    Row(Modifier.fillMaxSize()) {
                        LocalPlaylistLandscapeHeader(
                            playlist = playlistData,
                            songs = songs,
                            modifier = Modifier.weight(0.4f),
                            inSelectMode = inSelectMode,
                            selectionCount = selection.size,
                            allSelected = if (songs.isEmpty()) false else selection.size == songs.size,
                            onNavIconClick = {
                                if (inSelectMode) onExitSelectionMode()
                                else navController.navigateUp()
                            },
                            onSelectAllClick = {
                                selection.clear()
                                if (songs.isNotEmpty() && selection.size != songs.size) {
                                    selection.addAll(songs.map { it.map.id })
                                }
                            },
                            onSelectionMenuClick = onSelectionMenuClick,
                            isSearching = isSearching,
                            query = query,
                            onQueryChange = { query = it },
                            focusRequester = focusRequester,
                            onSearchClose = { isSearching = false; query = TextFieldValue() },
                            onSearchConfirmed = { isSearching = true },
                            onLikeAllClick = { showLikeAllDialog = true } // Pasar la acción
                        )

                        LazyColumn(
                            state = lazyListState,
                            modifier = Modifier.weight(0.6f),
                            contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
                        ) {
                            item {
                                LocalPlaylistActionControls(
                                    playlist = playlistData, songs = songs,
                                    onPlayClick = { playerConnection.playQueue(ListQueue(title = playlistData.playlist.name, items = songs.map { it.song.toMediaItem() })) },
                                    onShuffleClick = { playerConnection.playQueue(ListQueue(title = playlistData.playlist.name, items = songs.shuffled().map { it.song.toMediaItem() })) },
                                    onShowEditDialog = { showEditDialog = true },
                                    onShowRemoveDownloadDialog = { showRemoveDownloadDialog = true },
                                    snackbarHostState = snackbarHostState
                                )
                            }

                            if (playlistData.songCount > 0 && !isSearching) {
                                stickyHeader {
                                    SortAndLockControls(
                                        sortType = sortType, onSortTypeChange = onSortTypeChange,
                                        sortDescending = sortDescending, onSortDescendingChange = onSortDescendingChange,
                                        locked = locked, onLockClick = { locked = !locked }, inSelectMode = inSelectMode
                                    )
                                }
                            }
                            if (playlistData.songCount == 0) {
                                item { EmptyPlaceholder(icon = R.drawable.music_note, text = stringResource(R.string.playlist_is_empty)) }
                            } else {
                                itemsIndexed(items = if (isSearching) filteredSongs else mutableSongs, key = { _, song -> song.map.id }) { index, song ->
                                    ReorderableItem(state = reorderableState, key = song.map.id) {
                                        var dismissJob: Job? by remember { mutableStateOf(null) }
                                        val currentItem by rememberUpdatedState(song)
                                        fun deleteFromPlaylist() {
                                            database.transaction {
                                                move(currentItem.map.playlistId, currentItem.map.position, Int.MAX_VALUE)
                                                delete(currentItem.map.copy(position = Int.MAX_VALUE))
                                            }
                                            dismissJob?.cancel()
                                            dismissJob = coroutineScope.launch {
                                                val result = snackbarHostState.showSnackbar(message = context.getString(R.string.removed_song_from_playlist, currentItem.song.song.title), actionLabel = context.getString(R.string.undo), duration = SnackbarDuration.Short)
                                                if (result == SnackbarResult.ActionPerformed) {
                                                    database.transaction {
                                                        insert(currentItem.map.copy(position = songs.size))
                                                        move(currentItem.map.playlistId, songs.size, currentItem.map.position)
                                                    }
                                                }
                                            }
                                        }
                                        val dismissState = rememberSwipeToDismissBoxState(
                                            positionalThreshold = { it },
                                            confirmValueChange = {
                                                if (it == SwipeToDismissBoxValue.StartToEnd || it == SwipeToDismissBoxValue.EndToStart) deleteFromPlaylist()
                                                true
                                            }
                                        )
                                        val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(song.map.id) else selection.remove(song.map.id) }
                                        val content: @Composable () -> Unit = {
                                            SongListItem(
                                                song = song.song,
                                                isActive = song.song.id == mediaMetadata?.id,
                                                isPlaying = isPlaying,
                                                showInLibraryIcon = true,
                                                trailingContent = {
                                                    if (inSelectMode) {
                                                        Checkbox(checked = song.map.id in selection, onCheckedChange = onCheckedChange)
                                                    } else {
                                                        IconButton(onClick = { menuState.show { SongMenu(originalSong = song.song, navController = navController, onDismiss = menuState::dismiss, onDeleteFromPlaylist = ::deleteFromPlaylist) } }) {
                                                            Icon(painterResource(R.drawable.more_vert), null)
                                                        }
                                                        if (sortType == PlaylistSongSortType.CUSTOM && !locked && !isSearching) {
                                                            IconButton(onClick = {}, modifier = Modifier.draggableHandle()) { Icon(painterResource(R.drawable.drag_handle), null) }
                                                        }
                                                    }
                                                },
                                                modifier = Modifier.fillMaxWidth().combinedClickable(
                                                    onClick = {
                                                        if (inSelectMode) onCheckedChange(song.map.id !in selection)
                                                        else if (song.song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                                        else playerConnection.playQueue(ListQueue(title = playlistData.playlist.name, items = songs.map { it.song.toMediaItem() }, startIndex = songs.indexOfFirst { it.map.id == song.map.id }))
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
                                        if (locked || inSelectMode || isSearching) content()
                                        else SwipeToDismissBox(state = dismissState, backgroundContent = {}, content = { content() })
                                    }
                                }
                            }
                        }
                    }
                } else {
                    val lazyListState = rememberLazyListState()
                    val showTopBarTitle by remember { derivedStateOf { lazyListState.firstVisibleItemIndex > 0 } }
                    var dragInfo by remember { mutableStateOf<Pair<Int, Int>?>(null) }
                    val reorderableState = rememberReorderableLazyListState(lazyListState = lazyListState) { from, to ->
                        val headerItemCount = 2
                        if (to.index >= headerItemCount && from.index >= headerItemCount) {
                            val currentDragInfo = dragInfo
                            dragInfo = if (currentDragInfo == null) (from.index - headerItemCount) to (to.index - headerItemCount)
                            else currentDragInfo.first to (to.index - headerItemCount)
                            mutableSongs.move(from.index - headerItemCount, to.index - headerItemCount)
                        }
                    }
                    LaunchedEffect(reorderableState.isAnyItemDragging) {
                        if (!reorderableState.isAnyItemDragging) {
                            dragInfo?.let { (from, to) ->
                                database.transaction { move(viewModel.playlistId, from, to) }
                                dragInfo = null
                            }
                        }
                    }

                    LazyColumn(
                        state = lazyListState,
                        contentPadding = LocalPlayerAwareWindowInsets.current.union(WindowInsets.ime).asPaddingValues(),
                    ) {
                        item {
                            LocalPlaylistPortraitHeader(
                                playlist = playlistData,
                                songs = songs,
                                listState = lazyListState
                            )
                        }
                        item {
                            LocalPlaylistActionControls(
                                playlist = playlistData, songs = songs,
                                onPlayClick = { playerConnection.playQueue(ListQueue(title = playlistData.playlist.name, items = songs.map { it.song.toMediaItem() })) },
                                onShuffleClick = { playerConnection.playQueue(ListQueue(title = playlistData.playlist.name, items = songs.shuffled().map { it.song.toMediaItem() })) },
                                onShowEditDialog = { showEditDialog = true },
                                onShowRemoveDownloadDialog = { showRemoveDownloadDialog = true },
                                snackbarHostState = snackbarHostState
                            )
                        }
                        if (playlistData.songCount > 0 && !isSearching) {
                            stickyHeader {
                                SortAndLockControls(
                                    sortType = sortType, onSortTypeChange = onSortTypeChange,
                                    sortDescending = sortDescending, onSortDescendingChange = onSortDescendingChange,
                                    locked = locked, onLockClick = { locked = !locked }, inSelectMode = inSelectMode
                                )
                            }
                        }
                        if (playlistData.songCount == 0) {
                            item { EmptyPlaceholder(icon = R.drawable.music_note, text = stringResource(R.string.playlist_is_empty)) }
                        } else {
                            itemsIndexed(items = if (isSearching) filteredSongs else mutableSongs, key = { _, song -> song.map.id }) { index, song ->
                                ReorderableItem(state = reorderableState, key = song.map.id) {
                                    var dismissJob: Job? by remember { mutableStateOf(null) }
                                    val currentItem by rememberUpdatedState(song)
                                    fun deleteFromPlaylist() {
                                        database.transaction {
                                            move(currentItem.map.playlistId, currentItem.map.position, Int.MAX_VALUE)
                                            delete(currentItem.map.copy(position = Int.MAX_VALUE))
                                        }
                                        dismissJob?.cancel()
                                        dismissJob = coroutineScope.launch {
                                            val result = snackbarHostState.showSnackbar(message = context.getString(R.string.removed_song_from_playlist, currentItem.song.song.title), actionLabel = context.getString(R.string.undo), duration = SnackbarDuration.Short)
                                            if (result == SnackbarResult.ActionPerformed) {
                                                database.transaction {
                                                    insert(currentItem.map.copy(position = songs.size))
                                                    move(currentItem.map.playlistId, songs.size, currentItem.map.position)
                                                }
                                            }
                                        }
                                    }
                                    val dismissState = rememberSwipeToDismissBoxState(
                                        positionalThreshold = { it },
                                        confirmValueChange = {
                                            if (it == SwipeToDismissBoxValue.StartToEnd || it == SwipeToDismissBoxValue.EndToStart) deleteFromPlaylist()
                                            true
                                        }
                                    )
                                    val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(song.map.id) else selection.remove(song.map.id) }
                                    val content: @Composable () -> Unit = {
                                        SongListItem(
                                            song = song.song,
                                            isActive = song.song.id == mediaMetadata?.id,
                                            isPlaying = isPlaying,
                                            showInLibraryIcon = true,
                                            trailingContent = {
                                                if (inSelectMode) {
                                                    Checkbox(checked = song.map.id in selection, onCheckedChange = onCheckedChange)
                                                } else {
                                                    IconButton(onClick = { menuState.show { SongMenu(originalSong = song.song, navController = navController, onDismiss = menuState::dismiss, onDeleteFromPlaylist = ::deleteFromPlaylist) } }) {
                                                        Icon(painterResource(R.drawable.more_vert), null)
                                                    }
                                                    if (sortType == PlaylistSongSortType.CUSTOM && !locked && !isSearching) {
                                                        IconButton(onClick = {}, modifier = Modifier.draggableHandle()) { Icon(painterResource(R.drawable.drag_handle), null) }
                                                    }
                                                }
                                            },
                                            modifier = Modifier.fillMaxWidth().combinedClickable(
                                                onClick = {
                                                    if (inSelectMode) onCheckedChange(song.map.id !in selection)
                                                    else if (song.song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                                    else playerConnection.playQueue(ListQueue(title = playlistData.playlist.name, items = songs.map { it.song.toMediaItem() }, startIndex = songs.indexOfFirst { it.map.id == song.map.id }))
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
                                    if (locked || inSelectMode || isSearching) content()
                                    else SwipeToDismissBox(state = dismissState, backgroundContent = {}, content = { content() })
                                }
                            }
                        }
                    }

                    LocalPlaylistCollapsingTopAppBar(
                        playlistName = playlistData.playlist.name,
                        showTitle = showTopBarTitle,
                        inSelectMode = inSelectMode,
                        selectionCount = selection.size,
                        onExitSelectionMode = onExitSelectionMode,
                        isSearching = isSearching,
                        query = query,
                        onQueryChange = { query = it },
                        focusRequester = focusRequester,
                        onSearchClose = { isSearching = false; query = TextFieldValue() },
                        onSearchConfirmed = { isSearching = true },
                        onNavIconClick = { navController.navigateUp() },
                        onNavIconLongClick = { navController.backToMain() },
                        allSelected = if (songs.isEmpty()) false else selection.size == songs.size,
                        onSelectAllClick = onSelectAllClick,
                        onSelectionMenuClick = onSelectionMenuClick,
                        onLikeAllClick = { showLikeAllDialog = true } // Pasar la acción
                    )
                }
            }
        }

        SnackbarHost(
            hostState = snackbarHostState,
            modifier = Modifier.windowInsetsPadding(LocalPlayerAwareWindowInsets.current.union(WindowInsets.ime)).align(Alignment.BottomCenter)
        )
    }
}

// --- COMPONENTES AUXILIARES ---

@Composable
private fun PlaylistThumbnail(playlist: Playlist, modifier: Modifier = Modifier) {
    Box(
        modifier = modifier.background(MaterialTheme.colorScheme.surfaceColorAtElevation(4.dp)),
        contentAlignment = Alignment.Center
    ) {
        if (playlist.thumbnails.isEmpty()) {
            Icon(painterResource(R.drawable.music_note), null, modifier = Modifier.size(80.dp), tint = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.3f))
        } else if (playlist.thumbnails.size < 4) {
            AsyncImage(model = playlist.thumbnails[0], contentDescription = null, contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
        } else {
            Row(modifier = Modifier.fillMaxSize()) {
                Column(modifier = Modifier.weight(1f)) {
                    AsyncImage(model = playlist.thumbnails[0], null, Modifier.weight(1f).fillMaxWidth(), contentScale = ContentScale.Crop)
                    AsyncImage(model = playlist.thumbnails[2], null, Modifier.weight(1f).fillMaxWidth(), contentScale = ContentScale.Crop)
                }
                Column(modifier = Modifier.weight(1f)) {
                    AsyncImage(model = playlist.thumbnails[1], null, Modifier.weight(1f).fillMaxWidth(), contentScale = ContentScale.Crop)
                    AsyncImage(model = playlist.thumbnails[3], null, Modifier.weight(1f).fillMaxWidth(), contentScale = ContentScale.Crop)
                }
            }
        }
    }
}

@Composable
private fun LocalPlaylistPortraitHeader(
    playlist: Playlist, songs: List<PlaylistSong>, listState: LazyListState
) {
    val scrollOffset = if (listState.firstVisibleItemIndex == 0) listState.firstVisibleItemScrollOffset.toFloat() else Float.MAX_VALUE
    val headerHeightPx = with(LocalDensity.current) { 320.dp.toPx() }
    val imageTranslationY = -scrollOffset * 0.2f
    val textAlpha = (1f - (scrollOffset / (headerHeightPx / 2))).coerceIn(0f, 1f)
    val playlistLength = remember(songs) { songs.fastSumBy { it.song.song.duration } }

    Column(
        modifier = Modifier.fillMaxWidth().height(320.dp).graphicsLayer { translationY = imageTranslationY },
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        PlaylistThumbnail(
            playlist = playlist,
            modifier = Modifier.size(200.dp).clip(RoundedCornerShape(12.dp)).shadow(16.dp, RoundedCornerShape(12.dp))
        )
        Spacer(Modifier.height(16.dp))
        Column(
            modifier = Modifier.graphicsLayer { alpha = textAlpha },
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(playlist.playlist.name, style = MaterialTheme.typography.headlineSmall, fontWeight = FontWeight.Bold, maxLines = 1, overflow = TextOverflow.Ellipsis, color = MaterialTheme.colorScheme.primary)
            Text(
                text = "${pluralStringResource(R.plurals.n_song, playlist.songCount, playlist.songCount)} • ${makeTimeString(playlistLength * 1000L)}",
                style = MaterialTheme.typography.bodyLarge, color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}

@Composable
private fun LocalPlaylistLandscapeHeader(
    playlist: Playlist, songs: List<PlaylistSong>, modifier: Modifier = Modifier,
    inSelectMode: Boolean, selectionCount: Int, allSelected: Boolean, onNavIconClick: () -> Unit,
    onSelectAllClick: () -> Unit, onSelectionMenuClick: () -> Unit, isSearching: Boolean,
    query: TextFieldValue, onQueryChange: (TextFieldValue) -> Unit, focusRequester: FocusRequester,
    onSearchClose: () -> Unit, onSearchConfirmed: () -> Unit, onLikeAllClick: () -> Unit
) {
    val playlistLength = remember(songs) { songs.fastSumBy { it.song.song.duration } }

    Column(
        modifier = modifier.fillMaxHeight().padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        PlaylistActionBar(
            inSelectMode = inSelectMode, selectionCount = selectionCount, allSelected = allSelected,
            onNavIconClick = onNavIconClick, onSelectAllClick = onSelectAllClick,
            onSelectionMenuClick = onSelectionMenuClick, isSearching = isSearching, query = query,
            onQueryChange = onQueryChange, focusRequester = focusRequester,
            onSearchClose = onSearchClose, onSearchConfirmed = onSearchConfirmed,
            onLikeAllClick = onLikeAllClick
        )

        Column(
            modifier = Modifier.weight(1f).verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            PlaylistThumbnail(
                playlist = playlist,
                modifier = Modifier.fillMaxWidth(0.5f).aspectRatio(1f).clip(RoundedCornerShape(12.dp)).shadow(8.dp, RoundedCornerShape(12.dp))
            )
            Spacer(Modifier.height(24.dp))
            Text(
                text = playlist.playlist.name, style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold, textAlign = TextAlign.Center, color = MaterialTheme.colorScheme.primary
            )
            Text(
                text = "${pluralStringResource(R.plurals.n_song, playlist.songCount, playlist.songCount)} • ${makeTimeString(playlistLength * 1000L)}",
                style = MaterialTheme.typography.bodyLarge, color = MaterialTheme.colorScheme.onSurfaceVariant, textAlign = TextAlign.Center
            )
        }
    }
}

@Composable
private fun LocalPlaylistActionControls(
    playlist: Playlist, songs: List<PlaylistSong>, onPlayClick: () -> Unit, onShuffleClick: () -> Unit,
    onShowEditDialog: () -> Unit, onShowRemoveDownloadDialog: () -> Unit,
    snackbarHostState: SnackbarHostState
) {
    val context = LocalContext.current
    val database = LocalDatabase.current
    val scope = rememberCoroutineScope()
    val playerConnection = LocalPlayerConnection.current!!
    val downloadUtil = LocalDownloadUtil.current
    var downloadState by remember { mutableStateOf(Download.STATE_STOPPED) }

    LaunchedEffect(songs) {
        if (songs.isEmpty()) return@LaunchedEffect
        downloadUtil.downloads.collect { downloads ->
            downloadState = if (songs.all { downloads[it.song.id]?.state == Download.STATE_COMPLETED }) Download.STATE_COMPLETED
            else if (songs.any { downloads[it.song.id]?.state == Download.STATE_DOWNLOADING || downloads[it.song.id]?.state == Download.STATE_QUEUED }) Download.STATE_DOWNLOADING
            else Download.STATE_STOPPED
        }
    }

    Row(
        modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Row(horizontalArrangement = Arrangement.spacedBy(4.dp)) {
            IconButton(onClick = onShowEditDialog) { Icon(painterResource(R.drawable.edit), stringResource(id = R.string.edit)) }
            if (playlist.playlist.browseId != null) {
                IconButton(onClick = {
                    scope.launch(Dispatchers.IO) {
                        val playlistPage = YouTube.playlist(playlist.playlist.browseId!!).completed().getOrNull() ?: return@launch
                        database.transaction {
                            clearPlaylist(playlist.id)
                            playlistPage.songs.map(SongItem::toMediaMetadata).onEach(::insert).mapIndexed { position, song ->
                                PlaylistSongMap(songId = song.id, playlistId = playlist.id, position = position)
                            }.forEach(::insert)
                        }
                        snackbarHostState.showSnackbar(context.getString(R.string.playlist_synced))
                    }
                }) { Icon(painterResource(R.drawable.sync), stringResource(id = R.string.sync)) }
            }
            when (downloadState) {
                Download.STATE_COMPLETED -> IconButton(onClick = onShowRemoveDownloadDialog) { Icon(painterResource(R.drawable.offline), stringResource(R.string.remove_download), tint = MaterialTheme.colorScheme.primary) }
                Download.STATE_DOWNLOADING -> IconButton(onClick = { songs.forEach { DownloadService.sendRemoveDownload(context, ExoDownloadService::class.java, it.song.id, false) } }) {
                    CircularProgressIndicator(Modifier.size(24.dp), strokeWidth = 2.dp)
                }
                else -> IconButton(onClick = {
                    songs.forEach {
                        val request = DownloadRequest.Builder(it.song.id, it.song.id.toUri()).setCustomCacheKey(it.song.id).setData(it.song.song.title.toByteArray()).build()
                        DownloadService.sendAddDownload(context, ExoDownloadService::class.java, request, false)
                    }
                }) { Icon(painterResource(R.drawable.download), stringResource(id = R.string.download)) }
            }
            IconButton(onClick = { playerConnection.addToQueue(items = songs.map { it.song.toMediaItem() }) }) { Icon(painterResource(R.drawable.queue_music), stringResource(R.string.add_to_queue)) }
        }
        Row(verticalAlignment = Alignment.CenterVertically) {
            FloatingActionButton(onClick = onShuffleClick, elevation = FloatingActionButtonDefaults.elevation(0.dp, 0.dp), modifier = Modifier.size(48.dp)) { Icon(painterResource(R.drawable.shuffle), stringResource(id = R.string.shuffle)) }
            Spacer(Modifier.width(16.dp))
            FloatingActionButton(onClick = onPlayClick) { Icon(painterResource(R.drawable.play), stringResource(id = R.string.play)) }
        }
    }
}

@Composable
private fun SortAndLockControls(
    sortType: PlaylistSongSortType, onSortTypeChange: (PlaylistSongSortType) -> Unit,
    sortDescending: Boolean, onSortDescendingChange: (Boolean) -> Unit,
    locked: Boolean, onLockClick: () -> Unit, inSelectMode: Boolean
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = Modifier
            .fillMaxWidth()
            .background(MaterialTheme.colorScheme.surfaceColorAtElevation(3.dp))
            .padding(horizontal = 16.dp, vertical = 4.dp)
    ) {
        SortHeader(
            sortType = sortType, sortDescending = sortDescending,
            onSortTypeChange = onSortTypeChange, onSortDescendingChange = onSortDescendingChange,
            sortTypeText = {
                when (it) {
                    PlaylistSongSortType.CUSTOM -> R.string.sort_by_custom
                    PlaylistSongSortType.CREATE_DATE -> R.string.sort_by_create_date
                    PlaylistSongSortType.NAME -> R.string.sort_by_name
                    PlaylistSongSortType.ARTIST -> R.string.sort_by_artist
                    PlaylistSongSortType.PLAY_TIME -> R.string.sort_by_play_time
                }
            },
            modifier = Modifier.weight(1f)
        )
        if (!inSelectMode && sortType == PlaylistSongSortType.CUSTOM) {
            IconButton(onClick = onLockClick, modifier = Modifier.padding(horizontal = 6.dp)) {
                Icon(painterResource(if (locked) R.drawable.lock else R.drawable.lock_open), null)
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun LocalPlaylistCollapsingTopAppBar(
    playlistName: String, showTitle: Boolean,
    inSelectMode: Boolean, selectionCount: Int, onExitSelectionMode: () -> Unit,
    isSearching: Boolean, query: TextFieldValue, onQueryChange: (TextFieldValue) -> Unit, focusRequester: FocusRequester,
    onSearchClose: () -> Unit, onSearchConfirmed: () -> Unit,
    onNavIconClick: () -> Unit, onNavIconLongClick: () -> Unit,
    allSelected: Boolean, onSelectAllClick: (Boolean) -> Unit, onSelectionMenuClick: () -> Unit,
    onLikeAllClick: () -> Unit
) {
    val animatedColor by animateColorAsState(if (showTitle || inSelectMode || isSearching) MaterialTheme.colorScheme.surfaceColorAtElevation(3.dp).copy(alpha = 0.95f) else Color.Transparent, label = "TopBarColor")

    TopAppBar(
        modifier = Modifier.background(animatedColor),
        colors = TopAppBarDefaults.topAppBarColors(containerColor = Color.Transparent),
        title = {
            when {
                inSelectMode -> Text(pluralStringResource(R.plurals.n_selected, selectionCount, selectionCount))
                isSearching -> TextField(
                    value = query, onValueChange = onQueryChange,
                    placeholder = { Text(stringResource(R.string.search_in_playlist), style = MaterialTheme.typography.titleLarge, color = MaterialTheme.colorScheme.primary) },
                    singleLine = true, textStyle = MaterialTheme.typography.titleLarge.copy(color = MaterialTheme.colorScheme.primary),
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Search),
                    colors = TextFieldDefaults.colors(
                        focusedContainerColor = Color.Transparent, unfocusedContainerColor = Color.Transparent,
                        focusedIndicatorColor = Color.Transparent, unfocusedIndicatorColor = Color.Transparent
                    ),
                    modifier = Modifier.fillMaxWidth().focusRequester(focusRequester)
                )
                showTitle -> Text(playlistName, maxLines = 1, overflow = TextOverflow.Ellipsis, color = MaterialTheme.colorScheme.primary)
            }
        },
        navigationIcon = {
            val navIcon = if (inSelectMode || isSearching) R.drawable.close else R.drawable.arrow_back
            IconButton(
                onClick = { when { inSelectMode -> onExitSelectionMode(); isSearching -> onSearchClose(); else -> onNavIconClick() } },
                onLongClick = { if (!inSelectMode && !isSearching) onNavIconLongClick() }
            ) { Icon(painterResource(navIcon), null) }
        },
        actions = {
            when {
                inSelectMode -> {
                    Checkbox(checked = allSelected, onCheckedChange = onSelectAllClick)
                    IconButton(enabled = selectionCount > 0, onClick = onSelectionMenuClick) {
                        Icon(painterResource(R.drawable.more_vert), null)
                    }
                }
                !isSearching -> {
                    IconButton(onClick = onLikeAllClick) { Icon(Icons.Default.Favorite, null) }
                    IconButton(onClick = onSearchConfirmed) { Icon(painterResource(R.drawable.search), null) }
                }
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PlaylistActionBar(
    modifier: Modifier = Modifier, inSelectMode: Boolean, selectionCount: Int, allSelected: Boolean,
    onNavIconClick: () -> Unit, onSelectAllClick: () -> Unit, onSelectionMenuClick: () -> Unit,
    isSearching: Boolean, query: TextFieldValue, onQueryChange: (TextFieldValue) -> Unit,
    focusRequester: FocusRequester, onSearchClose: () -> Unit, onSearchConfirmed: () -> Unit,
    onLikeAllClick: () -> Unit
) {
    AnimatedContent(
        targetState = when { inSelectMode -> "select"; isSearching -> "search"; else -> "normal" },
        label = "ActionBarAnimation",
        modifier = modifier.fillMaxWidth().height(56.dp)
    ) { mode ->
        when (mode) {
            "select" -> {
                Row(modifier = Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    IconButton(onClick = onNavIconClick) { Icon(painterResource(R.drawable.close), null) }
                    Spacer(Modifier.width(8.dp))
                    Text(text = pluralStringResource(R.plurals.n_selected, selectionCount, selectionCount), modifier = Modifier.weight(1f))
                    Checkbox(checked = allSelected, onCheckedChange = { onSelectAllClick() })
                    IconButton(enabled = selectionCount > 0, onClick = onSelectionMenuClick) { Icon(painterResource(R.drawable.more_vert), null) }
                }
            }
            "search" -> {
                Row(modifier = Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    IconButton(onClick = onSearchClose) { Icon(Icons.AutoMirrored.Filled.ArrowBack, null) }
                    TextField(
                        value = query,
                        onValueChange = onQueryChange,
                        placeholder = { Text(stringResource(R.string.search_in_playlist), color = MaterialTheme.colorScheme.primary) },
                        singleLine = true,
                        textStyle = LocalTextStyle.current.copy(color = MaterialTheme.colorScheme.primary),
                        keyboardOptions = KeyboardOptions(imeAction = ImeAction.Search),
                        colors = TextFieldDefaults.colors(
                            focusedContainerColor = Color.Transparent, unfocusedContainerColor = Color.Transparent,
                            focusedIndicatorColor = Color.Transparent, unfocusedIndicatorColor = Color.Transparent
                        ),
                        modifier = Modifier.fillMaxWidth().focusRequester(focusRequester)
                    )
                }
            }
            else -> {
                Row(modifier = Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.SpaceBetween) {
                    TextButton(onClick = onNavIconClick) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = stringResource(R.string.back))
                        Spacer(Modifier.width(8.dp))
                        Text(stringResource(R.string.back))
                    }
                    Row {
                        IconButton(onClick = onLikeAllClick) { Icon(Icons.Default.Favorite, null) }
                        IconButton(onClick = onSearchConfirmed) { Icon(painterResource(R.drawable.search), null) }
                    }
                }
            }
        }
    }
}

@Composable
private fun LocalPlaylistScreenSkeleton() {
    BoxWithConstraints {
        val isExpanded = maxWidth > 600.dp
        if (isExpanded) {
            ShimmerHost {
                Row(Modifier.fillMaxSize()) {
                    Column(
                        modifier = Modifier.weight(0.4f).fillMaxHeight().padding(16.dp),
                        horizontalAlignment = Alignment.CenterHorizontally,
                    ) {
                        Row(modifier = Modifier.fillMaxWidth().height(56.dp), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                            Spacer(modifier = Modifier.size(width = 80.dp, height = 32.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                            Row {
                                Spacer(modifier = Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                Spacer(modifier = Modifier.width(8.dp))
                                Spacer(modifier = Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                            }
                        }
                        Column(modifier = Modifier.weight(1f), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
                            Spacer(modifier = Modifier.fillMaxWidth(0.5f).aspectRatio(1f).clip(RoundedCornerShape(12.dp)).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                            Spacer(Modifier.height(24.dp))
                            TextPlaceholder()
                            Spacer(Modifier.height(8.dp))
                            TextPlaceholder()
                        }
                    }
                    LazyColumn(modifier = Modifier.weight(0.6f), contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()) {
                        item {
                            Row(modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp), verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.SpaceBetween) {
                                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                                    repeat(4) { Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f))) }
                                }
                                Row(horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
                                    Spacer(Modifier.size(48.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                    Spacer(Modifier.size(56.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                                }
                            }
                        }
                        items(7) { ListItemPlaceHolder(modifier = Modifier.padding(horizontal = 8.dp)) }
                    }
                }
            }
        } else {
            ShimmerHost {
                LazyColumn(contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()) {
                    item {
                        Column(
                            modifier = Modifier.fillMaxWidth().height(320.dp),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.Center
                        ) {
                            Spacer(Modifier.size(200.dp).clip(RoundedCornerShape(12.dp)).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                            Spacer(Modifier.height(16.dp))
                            TextPlaceholder()
                            Spacer(Modifier.height(8.dp))
                            TextPlaceholder()
                        }
                    }
                    item {
                        Row(
                            modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp),
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.SpaceBetween
                        ) {
                            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                                repeat(4) { Spacer(Modifier.size(24.dp).clip(CircleShape).background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f))) }
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