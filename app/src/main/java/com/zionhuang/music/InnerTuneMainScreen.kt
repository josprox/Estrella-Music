package com.zionhuang.music

import BottomSheetPlayer
import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.drawable.BitmapDrawable
// MODIFICADO: Asegúrate de que el import sea el genérico y no uno específico de un Scope.
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.Crossfade
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideInHorizontally
import androidx.compose.animation.slideOutHorizontally
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AlertDialogDefaults
import androidx.compose.material3.Badge
import androidx.compose.material3.BadgedBox
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.NavigationRail
import androidx.compose.material3.NavigationRailItem
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.contentColorFor
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.TextRange
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.util.fastAny
import androidx.compose.ui.util.fastForEach
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import androidx.core.util.Consumer
import androidx.navigation.NavDestination.Companion.hierarchy
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import coil.imageLoader
import coil.request.ImageRequest
import com.valentinilk.shimmer.LocalShimmerTheme
import com.zionhuang.innertube.models.SongItem
import com.zionhuang.music.constants.*
import com.zionhuang.music.db.MusicDatabase
import com.zionhuang.music.db.entities.SearchHistory
import com.zionhuang.music.extensions.toEnum
import com.zionhuang.music.playback.DownloadUtil
import com.zionhuang.music.playback.PlayerConnection
import com.zionhuang.music.ui.component.BottomSheetMenu
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.LocalMenuState
import com.zionhuang.music.ui.component.SearchBar
import com.zionhuang.music.ui.component.getIconForDate
import com.zionhuang.music.ui.component.rememberBottomSheetState
import com.zionhuang.music.ui.component.shimmer.ShimmerTheme
import com.zionhuang.music.ui.menu.YouTubeSongMenu
import com.zionhuang.music.ui.screens.Screens
import com.zionhuang.music.ui.screens.navigationBuilder
import com.zionhuang.music.ui.screens.search.LocalSearchScreen
import com.zionhuang.music.ui.screens.search.OnlineSearchScreen
import com.zionhuang.music.ui.screens.settings.DarkMode
import com.zionhuang.music.ui.screens.settings.NavigationTab
import com.zionhuang.music.ui.theme.ColorSaver
import com.zionhuang.music.ui.theme.DefaultThemeColor
import com.zionhuang.music.ui.theme.InnerTuneTheme
import com.zionhuang.music.ui.theme.extractThemeColor
import com.zionhuang.music.ui.utils.appBarScrollBehavior
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.ui.utils.iconResultToPainter
import com.zionhuang.music.ui.utils.resetHeightOffset
import com.zionhuang.music.utils.DeepLinkHandler
import com.zionhuang.music.utils.UpdateMainViewModel
import com.zionhuang.music.utils.dataStore
import com.zionhuang.music.utils.rememberEnumPreference
import com.zionhuang.music.utils.rememberPreference
import com.zionhuang.music.utils.urlEncode
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

// Usa el IconButton de Material3 sólo en el trailing
import androidx.compose.material3.IconButton as M3IconButton
import com.zionhuang.music.utils.get

