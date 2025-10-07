package com.zionhuang.music

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import com.zionhuang.music.playback.MusicService

class MusicWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
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

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
            extras: android.os.Bundle? = null
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

            // Configurar PendingIntents para los botones
            views.setOnClickPendingIntent(R.id.btn_play_pause, getPendingIntent(context, ACTION_PLAY_PAUSE))
            views.setOnClickPendingIntent(R.id.btn_next, getPendingIntent(context, ACTION_NEXT))
            views.setOnClickPendingIntent(R.id.btn_prev, getPendingIntent(context, ACTION_PREV))

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        private fun getPendingIntent(context: Context, action: String): PendingIntent {
            val intent = Intent(context, MusicService::class.java).apply {
                this.action = action
            }
            return PendingIntent.getService(context, action.hashCode(), intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        }
    }
}

