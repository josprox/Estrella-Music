package com.zionhuang.music.ui.onboarding

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.datastore.preferences.core.edit
import androidx.lifecycle.lifecycleScope
import com.zionhuang.music.R
import com.zionhuang.music.constants.OnboardingShownKey
import com.zionhuang.music.utils.dataStore
import kotlinx.coroutines.launch

class OnboardingActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        setTheme(R.style.Theme_InnerTune) // opcional, mismo tema
        super.onCreate(savedInstanceState)

        // Puedes reutilizar los mismos items que en MainActivity, o definirlos aquí:
        val items = listOf(
            CarouselItem(R.drawable.joss_music_logo, "Bienvenido a Estrella Music", "Tu música en un solo lugar: rápido, limpio y pensado para ti."),
            CarouselItem(R.drawable.download, "Descargas inteligentes", "Guarda canciones, álbumes y playlists para escucharlos sin conexión."),
            CarouselItem(R.drawable.media3_icon_feed, "Enlaces internos seguros", "App Links verificados y deep links confiables."),
            CarouselItem(R.drawable.offline, "Modo sin conexión", "Tu música suena aun sin internet."),
            CarouselItem(R.drawable.search, "Búsqueda y descubrimiento", "YouTube Music y biblioteca local en un mismo sitio."),
            CarouselItem(R.drawable.library_add, "Listas y biblioteca", "Crea, organiza y comparte playlists.")
        )

        setContent {
            OnboardingScreen(
                items = items,
                onFinish = {
                    lifecycleScope.launch {
                        applicationContext.dataStore.edit { it[OnboardingShownKey] = true }
                    }
                    finish() // vuelve a la app (que ya está abierta con el deep link)
                }
            )
        }
    }
}
