package com.zionhuang.music

import android.Manifest
import android.annotation.SuppressLint
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.content.res.Configuration
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.view.WindowManager
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.viewinterop.AndroidView
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.FullscreenExit
import androidx.compose.material.icons.filled.HighQuality
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.media3.ui.PlayerView
import androidx.compose.ui.res.stringResource
import androidx.core.content.ContextCompat
import androidx.core.view.WindowCompat
import androidx.datastore.preferences.core.edit
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ProcessLifecycleOwner
import androidx.lifecycle.lifecycleScope
import androidx.work.Constraints
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.NetworkType
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import com.josprox.jossredconnect.services.AuthService
import com.onesignal.OneSignal
import com.zionhuang.music.constants.AlwaysCloudBackupKey
import com.zionhuang.music.constants.DisableScreenshotKey
import com.zionhuang.music.constants.FirstUseAtKey
import com.zionhuang.music.constants.OnboardingShownKey
import com.zionhuang.music.constants.ShowVideoPlayerKey
import com.zionhuang.music.constants.StopMusicOnTaskClearKey
import com.zionhuang.music.constants.VideoQualityKey
import com.zionhuang.music.db.MusicDatabase
import com.zionhuang.music.playback.DownloadUtil
import com.zionhuang.music.playback.MusicService
import com.zionhuang.music.playback.MusicService.MusicBinder
import com.zionhuang.music.playback.PlayerConnection
import com.zionhuang.music.ui.auth.WelcomeRoute
import com.zionhuang.music.ui.onboarding.CarouselItem
import com.zionhuang.music.ui.onboarding.OnboardingScreen
import com.zionhuang.music.ui.screens.NotificationPermissionScreen
import com.zionhuang.music.utils.UpdateChecker
import com.zionhuang.music.utils.UpdateMainViewModel
import com.zionhuang.music.utils.UpdateMainViewModelFactory
import com.zionhuang.music.utils.dataStore
import com.zionhuang.music.utils.get
import com.zionhuang.music.work.CloudBackupWorker
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import timber.log.Timber
import java.util.concurrent.TimeUnit
import javax.inject.Inject
import javax.inject.Named

