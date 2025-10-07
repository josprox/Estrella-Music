package com.josprox.jossredconnect

import android.content.Context
import android.net.Uri
import androidx.media3.datasource.DataSpec
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import java.io.IOException
import java.util.concurrent.TimeUnit

object JossRedClient {
    private const val BASE_STREAM_URL = "https://jossred.josprox.com/api/yt/v3/conn/stream/"
    private const val PREFS_NAME = "jossred_prefs"
    private const val PREF_JWT = "jwt_token"

    private val httpClient = OkHttpClient.Builder()
        .connectTimeout(15, TimeUnit.SECONDS)
        .readTimeout(15, TimeUnit.SECONDS)
        .followRedirects(false)
        .build()

    class JossRedException(
        val statusCode: Int,
        message: String,
        cause: Throwable? = null
    ) : Exception(message, cause)

    private fun readJwt(context: Context): String? =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            .getString(PREF_JWT, null)

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

        var response: Response? = null
        try {
            response = httpClient.newCall(request).execute()
            val code = response.code

            if (code == 302) {
                val redirectedUrl = response.header("Location")
                if (!redirectedUrl.isNullOrBlank()) {
                    return redirectedUrl
                } else {
                    throw JossRedException(code, "API devolvió 302 pero sin 'Location' en las cabeceras.")
                }
            } else {
                val bodyStr = response.body?.string()
                val message = when {
                    bodyStr?.contains("Unable to fetch audio URL", ignoreCase = true) == true ->
                        "El servidor no pudo obtener el audio (Joss Red falló)"
                    code == 401 -> "JWT inválido o expirado (401)"
                    code == 403 -> "Clave Joss Red inválida (403)"
                    code == 404 -> "Recurso no encontrado (404)"
                    code in 400..499 -> "Error del cliente ($code): ${bodyStr.orEmpty()}"
                    code in 500..599 -> "Error del servidor ($code): ${bodyStr.orEmpty()}"
                    else -> "Respuesta inesperada del servidor ($code): ${bodyStr.orEmpty()}"
                }
                throw JossRedException(code, message)
            }
        } catch (e: IOException) {
            throw JossRedException(-1, "Error de conexión: ${e.message}", e)
        } finally {
            response?.close()
        }
    }

    @Throws(JossRedException::class)
    fun resolveDataSpec(
        context: Context,
        original: DataSpec,
        mediaId: String,
        secretKey: String
    ): DataSpec {
        val cdnStreamUrl = getStreamingUrl(context, mediaId, secretKey)

        return original.buildUpon()
            .setUri(Uri.parse(cdnStreamUrl))
            .setHttpRequestHeaders(emptyMap())
            .build()
    }
}

