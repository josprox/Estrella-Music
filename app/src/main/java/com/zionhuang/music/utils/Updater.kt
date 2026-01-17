package com.zionhuang.music.utils

import com.zionhuang.music.BuildConfig
import io.ktor.client.HttpClient
import io.ktor.client.request.get
import io.ktor.client.statement.bodyAsText

import org.json.JSONObject

object Updater {
    val client = HttpClient()
    var lastCheckTime = -1L
        private set

    // Modelo de datos para los detalles de la versión
    data class ReleaseDetails(
        val version: String,
        val title: String,
        val description: String,
        val author: String,
        val downloadUrl: String
    )

    /**
     * Obtiene los detalles de la última versión como un modelo `ReleaseDetails`.
     */
    suspend fun getLatestReleaseDetails(): Result<ReleaseDetails> = runCatching {
        val response = client.get(SecureKeys.updaterUrl).bodyAsText()
        val json = JSONObject(response)

        val version = json.getString("Version")
        val title = json.optString("Titulo", "No disponible")
        val description = json.optString("Descripcion", "No disponible")
        val author = json.optString("Autor", "No disponible")
        val downloadUrl = json.optString("Descarga", "No disponible")

        lastCheckTime = System.currentTimeMillis()

        ReleaseDetails(
            version = version,
            title = title,
            description = description,
            author = author,
            downloadUrl = downloadUrl
        )
    }

    // Obtener solo la versión.

    suspend fun getLatestVersionName(): Result<String> = runCatching {
        val response = client.get(SecureKeys.updaterUrl).bodyAsText()
        val json = JSONObject(response)
        val versionName = json.getString("Version")
        lastCheckTime = System.currentTimeMillis()
        versionName
    }

    fun isNewVersionAvailable(current: String, latest: String): Boolean {
        return compareVersions(latest, current) > 0
    }

    fun compareVersions(v1: String, v2: String): Int {
        val v1Parts = v1.removePrefix("v").removePrefix("V").split(".")
        val v2Parts = v2.removePrefix("v").removePrefix("V").split(".")

        val length = maxOf(v1Parts.size, v2Parts.size)

        for (i in 0 until length) {
            val part1 = if (i < v1Parts.size) v1Parts[i].toIntOrNull() ?: 0 else 0
            val part2 = if (i < v2Parts.size) v2Parts[i].toIntOrNull() ?: 0 else 0

            if (part1 > part2) return 1
            if (part1 < part2) return -1
        }
        return 0
    }
}