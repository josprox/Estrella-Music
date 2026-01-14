package com.zionhuang.music.ui.screens.artist

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.widget.Toast
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.add
import androidx.compose.foundation.layout.asPaddingValues
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.systemBars
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.hapticfeedback.HapticFeedbackType
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalHapticFeedback
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.util.fastForEach
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.valentinilk.shimmer.shimmer
import com.zionhuang.innertube.models.AlbumItem
import com.zionhuang.innertube.models.ArtistItem
import com.zionhuang.innertube.models.PlaylistItem
import com.zionhuang.innertube.models.SongItem
import com.zionhuang.innertube.models.WatchEndpoint
import com.zionhuang.music.LocalDatabase
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.constants.AppBarHeight
import com.zionhuang.music.db.entities.ArtistEntity
import com.zionhuang.music.extensions.togglePlayPause
import com.zionhuang.music.models.toMediaMetadata
import com.zionhuang.music.playback.queues.YouTubeQueue
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.LocalMenuState
import com.zionhuang.music.ui.component.NavigationTitle
import com.zionhuang.music.ui.component.SongListItem
import com.zionhuang.music.ui.component.YouTubeGridItem
import com.zionhuang.music.ui.component.YouTubeListItem
import com.zionhuang.music.ui.component.shimmer.ButtonPlaceholder
import com.zionhuang.music.ui.component.shimmer.ListItemPlaceHolder
import com.zionhuang.music.ui.component.shimmer.ShimmerHost
import com.zionhuang.music.ui.component.shimmer.TextPlaceholder
import com.zionhuang.music.ui.menu.SongMenu
import com.zionhuang.music.ui.menu.YouTubeAlbumMenu
import com.zionhuang.music.ui.menu.YouTubeArtistMenu
import com.zionhuang.music.ui.menu.YouTubePlaylistMenu
import com.zionhuang.music.ui.menu.YouTubeSongMenu
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.ui.utils.fadingEdge
import com.zionhuang.music.ui.utils.resize
import com.zionhuang.music.constants.ModernDesignKey
import com.zionhuang.music.utils.rememberPreference
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.TileMode
import androidx.compose.foundation.layout.BoxWithConstraints
import com.zionhuang.music.viewmodels.ArtistViewModel
import com.zionhuang.music.ui.component.PetalAdsBanner


