package com.zionhuang.music.ui.screens.playlist

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
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.listSaver
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.hapticfeedback.HapticFeedbackType
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
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.text.withLink
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.util.fastAny
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import androidx.palette.graphics.Palette
import coil.compose.AsyncImage
import coil.request.ImageRequest
import coil.size.Size
import com.zionhuang.innertube.models.PlaylistItem
import com.zionhuang.innertube.models.SongItem
import com.zionhuang.innertube.models.WatchEndpoint
import com.zionhuang.music.LocalDatabase
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.constants.HideExplicitKey
import com.zionhuang.music.db.entities.PlaylistEntity
import com.zionhuang.music.db.entities.PlaylistSongMap
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.models.toMediaMetadata
import com.zionhuang.music.playback.queues.YouTubeQueue
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.LocalMenuState
import com.zionhuang.music.ui.component.YouTubeListItem
import com.zionhuang.music.ui.component.shimmer.ListItemPlaceHolder
import com.zionhuang.music.ui.component.shimmer.ShimmerHost
import com.zionhuang.music.ui.component.shimmer.TextPlaceholder
import com.zionhuang.music.ui.menu.YouTubePlaylistMenu
import com.zionhuang.music.ui.menu.YouTubeSongMenu
import com.zionhuang.music.ui.menu.YouTubeSongSelectionMenu
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberPreference
import com.zionhuang.music.viewmodels.OnlinePlaylistViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
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
fun OnlinePlaylistScreen(
    navController: NavController,
    viewModel: OnlinePlaylistViewModel = hiltViewModel(),
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
    val hideExplicit by rememberPreference(key = HideExplicitKey, defaultValue = false)

    val coroutineScope = rememberCoroutineScope()
    val snackbarHostState = remember { SnackbarHostState() }

    var isSearching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable(stateSaver = TextFieldValue.Saver) { mutableStateOf(TextFieldValue()) }
    val filteredSongs = remember(songs, query) {
        if (query.text.isEmpty()) songs.mapIndexed { index, song -> index to song }
        else songs.mapIndexed { index, song -> index to song }.filter { (_, song) ->
            song.title.contains(query.text, ignoreCase = true) ||
                    song.artists.fastAny { it.name.contains(query.text, ignoreCase = true) }
        }
    }
    val focusRequester = remember { FocusRequester() }
    LaunchedEffect(isSearching) { if (isSearching) focusRequester.requestFocus() }
    if (isSearching) {
        BackHandler { isSearching = false; query = TextFieldValue() }
    }
    var inSelectMode by rememberSaveable { mutableStateOf(false) }
    val selection = rememberSaveable(
        saver = listSaver<MutableList<Int>, Int>({ it.toList() }, { it.toMutableStateList() })
    ) { mutableStateListOf() }
    val onExitSelectionMode = { inSelectMode = false; selection.clear() }
    if (inSelectMode) { BackHandler(onBack = onExitSelectionMode) }

    val defaultColor = MaterialTheme.colorScheme.surface
    var dominantColor by remember { mutableStateOf(defaultColor) }
    val animatedBackgroundColor by animateColorAsState(dominantColor, tween(500), label = "background_color")
    LaunchedEffect(playlist?.thumbnail) {
        dominantColor = fetchDominantColor(context, playlist?.thumbnail, defaultColor)
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Brush.verticalGradient(listOf(animatedBackgroundColor.copy(alpha = 0.4f), MaterialTheme.colorScheme.surface)))
    ) {
        if (playlist == null) {
            OnlinePlaylistScreenSkeleton()
        } else {
            val playlistData = playlist!!
            BoxWithConstraints {
                val isExpanded = maxWidth > 600.dp

                if (isExpanded) {
                    Row(Modifier.fillMaxSize()) {
                        PlaylistLandscapeHeader(
                            playlist = playlistData,
                            navController = navController,
                            modifier = Modifier.weight(0.4f),
                            inSelectMode = inSelectMode,
                            selectionCount = selection.size,
                            allSelected = songs.isNotEmpty() && selection.size == songs.size,
                            onNavIconClick = {
                                if (inSelectMode) onExitSelectionMode()
                                else navController.navigateUp()
                            },
                            onSelectAllClick = {
                                if (selection.size == songs.size) selection.clear()
                                else {
                                    selection.clear()
                                    selection.addAll(songs.mapIndexedNotNull { index, song -> if (hideExplicit && song.explicit) null else index })
                                }
                            },
                            onSelectionMenuClick = {
                                menuState.show {
                                    YouTubeSongSelectionMenu(
                                        selection = selection.mapNotNull { songs.getOrNull(it) },
                                        onDismiss = menuState::dismiss,
                                        onExitSelectionMode = onExitSelectionMode
                                    )
                                }
                            },
                            isSearching = isSearching,
                            query = query,
                            onQueryChange = { query = it },
                            focusRequester = focusRequester,
                            onSearchClose = { isSearching = false; query = TextFieldValue() },
                            onSearchConfirmed = { isSearching = true }
                        )

                        LazyColumn(
                            state = rememberLazyListState(),
                            modifier = Modifier.weight(0.6f),
                            contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()
                        ) {
                            item {
                                PlaylistActionControls(
                                    playlist = playlistData,
                                    onShuffleClick = { playlistData.shuffleEndpoint?.let { playerConnection.playQueue(YouTubeQueue(it)) } },
                                    onRadioClick = { playlistData.radioEndpoint?.let { playerConnection.playQueue(YouTubeQueue(it)) } },
                                    onImportClick = {
                                        database.transaction {
                                            val playlistEntity = PlaylistEntity(name = playlistData.title, browseId = playlistData.id)
                                            insert(playlistEntity)
                                            songs.map(SongItem::toMediaMetadata).onEach(::insert).mapIndexed { index, song ->
                                                PlaylistSongMap(songId = song.id, playlistId = playlistEntity.id, position = index)
                                            }.forEach(::insert)
                                            coroutineScope.launch { snackbarHostState.showSnackbar(context.getString(R.string.playlist_imported)) }
                                        }
                                    },
                                    onMenuClick = {
                                        menuState.show {
                                            YouTubePlaylistMenu(
                                                playlist = playlistData,
                                                songs = songs,
                                                coroutineScope = coroutineScope,
                                                onDismiss = menuState::dismiss
                                            )
                                        }
                                    }
                                )
                            }
                            items(items = filteredSongs, key = { (index, _) -> index }) { (index, song) ->
                                val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(index) else selection.remove(index) }
                                YouTubeListItem(
                                    item = song,
                                    isActive = mediaMetadata?.id == song.id,
                                    isPlaying = isPlaying,
                                    trailingContent = {
                                        if (inSelectMode) {
                                            Checkbox(checked = index in selection, onCheckedChange = onCheckedChange)
                                        } else {
                                            IconButton(onClick = { menuState.show { YouTubeSongMenu(song = song, navController = navController, onDismiss = menuState::dismiss) } }) {
                                                Icon(painterResource(R.drawable.more_vert), null)
                                            }
                                        }
                                    },
                                    modifier = Modifier
                                        .combinedClickable(
                                            enabled = !hideExplicit || !song.explicit,
                                            onClick = {
                                                if (inSelectMode) onCheckedChange(index !in selection)
                                                else if (song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                                else playerConnection.playQueue(YouTubeQueue(song.endpoint ?: WatchEndpoint(videoId = song.id), song.toMediaMetadata()))
                                            },
                                            onLongClick = {
                                                if (!inSelectMode) {
                                                    haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                    inSelectMode = true
                                                    onCheckedChange(true)
                                                }
                                            }
                                        )
                                        .alpha(if (hideExplicit && song.explicit) 0.3f else 1f)
                                        .animateItem()
                                )
                            }
                        }
                    }
                } else {
                    val portraitListState = rememberLazyListState()
                    val showTopBarTitle by remember { derivedStateOf { portraitListState.firstVisibleItemIndex > 0 } }

                    LazyColumn(
                        state = portraitListState,
                        contentPadding = LocalPlayerAwareWindowInsets.current.union(WindowInsets.ime).asPaddingValues()
                    ) {
                        if (!isSearching) {
                            item {
                                PlaylistHeader(
                                    playlist = playlistData,
                                    navController = navController,
                                    listState = portraitListState
                                )
                            }
                            item {
                                PlaylistActionControls(
                                    playlist = playlistData,
                                    onShuffleClick = { playlistData.shuffleEndpoint?.let { playerConnection.playQueue(YouTubeQueue(it)) } },
                                    onRadioClick = { playlistData.radioEndpoint?.let { playerConnection.playQueue(YouTubeQueue(it)) } },
                                    onImportClick = {
                                        database.transaction {
                                            val playlistEntity = PlaylistEntity(name = playlistData.title, browseId = playlistData.id)
                                            insert(playlistEntity)
                                            songs.map(SongItem::toMediaMetadata).onEach(::insert).mapIndexed { index, song ->
                                                PlaylistSongMap(songId = song.id, playlistId = playlistEntity.id, position = index)
                                            }.forEach(::insert)
                                            coroutineScope.launch { snackbarHostState.showSnackbar(context.getString(R.string.playlist_imported)) }
                                        }
                                    },
                                    onMenuClick = {
                                        menuState.show {
                                            YouTubePlaylistMenu(
                                                playlist = playlistData,
                                                songs = songs,
                                                coroutineScope = coroutineScope,
                                                onDismiss = menuState::dismiss
                                            )
                                        }
                                    }
                                )
                            }
                        }
                        items(items = filteredSongs, key = { (index, _) -> index }) { (index, song) ->
                            val onCheckedChange: (Boolean) -> Unit = { if (it) selection.add(index) else selection.remove(index) }
                            YouTubeListItem(
                                item = song,
                                isActive = mediaMetadata?.id == song.id,
                                isPlaying = isPlaying,
                                trailingContent = {
                                    if (inSelectMode) {
                                        Checkbox(checked = index in selection, onCheckedChange = onCheckedChange)
                                    } else {
                                        IconButton(onClick = { menuState.show { YouTubeSongMenu(song = song, navController = navController, onDismiss = menuState::dismiss) } }) {
                                            Icon(painterResource(R.drawable.more_vert), null)
                                        }
                                    }
                                },
                                modifier = Modifier
                                    .combinedClickable(
                                        enabled = !hideExplicit || !song.explicit,
                                        onClick = {
                                            if (inSelectMode) onCheckedChange(index !in selection)
                                            else if (song.id == mediaMetadata?.id) playerConnection.player.togglePlayPause()
                                            else playerConnection.playQueue(YouTubeQueue(song.endpoint ?: WatchEndpoint(videoId = song.id), song.toMediaMetadata()))
                                        },
                                        onLongClick = {
                                            if (!inSelectMode) {
                                                haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                inSelectMode = true
                                                onCheckedChange(true)
                                            }
                                        }
                                    )
                                    .alpha(if (hideExplicit && song.explicit) 0.3f else 1f)
                                    .animateItem()
                            )
                        }
                    }

                    PlaylistCollapsingTopAppBar(
                        playlistTitle = playlistData.title,
                        showTitle = showTopBarTitle,
                        backgroundColor = animatedBackgroundColor,
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
                        allSelected = songs.isNotEmpty() && selection.size == songs.size,
                        onSelectAllClick = {
                            if (selection.size == songs.size) selection.clear()
                            else {
                                selection.clear()
                                selection.addAll(songs.mapIndexedNotNull { index, song -> if (hideExplicit && song.explicit) null else index })
                            }
                        },
                        onSelectionMenuClick = {
                            menuState.show {
                                YouTubeSongSelectionMenu(
                                    selection = selection.mapNotNull { songs.getOrNull(it) },
                                    onDismiss = menuState::dismiss,
                                    onExitSelectionMode = onExitSelectionMode
                                )
                            }
                        }
                    )
                }
            }
        }

        SnackbarHost(
            hostState = snackbarHostState,
            modifier = Modifier
                .windowInsetsPadding(LocalPlayerAwareWindowInsets.current.union(WindowInsets.ime))
                .align(Alignment.BottomCenter)
        )
    }
}