@SuppressLint("UnusedBoxWithConstraintsScope")
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun InnerTuneMainScreen(
    database: MusicDatabase,
    downloadUtil: DownloadUtil,
    playerConnection: PlayerConnection?,
    updateViewModel: UpdateMainViewModel,
    initialIntent: Intent?,
    onConsumeInitialIntent: () -> Unit,
    addOnNewIntentListener: (Consumer<Intent>) -> Unit,
    removeOnNewIntentListener: (Consumer<Intent>) -> Unit,
    setSystemBarAppearance: (Boolean) -> Unit
) {
    val showBadge by updateViewModel.showUpdateBadge.collectAsState()
    val latestVersionName by updateViewModel.latestVersionName.collectAsState()

    val enableDynamicTheme by rememberPreference(DynamicThemeKey, defaultValue = true)
    val darkTheme by rememberEnumPreference(DarkModeKey, defaultValue = DarkMode.AUTO)
    val pureBlack by rememberPreference(PureBlackKey, defaultValue = false)
    val systemDark = isSystemInDarkTheme()
    val useDarkTheme = remember(darkTheme, systemDark) {
        if (darkTheme == DarkMode.AUTO) systemDark else darkTheme == DarkMode.ON
    }
    LaunchedEffect(useDarkTheme) { setSystemBarAppearance(useDarkTheme) }

    val ctx = LocalContext.current
    var themeColor by rememberSaveable(stateSaver = ColorSaver) { mutableStateOf(DefaultThemeColor) }
    val iconPainter = iconResultToPainter(getIconForDate())
    val scope = rememberCoroutineScope()

    LaunchedEffect(playerConnection, enableDynamicTheme, systemDark) {
        val pc = playerConnection
        if (!enableDynamicTheme || pc == null) {
            themeColor = DefaultThemeColor
            return@LaunchedEffect
        }
        pc.service.currentMediaMetadata.collect { song ->
            themeColor = if (song != null) {
                withContext(Dispatchers.IO) {
                    val result = ctx.imageLoader.execute(
                        ImageRequest.Builder(ctx)
                            .data(song.thumbnailUrl)
                            .allowHardware(false)
                            .build()
                    )
                    (result.drawable as? BitmapDrawable)?.bitmap?.extractThemeColor() ?: DefaultThemeColor
                }
            } else DefaultThemeColor
        }
    }

    InnerTuneTheme(darkTheme = useDarkTheme, pureBlack = pureBlack, themeColor = themeColor) {
        BoxWithConstraints(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.surface)
        ) {
            val isExpandedScreen = this.maxWidth > 600.dp

            val focusManager = LocalFocusManager.current
            val density = LocalDensity.current
            val windowsInsets = WindowInsets.systemBars
            val bottomInset = with(density) { windowsInsets.getBottom(density).toDp() }

            val navController = rememberNavController()

            var deepLinkHandler by remember { mutableStateOf<DeepLinkHandler?>(null) }
            LaunchedEffect(navController) {
                deepLinkHandler = DeepLinkHandler(navController, scope)
                initialIntent?.let { intent ->
                    deepLinkHandler?.handleInitialDeepLink(intent)
                    onConsumeInitialIntent()
                }
            }

            val navBackStackEntry by navController.currentBackStackEntryAsState()
            val inSelectMode =
                navBackStackEntry?.savedStateHandle?.getStateFlow("inSelectMode", false)?.collectAsState()

            val navigationItems = remember { Screens.MainScreens }
            val defaultOpenTab = remember {
                ctx.dataStore[DefaultOpenTabKey].toEnum(defaultValue = NavigationTab.HOME)
            }
            val (slimNav) = rememberPreference(SlimNavBarKey, defaultValue = false)

            val tabOpenedFromShortcut = remember(initialIntent) {
                when (initialIntent?.action) {
                    MainActivity.ACTION_SONGS -> NavigationTab.SONG
                    MainActivity.ACTION_ALBUMS -> NavigationTab.ALBUM
                    MainActivity.ACTION_PLAYLISTS -> NavigationTab.PLAYLIST
                    else -> null
                }
            }

            val topLevelScreens = listOf(
                Screens.Home.route,
                Screens.Songs.route,
                Screens.Artists.route,
                Screens.Albums.route,
                Screens.Playlists.route,
                "settings"
            )

            val (query, onQueryChange) = rememberSaveable(stateSaver = TextFieldValue.Saver) {
                mutableStateOf(TextFieldValue())
            }
            var active by rememberSaveable { mutableStateOf(false) }
            val onActiveChange: (Boolean) -> Unit = { newActive ->
                active = newActive
                if (!newActive) {
                    focusManager.clearFocus()
                    if (navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route }) {
                        onQueryChange(TextFieldValue())
                    }
                }
            }
            var searchSource by rememberEnumPreference(SearchSourceKey, SearchSource.ONLINE)
            val searchBarFocusRequester = remember { FocusRequester() }

            val onSearch: (String) -> Unit = {
                if (it.isNotEmpty()) {
                    onActiveChange(false)
                    navController.navigate("search/${it.urlEncode()}")
                    if (ctx.dataStore[PauseSearchHistoryKey] != true) {
                        database.query { insert(SearchHistory(query = it)) }
                    }
                }
            }

            var openSearchImmediately by remember {
                mutableStateOf(initialIntent?.action == MainActivity.ACTION_SEARCH)
            }

            val shouldShowSearchBar = remember(active, navBackStackEntry, inSelectMode?.value) {
                (active ||
                        navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route } ||
                        navBackStackEntry?.destination?.route?.startsWith("search/") == true) &&
                        inSelectMode?.value != true
            }
            val shouldShowNavigationBar = remember(navBackStackEntry, active) {
                navBackStackEntry?.destination?.route == null ||
                        navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route } && !active
            }

            fun getNavPadding(): Dp =
                if (shouldShowNavigationBar && !isExpandedScreen) if (slimNav) 52.dp else 68.dp else 0.dp

            val navigationBarHeight by animateDpAsState(
                targetValue = if (shouldShowNavigationBar && !isExpandedScreen) NavigationBarHeight else 0.dp,
                animationSpec = NavigationBarAnimationSpec,
                label = ""
            )

            val playerBottomSheetState = rememberBottomSheetState(
                dismissedBound = 0.dp,
                collapsedBound = bottomInset + getNavPadding() + MiniPlayerHeight,
                expandedBound = maxHeight,
            )

            val playerAwareWindowInsets =
                remember(bottomInset, shouldShowNavigationBar, playerBottomSheetState.isDismissed, isExpandedScreen) {
                    var bottom = bottomInset
                    if (shouldShowNavigationBar && !isExpandedScreen) bottom += NavigationBarHeight
                    if (!playerBottomSheetState.isDismissed) bottom += MiniPlayerHeight
                    windowsInsets
                        .only(WindowInsetsSides.Horizontal + WindowInsetsSides.Top)
                        .add(WindowInsets(top = AppBarHeight, bottom = bottom))
                }

            val searchBarScrollBehavior = appBarScrollBehavior(
                canScroll = {
                    navBackStackEntry?.destination?.route?.startsWith("search/") == false &&
                            (playerBottomSheetState.isCollapsed || playerBottomSheetState.isDismissed)
                }
            )
            val topAppBarScrollBehavior = appBarScrollBehavior(
                canScroll = {
                    navBackStackEntry?.destination?.route?.startsWith("search/") == false &&
                            (playerBottomSheetState.isCollapsed || playerBottomSheetState.isDismissed)
                }
            )

            LaunchedEffect(navBackStackEntry) {
                if (navBackStackEntry?.destination?.route?.startsWith("search/") == true) {
                    val searchQuery = withContext(Dispatchers.IO) {
                        navBackStackEntry?.arguments?.getString("query")!!
                    }
                    onQueryChange(TextFieldValue(searchQuery, TextRange(searchQuery.length)))
                } else if (navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route }) {
                    onQueryChange(TextFieldValue())
                }
                searchBarScrollBehavior.state.resetHeightOffset()
                topAppBarScrollBehavior.state.resetHeightOffset()
            }
            LaunchedEffect(active) {
                if (active) {
                    searchBarScrollBehavior.state.resetHeightOffset()
                    topAppBarScrollBehavior.state.resetHeightOffset()
                }
            }

            LaunchedEffect(playerConnection) {
                val player = playerConnection?.player ?: return@LaunchedEffect
                if (player.currentMediaItem == null) {
                    if (!playerBottomSheetState.isDismissed) playerBottomSheetState.dismiss()
                } else {
                    if (playerBottomSheetState.isDismissed) playerBottomSheetState.collapseSoft()
                }
            }

            DisposableEffect(playerConnection, playerBottomSheetState) {
                val player = playerConnection?.player ?: return@DisposableEffect onDispose { }
                val listener = object : androidx.media3.common.Player.Listener {
                    override fun onMediaItemTransition(
                        mediaItem: androidx.media3.common.MediaItem?,
                        reason: Int
                    ) {
                        if (reason == androidx.media3.common.Player.MEDIA_ITEM_TRANSITION_REASON_PLAYLIST_CHANGED &&
                            mediaItem != null && playerBottomSheetState.isDismissed
                        ) {
                            playerBottomSheetState.collapseSoft()
                        }
                    }
                }
                player.addListener(listener)
                onDispose { player.removeListener(listener) }
            }

            val coroutineScope = rememberCoroutineScope()
            var sharedSong: SongItem? by remember { mutableStateOf(null) }

            DisposableEffect(Unit) {
                val listener = Consumer<Intent> { intent ->
                    deepLinkHandler?.handleNewIntent(intent) { song -> sharedSong = song }
                }
                addOnNewIntentListener(listener)
                onDispose { removeOnNewIntentListener(listener) }
            }

            Row(modifier = Modifier.fillMaxSize()) {
                // Esta es la barra de navegación lateral. Su AnimatedVisibility usa el contexto de Row.
                AnimatedVisibility(
                    visible = isExpandedScreen && shouldShowNavigationBar,
                    enter = slideInHorizontally(animationSpec = tween(250)) { -it },
                    exit = slideOutHorizontally(animationSpec = tween(200)) { -it }
                ) {
                    NavigationRail(
                        modifier = Modifier.padding(top = AppBarHeight)
                    ) {
                        navigationItems.fastForEach { screen ->
                            NavigationRailItem(
                                selected = navBackStackEntry?.destination?.hierarchy?.any { it.route == screen.route } == true,
                                icon = { Icon(painter = painterResource(screen.iconId), contentDescription = null) },
                                label = {
                                    Text(
                                        text = stringResource(screen.titleId),
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis
                                    )
                                },
                                alwaysShowLabel = false,
                                onClick = {
                                    if (navBackStackEntry?.destination?.hierarchy?.any { it.route == screen.route } == true) {
                                        navBackStackEntry?.savedStateHandle?.set("scrollToTop", true)
                                        coroutineScope.launch {
                                            searchBarScrollBehavior.state.resetHeightOffset()
                                        }
                                    } else {
                                        navController.navigate(screen.route) {
                                            popUpTo(navController.graph.startDestinationId) { saveState = true }
                                            launchSingleTop = true
                                            restoreState = true
                                        }
                                    }
                                }
                            )
                        }
                    }
                }

                Box(modifier = Modifier.weight(1f)) {
                    CompositionLocalProvider(
                        LocalDatabase provides database,
                        LocalContentColor provides contentColorFor(MaterialTheme.colorScheme.surface),
                        LocalPlayerConnection provides playerConnection,
                        LocalPlayerAwareWindowInsets provides playerAwareWindowInsets,
                        LocalDownloadUtil provides downloadUtil,
                        LocalShimmerTheme provides ShimmerTheme
                    ) {
                        NavHost(
                            navController = navController,
                            startDestination = when (tabOpenedFromShortcut ?: defaultOpenTab) {
                                NavigationTab.HOME -> Screens.Home
                                NavigationTab.SONG -> Screens.Songs
                                NavigationTab.ARTIST -> Screens.Artists
                                NavigationTab.ALBUM -> Screens.Albums
                                NavigationTab.PLAYLIST -> Screens.Playlists
                            }.route,
                            enterTransition = {
                                if (initialState.destination.route in topLevelScreens && targetState.destination.route in topLevelScreens) {
                                    fadeIn(tween(250))
                                } else {
                                    fadeIn(tween(250)) + slideInHorizontally { it / 2 }
                                }
                            },
                            exitTransition = {
                                if (initialState.destination.route in topLevelScreens && targetState.destination.route in topLevelScreens) {
                                    fadeOut(tween(200))
                                } else {
                                    fadeOut(tween(200)) + slideOutHorizontally { -it / 2 }
                                }
                            },
                            popEnterTransition = {
                                if ((initialState.destination.route in topLevelScreens ||
                                            initialState.destination.route?.startsWith("search/") == true) &&
                                    targetState.destination.route in topLevelScreens
                                ) {
                                    fadeIn(tween(250))
                                } else {
                                    fadeIn(tween(250)) + slideInHorizontally { -it / 2 }
                                }
                            },
                            popExitTransition = {
                                if ((initialState.destination.route in topLevelScreens ||
                                            initialState.destination.route?.startsWith("search/") == true) &&
                                    targetState.destination.route in topLevelScreens
                                ) {
                                    fadeOut(tween(200))
                                } else {
                                    fadeOut(tween(200)) + slideOutHorizontally { it / 2 }
                                }
                            },
                            modifier = Modifier.nestedScroll(
                                if (navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route } ||
                                    navBackStackEntry?.destination?.route?.startsWith("search/") == true
                                ) {
                                    searchBarScrollBehavior.nestedScrollConnection
                                } else {
                                    topAppBarScrollBehavior.nestedScrollConnection
                                }
                            )
                        ) {
                            (latestVersionName ?: ctx.packageManager.getPackageInfo(ctx.packageName, 0).versionName)?.let {
                                navigationBuilder(navController, topAppBarScrollBehavior, updateViewModel)
                            }
                        }

                        // SearchBar
                        // Esta AnimatedVisibility usa la versión genérica, porque está dentro de un Box.
                        androidx.compose.animation.AnimatedVisibility(
                            visible = shouldShowSearchBar,
                            enter = fadeIn(),
                            exit = fadeOut()
                        ) {
                            SearchBar(
                                query = query,
                                onQueryChange = onQueryChange,
                                onSearch = onSearch,
                                active = active,
                                onActiveChange = onActiveChange,
                                scrollBehavior = searchBarScrollBehavior,
                                placeholder = {
                                    Text(
                                        text = stringResource(
                                            if (!active) R.string.search
                                            else when (searchSource) {
                                                SearchSource.LOCAL -> R.string.search_library
                                                SearchSource.ONLINE -> R.string.search_yt_music
                                            }
                                        )
                                    )
                                },
                                leadingIcon = {
                                    IconButton(
                                        onClick = {
                                            when {
                                                active -> onActiveChange(false)
                                                !navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route } -> {
                                                    navController.navigateUp()
                                                }
                                                else -> onActiveChange(true)
                                            }
                                        },
                                        onLongClick = {
                                            when {
                                                active -> {}
                                                !navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route } -> {
                                                    navController.backToMain()
                                                }
                                                else -> {}
                                            }
                                        }
                                    ) {
                                        Icon(
                                            painterResource(
                                                if (active || !navigationItems.fastAny { it.route == navBackStackEntry?.destination?.route }) {
                                                    R.drawable.arrow_back
                                                } else {
                                                    R.drawable.search
                                                }
                                            ),
                                            contentDescription = null
                                        )
                                    }
                                },
                                trailingIcon = {
                                    if (active) {
                                        if (query.text.isNotEmpty()) {
                                            M3IconButton(onClick = { onQueryChange(TextFieldValue("")) }) {
                                                Icon(
                                                    painter = painterResource(R.drawable.close),
                                                    contentDescription = null
                                                )
                                            }
                                        }
                                        M3IconButton(
                                            onClick = {
                                                searchSource =
                                                    if (searchSource == SearchSource.ONLINE) SearchSource.LOCAL else SearchSource.ONLINE
                                            }
                                        ) {
                                            Icon(
                                                painter = painterResource(
                                                    when (searchSource) {
                                                        SearchSource.LOCAL -> R.drawable.library_music
                                                        SearchSource.ONLINE -> R.drawable.language
                                                    }
                                                ),
                                                contentDescription = null
                                            )
                                        }
                                    } else if (navBackStackEntry?.destination?.route in topLevelScreens) {
                                        Box(
                                            contentAlignment = Alignment.Center,
                                            modifier = Modifier
                                                .size(48.dp)
                                                .clip(CircleShape)
                                                .clickable { navController.navigate("settings") }
                                        ) {
                                            BadgedBox(badge = { if (showBadge) Badge() }) {
                                                Icon(painter = iconPainter, contentDescription = null)
                                            }
                                        }
                                    }
                                },
                                focusRequester = searchBarFocusRequester,
                                modifier = Modifier.align(Alignment.TopCenter),
                            ) {
                                Crossfade(
                                    targetState = searchSource,
                                    label = "",
                                    modifier = Modifier
                                        .fillMaxSize()
                                        .padding(bottom = if (!playerBottomSheetState.isDismissed) MiniPlayerHeight else 0.dp)
                                        .navigationBarsPadding()
                                ) { source ->
                                    when (source) {
                                        SearchSource.LOCAL -> LocalSearchScreen(
                                            query = query.text,
                                            navController = navController,
                                            onDismiss = { onActiveChange(false) }
                                        )

                                        SearchSource.ONLINE -> OnlineSearchScreen(
                                            query = query.text,
                                            onQueryChange = onQueryChange,
                                            navController = navController,
                                            onSearch = {
                                                navController.navigate("search/${it.urlEncode()}")
                                                if (ctx.dataStore[PauseSearchHistoryKey] != true) {
                                                    database.query { insert(SearchHistory(query = it)) }
                                                }
                                            },
                                            onDismiss = { onActiveChange(false) }
                                        )
                                    }
                                }
                            }
                        }

                        BottomSheetPlayer(
                            state = playerBottomSheetState,
                            navController = navController,
                        )

                        NavigationBar(
                            modifier = Modifier
                                .align(Alignment.BottomCenter)
                                .height(bottomInset + getNavPadding())
                                .offset {
                                    if (navigationBarHeight == 0.dp) {
                                        IntOffset(x = 0, y = (bottomInset + NavigationBarHeight).roundToPx())
                                    } else {
                                        val slideOffset =
                                            (bottomInset + NavigationBarHeight) * playerBottomSheetState.progress.coerceIn(0f, 1f)
                                        val hideOffset =
                                            (bottomInset + NavigationBarHeight) * (1 - navigationBarHeight / NavigationBarHeight)
                                        IntOffset(x = 0, y = (slideOffset + hideOffset).roundToPx())
                                    }
                                }
                        ) {
                            navigationItems.fastForEach { screen ->
                                NavigationBarItem(
                                    selected = navBackStackEntry?.destination?.hierarchy?.any { it.route == screen.route } == true,
                                    icon = { Icon(painter = painterResource(screen.iconId), contentDescription = null) },
                                    label = {
                                        if (!slimNav) {
                                            Text(
                                                text = stringResource(screen.titleId),
                                                maxLines = 1,
                                                overflow = TextOverflow.Ellipsis
                                            )
                                        }
                                    },
                                    onClick = {
                                        if (navBackStackEntry?.destination?.hierarchy?.any { it.route == screen.route } == true) {
                                            navBackStackEntry?.savedStateHandle?.set("scrollToTop", true)
                                            coroutineScope.launch {
                                                searchBarScrollBehavior.state.resetHeightOffset()
                                            }
                                        } else {
                                            navController.navigate(screen.route) {
                                                popUpTo(navController.graph.startDestinationId) { saveState = true }
                                                launchSingleTop = true
                                                restoreState = true
                                            }
                                        }
                                    }
                                )
                            }
                        }

                        BottomSheetMenu(
                            state = LocalMenuState.current,
                            modifier = Modifier.align(Alignment.BottomCenter)
                        )

                        sharedSong?.let { song ->
                            playerConnection?.let {
                                Dialog(
                                    onDismissRequest = { sharedSong = null },
                                    properties = DialogProperties(usePlatformDefaultWidth = false)
                                ) {
                                    Surface(
                                        modifier = Modifier.padding(24.dp),
                                        shape = RoundedCornerShape(16.dp),
                                        color = AlertDialogDefaults.containerColor,
                                        tonalElevation = AlertDialogDefaults.TonalElevation
                                    ) {
                                        Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                            YouTubeSongMenu(
                                                song = song,
                                                navController = navController,
                                                onDismiss = { sharedSong = null }
                                            )
                                        }
                                    }
                                }
                            }
                        }
                    }

                    LaunchedEffect(shouldShowSearchBar, openSearchImmediately) {
                        if (shouldShowSearchBar && openSearchImmediately) {
                            onActiveChange(true)
                            searchBarFocusRequester.requestFocus()
                            openSearchImmediately = false
                        }
                    }
                }
            }
        }
    }
}