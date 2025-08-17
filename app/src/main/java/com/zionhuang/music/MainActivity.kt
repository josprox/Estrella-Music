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
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.core.content.ContextCompat
import androidx.core.view.WindowCompat
import androidx.datastore.preferences.core.edit
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ProcessLifecycleOwner
import androidx.lifecycle.lifecycleScope
import com.onesignal.OneSignal
import com.zionhuang.music.constants.DisableScreenshotKey
import com.zionhuang.music.constants.OnboardingShownKey
import com.zionhuang.music.constants.StopMusicOnTaskClearKey
import com.zionhuang.music.db.MusicDatabase
import com.zionhuang.music.playback.DownloadUtil
import com.zionhuang.music.playback.MusicService
import com.zionhuang.music.playback.MusicService.MusicBinder
import com.zionhuang.music.playback.PlayerConnection
import com.zionhuang.music.ui.onboarding.CarouselItem
import com.zionhuang.music.ui.onboarding.OnboardingActivity
import com.zionhuang.music.ui.onboarding.OnboardingScreen
import com.zionhuang.music.ui.screens.NotificationPermissionScreen
import com.zionhuang.music.utils.UpdateChecker
import com.zionhuang.music.utils.UpdateMainViewModel
import com.zionhuang.music.utils.UpdateMainViewModelFactory
import com.zionhuang.music.utils.dataStore
import com.zionhuang.music.utils.get
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
import org.dotenv.vault.dotenvVault
import timber.log.Timber
import javax.inject.Inject

val dotenv = dotenvVault(BuildConfig.DOTENV_KEY) {
    directory = "/assets"
    filename = "env.vault"
}
val ONESIGNAL_APP_ID: String = dotenv["ONESIGNAL_APP_ID"]

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    @Inject lateinit var database: MusicDatabase
    @Inject lateinit var downloadUtil: DownloadUtil

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

    // Deep link que arrancó la Activity (lo consume la UI principal)
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

        // OneSignal + checker de updates
        OneSignal.initWithContext(this, ONESIGNAL_APP_ID)
        UpdateChecker(this).checkForUpdates()

        // Secure flag por preferencia
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

    // --------------------- Si hay permiso, decidir Onboarding o App ---------------------
    private fun maybeStartOnboardingOrApp() {
        lifecycleScope.launch {
            val hasDeepLink = intent?.data != null
            val alreadyShown = applicationContext.dataStore[OnboardingShownKey] == true

            if (alreadyShown) {
                // Ya lo vio → directo a la app
                initializeApp()
            } else {
                if (hasDeepLink) {
                    // 1) Maneja el deep link ya mismo
                    initializeApp()
                    // 2) Luego muestra el onboarding ENCIMA como actividad aparte
                    window.decorView.post {
                        startActivity(Intent(this@MainActivity, OnboardingActivity::class.java))
                    }
                } else {
                    // Sin deep link → muestra onboarding primero
                    setContent {
                        val items = jossOnboardingItems()
                        OnboardingScreen(
                            items = items,
                            onFinish = {
                                lifecycleScope.launch {
                                    applicationContext.dataStore.edit { it[OnboardingShownKey] = true }
                                }
                                initializeApp()
                            }
                        )
                    }
                }
            }
        }
    }

    // --------------------- Pantalla para guiar al permiso ---------------------
    private fun showNotificationPermissionScreen() {
        setContent {
            NotificationPermissionScreen(
                context = this,
                onPermissionGranted = { maybeStartOnboardingOrApp() },
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
                    // Concedido → ahora sí, Onboarding (si aplica) o App
                    maybeStartOnboardingOrApp()
                } else {
                    // No concedido → pantalla que guía a habilitar
                    showNotificationPermissionScreen()
                }
            }.launch(Manifest.permission.POST_NOTIFICATIONS)
        } else {
            // En Android < 13 no hace falta pedir permiso
            maybeStartOnboardingOrApp()
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
    private fun jossOnboardingItems(): List<CarouselItem> = listOf(
        CarouselItem(
            R.drawable.joss_music_logo,
            "Bienvenido a Joss Music",
            "Tu música en un solo lugar: rápido, limpio y pensado para ti."
        ),
        CarouselItem(
            R.drawable.download,
            "Descargas inteligentes",
            "Guarda canciones, álbumes y playlists para escucharlos sin conexión. Elige calidad y controla el espacio."
        ),
        CarouselItem(
            R.drawable.media3_icon_feed,
            "Enlaces internos seguros",
            "Abrimos jossmusic.com directamente en la app con App Links verificados y deep links confiables."
        ),
        CarouselItem(
            R.drawable.offline,
            "Modo sin conexión",
            "Tu música suena aun sin internet: sin cortes, sin preocupaciones."
        ),
        CarouselItem(
            R.drawable.search,
            "Búsqueda y descubrimiento",
            "Encuentra rápido en YouTube Music y en tu biblioteca local, todo en un mismo sitio."
        ),
        CarouselItem(
            R.drawable.library_add,
            "Listas y biblioteca",
            "Crea, organiza y comparte playlists; gestiona tu colección como quieras."
        )
    )

    companion object {
        const val ACTION_SEARCH = "com.zionhuang.music.action.SEARCH"
        const val ACTION_SONGS = "com.zionhuang.music.action.SONGS"
        const val ACTION_ALBUMS = "com.zionhuang.music.action.ALBUMS"
        const val ACTION_PLAYLISTS = "com.zionhuang.music.action.PLAYLISTS"
    }
}