@Composable
private fun PlaylistLandscapeHeader(
    playlist: PlaylistItem,
    navController: NavController,
    modifier: Modifier = Modifier,
    inSelectMode: Boolean,
    selectionCount: Int,
    allSelected: Boolean,
    onNavIconClick: () -> Unit,
    onSelectAllClick: () -> Unit,
    onSelectionMenuClick: () -> Unit,
    isSearching: Boolean,
    query: TextFieldValue,
    onQueryChange: (TextFieldValue) -> Unit,
    focusRequester: FocusRequester,
    onSearchClose: () -> Unit,
    onSearchConfirmed: () -> Unit
) {
    Column(
        modifier = modifier
            .fillMaxHeight()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        PlaylistActionBar(
            inSelectMode = inSelectMode,
            selectionCount = selectionCount,
            allSelected = allSelected,
            onNavIconClick = onNavIconClick,
            onSelectAllClick = onSelectAllClick,
            onSelectionMenuClick = onSelectionMenuClick,
            isSearching = isSearching,
            query = query,
            onQueryChange = onQueryChange,
            focusRequester = focusRequester,
            onSearchClose = onSearchClose,
            onSearchConfirmed = onSearchConfirmed
        )

        Column(
            modifier = Modifier
                .weight(1f)
                .verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            AsyncImage(
                model = playlist.thumbnail,
                contentDescription = "Playlist Thumbnail",
                modifier = Modifier
                    .fillMaxWidth(0.5f)
                    .aspectRatio(1f)
                    .clip(RoundedCornerShape(12.dp))
                    .shadow(8.dp, RoundedCornerShape(12.dp))
            )
            Spacer(Modifier.height(24.dp))
            Text(
                text = playlist.title,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center,
                color = MaterialTheme.colorScheme.primary
            )
            playlist.author?.let { author ->
                Text(
                    text = buildAnnotatedString {
                        if (author.id != null) {
                            withLink(LinkAnnotation.Clickable(author.id!!) { navController.navigate("artist/${author.id}") }) {
                                withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(author.name) }
                            }
                        } else {
                            withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(author.name) }
                        }
                    },
                    style = MaterialTheme.typography.bodyLarge,
                    textAlign = TextAlign.Center
                )
            }
            playlist.songCountText?.let {
                Text(
                    text = it,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PlaylistActionBar(
    modifier: Modifier = Modifier,
    inSelectMode: Boolean,
    selectionCount: Int,
    allSelected: Boolean,
    onNavIconClick: () -> Unit,
    onSelectAllClick: () -> Unit,
    onSelectionMenuClick: () -> Unit,
    isSearching: Boolean,
    query: TextFieldValue,
    onQueryChange: (TextFieldValue) -> Unit,
    focusRequester: FocusRequester,
    onSearchClose: () -> Unit,
    onSearchConfirmed: () -> Unit,
) {
    AnimatedContent(
        targetState = when {
            inSelectMode -> "select"
            isSearching -> "search"
            else -> "normal"
        },
        label = "ActionBarAnimation",
        modifier = modifier
            .fillMaxWidth()
            .height(56.dp)
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
                        modifier = Modifier
                            .fillMaxWidth()
                            .focusRequester(focusRequester)
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
                    IconButton(onClick = onSearchConfirmed) { Icon(painterResource(R.drawable.search), null) }
                }
            }
        }
    }
}

