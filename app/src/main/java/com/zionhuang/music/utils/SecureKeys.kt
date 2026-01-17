// app/src/main/java/com/zionhuang/music/utils/SecureKeys.kt
package com.zionhuang.music.utils

import android.content.Context
import com.josprox.jossredconnect.services.AuthService
import com.zionhuang.music.BuildConfig
import org.dotenv.vault.dotenvVault
import timber.log.Timber

object SecureKeys {

    // Cargamos el vault solo una vez
    private val vault by lazy {
        dotenvVault(BuildConfig.DOTENV_KEY) {
            directory = "/assets"
            filename = "env.vault"
        }
    }

    // Getter seguro con fallback + log
    private fun get(key: String, def: String = ""): String {
        val v = runCatching { vault[key] }.getOrNull()
        if (v.isNullOrBlank()) {
            Timber.w("SecureKeys: clave faltante o vacía: %s", key)
            return def
        }
        return v
    }

    // ---- Getters públicos ----
    val adMobBannerId: String
        get() = get("ADMOB_BANNER_ID")

    val petalBannerId: String
        get() = if (BuildConfig.DEBUG) {
            "testw6vs28auh3" // Test ID para Debug
        } else {
            get("PETALBANNER") // ID real para Release
        }
    val oneSignalAppId: String
        get() = get("ONESIGNAL_APP_ID")

    val jossRedBaseUrl: String
        get() = get("JOSSRED").let { if (it.endsWith("/")) it else "$it/" }

    val jossRedApiToken: String
        get() = get("JOSSRED_API")

    val homepageUrl: String get() = get("HOMEPAGE")
    val updaterUrl: String get() = get("UPDATER_URL")

    // Opción A: función (para evitar colisiones nombre/propiedad)
    fun getJossRedKey(): String = get("STREAMING_HEAD_JOSSRED")

    // ---- Constructor de servicios ya configurados ----
    fun createAuthService(context: Context): AuthService {
        return AuthService(
            context = context,
            baseUrl = jossRedBaseUrl,
            apiToken = jossRedApiToken
        )
    }
}
