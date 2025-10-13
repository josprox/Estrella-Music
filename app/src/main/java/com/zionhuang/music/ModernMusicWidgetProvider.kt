package com.zionhuang.music

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.view.View
import android.widget.RemoteViews
import coil.ImageLoader
import coil.request.ImageRequest
import com.zionhuang.music.playback.MusicService
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class ModernMusicWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId, null)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)

        if (intent.action == UPDATE_WIDGET_ACTION) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(
                ComponentName(context, ModernMusicWidgetProvider::class.java)
            )
            for (appWidgetId in appWidgetIds) {
                updateAppWidget(context, appWidgetManager, appWidgetId, intent.extras)
            }
        }
    }

    companion object {
        const val UPDATE_WIDGET_ACTION = "com.josprox.jossmusic.UPDATE_WIDGET"
        const val ACTION_PLAY_PAUSE = "com.josprox.jossmusic.PLAY_PAUSE"
        const val ACTION_NEXT = "com.josprox.jossmusic.NEXT"
        const val ACTION_PREV = "com.josprox.jossmusic.PREV"
        const val ACTION_TOGGLE_LIKE = "com.josprox.jossmusic.TOGGLE_LIKE"

        private val coroutineScope = CoroutineScope(Dispatchers.IO + Job())

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
            extras: android.os.Bundle?
        ) {
            // USAR EL NUEVO LAYOUT
            val views = RemoteViews(context.packageName, R.layout.new_widget_layout)

            // --- SECCIÓN NOW PLAYING (LÓGICA SIMILAR) ---
            views.setTextViewText(R.id.txt_song_title, extras?.getString("SONG_TITLE") ?: context.getString(R.string.noPlayback))
            views.setTextViewText(R.id.txt_artist_name, extras?.getString("ARTIST_NAME") ?: "---")

            val isPlaying = extras?.getBoolean("IS_PLAYING", false) ?: false
            views.setImageViewResource(R.id.btn_play_pause, if (isPlaying) R.drawable.ic_pause else R.drawable.ic_play_arrow)

            val isLiked = extras?.getBoolean("IS_LIKED", false) ?: false
            views.setImageViewResource(R.id.btn_like, if (isLiked) R.drawable.favorite else R.drawable.favorite_border)

            // Configurar PendingIntents
            views.setOnClickPendingIntent(R.id.btn_play_pause, getPendingIntent(context, ACTION_PLAY_PAUSE))
            views.setOnClickPendingIntent(R.id.btn_next, getPendingIntent(context, ACTION_NEXT))
            views.setOnClickPendingIntent(R.id.btn_prev, getPendingIntent(context, ACTION_PREV))
            views.setOnClickPendingIntent(R.id.btn_like, getPendingIntent(context, ACTION_TOGGLE_LIKE))
            // Para abrir la app al tocar el widget
            val openAppIntent = Intent(context, MainActivity::class.java)
            val openAppPendingIntent = PendingIntent.getActivity(context, 0, openAppIntent, PendingIntent.FLAG_IMMUTABLE)
            views.setOnClickPendingIntent(R.id.widget_container, openAppPendingIntent)


            // --- NUEVO: SECCIÓN UP NEXT ---
            updateUpNextView(views, extras, 1, R.id.up_next_1_container, R.id.up_next_1_title, R.id.up_next_1_artist)
            updateUpNextView(views, extras, 2, R.id.up_next_2_container, R.id.up_next_2_title, R.id.up_next_2_artist)

            // Actualización inicial para texto y controles
            appWidgetManager.updateAppWidget(appWidgetId, views)

            // Cargar imagen de portada principal de forma asíncrona
            loadImageAsync(context, appWidgetManager, appWidgetId, views, extras?.getString("IMAGE_URL"), R.id.image_cover, R.drawable.joss_music_logo)

            // Cargar imágenes de "Up Next"
            loadImageAsync(context, appWidgetManager, appWidgetId, views, extras?.getString("UP_NEXT_1_IMAGE_URL"), R.id.up_next_1_cover, R.drawable.joss_music_logo)
            loadImageAsync(context, appWidgetManager, appWidgetId, views, extras?.getString("UP_NEXT_2_IMAGE_URL"), R.id.up_next_2_cover, R.drawable.joss_music_logo)
        }

        // NUEVO: Función auxiliar para no repetir código
        private fun updateUpNextView(
            views: RemoteViews,
            extras: android.os.Bundle?,
            index: Int,
            containerId: Int,
            titleId: Int,
            artistId: Int
        ) {
            val title = extras?.getString("UP_NEXT_${index}_TITLE")
            if (title != null) {
                views.setViewVisibility(containerId, View.VISIBLE)
                views.setTextViewText(titleId, title)
                views.setTextViewText(artistId, extras.getString("UP_NEXT_${index}_ARTIST"))
            } else {
                views.setViewVisibility(containerId, View.GONE)
            }
        }

        // NUEVO: Función para cargar imágenes de forma asíncrona
        private fun loadImageAsync(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int, views: RemoteViews, imageUrl: String?, imageViewId: Int, placeholderResId: Int) {
            coroutineScope.launch {
                val bitmap = loadImage(context, imageUrl)
                if (bitmap != null) {
                    views.setImageViewBitmap(imageViewId, bitmap)
                } else {
                    views.setImageViewResource(imageViewId, placeholderResId)
                }
                appWidgetManager.updateAppWidget(appWidgetId, views)
            }
        }

        private suspend fun loadImage(context: Context, url: String?): Bitmap? {
            if (url == null) return null
            return try {
                val loader = ImageLoader(context)
                val request = ImageRequest.Builder(context)
                    .data(url)
                    .allowHardware(false)
                    .build()
                (loader.execute(request).drawable as? BitmapDrawable)?.bitmap
            } catch (e: Exception) {
                null
            }
        }

        private fun getPendingIntent(context: Context, action: String): PendingIntent {
            val intent = Intent(context, MusicService::class.java).apply { this.action = action }
            val flags = PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            return PendingIntent.getService(context, action.hashCode(), intent, flags)
        }
    }
}