val LocalPiPMode = compositionLocalOf { false }
val LocalFullscreenVideo = compositionLocalOf { false }
val LocalSetFullscreenVideo = compositionLocalOf<(Boolean) -> Unit> { {} }

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    @Inject lateinit var database: MusicDatabase
    @Inject lateinit var downloadUtil: DownloadUtil
    @Inject lateinit var auth: AuthService
    @Inject @Named("OneSignalAppId") lateinit var oneSignalAppId: String

    private var isServiceBound = false
    private var playerConnection by mutableStateOf<PlayerConnection?>(null)

    private var isInPipMode by mutableStateOf(false)
    private var isVideoModeEnabled by mutableStateOf(false)
    private var isFullscreenVideo by mutableStateOf(false)

    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            if (service is MusicBinder) {
                playerConnection = PlayerConnection(this@MainActivity, service, database, lifecycleScope)
                isServiceBound = true
            }
        }
        override fun onServiceDisconnected(name: ComponentName?) {
            playerConnection?.dispose()
            playerConnection = null
            isServiceBound = false
        }
    }

    private fun safeUnbindService(source: String) {
        if (!isServiceBound) return
        try {
            unbindService(serviceConnection)
        } catch (e: IllegalArgumentException) {
            Timber.tag("MainActivity").w(e, "Service was not bound when attempting to unbind in $source")
        } finally {
            isServiceBound = false
        }
    }

    private var initialIntent: Intent? = null

    private val updateViewModel: UpdateMainViewModel by viewModels {
        UpdateMainViewModelFactory(application)
    }

    override fun onStart() {
        super.onStart()
        if (!isServiceBound) bindMusicService()
    }

    override fun onStop() {
        super.onStop()
    }

    override fun onUserLeaveHint() {
        super.onUserLeaveHint()
        if (!isVideoModeEnabled) return
        
        val player = playerConnection?.player
        if (player != null && player.isPlaying) {
            val hasVideo = player.currentTracks.groups.any { it.type == androidx.media3.common.C.TRACK_TYPE_VIDEO && it.length > 0 }
            if (hasVideo) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    try {
                        val params = android.app.PictureInPictureParams.Builder()
                            .setAspectRatio(android.util.Rational(16, 9))
                            .build()
                        enterPictureInPictureMode(params)
                    } catch (e: IllegalStateException) {
                        android.util.Log.w("MainActivity", "PiP no soportado en este dispositivo/configuración: ${e.message}")
                    }
                }
            }
        }
    }

    override fun onPictureInPictureModeChanged(isInPictureInPictureMode: Boolean, newConfig: Configuration) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        isInPipMode = isInPictureInPictureMode
    }

    override fun onDestroy() {
        super.onDestroy()
        val stopServiceOnClear =
            dataStore.get(StopMusicOnTaskClearKey, false) &&
                playerConnection?.isPlaying?.value == true &&
                isFinishing

        playerConnection?.dispose()
        playerConnection = null
        safeUnbindService("onDestroy()")

        if (stopServiceOnClear) {
            stopService(Intent(this, MusicService::class.java))
        }
    }

    @SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
    override fun onCreate(savedInstanceState: Bundle?) {
        setTheme(R.style.Theme_InnerTune)
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)

        initialIntent = intent

        if (oneSignalAppId.isNotBlank()) {
            OneSignal.initWithContext(this, oneSignalAppId)
        } else {
            Timber.w("OneSignal App Id vacío; se omite inicialización.")
        }



        UpdateChecker(this).checkForUpdates()

        lifecycleScope.launch {
            dataStore.data
                .map { it[DisableScreenshotKey] == true }
                .distinctUntilChanged()
                .collectLatest { secure ->
                    if (secure) {
                        window.setFlags(
                            WindowManager.LayoutParams.FLAG_SECURE,
                            WindowManager.LayoutParams.FLAG_SECURE
                        )
                    } else {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                    }
                }
        }

        lifecycleScope.launch {
            dataStore.data
                .map { it[ShowVideoPlayerKey] == true }
                .distinctUntilChanged()
                .collectLatest { isVideoModeEnabled = it }
        }

        requestNotificationPermission()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        initialIntent = intent

        lifecycleScope.launch {
            val loggedIn = ensureValidSession()
            if (!loggedIn) {
                showWelcome()
            } else {
                initializeApp()
            }
        }
    }

    private fun bindMusicService() {
        val serviceIntent = Intent(this, MusicService::class.java)

        if (!MusicService.isRunning) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                ContextCompat.startForegroundService(this, serviceIntent)
            } else {
                startService(serviceIntent)
            }
        }

        if (!isServiceBound) {
            isServiceBound = bindService(serviceIntent, serviceConnection, BIND_AUTO_CREATE)
        }
    }

    private fun initializeApp() {
        setContent {
            val setFullscreen: (Boolean) -> Unit = { value ->
                isFullscreenVideo = value
                requestedOrientation = if (value)
                    android.content.pm.ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE
                else
                    android.content.pm.ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED
            }

            when {
                isInPipMode && playerConnection?.player != null -> {
                    // PiP: solo el video, sin más UI
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(Color.Black)
                    ) {
                        AndroidView(
                            factory = { ctx ->
                                PlayerView(ctx).apply {
                                    player = playerConnection!!.player
                                    useController = false
                                    resizeMode = androidx.media3.ui.AspectRatioFrameLayout.RESIZE_MODE_ZOOM
                                }
                            },
                            modifier = Modifier.fillMaxSize()
                        )
                    }
                }
                isFullscreenVideo && playerConnection?.player != null -> {
                    // Fullscreen: PlayerView con controles, orientación landscape
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(Color.Black)
                    ) {
                        AndroidView(
                            factory = { ctx ->
                                PlayerView(ctx).apply {
                                    player = playerConnection!!.player
                                    useController = false
                                    resizeMode = androidx.media3.ui.AspectRatioFrameLayout.RESIZE_MODE_FIT
                                }
                            },
                            modifier = Modifier.fillMaxSize()
                        )
                        // Botones overlay: salir fullscreen + calidad
                        FullscreenVideoControls(
                            player = playerConnection!!.player,
                            onExitFullscreen = { setFullscreen(false) }
                        )
                    }
                }
                else -> {
                    CompositionLocalProvider(
                        LocalPiPMode provides isInPipMode,
                        LocalFullscreenVideo provides isFullscreenVideo,
                        LocalSetFullscreenVideo provides setFullscreen,
                    ) {
                        InnerTuneMainScreen(
                            database = database,
                            downloadUtil = downloadUtil,
                            playerConnection = playerConnection,
                            updateViewModel = updateViewModel,
                            initialIntent = initialIntent,
                            onConsumeInitialIntent = { initialIntent = null },
                            addOnNewIntentListener = this@MainActivity::addOnNewIntentListener,
                            removeOnNewIntentListener = this@MainActivity::removeOnNewIntentListener,
                            setSystemBarAppearance = ::setSystemBarAppearance
                        )
                    }
                }
            }
        }
        lifecycleScope.launch { tryScheduleDailyCloudBackup() }
    }

    private fun showWelcome() {
        setContent {
            WelcomeRoute(
                onAuthSuccess = {
                    initializeApp()
                    lifecycleScope.launch { tryScheduleDailyCloudBackup() }
                },
                onSkip = {
                    initializeApp()
                }
            )
        }
    }

    private suspend fun ensureValidSession(): Boolean = withContext(Dispatchers.IO) {
        if (isNetworkAvailable()) {
            try {
                Timber.d("Hay conexión. Validando token con el servidor...")
                val res = auth.checkToken()
                val ok = (res["success"] == true && (res["valid"] as? Boolean ?: false))
                if (!ok) {
                    Timber.w("Token inválido o sesión expirada según el servidor. Cerrando sesión.")
                    auth.logout()
                }
                ok
            } catch (e: Exception) {
                Timber.e(e, "Error inesperado durante la comprobación de sesión con internet.")
                auth.logout()
                false
            }
        } else {
            Timber.d("No hay conexión a internet.")
            val hasLocalCredentials = auth.isLoggedInLocally()
            if (hasLocalCredentials) {
                Timber.i("Usuario sin internet pero con credenciales locales. Permitiendo acceso offline.")
                true
            } else {
                Timber.w("Usuario sin internet y sin credenciales locales. Se requiere login.")
                false
            }
        }
    }

    private fun isNetworkAvailable(): Boolean {
        val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val network = connectivityManager.activeNetwork ?: return false
            val activeNetwork = connectivityManager.getNetworkCapabilities(network) ?: return false
            return when {
                activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
                activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
                activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> true
                else -> false
            }
        } else {
            @Suppress("DEPRECATION")
            val networkInfo = connectivityManager.activeNetworkInfo ?: return false
            @Suppress("DEPRECATION")
            return networkInfo.isConnected
        }
    }

    private fun maybeStartWelcomeOrApp() {
        lifecycleScope.launch {
            val loggedIn = ensureValidSession()
            val hasDeepLink = intent?.data != null

            // Leer DataStore de forma asíncrona para no bloquear el hilo principal.
            val alreadyShown = withContext(Dispatchers.IO) {
                applicationContext.dataStore.data.first()[OnboardingShownKey] ?: false
            }

            if (hasDeepLink) {
                if (loggedIn) {
                    initializeApp()
                } else {
                    showWelcome()
                }
                return@launch
            }

            if (loggedIn) {
                if (alreadyShown) {
                    initializeApp()
                } else {
                    setContent {
                        OnboardingScreen(
                            items = jossOnboardingItems(),
                            onFinish = {
                                lifecycleScope.launch {
                                    applicationContext.dataStore.edit { it[OnboardingShownKey] = true }
                                }
                                initializeApp()
                            }
                        )
                    }
                }
            } else {
                if (!alreadyShown) {
                    setContent {
                        OnboardingScreen(
                            items = jossOnboardingItems(),
                            onFinish = {
                                lifecycleScope.launch {
                                    applicationContext.dataStore.edit { it[OnboardingShownKey] = true }
                                }
                                showWelcome()
                            }
                        )
                    }
                } else {
                    showWelcome()
                }
            }
        }
    }

    private fun showNotificationPermissionScreen() {
        setContent {
            NotificationPermissionScreen(
                context = this,
                onPermissionGranted = { maybeStartWelcomeOrApp() },
                onBackPressed = { finish() }
            )
        }
    }

    @SuppressLint("ObsoleteSdkInt")
    private fun requestNotificationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerForActivityResult(
                ActivityResultContracts.RequestPermission()
            ) { granted ->
                if (granted) {
                    maybeStartWelcomeOrApp()
                } else {
                    showNotificationPermissionScreen()
                }
            }.launch(Manifest.permission.POST_NOTIFICATIONS)
        } else {
            maybeStartWelcomeOrApp()
        }
    }

    private fun setSystemBarAppearance(isDark: Boolean) {
        WindowCompat.getInsetsController(window, window.decorView.rootView).apply {
            isAppearanceLightStatusBars = !isDark
            isAppearanceLightNavigationBars = !isDark
        }
    }

    @Composable
    fun jossOnboardingItems(): List<CarouselItem> = listOf(
        CarouselItem(R.drawable.joss_music_logo, stringResource(R.string.onboarding_welcome_title), stringResource(R.string.onboarding_welcome_desc)),
        CarouselItem(R.drawable.download, stringResource(R.string.onboarding_downloads_title), stringResource(R.string.onboarding_downloads_desc)),
        CarouselItem(R.drawable.media3_icon_feed, stringResource(R.string.onboarding_links_title), stringResource(R.string.onboarding_links_desc)),
        CarouselItem(R.drawable.offline, stringResource(R.string.onboarding_offline_title), stringResource(R.string.onboarding_offline_desc)),
        CarouselItem(R.drawable.search, stringResource(R.string.onboarding_search_title), stringResource(R.string.onboarding_search_desc)),
        CarouselItem(R.drawable.library_add, stringResource(R.string.onboarding_library_title), stringResource(R.string.onboarding_library_desc))
    )

    private suspend fun tryScheduleDailyCloudBackup() {
        val loggedIn = ensureValidSession()
        if (!loggedIn) {
            Timber.d("Auto-backup: no programo porque no hay sesión.")
            return
        }

        // ✅ CORRECCIÓN: Leer DataStore de forma asíncrona.
        val preferences = withContext(Dispatchers.IO) {
            applicationContext.dataStore.data.first()
        }
        val autoAlways = preferences[AlwaysCloudBackupKey] ?: true
        if (!autoAlways) {
            Timber.d("Auto-backup: usuario lo desactivó.")
            return
        }

        val now = System.currentTimeMillis()
        val firstUse = preferences[FirstUseAtKey]
        if (firstUse == null || firstUse == 0L) {
            applicationContext.dataStore.edit { it[FirstUseAtKey] = now }
            Timber.d("Auto-backup: registré primer uso; esperar 40 minutos.")
            return
        }

        val elapsed = now - firstUse
        val needMs = TimeUnit.MINUTES.toMillis(40)
        if (elapsed < needMs) {
            val remainMin = ((needMs - elapsed) / 60000).coerceAtLeast(0)
            Timber.d("Auto-backup: aún faltan ~${remainMin} min para llegar a 40.")
            return
        }

        val constraints = Constraints.Builder()
            .setRequiredNetworkType(NetworkType.CONNECTED)
            .build()
        val request = PeriodicWorkRequestBuilder<CloudBackupWorker>(24, TimeUnit.HOURS)
            .setConstraints(constraints)
            .build()
        WorkManager.getInstance(this)
            .enqueueUniquePeriodicWork("auto_cloud_backup", ExistingPeriodicWorkPolicy.KEEP, request)
        Timber.i("Auto-backup: ¡Programado cada 24h!")
    }

    companion object {
        const val ACTION_SEARCH = "com.zionhuang.music.action.SEARCH"
        const val ACTION_SONGS = "com.zionhuang.music.action.SONGS"
        const val ACTION_ALBUMS = "com.zionhuang.music.action.ALBUMS"
        const val ACTION_PLAYLISTS = "com.zionhuang.music.action.PLAYLISTS"
    }
}