@SuppressLint("FrequentlyChangedStateReadInComposition")
@Composable
private fun PlaylistHeader(
    playlist: PlaylistItem,
    navController: NavController,
    listState: LazyListState
) {
    val scrollOffset = if (listState.firstVisibleItemIndex == 0) listState.firstVisibleItemScrollOffset.toFloat() else 0f
    val headerHeightPx = with(LocalDensity.current) { 320.dp.toPx() }

    val imageTranslationY = -scrollOffset * 0.2f
    val textAlpha = (1f - (scrollOffset / (headerHeightPx / 2))).coerceIn(0f, 1f)

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .height(320.dp)
            .graphicsLayer { translationY = imageTranslationY },
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        AsyncImage(
            model = playlist.thumbnail,
            contentDescription = "Playlist Thumbnail",
            modifier = Modifier.size(200.dp).clip(RoundedCornerShape(12.dp)).shadow(16.dp, RoundedCornerShape(12.dp))
        )
        Spacer(Modifier.height(16.dp))
        Column(
            modifier = Modifier.graphicsLayer { alpha = textAlpha },
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = playlist.title,
                style = MaterialTheme.typography.headlineSmall,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                color = MaterialTheme.colorScheme.primary
            )
            playlist.author?.let { author ->
                Text(
                    text = buildAnnotatedString {
                        if (author.id != null) {
                            withLink(LinkAnnotation.Clickable(author.id!!) { navController.navigate("artist/${author.id}") }) {
                                withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(author.name) }
                            }
                        } else {
                            withStyle(SpanStyle(color = MaterialTheme.colorScheme.primary)) { append(author.name) }
                        }
                    },
                    style = MaterialTheme.typography.bodyLarge,
                    maxLines = 1
                )
            }
            playlist.songCountText?.let {
                Text(it, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
            }
        }
    }
}

