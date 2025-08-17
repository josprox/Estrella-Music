package com.josprox.jossredconnect.services

import android.content.Context
import android.content.SharedPreferences
import com.josprox.jossredconnect.models.ListBackupsResponse
import com.josprox.jossredconnect.models.UploadBackupResponse
import com.josprox.jossredconnect.net.ProgressRequestBody
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONObject
import java.io.IOException
import java.util.concurrent.TimeUnit

class BackupService(
    private val context: Context,
    /**
     * Debe incluir /api/ (y puede o no venir con slash final). Ej:
     *   https://tu-dominio.com/api/
     *   Joss Red lo hace de manera sencilla y cifrada
     */
    baseUrl: String,
    private val apiToken: String,    // X-JossRed-Auth (igual que AuthService)
    private val client: OkHttpClient = OkHttpClient.Builder()
        .connectTimeout(40, TimeUnit.SECONDS)
        .readTimeout(120, TimeUnit.SECONDS) // subir/descargar puede tardar
        .build()
) {
    private val json = "application/json; charset=utf-8".toMediaType()
    private val prefs: SharedPreferences by lazy {
        context.getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
    }

    // Normaliza baseUrl para garantizar el slash final
    private val baseUrlNormalized: String = if (baseUrl.endsWith("/")) baseUrl else "$baseUrl/"

    private fun jwt(): String? = prefs.getString("jwt_token", null)

    private fun baseHeaders(builder: Request.Builder, withJwt: Boolean = true) {
        builder.addHeader("Accept", "application/json")
        builder.addHeader("X-JossRed-Auth", apiToken)
        if (withJwt) {
            val token = jwt()
            if (!token.isNullOrBlank()) builder.addHeader("Authorization", "Bearer $token")
        }
    }

    private suspend fun parseJson(body: String): JSONObject = withContext(Dispatchers.Default) {
        try { if (body.isBlank()) JSONObject() else JSONObject(body) } catch (_: Exception) { JSONObject() }
    }

    /**
     * SUBIR backup
     * - appName permitido por backend
     * - fileNameWithAllowedExtension debe respetar la extensión validada por ALLOWED_BACKUPS.
     *
     * Endpoint real (POST):  {baseUrlNormalized}backup/{appName}
     * Ej: https://tu-dominio.com/api/backup/jossmusic_backup
     */
    suspend fun uploadBackup(
        appName: String,
        fileNameWithAllowedExtension: String,
        bytes: ByteArray,
        onProgress: ((Long, Long) -> Unit)? = null
    ): Result<UploadBackupResponse> = withContext(Dispatchers.IO) {
        try {
            val uploadBody = ProgressRequestBody(
                bytes = bytes,
                contentType = "application/octet-stream".toMediaTypeOrNull(),
                onProgress = onProgress
            )

            val multipart = MultipartBody.Builder().setType(MultipartBody.FORM)
                .addFormDataPart(
                    "file",
                    fileNameWithAllowedExtension,
                    uploadBody
                )
                .build()

            val req = Request.Builder()
                .url("${baseUrlNormalized}backup/$appName")
                .post(multipart)
                .also { baseHeaders(it) }
                .build()

            client.newCall(req).execute().use { resp ->
                val bodyStr = resp.body?.string().orEmpty()
                val json = parseJson(bodyStr)
                return@withContext if (resp.isSuccessful) {
                    Result.success(
                        UploadBackupResponse(
                            message = json.optString("message"),
                            file_path = json.optString("file_path")
                        )
                    )
                } else {
                    val msg = json.optString("error", "Error al subir backup (${resp.code})")
                    Result.failure(IOException(msg))
                }
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * LISTAR backups del usuario
     *
     * Endpoint real (GET): {baseUrlNormalized}listfiles
     * Ej: https://tu-dominio.com/api/listfiles
     */
    suspend fun listBackups(): Result<ListBackupsResponse> = withContext(Dispatchers.IO) {
        try {
            val req = Request.Builder()
                // ✅ Ruta correcta (sin "storage/")
                .url("${baseUrlNormalized}listfiles")
                .get()
                .also { baseHeaders(it) }
                .build()

            client.newCall(req).execute().use { resp ->
                val bodyStr = resp.body?.string().orEmpty()
                val json = parseJson(bodyStr)
                return@use if (resp.isSuccessful) {
                    val filesJson = json.optJSONArray("files")
                    val list = mutableListOf<com.josprox.jossredconnect.models.BackupFileDto>()
                    if (filesJson != null) {
                        for (i in 0 until filesJson.length()) {
                            val o = filesJson.optJSONObject(i) ?: continue
                            list.add(
                                com.josprox.jossredconnect.models.BackupFileDto(
                                    id = if (o.has("id")) o.optLong("id") else null,
                                    app_name = o.optString("app_name"),
                                    file_name = o.optString("file_name"),
                                    file_id = o.optString("file_id"),
                                    name = o.optString("name"),
                                    created_at = o.optString("created_at", null),
                                    updated_at = o.optString("updated_at", null)
                                )
                            )
                        }
                    }
                    Result.success(ListBackupsResponse(files = list))
                } else {
                    val msg = json.optString("error", "Error al listar backups (${resp.code})")
                    Result.failure(IOException(msg))
                }
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * DESCARGAR backup específico (devuelve los bytes del .backup)
     *
     * Endpoint real (GET): {baseUrlNormalized}backup/{appName}/{filename}
     * Ej: https://tu-dominio.com/api/backup/jossmusic_backup/jossmusic_20250817_1410.backup
     */
    suspend fun downloadBackup(
        appName: String,
        fileName: String
    ): Result<ByteArray> = withContext(Dispatchers.IO) {
        try {
            val req = Request.Builder()
                // ✅ Ruta correcta (sin "storage/")
                .url("${baseUrlNormalized}backup/$appName/$fileName")
                .get()
                .also { baseHeaders(it) }
                .build()

            client.newCall(req).execute().use { resp ->
                if (!resp.isSuccessful) {
                    val bodyStr = resp.body?.string().orEmpty()
                    val msg = parseJson(bodyStr).optString("error", "Error al descargar (${resp.code})")
                    return@withContext Result.failure(IOException(msg))
                }
                val bytes = resp.body?.bytes() ?: byteArrayOf()
                Result.success(bytes)
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
}