@androidx.compose.runtime.Composable
fun FullscreenVideoControls(
    player: androidx.media3.common.Player,
    onExitFullscreen: () -> Unit,
) {
    val context = androidx.compose.ui.platform.LocalContext.current
    var expandedQuality by androidx.compose.runtime.remember { androidx.compose.runtime.mutableStateOf(false) }
    val currentVideoQuality by com.zionhuang.music.utils.rememberPreference(com.zionhuang.music.constants.VideoQualityKey, "Auto")
    val coroutineScope = androidx.compose.runtime.rememberCoroutineScope()

    androidx.compose.foundation.layout.Box(
        modifier = Modifier
            .fillMaxSize()
            .statusBarsPadding()
    ) {
        androidx.compose.foundation.layout.Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 12.dp, vertical = 8.dp)
                .align(Alignment.TopStart),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(
                onClick = onExitFullscreen,
                modifier = Modifier.background(
                    androidx.compose.ui.graphics.Color.Black.copy(alpha = 0.5f),
                    androidx.compose.foundation.shape.CircleShape
                )
            ) {
                Icon(
                    imageVector = androidx.compose.material.icons.Icons.Default.FullscreenExit,
                    contentDescription = "Salir fullscreen",
                    tint = androidx.compose.ui.graphics.Color.White
                )
            }

            androidx.compose.foundation.layout.Box {
                IconButton(
                    onClick = { expandedQuality = true },
                    modifier = Modifier.background(
                        androidx.compose.ui.graphics.Color.Black.copy(alpha = 0.5f),
                        androidx.compose.foundation.shape.CircleShape
                    )
                ) {
                    Icon(
                        imageVector = androidx.compose.material.icons.Icons.Default.HighQuality,
                        contentDescription = "Calidad",
                        tint = androidx.compose.ui.graphics.Color.White
                    )
                }
                androidx.compose.material3.DropdownMenu(
                    expanded = expandedQuality,
                    onDismissRequest = { expandedQuality = false }
                ) {
                    listOf("Auto", "1080p", "720p", "480p", "360p").forEach { q ->
                        androidx.compose.material3.DropdownMenuItem(
                            text = {
                                androidx.compose.material3.Text(
                                    q,
                                    fontWeight = if (q == currentVideoQuality) androidx.compose.ui.text.font.FontWeight.Bold else null
                                )
                            },
                            onClick = {
                                expandedQuality = false
                                coroutineScope.launch(Dispatchers.IO) {
                                    context.dataStore.edit { it[com.zionhuang.music.constants.VideoQualityKey] = q }
                                }
                                // Forzar recarga del stream con la nueva calidad
                                val pos = player.currentPosition
                                val item = player.currentMediaItem
                                if (item != null) {
                                    player.stop()
                                    player.setMediaItem(item, pos)
                                    player.prepare()
                                    player.playWhenReady = true
                                }
                            }
                        )
                    }
                }
            }
        }
    }
}