@Composable
private fun PlaylistActionControls(
    playlist: PlaylistItem,
    onShuffleClick: () -> Unit,
    onRadioClick: () -> Unit,
    onImportClick: () -> Unit,
    onMenuClick: () -> Unit
) {
    Row(
        modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Row {
            IconButton(onClick = onImportClick) { Icon(painterResource(R.drawable.input), "Import") }
            IconButton(onClick = onMenuClick) { Icon(painterResource(R.drawable.more_vert), "Menu") }
        }
        Row(verticalAlignment = Alignment.CenterVertically) {
            FloatingActionButton(onClick = onShuffleClick, elevation = FloatingActionButtonDefaults.elevation(0.dp, 0.dp), modifier = Modifier.size(48.dp)) {
                Icon(painterResource(R.drawable.shuffle), "Shuffle")
            }
            playlist.radioEndpoint?.let {
                Spacer(Modifier.width(16.dp))
                FloatingActionButton(onClick = onRadioClick) { Icon(painterResource(R.drawable.radio), "Radio") }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PlaylistCollapsingTopAppBar(
    playlistTitle: String, showTitle: Boolean, backgroundColor: Color,
    inSelectMode: Boolean, selectionCount: Int, onExitSelectionMode: () -> Unit,
    isSearching: Boolean, query: TextFieldValue, onQueryChange: (TextFieldValue) -> Unit, focusRequester: FocusRequester,
    onSearchClose: () -> Unit, onSearchConfirmed: () -> Unit,
    onNavIconClick: () -> Unit, onNavIconLongClick: () -> Unit,
    allSelected: Boolean, onSelectAllClick: () -> Unit, onSelectionMenuClick: () -> Unit
) {
    val animatedColor by animateColorAsState(if (showTitle || inSelectMode || isSearching) backgroundColor.copy(alpha = 0.8f) else Color.Transparent, label = "TopBarColor")

    TopAppBar(
        modifier = Modifier.background(animatedColor),
        colors = TopAppBarDefaults.topAppBarColors(containerColor = Color.Transparent),
        title = {
            when {
                inSelectMode -> Text(pluralStringResource(R.plurals.n_selected, selectionCount, selectionCount))
                isSearching -> TextField(
                    value = query,
                    onValueChange = onQueryChange,
                    placeholder = { Text(stringResource(R.string.search_in_playlist), style = MaterialTheme.typography.titleLarge, color = MaterialTheme.colorScheme.primary) },
                    singleLine = true,
                    textStyle = MaterialTheme.typography.titleLarge.copy(color = MaterialTheme.colorScheme.primary),
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Search),
                    colors = TextFieldDefaults.colors(
                        focusedContainerColor = Color.Transparent, unfocusedContainerColor = Color.Transparent,
                        focusedIndicatorColor = Color.Transparent, unfocusedIndicatorColor = Color.Transparent
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .focusRequester(focusRequester)
                )
                showTitle -> Text(
                    playlistTitle,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    color = MaterialTheme.colorScheme.primary
                )
            }
        },
        navigationIcon = {
            val navIcon = if (inSelectMode || isSearching) R.drawable.close else R.drawable.arrow_back
            IconButton(
                onClick = {
                    when {
                        inSelectMode -> onExitSelectionMode()
                        isSearching -> onSearchClose()
                        else -> onNavIconClick()
                    }
                },
                onLongClick = { if (!inSelectMode && !isSearching) onNavIconLongClick() }
            ) {
                Icon(painterResource(navIcon), null, tint = MaterialTheme.colorScheme.onSurface)
            }
        },
        actions = {
            when {
                inSelectMode -> {
                    Checkbox(checked = allSelected, onCheckedChange = { onSelectAllClick() })
                    IconButton(enabled = selectionCount > 0, onClick = onSelectionMenuClick) {
                        Icon(painterResource(R.drawable.more_vert), null)
                    }
                }
                !isSearching -> {
                    IconButton(onClick = onSearchConfirmed) { Icon(painterResource(R.drawable.search), null) }
                }
            }
        }
    )
}


@Composable
private fun OnlinePlaylistScreenSkeleton() {
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
                            .height(56.dp),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Spacer(
                                modifier = Modifier
                                    .size(width = 80.dp, height = 32.dp)
                                    .clip(CircleShape)
                                    .background(MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f))
                            )
                            Spacer(
                                modifier = Modifier
                                    .size(24.dp)
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
                LazyColumn(contentPadding = LocalPlayerAwareWindowInsets.current.asPaddingValues()) {
                    item {
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(320.dp),
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