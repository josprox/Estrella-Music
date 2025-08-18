package com.josprox.jossredconnect

import android.content.Context
import android.net.Uri
import androidx.media3.datasource.DataSpec
import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.IOException
import java.util.concurrent.TimeUnit

object JossRedClient {
    // Nuevo path v3 + conn
    private const val BASE_STREAM_URL = "https://jossred.josprox.com/yt/v3/conn/stream/"

    private const val PREFS_NAME = "jossred_prefs"
    private const val PREF_JWT = "jwt_token"

    private val httpClient = OkHttpClient.Builder()
        .connectTimeout(15, TimeUnit.SECONDS)
        .readTimeout(15, TimeUnit.SECONDS)
        .build()

    /** Excepción específica de JossRed (propaga código HTTP si existe). */
    class JossRedException(
        val statusCode: Int,
        message: String,
        cause: Throwable? = null
    ) : Exception(message, cause)

    private fun readJwt(context: Context): String? =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            .getString(PREF_JWT, null)

    /**
     * Valida que el endpoint protegido con JWT + X-JossRed-Auth responda 2xx.
     * Si va bien, devuelve la URL (redireccionará al CDN en ejecución real).
     */
    @Throws(JossRedException::class)
    fun getStreamingUrl(context: Context, mediaId: String, secretKey: String): String {
        if (secretKey.isBlank()) {
            throw JossRedException(-1, "Falta X-JossRed-Auth (clave vacía)")
        }
        val jwt = readJwt(context)
            ?: throw JossRedException(401, "No hay JWT almacenado, inicia sesión")

        val requestUrl = "$BASE_STREAM_URL$mediaId"
        val request = Request.Builder()
            .url(requestUrl)
            .addHeader("X-JossRed-Auth", secretKey)
            .addHeader("Authorization", "Bearer $jwt")
            .get()
            .build()

        try {
            httpClient.newCall(request).execute().use { response ->
                val code = response.code
                val bodyStr = response.body?.string()

                if (!response.isSuccessful ||
                    bodyStr?.contains("Unable to fetch audio URL", ignoreCase = true) == true
                ) {
                    val message = when {
                        bodyStr?.contains("Unable to fetch audio URL", ignoreCase = true) == true ->
                            "El servidor no pudo obtener el audio (yt-dlp falló)"
                        code == 401 -> "JWT inválido o expirado (401)"
                        code == 403 -> "Clave Joss Red inválida (403)"
                        code == 404 -> "Recurso no encontrado (404)"
                        code in 400..499 -> "Error del cliente ($code)"
                        code in 500..599 -> "Error del servidor ($code)"
                        else -> "Error desconocido ($code)"
                    }
                    throw JossRedException(code, message)
                }
            }
        } catch (e: IOException) {
            throw JossRedException(-1, "Error de conexión: ${e.message}", e)
        }

        return requestUrl
    }

    /**
     * Devuelve un DataSpec apuntando al stream v3 con ambas cabeceras.
     * ExoPlayer seguirá la redirección 302 al CDN; las cabeceras no son necesarias allá.
     */
    @Throws(JossRedException::class)
    fun resolveDataSpec(
        context: Context,
        original: DataSpec,
        mediaId: String,
        secretKey: String
    ): DataSpec {
        val streamUrl = getStreamingUrl(context, mediaId, secretKey)
        val jwt = readJwt(context)
            ?: throw JossRedException(401, "No hay JWT almacenado, inicia sesión")

        return original.buildUpon()
            .setUri(Uri.parse(streamUrl))
            .setHttpRequestHeaders(
                mapOf(
                    "X-JossRed-Auth" to secretKey,
                    "Authorization" to "Bearer $jwt",
                )
            )
            .build()
    }
}
