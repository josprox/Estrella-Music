package com.josprox.jossredconnect.services

import android.annotation.SuppressLint
import android.content.Context
import android.content.SharedPreferences
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import java.io.IOException
import java.util.concurrent.TimeUnit
import android.util.Log



/**
 * Traducción de AuthService Joss Red (Flutter/Dart) a Kotlin para Android (librería).
 * - Guarda token, refresh y expiración en SharedPreferences.
 * - Usa OkHttp para HTTP y coroutines (suspend).
 * - Devuelve mapas estilo { "success": Boolean, ... } como en Dart.
 *
 * @param context   Contexto para SharedPreferences.
 * @param baseUrl   Base URL, p.ej. "https://api.tu-dominio.com/" (incluye slash final).
 * @param apiToken  Token estático (equivalente a dotenv['JOSSRED_API']) para header X-JossRed-Auth.
 */
class AuthService(
    private val context: Context,
    private val baseUrl: String,
    private val apiToken: String
) {

    private val jsonMedia = "application/json; charset=utf-8".toMediaType()

    private val client: OkHttpClient = OkHttpClient.Builder()
        .connectTimeout(25, TimeUnit.SECONDS)
        .readTimeout(25, TimeUnit.SECONDS)
        .build()

    private val prefs: SharedPreferences by lazy {
        context.getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
    }

    // === Helpers de storage ===

    private suspend fun saveTokenData(token: String, refreshToken: String, expiresInSeconds: Int) =
        withContext(Dispatchers.IO) {
            // guardamos expiración en segundos tipo UNIX (como en Dart)
            val expirationUnixSeconds =
                (System.currentTimeMillis() / 1000L) + expiresInSeconds.toLong()
            prefs.edit()
                .putString("jwt_token", token)
                .putString("refresh_token", refreshToken)
                .putLong("token_expiration", expirationUnixSeconds)
                .apply()
        }

    @SuppressLint("UseKtx")
    private suspend fun clearStorage() = withContext(Dispatchers.IO) {
        prefs.edit()
            .remove("jwt_token")
            .remove("refresh_token")
            .remove("remove") // Typo in original? No, "password" was unused?
            .remove("password")
            .apply()
    }

    private fun headers(): Map<String, String> = mapOf(
        "Content-Type" to "application/json",
        "Accept" to "application/json",
        "Authorization" to "Bearer $apiToken"
    )

    private fun headersWithJWT(jwt: String?): Map<String, String> {
        val base = headers().toMutableMap()
        if (!jwt.isNullOrBlank()) base["Authorization"] = "Bearer $jwt"
        return base
    }

    private fun httpError(e: Exception): Map<String, Any?> = mapOf(
        "success" to false,
        "message" to when (e) {
            is IOException -> "Error de conexión: ${e.message}"
            else -> "Error inesperado: ${e.message}"
        }
    )

    private suspend fun doPostJson(
        urlPath: String,
        body: JSONObject,
        headers: Map<String, String> = headers()
    ): Pair<Int, String> = withContext(Dispatchers.IO) {
        val reqBody = body.toString().toRequestBody(jsonMedia)
        val reqBuilder = Request.Builder()
            .url("${baseUrl}${urlPath}")
            .post(reqBody)
        headers.forEach { (k, v) -> reqBuilder.addHeader(k, v) }
        val url = reqBuilder.build().url.toString()
        Log.d("JOSS_DEBUG", "POST URL: $url")
        client.newCall(reqBuilder.build()).execute().use { resp ->
            val body = resp.body?.string().orEmpty()
            Log.d("JOSS_DEBUG", "Resp ($url): ${resp.code} / $body")
            Pair(resp.code, body)
        }
    }

    private suspend fun doGet(
        urlPath: String,
        headers: Map<String, String>
    ): Pair<Int, String> = withContext(Dispatchers.IO) {
        val reqBuilder = Request.Builder()
            .url("${baseUrl}${urlPath}")
            .get()
        headers.forEach { (k, v) -> reqBuilder.addHeader(k, v) }
        val url = reqBuilder.build().url.toString()
        Log.d("JOSS_DEBUG", "GET URL: $url")
        client.newCall(reqBuilder.build()).execute().use { resp ->
            val body = resp.body?.string().orEmpty()
            Log.d("JOSS_DEBUG", "Resp ($url): ${resp.code} / $body")
            Pair(resp.code, body)
        }
    }

    // === API Públicas (símil a Dart) ===

    suspend fun login(email: String, password: String): Map<String, Any?> {
        return try {
            val (code, bodyStr) = doPostJson(
                urlPath = "api/login",
                body = JSONObject().apply {
                    put("email", email.trim())
                    put("password", password.trim())
                }
            )

            val data = bodyStr.safeJson()

            when (code) {
                200 -> {
                    if (data.has("token")) {
                        saveTokenData(
                            token = data.optString("token"),
                            refreshToken = data.optString("refresh_token", ""),
                            expiresInSeconds = data.optInt("expires_in", 7_776_000) // 90 días
                        )
                        mapOf("success" to true, "token" to data.optString("token"))
                    } else {
                        mapOf(
                            "success" to false,
                            "message" to data.optString("error", "Error desconocido en el login")
                        )
                    }
                }
                404, 422 -> mapOf("success" to false, "message" to "EMAIL_NOT_FOUND") // Adjusting for typical 422 validation errs too? Keep simple
                401 -> mapOf("success" to false, "message" to "INVALID_PASSWORD")
                else -> mapOf("success" to false, "message" to "SERVER_ERROR ($code)")
            }        } catch (e: Exception) {
            Log.e("JOSS_DEBUG", "Login error", e)
            httpError(e)
        }
    }

    suspend fun register(
        username: String,
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ): Map<String, Any?> {
        return try {
            val body = JSONObject().apply {
                put("username", username.trim())
                put("first_name", firstName.trim())
                put("last_name", lastName.trim())
                put("email", email.trim())
                put("phone", "")
                put("password", password.trim())
            }

            val (code, bodyStr) = doPostJson("api/register", body)
            val data = bodyStr.safeJson()

            if (code == 201) {
                if (data.has("token")) {
                    saveTokenData(
                        token = data.optString("token"),
                        refreshToken = data.optString("refresh_token", ""),
                        expiresInSeconds = data.optInt("expires_in", 7_776_000)
                    )
                }
                mapOf("success" to true, "message" to data.optString("message"))
            } else {
                mapOf(
                    "success" to false,
                    "errors" to (data.optJSONObject("errors")?.toMap() ?: emptyMap<String, Any?>()),
                    "message" to data.optString("message", "Error en el registro")
                )
            }
        } catch (e: Exception) {
            httpError(e)
        }
    }

    suspend fun sendRecoveryEmail(email: String): Map<String, Any?> {
        return try {
            val (code, bodyStr) = doPostJson(
                urlPath = "api/password/email",
                body = JSONObject().apply { put("email", email.trim()) }
            )
            val data = bodyStr.safeJson()
            if (code == 200) {
                mapOf("success" to true, "message" to data.optString("message"))
            } else {
                mapOf(
                    "success" to false,
                    "message" to data.optString("message", "Error desconocido")
                )
            }
        } catch (e: Exception) {
            httpError(e)
        }
    }

    suspend fun fetchUserProfile(): Map<String, Any?> {
        val token = prefs.getString("jwt_token", null)
        if (token.isNullOrBlank()) {
            return mapOf("success" to false, "message" to "No se encontró token JWT almacenado")
        }
        return try {
            val (code, bodyStr) = doGet(
                urlPath = "api/profile",
                headers = headersWithJWT(token)
            )

            when (code) {
                200 -> {
                    val data = bodyStr.safeJson()
                    // La respuesta trae "user": { "Fields": { ... } }
                    val userObj = data.optJSONObject("user")
                    val fields = userObj?.optJSONObject("Fields") ?: userObj
                    mapOf("success" to true, "user" to fields)
                }
                401 -> mapOf("success" to false, "message" to "Token inválido o expirado")
                404 -> mapOf("success" to false, "message" to "Usuario no encontrado")
                else -> {
                    val err = bodyStr.safeJson()
                    mapOf(
                        "success" to false,
                        "message" to (err.optString("error")
                            .ifBlank { "Error del servidor ($code)" })
                    )
                }
            }
        } catch (e: Exception) {
            httpError(e)
        }
    }

    suspend fun checkToken(): Map<String, Any?> {
        var token = prefs.getString("jwt_token", null)
        if (token.isNullOrBlank()) {
            return mapOf("success" to false, "message" to "No hay token almacenado")
        }

        // refrescar si se acerca a expirar
        if (shouldRefreshToken()) {
            val refreshed = refreshToken()
            if (refreshed["success"] != true) {
                return mapOf("success" to false, "message" to "Error al refrescar token")
            }
            // tomar el nuevo token
            token = prefs.getString("jwt_token", null)
        }

        return try {
            val (code, bodyStr) = doGet(
                urlPath = "api/profile",
                headers = headersWithJWT(token)
            )
            val data = bodyStr.safeJson()
            if (code == 200) {
                // La respuesta trae "user": { "Fields": { ... } }
                val userObj = data.optJSONObject("user")
                val fields = userObj?.optJSONObject("Fields") ?: userObj
                mapOf(
                    "success" to true,
                    "valid" to true,
                    "user" to fields
                )
            } else {
                mapOf(
                    "success" to false,
                    "message" to data.optString("message", "Error al verificar token")
                )
            }
        } catch (e: Exception) {
            mapOf("success" to false, "message" to "Error de conexión")
        }
    }

    suspend fun refreshToken(): Map<String, Any?> {
        val currentRefresh = prefs.getString("refresh_token", null)
        if (currentRefresh.isNullOrBlank()) {
            return mapOf("success" to false, "message" to "No hay refresh token disponible")
        }
        return try {
            val (code, bodyStr) = withContext(Dispatchers.IO) {
                val reqBuilder = Request.Builder()
                    .url("${baseUrl}api/refresh")
                    .post("{}".toRequestBody(jsonMedia))

                val hdrs = headers().toMutableMap().apply {
                    this["Authorization"] = "Bearer $currentRefresh"
                }
                hdrs.forEach { (k, v) -> reqBuilder.addHeader(k, v) }

                client.newCall(reqBuilder.build()).execute().use { resp ->
                    Pair(resp.code, resp.body?.string().orEmpty())
                }
            }

            val data = bodyStr.safeJson()
            if (code == 200) {
                val newToken = data.optString("token")
                val newRefresh = data.optString("refresh_token", currentRefresh)
                val expiresIn = data.optInt("expires_in", 7_776_000)
                saveTokenData(newToken, newRefresh, expiresIn)
                mapOf("success" to true, "token" to newToken)
            } else {
                mapOf(
                    "success" to false,
                    "message" to data.optString("message", "Error al refrescar token")
                )
            }
        } catch (e: Exception) {
            httpError(e)
        }
    }

    suspend fun logout(): Map<String, Any?> {
        val token = prefs.getString("jwt_token", null)
        if (token.isNullOrBlank()) {
            clearStorage()
            return mapOf("success" to true, "message" to "Sesión local cerrada")
        }

        return try {
            // No importa la respuesta, igual limpiamos storage
            val (code, _) = doPostJson(
                urlPath = "api/logout",
                body = JSONObject(),
                headers = headersWithJWT(token)
            )
            clearStorage()
            if (code == 200) {
                mapOf("success" to true, "message" to "Sesión cerrada correctamente")
            } else {
                mapOf("success" to true, "message" to "Sesión local cerrada")
            }
        } catch (e: Exception) {
            clearStorage()
            mapOf("success" to true, "message" to "Sesión local cerrada")
        }
    }

    // === Lógica de expiración (igual a Dart) ===

    private suspend fun isTokenExpiringSoon(daysThreshold: Int = 15): Boolean =
        withContext(Dispatchers.IO) {
            val expirationUnix = prefs.getLong("token_expiration", -1L)
            if (expirationUnix <= 0L) return@withContext true
            val nowUnix = System.currentTimeMillis() / 1000L
            val remainingDays = (expirationUnix - nowUnix) / (60 * 60 * 24)
            remainingDays <= daysThreshold
        }

    suspend fun shouldRefreshToken(): Boolean {
        val token = prefs.getString("jwt_token", null)
        val refresh = prefs.getString("refresh_token", null)
        if (token.isNullOrBlank() || refresh.isNullOrBlank()) return false
        return isTokenExpiringSoon()
    }

    // === Utils JSON ===

    private fun String.safeJson(): JSONObject =
        try {
            if (this.isBlank()) JSONObject() else JSONObject(this)
        } catch (_: Exception) {
            JSONObject()
        }

    // Conversión simple JSONObject -> Map (para errores de registro)
    private fun JSONObject.toMap(): Map<String, Any?> {
        val map = mutableMapOf<String, Any?>()
        val it = this.keys()
        while (it.hasNext()) {
            val k = it.next()
            map[k] = this.opt(k)
        }
        return map
    }

    /* NUEVO METODO: Verifica si existe un token localmente, SIN hacer una llamada de red.
    * Devuelve 'true' si hay credenciales guardadas, 'false' en caso contrario.
    */
    fun isLoggedInLocally(): Boolean {
        val token = prefs.getString("jwt_token", null)
        return !token.isNullOrBlank()
    }
}
