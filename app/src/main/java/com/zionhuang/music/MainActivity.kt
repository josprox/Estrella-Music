package com.zionhuang.music

import android.Manifest
import android.annotation.SuppressLint
import android.content.ComponentName
import android.content.Intent
import android.content.ServiceConnection
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.view.WindowManager
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.res.stringResource
import androidx.core.content.ContextCompat
import androidx.core.view.WindowCompat
import androidx.datastore.preferences.core.edit
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ProcessLifecycleOwner
import androidx.lifecycle.lifecycleScope
import com.josprox.jossredconnect.services.AuthService
import com.onesignal.OneSignal
import com.zionhuang.music.constants.DisableScreenshotKey
import com.zionhuang.music.constants.OnboardingShownKey
import com.zionhuang.music.constants.StopMusicOnTaskClearKey
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
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import timber.log.Timber
import javax.inject.Inject
import javax.inject.Named

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    @Inject lateinit var database: MusicDatabase
    @Inject lateinit var downloadUtil: DownloadUtil

    // Inyectado: servicio de auth ya configurado con claves del vault
    @Inject lateinit var auth: AuthService

    // Inyectado: OneSignal App Id (oculto detrás de SecureKeys/SecretsModule)
    @Inject @Named("OneSignalAppId") lateinit var oneSignalAppId: String

    private var isServiceBound = false
    private var playerConnection by mutableStateOf<PlayerConnection?>(null)

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

    // Deep link de arranque (lo consume la UI principal)
    private var initialIntent: Intent? = null

    private val updateViewModel: UpdateMainViewModel by viewModels {
        UpdateMainViewModelFactory(application)
    }

    override fun onStart() {
        super.onStart()
        if (!isServiceBound) bindMusicService()
    }

    override fun onStop() {
        if (isServiceBound) {
            unbindService(serviceConnection)
            isServiceBound = false
        }
        super.onStop()
    }

    override fun onDestroy() {
        super.onDestroy()
        if (dataStore.get(StopMusicOnTaskClearKey, false) &&
            playerConnection?.isPlaying?.value == true && isFinishing
        ) {
            stopService(Intent(this, MusicService::class.java))
            unbindService(serviceConnection)
            playerConnection = null
        }
    }

    @SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
    override fun onCreate(savedInstanceState: Bundle?) {
        setTheme(R.style.Theme_InnerTune)
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)

        // Guarda el intent inicial (deep link)
        initialIntent = intent

        // OneSignal (solo si hay App Id válido) + checker de updates
        if (oneSignalAppId.isNotBlank()) {
            OneSignal.initWithContext(this, oneSignalAppId)
        } else {
            Timber.w("OneSignal App Id vacío; se omite inicialización.")
        }
        UpdateChecker(this).checkForUpdates()

        // Secure flag (bloquear screenshots) según preferencia
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

        // 1) Primero: permiso de notificaciones
        requestNotificationPermission()
    }

    // --------------------- Servicio de música ---------------------
    private fun bindMusicService() {
        val serviceIntent = Intent(this, MusicService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            if (ProcessLifecycleOwner.get().lifecycle.currentState.isAtLeast(Lifecycle.State.STARTED)) {
                ContextCompat.startForegroundService(this, serviceIntent)
            } else {
                Timber.tag("MainActivity").w("No se puede iniciar el servicio en background")
            }
        } else {
            startService(serviceIntent)
        }
        bindService(serviceIntent, serviceConnection, BIND_AUTO_CREATE)
    }

    // --------------------- Monta UI principal ---------------------
    private fun initializeApp() {
        setContent {
            InnerTuneMainScreen(
                database = database,
                downloadUtil = downloadUtil,
                playerConnection = playerConnection,
                updateViewModel = updateViewModel,
                initialIntent = initialIntent,
                onConsumeInitialIntent = { initialIntent = null },
                addOnNewIntentListener = this::addOnNewIntentListener,
                removeOnNewIntentListener = this::removeOnNewIntentListener,
                setSystemBarAppearance = ::setSystemBarAppearance
            )
        }
    }

    // --------------------- Welcome/Auth (login/registro/recuperar/skip) ---------------------
    private fun showWelcome() {
        setContent {
            WelcomeRoute(
                onAuthSuccess = { initializeApp() },
                onSkip = { initializeApp() } // “No iniciar sesión por ahora”
            )
        }
    }

    // --------------------- Comprobar sesión con AuthService ---------------------
    private suspend fun ensureValidSession(): Boolean = withContext(Dispatchers.IO) {
        try {
            // checkToken() refresca si faltan <= 15 días (via shouldRefreshToken).
            // Si ya caducó o falla, devolvemos false y cerramos sesión local.
            val res = auth.checkToken()
            val ok = (res["success"] == true && (res["valid"] as? Boolean ?: false))
            if (!ok) {
                auth.logout() // limpia storage si token inválido/expirado
            }
            ok
        } catch (e: Exception) {
            Timber.e(e, "Error comprobando sesión")
            false
        }
    }

    // --------------------- Flujo tras conceder permiso ---------------------
    private fun maybeStartWelcomeOrApp() {
        lifecycleScope.launch {
            val hasDeepLink = intent?.data != null
            val alreadyShown = applicationContext.dataStore[OnboardingShownKey] == true

            // Deep link tiene prioridad para manejar de inmediato en la app
            if (hasDeepLink) {
                initializeApp()
                return@launch
            }

            val loggedIn = ensureValidSession()

            if (loggedIn) {
                // Usuario autenticado → onboarding solo si nunca lo vio
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
                // No autenticado → onboarding (si aplica) y luego Welcome
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

    // --------------------- Pantalla para guiar al permiso ---------------------
    private fun showNotificationPermissionScreen() {
        setContent {
            NotificationPermissionScreen(
                context = this,
                onPermissionGranted = { maybeStartWelcomeOrApp() },
                onBackPressed = { finish() }
            )
        }
    }

    // --------------------- Pedir permiso de notificaciones ---------------------
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

    // --------------------- Apariencia de barras del sistema ---------------------
    private fun setSystemBarAppearance(isDark: Boolean) {
        WindowCompat.getInsetsController(window, window.decorView.rootView).apply {
            isAppearanceLightStatusBars = !isDark
            isAppearanceLightNavigationBars = !isDark
        }
    }

    // --------------------- Items de Onboarding (Joss Music) ---------------------
    @Composable
    fun jossOnboardingItems(): List<CarouselItem> = listOf(
        CarouselItem(
            R.drawable.joss_music_logo,
            stringResource(R.string.onboarding_welcome_title),
            stringResource(R.string.onboarding_welcome_desc)
        ),
        CarouselItem(
            R.drawable.download,
            stringResource(R.string.onboarding_downloads_title),
            stringResource(R.string.onboarding_downloads_desc)
        ),
        CarouselItem(
            R.drawable.media3_icon_feed,
            stringResource(R.string.onboarding_links_title),
            stringResource(R.string.onboarding_links_desc)
        ),
        CarouselItem(
            R.drawable.offline,
            stringResource(R.string.onboarding_offline_title),
            stringResource(R.string.onboarding_offline_desc)
        ),
        CarouselItem(
            R.drawable.search,
            stringResource(R.string.onboarding_search_title),
            stringResource(R.string.onboarding_search_desc)
        ),
        CarouselItem(
            R.drawable.library_add,
            stringResource(R.string.onboarding_library_title),
            stringResource(R.string.onboarding_library_desc)
        )
    )

    companion object {
        const val ACTION_SEARCH = "com.zionhuang.music.action.SEARCH"
        const val ACTION_SONGS = "com.zionhuang.music.action.SONGS"
        const val ACTION_ALBUMS = "com.zionhuang.music.action.ALBUMS"
        const val ACTION_PLAYLISTS = "com.zionhuang.music.action.PLAYLISTS"
    }
}
