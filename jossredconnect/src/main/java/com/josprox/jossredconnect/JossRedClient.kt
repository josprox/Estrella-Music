package com.josprox.jossredconnect

import android.net.Uri
import androidx.media3.datasource.DataSpec
import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.IOException
import java.util.concurrent.TimeUnit

object JossRedClient {
    // Si esta ruta responde directamente con el audio, no hace falta extraer nada del body.
    private const val BASE_STREAM_URL = "https://jossred.josprox.com/yt/v2/stream/"

    private val httpClient = OkHttpClient.Builder()
        .connectTimeout(10, TimeUnit.SECONDS)
        .readTimeout(10, TimeUnit.SECONDS)
        .build()

    /** Excepción específica de JossRed (propaga código HTTP si existe). */
    class JossRedException(
        val statusCode: Int,
        message: String,
        cause: Throwable? = null
    ) : Exception(message, cause)

    /**
     * Valida que el endpoint de streaming esté accesible (2xx).
     * Si todo va bien, devuelve la URL final de streaming (la misma que consultamos).
     *
     * NOTA: Hacemos una petición síncrona breve para validar acceso.
     * Si prefieres menos latencia, puedes omitir el preflight y devolver la URL sin pedirla.
     */
    @Throws(JossRedException::class)
    fun getStreamingUrl(mediaId: String, secretKey: String): String {
        if (secretKey.isBlank()) {
            throw JossRedException(-1, "Falta X-JossRed-Auth (clave vacía)")
        }

        val requestUrl = "$BASE_STREAM_URL$mediaId"
        val request = Request.Builder()
            .url(requestUrl)
            .addHeader("X-JossRed-Auth", secretKey)
            .get()
            .build()

        try {
            httpClient.newCall(request).execute().use { response ->
                val code = response.code
                val bodyStr = response.body?.string() // solo para diagnosticar; el stream real lo hará ExoPlayer

                if (!response.isSuccessful ||
                    bodyStr?.contains("Unable to fetch audio URL", ignoreCase = true) == true
                ) {
                    val message =
                        if (bodyStr?.contains("Unable to fetch audio URL", ignoreCase = true) == true) {
                            "Error del servidor: No se pudo obtener el audio desde JossRed"
                        } else {
                            when (code) {
                                403 -> "Acceso denegado (403) para el recurso"
                                404 -> "Recurso no encontrado (404)"
                                in 400..499 -> "Error del cliente ($code)"
                                in 500..599 -> "Error del servidor ($code)"
                                else -> "Error desconocido ($code)"
                            }
                        }
                    throw JossRedException(code, message)
                }
            }
        } catch (e: IOException) {
            throw JossRedException(-1, "Error de conexión: ${e.message}", e)
        }

        // Si la validación pasó, ExoPlayer usará esta misma URL con el header.
        return requestUrl
    }

    /**
     * Devuelve un DataSpec que apunta al stream de JossRed y añade el header de autenticación.
     */
    @Throws(JossRedException::class)
    fun resolveDataSpec(original: DataSpec, mediaId: String, secretKey: String): DataSpec {
        val streamUrl = getStreamingUrl(mediaId, secretKey)
        return original.buildUpon()
            .setUri(Uri.parse(streamUrl))
            .setHttpRequestHeaders(mapOf("X-JossRed-Auth" to secretKey))
            .build()
    }
}
