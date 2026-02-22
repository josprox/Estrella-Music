package com.zionhuang.music.playback


import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.database.SQLException
import android.media.audiofx.AudioEffect
import android.net.ConnectivityManager
import android.os.Binder
import android.os.Build
import android.os.Bundle
import androidx.core.app.NotificationCompat
import androidx.core.content.getSystemService
import androidx.core.net.toUri
import androidx.datastore.preferences.core.edit
import androidx.media3.common.AudioAttributes
import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.common.PlaybackException
import androidx.media3.common.Player
import androidx.media3.common.Player.EVENT_IS_PLAYING_CHANGED
import androidx.media3.common.Player.EVENT_POSITION_DISCONTINUITY
import androidx.media3.common.Player.EVENT_TIMELINE_CHANGED
import androidx.media3.common.Player.REPEAT_MODE_ALL
import androidx.media3.common.Player.REPEAT_MODE_OFF
import androidx.media3.common.Player.REPEAT_MODE_ONE
import androidx.media3.common.Player.STATE_IDLE
import androidx.media3.common.Timeline
import androidx.media3.common.audio.SonicAudioProcessor
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DefaultDataSource
import androidx.media3.datasource.ResolvingDataSource
import androidx.media3.datasource.cache.CacheDataSource
import androidx.media3.datasource.cache.CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR
import androidx.media3.datasource.cache.SimpleCache
import androidx.media3.datasource.okhttp.OkHttpDataSource
import androidx.media3.exoplayer.DefaultRenderersFactory
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.analytics.AnalyticsListener
import androidx.media3.exoplayer.analytics.PlaybackStats
import androidx.media3.exoplayer.analytics.PlaybackStatsListener
import androidx.media3.exoplayer.audio.DefaultAudioSink
import androidx.media3.exoplayer.audio.SilenceSkippingAudioProcessor
import androidx.media3.exoplayer.source.DefaultMediaSourceFactory
import androidx.media3.extractor.mkv.MatroskaExtractor
import androidx.media3.extractor.mp4.FragmentedMp4Extractor
import androidx.media3.session.CommandButton
import androidx.media3.session.DefaultMediaNotificationProvider
import androidx.media3.session.MediaController
import androidx.media3.session.MediaLibraryService
import androidx.media3.session.MediaSession
import androidx.media3.session.SessionToken
import com.google.common.util.concurrent.MoreExecutors
import com.josprox.jossredconnect.JossRedClient
import com.zionhuang.innertube.YouTube
import com.zionhuang.innertube.models.WatchEndpoint
import com.zionhuang.innertube.models.response.PlayerResponse
import com.zionhuang.music.ClassicMusicWidgetProvider
import com.zionhuang.music.MainActivity
import com.zionhuang.music.ModernMusicWidgetProvider
import com.zionhuang.music.R
import com.zionhuang.music.constants.AudioNormalizationKey
import com.zionhuang.music.constants.AudioQuality
import com.zionhuang.music.constants.AudioQualityKey
import com.zionhuang.music.constants.DiscordButton1LabelKey
import com.zionhuang.music.constants.DiscordButton2LabelKey
import com.zionhuang.music.constants.DiscordTokenKey
import com.zionhuang.music.constants.EnableDiscordRPCKey
import com.zionhuang.music.constants.JossRedMultimedia
import com.zionhuang.music.constants.MediaSessionConstants.CommandToggleLibrary
import com.zionhuang.music.constants.MediaSessionConstants.CommandToggleLike
import com.zionhuang.music.constants.MediaSessionConstants.CommandToggleRepeatMode
import com.zionhuang.music.constants.MediaSessionConstants.CommandToggleShuffle
import com.zionhuang.music.constants.PersistentQueueKey
import com.zionhuang.music.constants.PlayerVolumeKey
import com.zionhuang.music.constants.RepeatModeKey
import com.zionhuang.music.constants.ShowLyricsKey
import com.zionhuang.music.constants.SkipSilenceKey
import com.zionhuang.music.db.MusicDatabase
import com.zionhuang.music.db.entities.Event
import com.zionhuang.music.db.entities.FormatEntity
import com.zionhuang.music.db.entities.LyricsEntity
import com.zionhuang.music.di.AppModule.PlayerCache
import com.zionhuang.music.di.DownloadCache
import com.zionhuang.music.extensions.SilentHandler
import com.zionhuang.music.extensions.collect
import com.zionhuang.music.extensions.collectLatest
import com.zionhuang.music.extensions.currentMetadata
import com.zionhuang.music.extensions.findNextMediaItemById
import com.zionhuang.music.extensions.mediaItems
import com.zionhuang.music.extensions.metadata
import com.zionhuang.music.extensions.toMediaItem
import com.zionhuang.music.lyrics.LyricsHelper
import com.zionhuang.music.models.PersistQueue
import com.zionhuang.music.playback.queues.EmptyQueue
import com.zionhuang.music.playback.queues.ListQueue
import com.zionhuang.music.playback.queues.Queue
import com.zionhuang.music.playback.queues.YouTubeQueue
import com.zionhuang.music.playback.queues.filterExplicit
import com.zionhuang.music.utils.CoilBitmapLoader
import com.zionhuang.music.utils.DiscordRPC
import com.zionhuang.music.utils.SecureKeys
import com.zionhuang.music.utils.YTPlayerUtils
import com.zionhuang.music.utils.dataStore
import com.zionhuang.music.utils.enumPreference
import com.zionhuang.music.utils.get
import com.zionhuang.music.utils.isInternetAvailable
import com.zionhuang.music.utils.reportException
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.FlowPreview
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.debounce
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.distinctUntilChangedBy
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.plus
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import timber.log.Timber
import java.io.ObjectInputStream
import java.io.ObjectOutputStream
import java.net.ConnectException
import java.net.SocketTimeoutException
import java.net.UnknownHostException
import java.time.LocalDateTime
import javax.inject.Inject
import kotlin.math.min
import kotlin.math.pow
import kotlin.time.Duration.Companion.seconds