@OptIn(ExperimentalFoundationApi::class, ExperimentalMaterial3Api::class)
@Composable
fun ArtistScreen(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
    viewModel: ArtistViewModel = hiltViewModel(),
) {
    val context = LocalContext.current
    val database = LocalDatabase.current
    val menuState = LocalMenuState.current
    val haptic = LocalHapticFeedback.current
    val coroutineScope = rememberCoroutineScope()
    val playerConnection = LocalPlayerConnection.current ?: return
    val isPlaying by playerConnection.isPlaying.collectAsState()
    val mediaMetadata by playerConnection.mediaMetadata.collectAsState()
    val artistPage = viewModel.artistPage
    val libraryArtist by viewModel.libraryArtist.collectAsState()
    val librarySongs by viewModel.librarySongs.collectAsState()
    val libraryAlbums by viewModel.libraryAlbums.collectAsState()
    val modernDesign by rememberPreference(ModernDesignKey, defaultValue = true)

    val lazyListState = rememberLazyListState()
    val snackbarHostState = remember { SnackbarHostState() }

    val transparentAppBar by remember {
        derivedStateOf {
            lazyListState.firstVisibleItemIndex <= 1
        }
    }

    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        LazyColumn(
            state = lazyListState,
            contentPadding = LocalPlayerAwareWindowInsets.current
                .add(
                    WindowInsets(
                        top = -WindowInsets.systemBars.asPaddingValues()
                            .calculateTopPadding() - AppBarHeight
                    )
                )
                .asPaddingValues(),
        ) {
            if (artistPage == null && libraryArtist == null) {
                item(key = "shimmer") {
                    ShimmerHost {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .aspectRatio(1.2f / 1),
                        ) {
                            Spacer(
                                modifier = Modifier
                                    .fillMaxSize()
                                    .shimmer()
                                    .background(MaterialTheme.colorScheme.onSurface)
                                    .fadingEdge(
                                        top = WindowInsets.systemBars
                                            .asPaddingValues()
                                            .calculateTopPadding() + AppBarHeight,
                                        bottom = 200.dp,
                                    ),
                            )
                        }

                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(16.dp)
                        ) {
                            TextPlaceholder(
                                height = 36.dp,
                                modifier = Modifier
                                    .fillMaxWidth(0.7f)
                                    .padding(bottom = 16.dp)
                            )

                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                ButtonPlaceholder(
                                    modifier = Modifier
                                        .width(120.dp)
                                        .height(40.dp)
                                )

                                Spacer(modifier = Modifier.weight(1f))

                                Row(
                                    horizontalArrangement = Arrangement.spacedBy(16.dp),
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    ButtonPlaceholder(
                                        modifier = Modifier
                                            .width(100.dp)
                                            .height(40.dp)
                                    )

                                    Box(
                                        modifier = Modifier
                                            .size(48.dp)
                                            .shimmer()
                                            .background(
                                                MaterialTheme.colorScheme.onSurface,
                                                RoundedCornerShape(24.dp)
                                            )
                                    )
                                }
                            }
                        }

                        repeat(6) {
                            ListItemPlaceHolder()
                        }
                    }
                }
            } else {
                item(key = "header") {
                    val thumbnail = artistPage?.artist?.thumbnail ?: libraryArtist?.artist?.thumbnailUrl
                    val artistName = artistPage?.artist?.title ?: libraryArtist?.artist?.name.orEmpty()

                    if (modernDesign) {
                        // --- MODERN DESIGN HEADER ---
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(380.dp) // Taller header
                        ) {
                            if (thumbnail != null) {
                                AsyncImage(
                                    model = thumbnail.resize(1200, 1000),
                                    contentDescription = null,
                                    modifier = Modifier
                                        .fillMaxSize()
                                        .fadingEdge(
                                            bottom = 150.dp, // Smoother fade
                                        ),
                                    contentScale = androidx.compose.ui.layout.ContentScale.Crop
                                )
                                // Gradient Overlay for text readability
                                Box(
                                    modifier = Modifier
                                        .fillMaxSize()
                                        .background(
                                            Brush.verticalGradient(
                                                colors = listOf(
                                                    Color.Transparent,
                                                    MaterialTheme.colorScheme.background.copy(alpha = 0.6f),
                                                    MaterialTheme.colorScheme.background
                                                ),
                                                startY = 300f
                                            )
                                        )
                                )
                            }
                            
                            Column(
                                modifier = Modifier
                                    .align(Alignment.BottomStart)
                                    .padding(start = 24.dp, end = 24.dp, bottom = 24.dp)
                            ) {
                                Text(
                                    text = artistName,
                                    style = MaterialTheme.typography.displayMedium, // Larger, decorative font
                                    fontWeight = FontWeight.Black,
                                    maxLines = 2,
                                    overflow = TextOverflow.Ellipsis,
                                    color = MaterialTheme.colorScheme.onBackground,
                                    modifier = Modifier.padding(bottom = 12.dp)
                                )

                                Row(
                                    horizontalArrangement = Arrangement.spacedBy(12.dp),
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    // Subscribe Button (Filled)
                                    val isSubscribed = libraryArtist?.artist?.bookmarkedAt != null
                                    androidx.compose.material3.Button(
                                        onClick = {
                                            database.transaction {
                                                val artist = libraryArtist?.artist
                                                if (artist != null) {
                                                    update(artist.toggleLike())
                                                } else {
                                                    artistPage?.artist?.let {
                                                        insert(
                                                            ArtistEntity(
                                                                id = it.id,
                                                                name = it.title,
                                                                thumbnailUrl = it.thumbnail,
                                                            ).toggleLike()
                                                        )
                                                    }
                                                }
                                            }
                                        },
                                        colors = ButtonDefaults.buttonColors(
                                            containerColor = if (isSubscribed) MaterialTheme.colorScheme.surfaceContainerHighest else MaterialTheme.colorScheme.primary,
                                            contentColor = if (isSubscribed) MaterialTheme.colorScheme.onSurface else MaterialTheme.colorScheme.onPrimary
                                        ),
                                        shape = RoundedCornerShape(50),
                                        contentPadding = androidx.compose.foundation.layout.PaddingValues(horizontal = 20.dp, vertical = 0.dp)
                                    ) {
                                        Text(stringResource(if (isSubscribed) R.string.subscribed else R.string.subscribe))
                                    }

                                    Spacer(modifier = Modifier.weight(1f))

                                    // Radio Button
                                    (artistPage?.artist?.radioEndpoint ?: libraryArtist?.artist?.id?.let {
                                        WatchEndpoint(videoId = null, playlistId = "RD$it") // Fallback radio endpoint construction if possible or omit
                                    })?.let { radioEndpoint ->
                                        androidx.compose.material3.FilledTonalIconToggleButton(
                                            checked = false,
                                            onCheckedChange = { playerConnection.playQueue(YouTubeQueue(radioEndpoint)) },
                                            modifier = Modifier.size(48.dp)
                                        ) {
                                            Icon(painterResource(R.drawable.radio), null)
                                        }
                                    }

                                    // Shuffle Button
                                    (artistPage?.artist?.shuffleEndpoint ?: libraryArtist?.artist?.id?.let {
                                        WatchEndpoint(videoId = null, playlistId = "RD$it", params = "wAEB") // Fallback shuffle
                                    })?.let { shuffleEndpoint ->
                                        androidx.compose.material3.FilledIconButton(
                                            onClick = { playerConnection.playQueue(YouTubeQueue(shuffleEndpoint)) },
                                            modifier = Modifier.size(48.dp),
                                            colors = androidx.compose.material3.IconButtonDefaults.filledIconButtonColors(
                                                containerColor = MaterialTheme.colorScheme.primaryContainer,
                                                contentColor = MaterialTheme.colorScheme.onPrimaryContainer
                                            )
                                        ) {
                                            Icon(painterResource(R.drawable.shuffle), null)
                                        }
                                    }
                                }
                            }
                        }
                        Spacer(modifier = Modifier.height(24.dp))
                    } else {
                        // --- CLASSIC DESIGN HEADER ---
                        Column {
                            if (thumbnail != null) {
                                Box(
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .aspectRatio(1.2f / 1),
                                ) {
                                    AsyncImage(
                                        model = thumbnail.resize(1200, 1000),
                                        contentDescription = null,
                                        modifier = Modifier
                                            .fillMaxWidth()
                                            .align(Alignment.TopCenter)
                                            .fadingEdge(
                                                bottom = 200.dp,
                                            ),
                                    )
                                }
                            }

                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(top = 8.dp, start = 16.dp, end = 16.dp, bottom = 0.dp)
                            ) {
                                Text(
                                    text = artistName,
                                    style = MaterialTheme.typography.headlineLarge,
                                    fontWeight = FontWeight.Bold,
                                    maxLines = 1,
                                    overflow = TextOverflow.Ellipsis,
                                    fontSize = 32.sp,
                                    modifier = Modifier.padding(bottom = 16.dp)
                                )

                                    PetalAdsBanner(
                                        modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp)
                                    )

                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    OutlinedButton(
                                        onClick = {
                                            database.transaction {
                                                val artist = libraryArtist?.artist
                                                if (artist != null) {
                                                    update(artist.toggleLike())
                                                } else {
                                                    artistPage?.artist?.let {
                                                        insert(
                                                            ArtistEntity(
                                                                id = it.id,
                                                                name = it.title,
                                                                thumbnailUrl = it.thumbnail,
                                                            ).toggleLike()
                                                        )
                                                    }
                                                }
                                            }
                                        },
                                        colors = ButtonDefaults.outlinedButtonColors(
                                            containerColor = if (libraryArtist?.artist?.bookmarkedAt != null)
                                                MaterialTheme.colorScheme.surface
                                            else
                                                Color.Transparent
                                        ),
                                        shape = RoundedCornerShape(50),
                                        modifier = Modifier.height(40.dp)
                                    ) {
                                        val isSubscribed = libraryArtist?.artist?.bookmarkedAt != null
                                        Text(
                                            text = stringResource(if (isSubscribed) R.string.subscribed else R.string.subscribe),
                                            fontSize = 14.sp,
                                            color = if (!isSubscribed) MaterialTheme.colorScheme.error else LocalContentColor.current
                                        )
                                    }

                                    Spacer(modifier = Modifier.weight(1f))

                                    Row(
                                        horizontalArrangement = Arrangement.spacedBy(16.dp),
                                        verticalAlignment = Alignment.CenterVertically
                                    ) {
                                        (artistPage?.artist?.radioEndpoint ?: libraryArtist?.artist?.id?.let {
                                            WatchEndpoint(videoId = null, playlistId = "RD$it")
                                        })?.let { radioEndpoint ->
                                            OutlinedButton(
                                                onClick = {
                                                    playerConnection.playQueue(YouTubeQueue(radioEndpoint))
                                                },
                                                shape = RoundedCornerShape(50),
                                                modifier = Modifier.height(40.dp)
                                            ) {
                                                Icon(
                                                    painter = painterResource(R.drawable.radio),
                                                    contentDescription = null,
                                                    modifier = Modifier.size(20.dp)
                                                )
                                                Spacer(modifier = Modifier.width(8.dp))
                                                Text(
                                                    text = stringResource(R.string.radio),
                                                    fontSize = 14.sp
                                                )
                                            }
                                        }

                                        (artistPage?.artist?.shuffleEndpoint ?: libraryArtist?.artist?.id?.let {
                                            WatchEndpoint(videoId = null, playlistId = "RD$it", params = "wAEB") // Fallback
                                        })?.let { shuffleEndpoint ->
                                            IconButton(
                                                onClick = {
                                                    playerConnection.playQueue(YouTubeQueue(shuffleEndpoint))
                                                },
                                                modifier = Modifier
                                                    .size(48.dp)
                                                    .background(
                                                        MaterialTheme.colorScheme.primary,
                                                        RoundedCornerShape(24.dp)
                                                    )
                                            ) {
                                                Icon(
                                                    painter = painterResource(R.drawable.shuffle),
                                                    contentDescription = "Shuffle",
                                                    tint = MaterialTheme.colorScheme.onPrimary,
                                                    modifier = Modifier.size(20.dp)
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                            Spacer(modifier = Modifier.height(16.dp))
                        }
                    }
                }

                item(key = "ad_banner") {
                    PetalAdsBanner(modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp))
                }

                if (librarySongs.isNotEmpty()) {
                    item {
                        NavigationTitle(
                            title = stringResource(R.string.from_your_library),
                            onClick = {
                                navController.navigate("artist/${viewModel.artistId}/songs")
                            },
                        )
                    }

                    items(
                        items = librarySongs,
                        key = { "local_${it.id}" },
                    ) { song ->
                        SongListItem(
                            song = song,
                            showInLibraryIcon = true,
                            isActive = song.id == mediaMetadata?.id,
                            isPlaying = isPlaying,
                            trailingContent = {
                                IconButton(
                                    onClick = {
                                        menuState.show {
                                            SongMenu(
                                                originalSong = song,
                                                navController = navController,
                                                onDismiss = menuState::dismiss,
                                            )
                                        }
                                    },
                                ) {
                                    Icon(
                                        painter = painterResource(R.drawable.more_vert),
                                        contentDescription = null,
                                    )
                                }
                            },
                            modifier = Modifier
                                .fillMaxWidth()
                                .combinedClickable(
                                    onClick = {
                                        if (song.id == mediaMetadata?.id) {
                                            playerConnection.player.togglePlayPause()
                                        } else {
                                            playerConnection.playQueue(
                                                YouTubeQueue(
                                                    WatchEndpoint(
                                                        videoId = song.id,
                                                    ),
                                                    song.toMediaMetadata(),
                                                ),
                                            )
                                        }
                                    },
                                    onLongClick = {
                                        haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                        menuState.show {
                                            SongMenu(
                                                originalSong = song,
                                                navController = navController,
                                                onDismiss = menuState::dismiss,
                                            )
                                        }
                                    },
                                )
                                .animateItem(),
                        )
                    }
                }

                if (libraryAlbums.isNotEmpty()) {
                    item {
                        NavigationTitle(
                            title = stringResource(R.string.albums_in_library),
                        )
                    }
                    item {
                        LazyRow {
                            items(
                                items = libraryAlbums,
                                key = { it.id }
                            ) { album ->
                                YouTubeGridItem(
                                    item = com.zionhuang.innertube.models.AlbumItem(
                                        browseId = album.id,
                                        playlistId = "",
                                        title = album.title,
                                        thumbnail = album.thumbnailUrl.orEmpty(),
                                        year = album.album.year,
                                        artists = album.artists.map { com.zionhuang.innertube.models.Artist(name = it.name, id = it.id) }
                                    ),
                                    isActive = mediaMetadata?.album?.id == album.id,
                                    isPlaying = isPlaying,
                                    coroutineScope = coroutineScope,
                                    modifier = Modifier
                                        .combinedClickable(
                                            onClick = {
                                                navController.navigate("album/${album.id}")
                                            },
                                            onLongClick = {
                                                haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                // Simplified menu for offline album or implementing one
                                            }
                                        )
                                        .animateItem()
                                )
                            }
                        }
                    }
                }

                artistPage?.sections?.fastForEach { section ->
                    item {
                        NavigationTitle(
                            title = section.title,
                            onClick = section.moreEndpoint?.let {
                                {
                                    navController.navigate("artist/${viewModel.artistId}/items?browseId=${it.browseId}?params=${it.params}")
                                }
                            }
                        )
                    }

                    if ((section.items.firstOrNull() as? SongItem)?.album != null) {
                        items(
                            items = section.items,
                            key = { it.id }
                        ) { song ->
                            YouTubeListItem(
                                item = song as SongItem,
                                isActive = mediaMetadata?.id == song.id,
                                isPlaying = isPlaying,
                                trailingContent = {
                                    IconButton(
                                        onClick = {
                                            menuState.show {
                                                YouTubeSongMenu(
                                                    song = song,
                                                    navController = navController,
                                                    onDismiss = menuState::dismiss
                                                )
                                            }
                                        }
                                    ) {
                                        Icon(
                                            painter = painterResource(R.drawable.more_vert),
                                            contentDescription = null
                                        )
                                    }
                                },
                                modifier = Modifier
                                    .clickable {
                                        if (song.id == mediaMetadata?.id) {
                                            playerConnection.player.togglePlayPause()
                                        } else {
                                            playerConnection.playQueue(YouTubeQueue.radio(song.toMediaMetadata()))
                                        }
                                    }
                                    .animateItem()
                            )
                        }
                    } else {
                        item {
                            LazyRow {
                                items(
                                    items = section.items,
                                    key = { it.id }
                                ) { item ->
                                    YouTubeGridItem(
                                        item = item,
                                        isActive = when (item) {
                                            is SongItem -> mediaMetadata?.id == item.id
                                            is AlbumItem -> mediaMetadata?.album?.id == item.id
                                            else -> false
                                        },
                                        isPlaying = isPlaying,
                                        coroutineScope = coroutineScope,
                                        modifier = Modifier
                                            .combinedClickable(
                                                onClick = {
                                                    when (item) {
                                                        is SongItem -> playerConnection.playQueue(YouTubeQueue.radio(item.toMediaMetadata()))
                                                        is AlbumItem -> navController.navigate("album/${item.id}")
                                                        is ArtistItem -> navController.navigate("artist/${item.id}")
                                                        is PlaylistItem -> navController.navigate("online_playlist/${item.id}")
                                                    }
                                                },
                                                onLongClick = {
                                                    haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                                                    menuState.show {
                                                        when (item) {
                                                            is SongItem ->
                                                                YouTubeSongMenu(
                                                                    song = item,
                                                                    navController = navController,
                                                                    onDismiss = menuState::dismiss,
                                                                )

                                                            is AlbumItem ->
                                                                YouTubeAlbumMenu(
                                                                    albumItem = item,
                                                                    navController = navController,
                                                                    onDismiss = menuState::dismiss,
                                                                )

                                                            is ArtistItem ->
                                                                YouTubeArtistMenu(
                                                                    artist = item,
                                                                    onDismiss = menuState::dismiss,
                                                                )

                                                            is PlaylistItem ->
                                                                YouTubePlaylistMenu(
                                                                    playlist = item,
                                                                    coroutineScope = coroutineScope,
                                                                    onDismiss = menuState::dismiss,
                                                                )
                                                        }
                                                    }
                                                },
                                            )
                                            .animateItem(),
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }

        SnackbarHost(
            hostState = snackbarHostState,
            modifier = Modifier
                .windowInsetsPadding(LocalPlayerAwareWindowInsets.current)
                .align(Alignment.BottomCenter)
        )
    }

    TopAppBar(
        title = { if (!transparentAppBar) Text(artistPage?.artist?.title ?: libraryArtist?.artist?.name.orEmpty()) },
        navigationIcon = {
            IconButton(
                onClick = navController::navigateUp,
                onLongClick = navController::backToMain,
            ) {
                Icon(
                    painterResource(R.drawable.arrow_back),
                    contentDescription = null,
                )
            }
        },
        actions = {
            IconButton(
                onClick = {
                    viewModel.artistPage?.artist?.shareLink?.let { link ->
                        val clipboard = context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
                        val clip = ClipData.newPlainText("Artist Link", link)
                        clipboard.setPrimaryClip(clip)
                        Toast.makeText(context, R.string.link_copied, Toast.LENGTH_SHORT).show()
                    }
                },
            ) {
                Icon(
                    painterResource(R.drawable.share),
                    contentDescription = null,
                )
            }
        },
        scrollBehavior = scrollBehavior,
        colors =
            if (transparentAppBar) {
                TopAppBarDefaults.topAppBarColors(containerColor = Color.Transparent)
            } else {
                TopAppBarDefaults.topAppBarColors()
            },
    )
}