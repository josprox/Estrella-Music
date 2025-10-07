package com.zionhuang.music

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.widget.RemoteViews
import coil.ImageLoader
import coil.request.ImageRequest
import com.zionhuang.music.playback.MusicService
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class MusicWidgetProvider : AppWidgetProvider() {

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
                ComponentName(context, MusicWidgetProvider::class.java)
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
            val views = RemoteViews(context.packageName, R.layout.widget_layout)

            // Configurar textos
            views.setTextViewText(R.id.txt_song_title, extras?.getString("SONG_TITLE") ?: context.getString(R.string.noPlayback))
            views.setTextViewText(R.id.txt_artist_name, extras?.getString("ARTIST_NAME") ?: "---")

            // Configurar icono de Play/Pausa
            val isPlaying = extras?.getBoolean("IS_PLAYING", false) ?: false
            views.setImageViewResource(
                R.id.btn_play_pause,
                if (isPlaying) R.drawable.ic_pause else R.drawable.ic_play_arrow
            )

            // Configurar icono de Me Gusta
            val isLiked = extras?.getBoolean("IS_LIKED", false) ?: false
            views.setImageViewResource(
                R.id.btn_like,
                if (isLiked) R.drawable.favorite else R.drawable.favorite_border
            )

            // Configurar PendingIntents para los botones
            views.setOnClickPendingIntent(R.id.btn_play_pause, getPendingIntent(context, ACTION_PLAY_PAUSE))
            views.setOnClickPendingIntent(R.id.btn_next, getPendingIntent(context, ACTION_NEXT))
            views.setOnClickPendingIntent(R.id.btn_prev, getPendingIntent(context, ACTION_PREV))
            views.setOnClickPendingIntent(R.id.btn_like, getPendingIntent(context, ACTION_TOGGLE_LIKE))


            // Actualización inicial para texto y controles
            appWidgetManager.updateAppWidget(appWidgetId, views)

            // Cargar imagen de portada de forma asíncrona
            val imageUrl = extras?.getString("IMAGE_URL")
            coroutineScope.launch {
                val bitmap = loadImage(context, imageUrl)
                if (bitmap != null) {
                    views.setImageViewBitmap(R.id.image_cover, bitmap)
                } else {
                    views.setImageViewResource(R.id.image_cover, R.drawable.joss_music_logo)
                }
                // Actualizar el widget de nuevo con la imagen cargada
                appWidgetManager.updateAppWidget(appWidgetId, views)
            }
        }

        private suspend fun loadImage(context: Context, url: String?): Bitmap? {
            if (url == null) return null
            return try {
                val loader = ImageLoader(context)
                val request = ImageRequest.Builder(context)
                    .data(url)
                    .allowHardware(false) // Requerido para RemoteViews
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

