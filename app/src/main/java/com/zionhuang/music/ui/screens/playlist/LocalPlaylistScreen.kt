package com.zionhuang.music.ui.screens.playlist

import androidx.activity.compose.BackHandler
import androidx.compose.animation.animateColorAsState
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.asPaddingValues
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.ime
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.union
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.windowInsetsPadding
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
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.FloatingActionButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.SwipeToDismissBox
import androidx.compose.material3.SwipeToDismissBoxValue
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.rememberSwipeToDismissBoxState
import androidx.compose.material3.surfaceColorAtElevation
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.saveable.listSaver
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.runtime.toMutableStateList
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
import com.zionhuang.music.constants.PlaylistEditLockKey
import com.zionhuang.music.constants.PlaylistSongSortDescendingKey
import com.zionhuang.music.constants.PlaylistSongSortType
import com.zionhuang.music.constants.PlaylistSongSortTypeKey
import com.zionhuang.music.db.entities.Playlist
import com.zionhuang.music.db.entities.PlaylistSong
import com.zionhuang.music.db.entities.PlaylistSongMap
import com.zionhuang.music.extensions.move
import com.zionhuang.music.extensions.toMediaItem
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.models.toMediaMetadata
import com.zionhuang.music.playback.ExoDownloadService
import com.zionhuang.music.playback.queues.ListQueue
import com.zionhuang.music.ui.component.PetalAdsBanner
import com.zionhuang.music.ui.component.DefaultDialog
import com.zionhuang.music.ui.component.EmptyPlaceholder
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.LocalMenuState
import com.zionhuang.music.ui.component.SongListItem
import com.zionhuang.music.ui.component.SortHeader
import com.zionhuang.music.ui.component.TextFieldDialog
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
    // --- LÓGICA Y ESTADO ORIGINAL (100% INTACTO) ---
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

    val lazyListState = rememberLazyListState()
    var dragInfo by remember { mutableStateOf<Pair<Int, Int>?>(null) }
    val reorderableState = rememberReorderableLazyListState(
        lazyListState = lazyListState,
        scrollThresholdPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
    ) { from, to ->
        val headerItemCount = if (isSearching) 2 else 3 // Adaptación para el conteo de headers
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

    val showTopBarTitle by remember { derivedStateOf { lazyListState.firstVisibleItemIndex > 0 } }
    var dismissJob: Job? by remember { mutableStateOf(null) }
    var showEditDialog by remember { mutableStateOf(false) }
    var showRemoveDownloadDialog by remember { mutableStateOf(false) }
    var showLikeAllDialog by remember { mutableStateOf(false) }
    // --- FIN DE LÓGICA Y ESTADO ORIGINAL ---


    // --- DIÁLOGOS (LÓGICA INTACTA Y AÑADIDA) ---
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
        DefaultDialog(
            onDismiss = { showRemoveDownloadDialog = false },
            content = { Text(text = stringResource(R.string.remove_download_playlist_confirm, playlist!!.playlist.name), style = MaterialTheme.typography.bodyLarge, modifier = Modifier.padding(horizontal = 18.dp)) },
            buttons = {
                TextButton(onClick = { showRemoveDownloadDialog = false }) { Text(text = stringResource(android.R.string.cancel)) }
                TextButton(onClick = {
                    showRemoveDownloadDialog = false
                    songs.forEach { song -> DownloadService.sendRemoveDownload(context, ExoDownloadService::class.java, song.song.id, false) }
                }) { Text(text = stringResource(android.R.string.ok)) }
            }
        )
    }

    if (showLikeAllDialog) {
        AlertDialog(
            onDismissRequest = { showLikeAllDialog = false },
            icon = { Icon(Icons.Default.Favorite, contentDescription = null) },
            title = { Text(text = stringResource(R.string.addAllLikeSounds)) },
            text = { Text(text = stringResource(R.string.addAllLikeSoundsDesc)) },
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
                            snackbarHostState.showSnackbar(context.getString(R.string.songsAddedFavorites))
                        }
                        showLikeAllDialog = false
                    }
                ) {
                    Text(text = stringResource(android.R.string.ok))
                }
            },
            dismissButton = {
                TextButton(onClick = { showLikeAllDialog = false }) {
                    Text(text = stringResource(android.R.string.cancel))
                }
            }
        )
    }

    // --- ESTRUCTURA VISUAL ---
    Box(modifier = Modifier
        .fillMaxSize()
        .background(MaterialTheme.colorScheme.surface)) {
        if (playlist == null) {
            LocalPlaylistScreenSkeleton()
        } else {
            // ================== INICIO DE LA MODIFICACIÓN ==================
            BoxWithConstraints {
                val isExpanded = maxWidth > 600.dp

                if (isExpanded) {
                    // --- DISEÑO HORIZONTAL (TABLET/TV) ---
                    Row(Modifier.fillMaxSize()) {
                        LocalPlaylistLandscapeHeader(
                            playlist = playlist!!,
                            songs = songs,
                            modifier = Modifier.weight(0.4f),
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
                            onSelectAllClick = { shouldSelectAll ->
                                selection.clear()
                                if (shouldSelectAll) {
                                    selection.addAll(songs.map { it.map.id })
                                }
                            },
                            onSelectionMenuClick = {
                                menuState.show {
                                    SongSelectionMenu(
                                        selection = selection.mapNotNull { mapId -> songs.find { it.map.id == mapId }?.song },
                                        onDismiss = menuState::dismiss,
                                        onExitSelectionMode = onExitSelectionMode,
                                        onRemoveFromQueue = {
                                            // Lógica de borrado (sin cambios)
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
                            },
                            onLikeAllClick = { showLikeAllDialog = true }
                        )

                        LazyColumn(
                            state = lazyListState,
                            modifier = Modifier.weight(0.6f),
                            contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues(),
                        ) {
                            item {
                                LocalPlaylistActionControls(
                                    playlist = playlist!!,
                                    songs = songs,
                                    onPlayClick = { playerConnection.playQueue(ListQueue(title = playlist!!.playlist.name, items = songs.map { it.song.toMediaItem() })) },
                                    onShuffleClick = { playerConnection.playQueue(ListQueue(title = playlist!!.playlist.name, items = songs.shuffled().map { it.song.toMediaItem() })) },
                                    onShowEditDialog = { showEditDialog = true },
                                    onShowRemoveDownloadDialog = { showRemoveDownloadDialog = true },
                                    snackbarHostState = snackbarHostState
                                )
                            }
                            item(key = "ad_banner") {
                                PetalAdsBanner(modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp))
                            }
                            if (playlist!!.songCount > 0 && !isSearching) {
                                stickyHeader {
                                    SortAndLockControls(
                                        sortType = sortType, onSortTypeChange = onSortTypeChange,
                                        sortDescending = sortDescending, onSortDescendingChange = onSortDescendingChange,
                                        locked = locked, onLockClick = { locked = !locked }, inSelectMode = inSelectMode
                                    )
                                }
                            }
                            if (playlist!!.songCount == 0) {
                                item { EmptyPlaceholder(icon = R.drawable.music_note, text = stringResource(R.string.playlist_is_empty)) }
                            } else {
                                itemsIndexed(items = if (isSearching) filteredSongs else mutableSongs, key = { _, song -> song.map.id }) { index, song ->
                                    // El contenido del item es idéntico al de la vista vertical
                                    ReorderableItem(state = reorderableState, key = song.map.id) {
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
                                                modifier = Modifier
                                                    .fillMaxWidth()
                                                    .combinedClickable(
                                                        onClick = {
                                                            if (inSelectMode) onCheckedChange(song.map.id !in selection)
                                                            else if (song.song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                                            else playerConnection.playQueue(ListQueue(title = playlist!!.playlist.name, items = songs.map { it.song.toMediaItem() }, startIndex = songs.indexOfFirst { it.map.id == song.map.id }))
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
                    // --- DISEÑO VERTICAL ORIGINAL ---
                    LazyColumn(
                        state = lazyListState,
                        contentPadding = LocalPlayerAwareWindowInsets.current.union(WindowInsets.ime).asPaddingValues(),
                    ) {
                        item {
                            LocalPlaylistScreenHeader(
                                playlist = playlist!!, songs = songs, listState = lazyListState,
                                onPlayClick = { playerConnection.playQueue(ListQueue(title = playlist!!.playlist.name, items = songs.map { it.song.toMediaItem() })) },
                                onShuffleClick = { playerConnection.playQueue(ListQueue(title = playlist!!.playlist.name, items = songs.shuffled().map { it.song.toMediaItem() })) },
                                onShowEditDialog = { showEditDialog = true },
                                onShowRemoveDownloadDialog = { showRemoveDownloadDialog = true },
                                snackbarHostState = snackbarHostState
                            )
                        }
                        item(key = "ad_banner") {
                            PetalAdsBanner(modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp))
                        }
                        if (playlist!!.songCount > 0 && !isSearching) {
                            stickyHeader {
                                SortAndLockControls(
                                    sortType = sortType, onSortTypeChange = onSortTypeChange,
                                    sortDescending = sortDescending, onSortDescendingChange = onSortDescendingChange,
                                    locked = locked, onLockClick = { locked = !locked }, inSelectMode = inSelectMode
                                )
                            }
                        }
                        if (playlist!!.songCount == 0) {
                            item { EmptyPlaceholder(icon = R.drawable.music_note, text = stringResource(R.string.playlist_is_empty)) }
                        } else {
                            itemsIndexed(items = if (isSearching) filteredSongs else mutableSongs, key = { _, song -> song.map.id }) { index, song ->
                                ReorderableItem(state = reorderableState, key = song.map.id) {
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
                                            modifier = Modifier
                                                .fillMaxWidth()
                                                .combinedClickable(
                                                    onClick = {
                                                        if (inSelectMode) onCheckedChange(song.map.id !in selection)
                                                        else if (song.song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                                        else playerConnection.playQueue(ListQueue(title = playlist!!.playlist.name, items = songs.map { it.song.toMediaItem() }, startIndex = songs.indexOfFirst { it.map.id == song.map.id }))
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
                        playlistName = playlist?.playlist?.name.orEmpty(),
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
                        onSelectAllClick = { shouldSelectAll ->
                            selection.clear()
                            if (shouldSelectAll) {
                                selection.addAll(songs.map { it.map.id })
                            }
                        },
                        onSelectionMenuClick = {
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
                        },
                        onLikeAllClick = { showLikeAllDialog = true }
                    )
                }
            }
            // =================== FIN DE LA MODIFICACIÓN ====================
        }

        SnackbarHost(
            hostState = snackbarHostState,
            modifier = Modifier
                .windowInsetsPadding(LocalPlayerAwareWindowInsets.current.union(WindowInsets.ime))
                .align(Alignment.BottomCenter)
        )
    }
}

// ================== INICIO DE NUEVOS COMPONENTES PARA LANDSCAPE ==================
@Composable
private fun LocalPlaylistLandscapeHeader(
    playlist: Playlist,
    songs: List<PlaylistSong>,
    modifier: Modifier = Modifier,
    inSelectMode: Boolean,
    selectionCount: Int,
    onExitSelectionMode: () -> Unit,
    isSearching: Boolean,
    query: TextFieldValue,
    onQueryChange: (TextFieldValue) -> Unit,
    focusRequester: FocusRequester,
    onSearchClose: () -> Unit,
    onSearchConfirmed: () -> Unit,
    onNavIconClick: () -> Unit,
    onNavIconLongClick: () -> Unit,
    allSelected: Boolean,
    onSelectAllClick: (Boolean) -> Unit,
    onSelectionMenuClick: () -> Unit,
    onLikeAllClick: () -> Unit
) {
    val playlistLength = remember(songs) { songs.fastSumBy { it.song.song.duration } }

    Column(
        modifier = modifier
            .fillMaxHeight()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        // La barra superior se reutiliza aquí, pero sin el título colapsable
        LocalPlaylistCollapsingTopAppBar(
            playlistName = "", // No es necesario aquí
            showTitle = false, // No es necesario aquí
            inSelectMode = inSelectMode,
            selectionCount = selectionCount,
            onExitSelectionMode = onExitSelectionMode,
            isSearching = isSearching,
            query = query,
            onQueryChange = onQueryChange,
            focusRequester = focusRequester,
            onSearchClose = onSearchClose,
            onSearchConfirmed = onSearchConfirmed,
            onNavIconClick = onNavIconClick,
            onNavIconLongClick = onNavIconLongClick,
            allSelected = allSelected,
            onSelectAllClick = onSelectAllClick,
            onSelectionMenuClick = onSelectionMenuClick,
            onLikeAllClick = onLikeAllClick
        )

        Column(
            modifier = Modifier
                .weight(1f)
                .verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth(0.6f)
                    .aspectRatio(1f)
                    .clip(RoundedCornerShape(12.dp))
                    .shadow(16.dp, RoundedCornerShape(12.dp)),
                contentAlignment = Alignment.Center
            ) {
                if (playlist.thumbnails.isEmpty()) {
                    Icon(painterResource(R.drawable.music_note), null, modifier = Modifier.size(80.dp), tint = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.3f))
                } else if (playlist.thumbnails.size < 4) {
                    AsyncImage(model = playlist.thumbnails[0], contentDescription = null, contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
                } else {
                    Row(modifier = Modifier.fillMaxSize()) {
                        Column(modifier = Modifier.weight(1f)) {
                            AsyncImage(model = playlist.thumbnails[0], null, Modifier
                                .weight(1f)
                                .fillMaxWidth(), contentScale = ContentScale.Crop)
                            AsyncImage(model = playlist.thumbnails[2], null, Modifier
                                .weight(1f)
                                .fillMaxWidth(), contentScale = ContentScale.Crop)
                        }
                        Column(modifier = Modifier.weight(1f)) {
                            AsyncImage(model = playlist.thumbnails[1], null, Modifier
                                .weight(1f)
                                .fillMaxWidth(), contentScale = ContentScale.Crop)
                            AsyncImage(model = playlist.thumbnails[3], null, Modifier
                                .weight(1f)
                                .fillMaxWidth(), contentScale = ContentScale.Crop)
                        }
                    }
                }
            }

            Spacer(Modifier.height(24.dp))

            Text(
                text = playlist.playlist.name,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center
            )
            Text(
                text = "${pluralStringResource(R.plurals.n_song, playlist.songCount, playlist.songCount)} • ${makeTimeString(playlistLength * 1000L)}",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                textAlign = TextAlign.Center
            )
        }
    }
}

@Composable
private fun LocalPlaylistActionControls(
    playlist: Playlist,
    songs: List<PlaylistSong>,
    onPlayClick: () -> Unit,
    onShuffleClick: () -> Unit,
    onShowEditDialog: () -> Unit,
    onShowRemoveDownloadDialog: () -> Unit,
    snackbarHostState: SnackbarHostState
) {
    val context = LocalContext.current
    val database = LocalDatabase.current
    val scope = rememberCoroutineScope()
    val playerConnection = LocalPlayerConnection.current!!

    val downloadUtil = LocalDownloadUtil.current
    var downloadState by remember { mutableIntStateOf(Download.STATE_STOPPED) }
    LaunchedEffect(songs) {
        if (songs.isEmpty()) return@LaunchedEffect
        downloadUtil.downloads.collect { downloads ->
            downloadState = if (songs.all { downloads[it.song.id]?.state == Download.STATE_COMPLETED }) Download.STATE_COMPLETED
            else if (songs.any { downloads[it.song.id]?.state == Download.STATE_DOWNLOADING || downloads[it.song.id]?.state == Download.STATE_QUEUED }) Download.STATE_DOWNLOADING
            else Download.STATE_STOPPED
        }
    }

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Row {
            IconButton(onClick = onShowEditDialog) { Icon(painterResource(R.drawable.edit), null) }
            if (playlist.playlist.browseId != null) {
                IconButton(onClick = {
                    scope.launch(Dispatchers.IO) {
                        val playlistPage = YouTube.playlist(playlist.playlist.browseId!!).completed().getOrNull() ?: return@launch
                        database.transaction {
                            clearPlaylist(playlist.id)
                            playlistPage.songs.map(SongItem::toMediaMetadata).onEach(::insert).mapIndexed { position, song ->
                                PlaylistSongMap(
                                    songId = song.id,
                                    playlistId = playlist.id,
                                    position = position
                                )
                            }.forEach(::insert)
                        }
                        snackbarHostState.showSnackbar(context.getString(R.string.playlist_synced))
                    }
                }) { Icon(painterResource(R.drawable.sync), null) }
            }
            when (downloadState) {
                Download.STATE_COMPLETED -> IconButton(onClick = onShowRemoveDownloadDialog) { Icon(painterResource(R.drawable.offline), null, tint = MaterialTheme.colorScheme.primary) }
                Download.STATE_DOWNLOADING -> IconButton(onClick = { songs.forEach { DownloadService.sendRemoveDownload(context, ExoDownloadService::class.java, it.song.id, false) } }) {
                    CircularProgressIndicator(Modifier.size(24.dp), strokeWidth = 2.dp)
                }
                else -> IconButton(onClick = {
                    songs.forEach {
                        val request = DownloadRequest.Builder(it.song.id, it.song.id.toUri()).setCustomCacheKey(it.song.id).setData(it.song.song.title.toByteArray()).build()
                        DownloadService.sendAddDownload(context, ExoDownloadService::class.java, request, false)
                    }
                }) { Icon(painterResource(R.drawable.download), null) }
            }
            IconButton(onClick = { playerConnection.addToQueue(items = songs.map { it.song.toMediaItem() }) }) { Icon(painterResource(R.drawable.queue_music), null) }
        }
        Row(verticalAlignment = Alignment.CenterVertically) {
            FloatingActionButton(onClick = onShuffleClick, elevation = FloatingActionButtonDefaults.elevation(0.dp, 0.dp), modifier = Modifier.size(48.dp)) { Icon(painterResource(R.drawable.shuffle), null) }
            Spacer(Modifier.width(16.dp))
            FloatingActionButton(onClick = onPlayClick) { Icon(painterResource(R.drawable.play), null) }
        }
    }
}
// =================== FIN DE NUEVOS COMPONENTES PARA LANDSCAPE ===================


// --- COMPONENTES DE UI AUXILIARES (NO MODIFICADOS) ---
@Composable
private fun LocalPlaylistScreenHeader(
    playlist: Playlist, songs: List<PlaylistSong>, listState: LazyListState,
    onPlayClick: () -> Unit, onShuffleClick: () -> Unit,
    onShowEditDialog: () -> Unit, onShowRemoveDownloadDialog: () -> Unit, snackbarHostState: SnackbarHostState
) {
    val context = LocalContext.current
    val database = LocalDatabase.current
    val scope = rememberCoroutineScope()
    val playerConnection = LocalPlayerConnection.current!!

    val playlistLength = remember(songs) { songs.fastSumBy { it.song.song.duration } }
    val downloadUtil = LocalDownloadUtil.current
    var downloadState by remember { mutableIntStateOf(Download.STATE_STOPPED) }
    LaunchedEffect(songs) {
        if (songs.isEmpty()) return@LaunchedEffect
        downloadUtil.downloads.collect { downloads ->
            downloadState = if (songs.all { downloads[it.song.id]?.state == Download.STATE_COMPLETED }) Download.STATE_COMPLETED
            else if (songs.any { downloads[it.song.id]?.state == Download.STATE_DOWNLOADING || downloads[it.song.id]?.state == Download.STATE_QUEUED }) Download.STATE_DOWNLOADING
            else Download.STATE_STOPPED
        }
    }

    val scrollOffset = if (listState.firstVisibleItemIndex == 0) listState.firstVisibleItemScrollOffset.toFloat() else Float.MAX_VALUE
    val headerHeightPx = with(LocalDensity.current) { 340.dp.toPx() }
    val imageTranslationY = -scrollOffset * 0.2f
    val textAlpha = (1f - (scrollOffset / (headerHeightPx / 2))).coerceIn(0f, 1f)

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .height(340.dp)
            .graphicsLayer { translationY = imageTranslationY },
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Box(
            modifier = Modifier
                .size(200.dp)
                .clip(RoundedCornerShape(12.dp))
                .shadow(16.dp, RoundedCornerShape(12.dp)),
            contentAlignment = Alignment.Center
        ) {
            if (playlist.thumbnails.isEmpty()) {
                Icon(painterResource(R.drawable.music_note), null, modifier = Modifier.size(80.dp), tint = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.3f))
            } else if (playlist.thumbnails.size < 4) {
                AsyncImage(model = playlist.thumbnails[0], contentDescription = null, contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
            } else {
                Row(modifier = Modifier.fillMaxSize()) {
                    Column(modifier = Modifier.weight(1f)) {
                        AsyncImage(model = playlist.thumbnails[0], null, Modifier
                            .weight(1f)
                            .fillMaxWidth(), contentScale = ContentScale.Crop)
                        AsyncImage(model = playlist.thumbnails[2], null, Modifier
                            .weight(1f)
                            .fillMaxWidth(), contentScale = ContentScale.Crop)
                    }
                    Column(modifier = Modifier.weight(1f)) {
                        AsyncImage(model = playlist.thumbnails[1], null, Modifier
                            .weight(1f)
                            .fillMaxWidth(), contentScale = ContentScale.Crop)
                        AsyncImage(model = playlist.thumbnails[3], null, Modifier
                            .weight(1f)
                            .fillMaxWidth(), contentScale = ContentScale.Crop)
                    }
                }
            }
        }

        Spacer(Modifier.height(16.dp))

        Column(
            modifier = Modifier.graphicsLayer { alpha = textAlpha },
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(playlist.playlist.name, style = MaterialTheme.typography.headlineSmall, fontWeight = FontWeight.Bold, maxLines = 1, overflow = TextOverflow.Ellipsis)
            Text(
                text = "${pluralStringResource(R.plurals.n_song, playlist.songCount, playlist.songCount)} • ${makeTimeString(playlistLength * 1000L)}",
                style = MaterialTheme.typography.bodyLarge, color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }

        Spacer(Modifier.height(16.dp))

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Row {
                IconButton(onClick = onShowEditDialog) { Icon(painterResource(R.drawable.edit), null) }
                if (playlist.playlist.browseId != null) {
                    IconButton(onClick = {
                        scope.launch(Dispatchers.IO) {
                            val playlistPage = YouTube.playlist(playlist.playlist.browseId!!).completed().getOrNull() ?: return@launch
                            database.transaction {
                                clearPlaylist(playlist.id)
                                playlistPage.songs.map(SongItem::toMediaMetadata).onEach(::insert).mapIndexed { position, song ->
                                    PlaylistSongMap(
                                        songId = song.id,
                                        playlistId = playlist.id,
                                        position = position
                                    )
                                }.forEach(::insert)
                            }
                            snackbarHostState.showSnackbar(context.getString(R.string.playlist_synced))
                        }
                    }) { Icon(painterResource(R.drawable.sync), null) }
                }
                when (downloadState) {
                    Download.STATE_COMPLETED -> IconButton(onClick = onShowRemoveDownloadDialog) { Icon(painterResource(R.drawable.offline), null, tint = MaterialTheme.colorScheme.primary) }
                    Download.STATE_DOWNLOADING -> IconButton(onClick = { songs.forEach { DownloadService.sendRemoveDownload(context, ExoDownloadService::class.java, it.song.id, false) } }) {
                        CircularProgressIndicator(Modifier.size(24.dp), strokeWidth = 2.dp)
                    }
                    else -> IconButton(onClick = {
                        songs.forEach {
                            val request = DownloadRequest.Builder(it.song.id, it.song.id.toUri()).setCustomCacheKey(it.song.id).setData(it.song.song.title.toByteArray()).build()
                            DownloadService.sendAddDownload(context, ExoDownloadService::class.java, request, false)
                        }
                    }) { Icon(painterResource(R.drawable.download), null) }
                }
                IconButton(onClick = { playerConnection.addToQueue(items = songs.map { it.song.toMediaItem() }) }) { Icon(painterResource(R.drawable.queue_music), null) }
            }
            Row(verticalAlignment = Alignment.CenterVertically) {
                FloatingActionButton(onClick = onShuffleClick, elevation = FloatingActionButtonDefaults.elevation(0.dp, 0.dp), modifier = Modifier.size(48.dp)) { Icon(painterResource(R.drawable.shuffle), null) }
                Spacer(Modifier.width(16.dp))
                FloatingActionButton(onClick = onPlayClick) { Icon(painterResource(R.drawable.play), null) }
            }
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
        if (!inSelectMode) {
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
    val isActionOrSearch = inSelectMode || isSearching
    val animatedColor by animateColorAsState(if (showTitle || isActionOrSearch) MaterialTheme.colorScheme.surfaceColorAtElevation(3.dp).copy(alpha = 0.8f) else Color.Transparent, label = "TopBarColor")
    val containerColor = if (isActionOrSearch) MaterialTheme.colorScheme.surface else animatedColor


    TopAppBar(
        modifier = Modifier.background(containerColor),
        colors = TopAppBarDefaults.topAppBarColors(containerColor = Color.Transparent),
        title = {
            when {
                inSelectMode -> Text(pluralStringResource(R.plurals.n_selected, selectionCount, selectionCount))
                isSearching -> TextField(
                    value = query, onValueChange = onQueryChange,
                    placeholder = { Text(stringResource(R.string.search), style = MaterialTheme.typography.titleLarge) },
                    singleLine = true, textStyle = MaterialTheme.typography.titleLarge.copy(color = MaterialTheme.colorScheme.onSurface),
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Search),
                    colors = TextFieldDefaults.colors(
                        focusedContainerColor = Color.Transparent, unfocusedContainerColor = Color.Transparent,
                        focusedIndicatorColor = Color.Transparent, unfocusedIndicatorColor = Color.Transparent
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .focusRequester(focusRequester)
                )
                showTitle -> Text(playlistName, maxLines = 1, overflow = TextOverflow.Ellipsis)
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
                    IconButton(onClick = onLikeAllClick) {
                        Icon(Icons.Default.Favorite, contentDescription = stringResource(R.string.like_all))
                    }
                    IconButton(onClick = onSearchConfirmed) {
                        Icon(painterResource(R.drawable.search), null)
                    }
                }
            }
        }
    )
}

@Composable
private fun LocalPlaylistScreenSkeleton() {
    ShimmerHost {
        LazyColumn(contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()) {
            item {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(340.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center
                ) {
                    Spacer(Modifier
                        .size(200.dp)
                        .clip(RoundedCornerShape(12.dp))
                        .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                    Spacer(Modifier.height(16.dp))
                    TextPlaceholder()
                    Spacer(Modifier.height(8.dp))
                    TextPlaceholder()
                    Spacer(Modifier.height(16.dp))
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(horizontal = 16.dp),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            repeat(4) { Spacer(Modifier
                                .size(24.dp)
                                .clip(CircleShape)
                                .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f))) }
                        }
                        Row(horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
                            Spacer(Modifier
                                .size(48.dp)
                                .clip(CircleShape)
                                .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                            Spacer(Modifier
                                .size(56.dp)
                                .clip(CircleShape)
                                .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f)))
                        }
                    }
                }
            }
            item {
                Row(modifier = Modifier
                    .fillMaxWidth()
                    .padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 8.dp)) {
                    TextPlaceholder()
                }
            }
            items(7) {
                ListItemPlaceHolder(modifier = Modifier.padding(horizontal = 8.dp))
            }
        }
    }
}