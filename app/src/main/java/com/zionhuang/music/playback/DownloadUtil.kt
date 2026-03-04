package com.zionhuang.music.playback

import android.content.Context
import android.net.ConnectivityManager
import androidx.core.content.getSystemService
import androidx.core.net.toUri
import androidx.media3.database.DatabaseProvider
import androidx.media3.datasource.ResolvingDataSource
import androidx.media3.datasource.cache.CacheDataSource
import androidx.media3.datasource.cache.SimpleCache
import androidx.media3.datasource.okhttp.OkHttpDataSource
import androidx.media3.exoplayer.offline.Download
import androidx.media3.exoplayer.offline.DownloadManager
import androidx.media3.exoplayer.offline.DownloadNotificationHelper
import androidx.media3.exoplayer.offline.DownloadRequest
import androidx.media3.exoplayer.offline.DownloadService
import com.josprox.jossredconnect.JossRedClient
import com.zionhuang.innertube.YouTube
import com.zionhuang.music.constants.AudioQuality
import com.zionhuang.music.constants.AudioQualityKey
import com.zionhuang.music.db.MusicDatabase
import com.zionhuang.music.db.entities.FormatEntity
import com.zionhuang.music.db.entities.SongEntity
import com.zionhuang.music.di.AppModule.PlayerCache
import com.zionhuang.music.di.DownloadCache
import com.zionhuang.music.models.MediaMetadata
import com.zionhuang.music.utils.SecureKeys
import com.zionhuang.music.utils.YTPlayerUtils
import com.zionhuang.music.utils.enumPreference
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.runBlocking
import okhttp3.OkHttpClient
import java.util.concurrent.Executor
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class DownloadUtil @Inject constructor(
    @ApplicationContext private val context: Context,
    val database: MusicDatabase,
    val databaseProvider: DatabaseProvider,
    @DownloadCache val downloadCache: SimpleCache,
    @PlayerCache val playerCache: SimpleCache,
) {
    private val connectivityManager = context.getSystemService<ConnectivityManager>()!!
    private val audioQuality by enumPreference(context, AudioQualityKey, AudioQuality.AUTO)
    private val songUrlCache = HashMap<String, Pair<String, Long>>()

    // Clave segura Joss Red (igual que en playback)
    private val jossRedKey: String by lazy { SecureKeys.getJossRedKey() }

    // Helpers JWT almacenado por tu AuthService
    private fun hasJwt(): Boolean {
        val sp = context.getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
        val jwt = sp.getString("jwt_token", null) ?: return false
        val exp = sp.getLong("token_expiration", -1L)
        val now = System.currentTimeMillis() / 1000L
        val skew = 60 // margen de 1 min
        return exp <= 0L || (exp - now) > skew
    }
    private fun readJwtOrNull(): String? =
        context.getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
            .getString("jwt_token", null)

    private val dataSourceFactory = ResolvingDataSource.Factory(
        CacheDataSource.Factory()
            .setCache(playerCache) // ok: DownloadManager ya persiste en downloadCache internamente
            .setUpstreamDataSourceFactory(
                OkHttpDataSource.Factory(
                    OkHttpClient.Builder()
                        .proxy(YouTube.proxy)
                        .build()
                )
            )
    ) { dataSpec ->
        val mediaId = dataSpec.key ?: error("No media id")
        val length = if (dataSpec.length >= 0) dataSpec.length else 1

        // 1) Si ya está en cache local, usarlo
        if (playerCache.isCached(mediaId, dataSpec.position, length)) {
            return@Factory dataSpec
        }

        // 2) (opcional) cache en memoria
        // songUrlCache[mediaId]?.takeIf { it.second > System.currentTimeMillis() }?.let {
        //     return@Factory dataSpec.withUri(it.first.toUri())
        // }

        var lastError: Exception? = null

        // 3) Intentar YouTube/NewPipe (hasta 3 intentos, como antes)
        repeat(3) retry@{
            try {
                // (a) formato previo (si lo usas para algo adicional)
                runBlocking(Dispatchers.IO) { database.format(mediaId).first() }

                // (b) player response -> streamUrl
                val playbackData = runBlocking(Dispatchers.IO) {
                    YTPlayerUtils.playerResponseForPlayback(
                        mediaId,
                        audioQuality = audioQuality,
                        connectivityManager = connectivityManager,
                    )
                }.getOrThrow()

                val format = playbackData.format

                // (c) guardar formato
                database.query {
                    upsert(
                        FormatEntity(
                            id = mediaId,
                            itag = format.itag,
                            mimeType = format.mimeType.split(";")[0],
                            codecs = format.mimeType.split("codecs=").getOrNull(1)?.removeSurrounding("\"") ?: "",
                            bitrate = format.bitrate,
                            sampleRate = format.audioSampleRate,
                            contentLength = format.contentLength ?: 0L,
                            loudnessDb = playbackData.audioConfig?.loudnessDb,
                        )
                    )
                }

                // (d) URL con rango forzado (tu lógica)
                val streamUrl = playbackData.streamUrl.let {
                    "${it}&range=0-${format.contentLength ?: 10000000}"
                }

                // (e) cache simple en memoria
                songUrlCache[mediaId] = streamUrl to
                        System.currentTimeMillis() + (playbackData.streamExpiresInSeconds * 1000L)

                return@Factory dataSpec.withUri(streamUrl.toUri())

            } catch (e: Exception) {
                lastError = e
                val is403 = e.message?.contains("403") == true || e.message?.contains("Forbidden") == true
                if (!is403) {
                    // No vale la pena reintentar YouTube -> salimos del bucle
                    return@retry
                }
                // en 403, se reintenta hasta agotar
            }
        }

        // 4) EMERGENCIA: intentar Joss Red si hay sesión y key
        if (hasJwt() && jossRedKey.isNotBlank()) {
            try {
                val url = JossRedClient.getStreamingUrl(
                    context = context,
                    mediaId = mediaId,
                    secretKey = jossRedKey
                )
                val jwt = readJwtOrNull()!!
                return@Factory dataSpec.buildUpon()
                    .setUri(url.toUri())
                    .setHttpRequestHeaders(
                        mapOf(
                            "X-JossRed-Auth" to jossRedKey,
                            "Authorization" to "Bearer $jwt",
                        )
                    )
                    .build()
            } catch (e: Exception) {
                // Si también falla, dejamos seguir el flujo como error
                lastError = e
            }
        }

        // 5) Si falla, devolvemos el DataSpec original (el DownloadManager marcará el fallo)
        return@Factory dataSpec
    }

    val downloadNotificationHelper =
        DownloadNotificationHelper(context, ExoDownloadService.CHANNEL_ID)

    val downloadManager: DownloadManager = DownloadManager(
        context,
        databaseProvider,
        downloadCache,
        dataSourceFactory,
        Executor(Runnable::run)
    ).apply {
        maxParallelDownloads = 3
        addListener(
            ExoDownloadService.TerminalStateNotificationHelper(
                context = context,
                notificationHelper = downloadNotificationHelper,
                nextNotificationId = ExoDownloadService.NOTIFICATION_ID + 1
            )
        )
    }

    val downloads = MutableStateFlow<Map<String, Download>>(emptyMap())

    fun getDownload(songId: String): Flow<Download?> = downloads.map { it[songId] }

    fun download(songs: List<MediaMetadata>) {
        songs.forEach { song -> downloadSong(song.id, song.title) }
    }

    fun download(song: MediaMetadata) {
        downloadSong(song.id, song.title)
    }

    fun download(song: SongEntity) {
        downloadSong(song.id, song.title)
    }

    private fun downloadSong(id: String, title: String) {
        val downloadRequest = DownloadRequest.Builder(id, id.toUri())
            .setCustomCacheKey(id) // importante: key = mediaId para el resolver
            .setData(title.toByteArray())
            .build()
        DownloadService.sendAddDownload(
            context,
            ExoDownloadService::class.java,
            downloadRequest,
            false
        )
    }

    init {
        val result = mutableMapOf<String, Download>()
        val cursor = downloadManager.downloadIndex.getDownloads()
        while (cursor.moveToNext()) {
            result[cursor.download.request.id] = cursor.download
        }
        downloads.value = result
        downloadManager.addListener(
            object : DownloadManager.Listener {
                override fun onDownloadChanged(
                    downloadManager: DownloadManager,
                    download: Download,
                    finalException: Exception?
                ) {
                    downloads.update { map ->
                        map.toMutableMap().apply { set(download.request.id, download) }
                    }
                }
            }
        )
    }
}