private data class MusicServiceSettings(
    val playerVolume: Float = 1f,
    val repeatMode: Int = REPEAT_MODE_OFF,
    val sleepFinishSong: Boolean = false,
    val autoLoadMore: Boolean = true,
    val hideExplicit: Boolean = false,
    val autoSkipOnError: Boolean = false,
    val pauseHistory: Boolean = false,
    val persistentQueue: Boolean = true
)

@OptIn(ExperimentalCoroutinesApi::class, FlowPreview::class)
@AndroidEntryPoint
class MusicService : MediaLibraryService(),
    Player.Listener,
    PlaybackStatsListener.Callback {

    @Inject lateinit var database: MusicDatabase
    @Inject lateinit var lyricsHelper: LyricsHelper
    @Inject lateinit var mediaLibrarySessionCallback: MediaLibrarySessionCallback

    private var scope = CoroutineScope(Dispatchers.Main.immediate) + SupervisorJob()
    private val binder = MusicBinder()

    private lateinit var connectivityManager: ConnectivityManager
    private val audioQuality by enumPreference(this, AudioQualityKey, AudioQuality.AUTO)
    private val jossRedKey: String by lazy { SecureKeys.getJossRedKey() }

    private var currentQueue: Queue = EmptyQueue
    var queueTitle: String? = null

    val currentMediaMetadata = MutableStateFlow<com.zionhuang.music.models.MediaMetadata?>(null)
    private val currentSong =
        currentMediaMetadata.flatMapLatest { mediaMetadata ->
            database.song(mediaMetadata?.id)
        }.stateIn(scope, SharingStarted.Lazily, null)
    private val currentFormat =
        currentMediaMetadata.flatMapLatest { mediaMetadata ->
            database.format(mediaMetadata?.id)
        }

    private val normalizeFactor = MutableStateFlow(1f)
    val playerVolume = MutableStateFlow(1f)
    private val settingsState = MutableStateFlow(MusicServiceSettings())
    private val sleepTimerFinish = MutableStateFlow(false)

    lateinit var sleepTimer: SleepTimer
    @Inject @PlayerCache lateinit var playerCache: SimpleCache
    @Inject @DownloadCache lateinit var downloadCache: SimpleCache
    lateinit var player: ExoPlayer
    private lateinit var mediaSession: MediaLibrarySession
    private var isAudioEffectSessionOpened = false
    private var discordRpc: DiscordRPC? = null

    override fun onCreate() {
        super.onCreate()

        // Canal y notificación para servicio foreground
        val channel = NotificationChannel(
            "MUSIC_CHANNEL",
            getString(R.string.music_player),
            NotificationManager.IMPORTANCE_LOW
        ).apply {
            description = getString(R.string.musicDescNotification)
        }
        val notificationManager = getSystemService(NotificationManager::class.java)
        notificationManager.createNotificationChannel(channel)

        val notification = NotificationCompat.Builder(this, "MUSIC_CHANNEL")
            .setContentTitle(getString(R.string.musicTitleNotification))
            .setContentText(getString(R.string.musicDescNotification))
            .setSmallIcon(R.drawable.joss_music_logo)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            if (checkSelfPermission(android.Manifest.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK) == PackageManager.PERMISSION_GRANTED) {
                startForeground(1, notification)
            } else {
                Timber.tag("MusicService").w("Falta permiso FOREGROUND_SERVICE_MEDIA_PLAYBACK")
            }
        } else {
            startForeground(1, notification)
        }

        setMediaNotificationProvider(
            DefaultMediaNotificationProvider(this, { NOTIFICATION_ID }, CHANNEL_ID, R.string.music_player)
                .apply { setSmallIcon(R.drawable.joss_music_logo) }
        )

        player = ExoPlayer.Builder(this)
            .setMediaSourceFactory(createMediaSourceFactory())
            .setRenderersFactory(createRenderersFactory())
            .setHandleAudioBecomingNoisy(true)
            .setWakeMode(C.WAKE_MODE_NETWORK)
            .setAudioAttributes(
                AudioAttributes.Builder()
                    .setUsage(C.USAGE_MEDIA)
                    .setContentType(C.AUDIO_CONTENT_TYPE_MUSIC)
                    .build(),
                true
            )
            .setSeekBackIncrementMs(5000)
            .setSeekForwardIncrementMs(5000)
            .build()
            .apply {
                addListener(this@MusicService)
                sleepTimer = SleepTimer(scope, this, sleepTimerFinish)
                addListener(sleepTimer)
                addAnalyticsListener(PlaybackStatsListener(false, this@MusicService))
            }

        mediaLibrarySessionCallback.apply {
            toggleLike = ::toggleLike
            toggleLibrary = ::toggleLibrary
        }

        mediaSession = MediaLibrarySession.Builder(this, player, mediaLibrarySessionCallback)
            .setSessionActivity(
                PendingIntent.getActivity(
                    this,
                    0,
                    Intent(this, MainActivity::class.java),
                    PendingIntent.FLAG_IMMUTABLE
                )
            )
            .setBitmapLoader(CoilBitmapLoader(this, scope))
            .build()

        player.repeatMode = dataStore.get(RepeatModeKey, REPEAT_MODE_OFF)

        // Controlador para mantener notificación viva
        val sessionToken = SessionToken(this, ComponentName(this, MusicService::class.java))
        val controllerFuture = MediaController.Builder(this, sessionToken).buildAsync()
        controllerFuture.addListener({ controllerFuture.get() }, MoreExecutors.directExecutor())

        connectivityManager = getSystemService()!!

        combine(playerVolume, normalizeFactor) { vol, norm -> vol * norm }
            .collectLatest(scope) { player.volume = it }

        playerVolume.debounce(1000).collect(scope) { volume ->
            dataStore.edit { settings -> settings[PlayerVolumeKey] = volume }
        }

        currentSong.debounce(1000).collect(scope) { song ->
            updateNotification()
            if (song != null) {
                val btn1 = dataStore.get(DiscordButton1LabelKey, "Listen")
                val btn2 = dataStore.get(DiscordButton2LabelKey, "Visit Estrella Music")
                discordRpc?.updateSong(song, btn1, btn2)
            } else {
                discordRpc?.closeRPC()
            }
        }

        // NUEVO: Colector para el Widget.
        // Este reaccionará a CUALQUIER cambio en la canción actual.
        currentSong.collect(scope) {
            // No usamos debounce porque queremos que la UI reaccione al instante.
            notifyWidget()
        }

        combine(
            currentMediaMetadata.distinctUntilChangedBy { it?.id },
            dataStore.data.map { it[ShowLyricsKey] ?: false }.distinctUntilChanged()
        ) { mediaMetadata, showLyrics -> mediaMetadata to showLyrics }
            .collectLatest(scope) { (mediaMetadata, showLyrics) ->
                if (showLyrics && mediaMetadata != null && database.lyrics(mediaMetadata.id).first() == null) {
                    val lyrics = lyricsHelper.getLyrics(mediaMetadata)
                    database.query { upsert(LyricsEntity(id = mediaMetadata.id, lyrics = lyrics)) }
                }
            }

        dataStore.data
            .map { it[SkipSilenceKey] ?: false }
            .distinctUntilChanged()
            .collectLatest(scope) { player.skipSilenceEnabled = it }

        combine(
            currentFormat,
            dataStore.data.map { it[AudioNormalizationKey] ?: true }.distinctUntilChanged()
        ) { format, normalize -> format to normalize }
            .collectLatest(scope) { (format, normalize) ->
                normalizeFactor.value = if (normalize && format?.loudnessDb != null) {
                    min(10f.pow(-format.loudnessDb.toFloat() / 20), 1f)
                } else 1f
            }

        dataStore.data
            .map { it[DiscordTokenKey] to (it[EnableDiscordRPCKey] ?: true) }
            .debounce(300)
            .distinctUntilChanged()
            .collect(scope) { (key, enabled) ->
                if (discordRpc?.isRpcRunning() == true) discordRpc?.closeRPC()
                discordRpc = null
                if (key != null && enabled) {
                    discordRpc = DiscordRPC(this, key)
                    currentSong.value?.let {
                        val btn1 = dataStore.get(DiscordButton1LabelKey, "Listen")
                        val btn2 = dataStore.get(DiscordButton2LabelKey, "Visit Estrella Music")
                        discordRpc?.updateSong(it, btn1, btn2)
                    }
                }
            }

        if (dataStore.get(PersistentQueueKey, true)) {
            runCatching {
                filesDir.resolve(PERSISTENT_QUEUE_FILE).inputStream().use { fis ->
                    ObjectInputStream(fis).use { ois -> ois.readObject() as PersistQueue }
                }
            }.onSuccess { queue ->
                playQueue(
                    queue = ListQueue(
                        title = queue.title,
                        items = queue.items.map { it.toMediaItem() },
                        startIndex = queue.mediaItemIndex,
                        position = queue.position
                    ),
                    playWhenReady = false
                )
            }
        }

        // Guardado periódico de la cola
        scope.launch {
            while (isActive) {
                delay(30.seconds)
                if (dataStore.get(PersistentQueueKey, true)) saveQueueToDisk()
            }
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ModernMusicWidgetProvider.ACTION_PLAY_PAUSE -> if (player.isPlaying) player.pause() else player.play()
            ModernMusicWidgetProvider.ACTION_NEXT -> player.seekToNextMediaItem()
            ModernMusicWidgetProvider.ACTION_PREV -> player.seekToPreviousMediaItem()
            ModernMusicWidgetProvider.ACTION_TOGGLE_LIKE -> toggleLike()
        }
        return super.onStartCommand(intent, flags, startId)
    }

    private fun updateNotification() {
        mediaSession.setCustomLayout(
            listOf(
                CommandButton.Builder().setDisplayName(getString(if (currentSong.value?.song?.inLibrary != null) R.string.remove_from_library else R.string.add_to_library)).setIconResId(if (currentSong.value?.song?.inLibrary != null) R.drawable.library_add_check else R.drawable.library_add).setSessionCommand(CommandToggleLibrary).setEnabled(currentSong.value != null).build(),
                CommandButton.Builder().setDisplayName(getString(if (currentSong.value?.song?.liked == true) R.string.action_remove_like else R.string.action_like)).setIconResId(if (currentSong.value?.song?.liked == true) R.drawable.favorite else R.drawable.favorite_border).setSessionCommand(CommandToggleLike).setEnabled(currentSong.value != null).build(),
                CommandButton.Builder().setDisplayName(getString(if (player.shuffleModeEnabled) R.string.action_shuffle_off else R.string.action_shuffle_on)).setIconResId(if (player.shuffleModeEnabled) R.drawable.shuffle_on else R.drawable.shuffle).setSessionCommand(CommandToggleShuffle).build(),
                CommandButton.Builder().setDisplayName(getString(when (player.repeatMode) {
                    REPEAT_MODE_OFF -> R.string.repeat_mode_off
                    REPEAT_MODE_ONE -> R.string.repeat_mode_one
                    REPEAT_MODE_ALL -> R.string.repeat_mode_all
                    else -> throw IllegalStateException()
                })).setIconResId(when (player.repeatMode) {
                    REPEAT_MODE_OFF -> R.drawable.repeat
                    REPEAT_MODE_ONE -> R.drawable.repeat_one_on
                    REPEAT_MODE_ALL -> R.drawable.repeat_on
                    else -> throw IllegalStateException()
                }).setSessionCommand(CommandToggleRepeatMode).build()
            )
        )
    }

    private suspend fun recoverSong(mediaId: String, playbackData: YTPlayerUtils.PlaybackData? = null) {
        val song = database.song(mediaId).first()
        val mediaMetadata = withContext(Dispatchers.Main) { player.findNextMediaItemById(mediaId)?.metadata } ?: return
        val duration = song?.song?.duration?.takeIf { it != -1 }
            ?: mediaMetadata.duration.takeIf { it != -1 }
            ?: (playbackData?.videoDetails ?: YTPlayerUtils.playerResponseForMetadata(mediaId).getOrNull()?.videoDetails)?.lengthSeconds?.toInt()
            ?: -1
        database.query {
            if (song == null) insert(mediaMetadata.copy(duration = duration))
            else if (song.song.duration == -1) update(song.song.copy(duration = duration))
        }
    }

    fun playQueue(queue: Queue, playWhenReady: Boolean = true) {
        currentQueue = queue
        queueTitle = null
        player.shuffleModeEnabled = false
        if (queue.preloadItem != null) {
            player.setMediaItem(queue.preloadItem!!.toMediaItem())
            player.prepare()
            player.playWhenReady = playWhenReady
        }
        scope.launch(SilentHandler) {
            val initialStatus = withContext(Dispatchers.IO) { queue.getInitialStatus().filterExplicit(settingsState.value.hideExplicit) }
            if (queue.preloadItem != null && player.playbackState == STATE_IDLE) return@launch
            if (initialStatus.title != null) queueTitle = initialStatus.title
            if (initialStatus.items.isEmpty()) return@launch
            withContext(Dispatchers.Main) { // Asegura que las interacciones con el player se hagan en el hilo principal
                if (queue.preloadItem != null) {
                    player.addMediaItems(0, initialStatus.items.subList(0, initialStatus.mediaItemIndex))
                    player.addMediaItems(initialStatus.items.subList(initialStatus.mediaItemIndex + 1, initialStatus.items.size))
                } else {
                    player.setMediaItems(initialStatus.items, if (initialStatus.mediaItemIndex > 0) initialStatus.mediaItemIndex else 0, initialStatus.position)
                    player.prepare()
                    player.playWhenReady = playWhenReady
                }
            }
        }
    }

    fun startRadioSeamlessly() {
        val currentMediaMetadata = player.currentMetadata ?: return
        if (player.currentMediaItemIndex > 0) player.removeMediaItems(0, player.currentMediaItemIndex)
        if (player.currentMediaItemIndex < player.mediaItemCount - 1) player.removeMediaItems(player.currentMediaItemIndex + 1, player.mediaItemCount)
        scope.launch(SilentHandler) {
            val radioQueue = YouTubeQueue(endpoint = WatchEndpoint(videoId = currentMediaMetadata.id))
            val initialStatus = radioQueue.getInitialStatus()
            if (initialStatus.title != null) queueTitle = initialStatus.title
            withContext(Dispatchers.Main) {
                player.addMediaItems(initialStatus.items.drop(1))
            }
            currentQueue = radioQueue
        }
    }

    fun playNext(items: List<MediaItem>) {
        player.addMediaItems(if (player.mediaItemCount == 0) 0 else player.currentMediaItemIndex + 1, items)
        player.prepare()
    }

    fun addToQueue(items: List<MediaItem>) {
        player.addMediaItems(items)
        player.prepare()
    }

    fun toggleLibrary() {
        database.query { currentSong.value?.let { update(it.song.toggleLibrary()) } }
    }

    fun toggleLike() {
        database.query { currentSong.value?.let { update(it.song.toggleLike()) } }
    }

    private fun openAudioEffectSession() {
        if (isAudioEffectSessionOpened) return
        isAudioEffectSessionOpened = true
        sendBroadcast(Intent(AudioEffect.ACTION_OPEN_AUDIO_EFFECT_CONTROL_SESSION).apply {
            putExtra(AudioEffect.EXTRA_AUDIO_SESSION, player.audioSessionId)
            putExtra(AudioEffect.EXTRA_PACKAGE_NAME, packageName)
            putExtra(AudioEffect.EXTRA_CONTENT_TYPE, AudioEffect.CONTENT_TYPE_MUSIC)
        })
    }

    private fun closeAudioEffectSession() {
        if (!isAudioEffectSessionOpened) return
        isAudioEffectSessionOpened = false
        sendBroadcast(Intent(AudioEffect.ACTION_CLOSE_AUDIO_EFFECT_CONTROL_SESSION).apply {
            putExtra(AudioEffect.EXTRA_AUDIO_SESSION, player.audioSessionId)
            putExtra(AudioEffect.EXTRA_PACKAGE_NAME, packageName)
        })
    }

    override fun onMediaItemTransition(mediaItem: MediaItem?, reason: Int) {
        if (settingsState.value.autoLoadMore && reason != Player.MEDIA_ITEM_TRANSITION_REASON_REPEAT && player.mediaItemCount - player.currentMediaItemIndex <= 5 && currentQueue.hasNextPage()) {
            scope.launch(SilentHandler) {
                val mediaItems = currentQueue.nextPage().filterExplicit(settingsState.value.hideExplicit)
                withContext(Dispatchers.Main) {
                    if (player.playbackState != STATE_IDLE) player.addMediaItems(mediaItems)
                }
            }
        }
    }

    override fun onPlaybackStateChanged(@Player.State playbackState: Int) {
        if (playbackState == STATE_IDLE) {
            currentQueue = EmptyQueue
            player.shuffleModeEnabled = false
            queueTitle = null
        }
    }

    // ✅ La pieza clave para gestionar la notificación.
    override fun onIsPlayingChanged(isPlaying: Boolean) {
        super.onIsPlayingChanged(isPlaying)
    }

    override fun onEvents(player: Player, events: Player.Events) {
        if (events.containsAny(Player.EVENT_PLAYBACK_STATE_CHANGED, Player.EVENT_PLAY_WHEN_READY_CHANGED)) {
            val isBufferingOrReady = player.playbackState == Player.STATE_BUFFERING || player.playbackState == Player.STATE_READY
            if (isBufferingOrReady && player.playWhenReady) openAudioEffectSession() else closeAudioEffectSession()
        }

        if (events.containsAny(EVENT_TIMELINE_CHANGED, EVENT_POSITION_DISCONTINUITY, EVENT_IS_PLAYING_CHANGED)) {
            currentMediaMetadata.value = player.currentMetadata
            scope.launch { notifyWidget() }
        }
    }

    override fun onShuffleModeEnabledChanged(shuffleModeEnabled: Boolean) {
        updateNotification()
    }

    override fun onRepeatModeChanged(repeatMode: Int) {
        updateNotification()
        scope.launch { dataStore.edit { settings -> settings[RepeatModeKey] = repeatMode } }
    }

    override fun onPlayerError(error: PlaybackException) {
        if (settingsState.value.autoSkipOnError && isInternetAvailable(this) && player.hasNextMediaItem()) {
            player.seekToNext()
            player.prepare()
            player.playWhenReady = true
        }
    }

    // ... (El resto de tus métodos como createDataSourceFactory, etc. permanecen igual) ...
    private fun createCacheDataSource(): CacheDataSource.Factory =
        CacheDataSource.Factory()
            .setCache(downloadCache)
            .setUpstreamDataSourceFactory(DefaultDataSource.Factory(this, OkHttpDataSource.Factory(OkHttpClient.Builder().proxy(YouTube.proxy).build())))
            .setCacheWriteDataSinkFactory(null)
            .setFlags(FLAG_IGNORE_CACHE_ON_ERROR)

    private fun hasJwt(): Boolean {
        val sp = getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
        val jwt = sp.getString("jwt_token", null)
        if (jwt.isNullOrBlank()) return false
        val exp = sp.getLong("token_expiration", -1L)
        val now = System.currentTimeMillis() / 1000L
        return exp <= 0L || exp > now
    }

    private suspend fun shouldUseJossRedFirst(): Boolean {
        val switchOn = dataStore.data.map { it[JossRedMultimedia] ?: false }.first()
        return switchOn && hasJwt()
    }

    private fun createDataSourceFactory(): DataSource.Factory {
        return ResolvingDataSource.Factory(createCacheDataSource()) { dataSpec ->
            val mediaId = dataSpec.key ?: error("No media id")
            Timber.d("Resolviendo DataSpec para mediaId: $mediaId")
            if (downloadCache.isCached(mediaId, dataSpec.position, if (dataSpec.length >= 0) dataSpec.length else 1)) {
                Timber.i("Media '$mediaId' encontrado en la caché de descargas. Usando el archivo local.")
                scope.launch(Dispatchers.IO) { recoverSong(mediaId) }
                return@Factory dataSpec
            }
            val useJossRedAsPrimary = runBlocking(Dispatchers.IO) { shouldUseJossRedFirst() }
            if (useJossRedAsPrimary) {
                Timber.i("Estrategia Principal: JOSS RED (Activado por el usuario).")
                try {
                    if (jossRedKey.isBlank()) {
                        throw JossRedClient.JossRedException(-1, "La clave de Joss Red está vacía en la app.")
                    }
                    val modifiedDataSpec = JossRedClient.resolveDataSpec(this@MusicService, dataSpec, mediaId, jossRedKey)
                    Timber.i("Joss Red resolvió la URL del CDN exitosamente para '$mediaId'.")
                    scope.launch(Dispatchers.IO) { recoverSong(mediaId) }
                    return@Factory modifiedDataSpec
                } catch (e: Exception) {
                    Timber.e(e, "La estrategia principal (Joss Red) falló. Esto es un error fatal para la reproducción.")
                    handlePlaybackError(e)
                }
            }
            Timber.i("Estrategia Principal: YOUTUBE/NEWPIPE (Joss Red desactivado o sin login).")
            var lastError: Throwable? = null
            repeat(4) { attempt ->
                try {
                    val playbackData = runBlocking(Dispatchers.IO) { YTPlayerUtils.playerResponseForPlayback(mediaId, null, audioQuality, connectivityManager).getOrThrow() }
                    updateFormatInfo(mediaId, playbackData.format, playbackData.audioConfig?.loudnessDb)
                    scope.launch(Dispatchers.IO) { recoverSong(mediaId, playbackData) }
                    val streamUrl = playbackData.streamUrl
                    Timber.i("YouTube/NewPipe exitoso (intento ${attempt + 1}): $streamUrl")
                    return@Factory dataSpec.withUri(streamUrl.toUri())
                } catch (e: Exception) {
                    lastError = e
                    if (e is YTPlayerUtils.PlaybackException && e.statusCode == 403) {
                        Timber.w(e, "YouTube/NewPipe falló con 403 (intento ${attempt + 1}), reintentando...")
                    } else {
                        Timber.e(e, "YouTube/NewPipe falló con un error no recuperable.")
                        return@repeat
                    }
                }
            }
            Timber.w("La estrategia principal (YouTube/NewPipe) falló. Verificando si es posible un fallback inteligente a Joss Red.")
            if (hasJwt() && jossRedKey.isNotBlank()) {
                Timber.i("Usuario logueado. Intentando fallback inteligente a Joss Red...")
                try {
                    val modifiedDataSpec = JossRedClient.resolveDataSpec(this@MusicService, dataSpec, mediaId, jossRedKey)
                    Timber.i("¡Fallback inteligente a Joss Red exitoso para '$mediaId'!")
                    scope.launch(Dispatchers.IO) { recoverSong(mediaId) }
                    return@Factory modifiedDataSpec
                } catch (fallbackError: Exception) {
                    Timber.e(fallbackError, "El fallback inteligente a Joss Red también falló. Reportando el error original de YouTube/NewPipe.")
                    handlePlaybackError(lastError ?: fallbackError)
                }
            }
            Timber.e(lastError, "Todos los métodos de obtención de stream para '$mediaId' han fallado.")
            handlePlaybackError(lastError ?: Exception("No se pudo obtener la URL del stream por ningún método."))
        }
    }

    private fun handlePlaybackError(throwable: Throwable): Nothing {
        when (throwable) {
            is PlaybackException -> throw throwable
            is ConnectException, is UnknownHostException -> throw PlaybackException(getString(R.string.error_no_internet), throwable, PlaybackException.ERROR_CODE_IO_NETWORK_CONNECTION_FAILED)
            is SocketTimeoutException -> throw PlaybackException(getString(R.string.error_timeout), throwable, PlaybackException.ERROR_CODE_IO_NETWORK_CONNECTION_TIMEOUT)
            is JossRedClient.JossRedException -> throw PlaybackException(throwable.message ?: "Error en la API de Joss Red", throwable, PlaybackException.ERROR_CODE_REMOTE_ERROR)
            else -> throw PlaybackException(throwable.message ?: getString(R.string.error_unknown), throwable, PlaybackException.ERROR_CODE_REMOTE_ERROR)
        }
    }

    private fun updateFormatInfo(mediaId: String, format: PlayerResponse.StreamingData.Format, loudnessDb: Double?) {
        database.query {
            upsert(FormatEntity(id = mediaId, itag = format.itag, mimeType = format.mimeType.split(";")[0], codecs = format.mimeType.split("codecs=")[1].removeSurrounding("\""), bitrate = format.bitrate, sampleRate = format.audioSampleRate, contentLength = format.contentLength!!, loudnessDb = loudnessDb))
        }
    }

    private fun createMediaSourceFactory() = DefaultMediaSourceFactory(createDataSourceFactory()) { arrayOf(MatroskaExtractor(), FragmentedMp4Extractor()) }

    private fun createRenderersFactory() =
        object : DefaultRenderersFactory(this) {
            override fun buildAudioSink(context: Context, enableFloatOutput: Boolean, enableAudioTrackPlaybackParams: Boolean) =
                DefaultAudioSink.Builder(this@MusicService)
                    .setEnableFloatOutput(enableFloatOutput)
                    .setEnableAudioTrackPlaybackParams(enableAudioTrackPlaybackParams)
                    .setAudioProcessorChain(DefaultAudioSink.DefaultAudioProcessorChain(emptyArray(), SilenceSkippingAudioProcessor(2_000_000, 0.01f, 2_000_000, 0, 256), SonicAudioProcessor()))
                    .build()
        }

    override fun onPlaybackStatsReady(eventTime: AnalyticsListener.EventTime, playbackStats: PlaybackStats) {
        val mediaItem = eventTime.timeline.getWindow(eventTime.windowIndex, Timeline.Window()).mediaItem
        if (playbackStats.totalPlayTimeMs >= 30000 && !settingsState.value.pauseHistory) {
            database.query {
                incrementTotalPlayTime(mediaItem.mediaId, playbackStats.totalPlayTimeMs)
                try {
                    insert(Event(songId = mediaItem.mediaId, timestamp = LocalDateTime.now(), playTime = playbackStats.totalPlayTimeMs))
                } catch (_: SQLException) {
                }
            }
        }
    }

    private fun saveQueueToDiskIO(persistQueue: PersistQueue?) {
        val queueFile = filesDir.resolve(PERSISTENT_QUEUE_FILE)
        if (persistQueue == null) {
            queueFile.delete()
            return
        }

        runCatching {
            queueFile.outputStream().use { fos ->
                ObjectOutputStream(fos).use { oos -> oos.writeObject(persistQueue) }
            }
        }.onFailure { reportException(it) }
    }

    private suspend fun saveQueueToDisk() {
        val persistQueue: PersistQueue? = withContext(Dispatchers.Main) {
            if (player.playbackState == STATE_IDLE || player.mediaItemCount == 0) {
                null
            } else {
                PersistQueue(
                    title = queueTitle,
                    items = player.mediaItems.mapNotNull { it.metadata },
                    mediaItemIndex = player.currentMediaItemIndex,
                    position = player.currentPosition
                )
            }
        }

        withContext(Dispatchers.IO) {
            saveQueueToDiskIO(persistQueue)
        }
    }

    override fun onDestroy() {
        // Capture state BEFORE releasing the player
        if (settingsState.value.persistentQueue) {
            val persistQueue = if (player.playbackState == STATE_IDLE || player.mediaItemCount == 0) {
                null
            } else {
                PersistQueue(
                    title = queueTitle,
                    items = player.mediaItems.mapNotNull { it.metadata },
                    mediaItemIndex = player.currentMediaItemIndex,
                    position = player.currentPosition
                )
            }
            // Block briefly to save data safely
            runBlocking(Dispatchers.IO) {
                saveQueueToDiskIO(persistQueue)
            }
        }

        discordRpc?.closeRPC()
        discordRpc = null
        mediaSession.release()
        player.removeListener(this)
        player.removeListener(sleepTimer)
        player.release()
        scope.cancel()
        super.onDestroy()
    }

    override fun onBind(intent: Intent?) = super.onBind(intent) ?: binder

    override fun onTaskRemoved(rootIntent: Intent?) {
        if (!player.playWhenReady) {
            stopSelf()
        }
    }

    override fun onGetSession(controllerInfo: MediaSession.ControllerInfo) = mediaSession

    inner class MusicBinder : Binder() {
        val service: MusicService get() = this@MusicService
    }

    companion object {
        const val ROOT = "root"
        const val SONG = "song"
        const val ARTIST = "artist"
        const val ALBUM = "album"
        const val PLAYLIST = "playlist"
        const val CHANNEL_ID = "music_channel_01"
        const val NOTIFICATION_ID = 888
        const val ERROR_CODE_NO_STREAM = 1000001
        const val CHUNK_LENGTH = 512 * 1024L
        const val PERSISTENT_QUEUE_FILE = "persistent_queue.data"
    }

    private suspend fun notifyWidget() {
        val extras = Bundle().apply {
            // --- Datos de la canción actual ---
            val currentMetadata = player.currentMediaItem?.mediaMetadata
            putString("SONG_TITLE", currentMetadata?.title?.toString() ?: getString(R.string.untitled))
            putString("ARTIST_NAME", currentMetadata?.artist?.toString() ?: getString(R.string.unknownArtist))
            putBoolean("IS_PLAYING", player.isPlaying)
            putString("IMAGE_URL", currentMetadata?.artworkUri?.toString())
            val isLiked = currentSong.value?.song?.liked ?: false
            putBoolean("IS_LIKED", isLiked)

            // --- Datos de las siguientes canciones (para el widget moderno) ---
            val currentIndex = player.currentMediaItemIndex
            val totalItems = player.mediaItemCount

            if (currentIndex + 1 < totalItems) {
                val nextMetadata = player.getMediaItemAt(currentIndex + 1).mediaMetadata
                putString("UP_NEXT_1_TITLE", nextMetadata.title?.toString())
                putString("UP_NEXT_1_ARTIST", nextMetadata.artist?.toString())
                putString("UP_NEXT_1_IMAGE_URL", nextMetadata.artworkUri?.toString())
            }

            if (currentIndex + 2 < totalItems) {
                val nextNextMetadata = player.getMediaItemAt(currentIndex + 2).mediaMetadata
                putString("UP_NEXT_2_TITLE", nextNextMetadata.title?.toString())
                putString("UP_NEXT_2_ARTIST", nextNextMetadata.artist?.toString())
                putString("UP_NEXT_2_IMAGE_URL", nextNextMetadata.artworkUri?.toString())
            }
        }

        // Crear y enviar intent para el WIDGET CLÁSICO
        val classicIntent = Intent(this, ClassicMusicWidgetProvider::class.java).apply {
            action = ClassicMusicWidgetProvider.UPDATE_WIDGET_ACTION
            putExtras(extras)
        }
        sendBroadcast(classicIntent)

        // Crear y enviar intent para el WIDGET MODERNO
        val modernIntent = Intent(this, ModernMusicWidgetProvider::class.java).apply {
            action = ModernMusicWidgetProvider.UPDATE_WIDGET_ACTION
            putExtras(extras)
        }
        sendBroadcast(modernIntent)
    }
}