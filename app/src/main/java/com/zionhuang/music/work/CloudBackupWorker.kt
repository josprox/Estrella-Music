package com.zionhuang.music.work

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import androidx.datastore.preferences.core.edit
import androidx.hilt.work.HiltWorker
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.josprox.jossredconnect.services.BackupService
import com.zionhuang.music.BuildConfig
import com.zionhuang.music.constants.AlwaysCloudBackupKey
import com.zionhuang.music.db.InternalDatabase
import com.zionhuang.music.utils.dataStore
import com.zionhuang.music.utils.get
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

import java.io.ByteArrayOutputStream
import java.io.FileInputStream
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream

class CloudBackupWorker(
    appContext: Context,
    params: WorkerParameters
) : CoroutineWorker(appContext, params) {

    override suspend fun doWork(): Result = withContext(Dispatchers.IO) {
        try {
            // 1) ¿pref activada?
            val prefEnabled = applicationContext.dataStore.get(AlwaysCloudBackupKey, true)
            if (!prefEnabled) return@withContext Result.success()

            // 2) ¿sesión válida?
            if (!applicationContext.isTokenValidNow()) return@withContext Result.success()

            // 3) SecureKeys
            val baseUrl = com.zionhuang.music.utils.SecureKeys.jossRedBaseUrl
            val apiToken = com.zionhuang.music.utils.SecureKeys.jossRedApiToken

            if (baseUrl.isBlank() || apiToken.isBlank()) return@withContext Result.retry()

            // 4) armar zip
            val zipBytes = buildZipBytes(applicationContext)

            // 5) subir
            val stamp = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
            val fileNameOut = "jossmusic_$stamp.backup"

            val backupService = BackupService(
                context = applicationContext,
                baseUrl = if (baseUrl.endsWith("/")) baseUrl else "$baseUrl/",
                apiToken = apiToken
            )
            val res = backupService.uploadBackup(
                appName = "jossmusic_backup",
                fileNameWithAllowedExtension = fileNameOut,
                bytes = zipBytes,
                onProgress = null
            )

            if (res.isSuccess) Result.success() else Result.retry()
        } catch (_: Exception) {
            Result.retry()
        }
    }

    private fun buildZipBytes(context: Context): ByteArray {
        val baos = ByteArrayOutputStream()
        ZipOutputStream(baos).use { zos ->
            // settings.preferences_pb
            val settingsFile = context.filesDir.resolve("datastore").resolve("settings.preferences_pb")
            if (settingsFile.exists()) {
                FileInputStream(settingsFile).use { input ->
                    zos.putNextEntry(ZipEntry("settings.preferences_pb"))
                    input.copyTo(zos)
                    zos.closeEntry()
                }
            }
            // checkpoint de la DB para consolidar WAL (si aplica)
            val dbFile = context.getDatabasePath(InternalDatabase.DB_NAME)
            try {
                SQLiteDatabase.openDatabase(dbFile.path, null, SQLiteDatabase.OPEN_READWRITE).use { db ->
                    db.rawQuery("PRAGMA wal_checkpoint(FULL);", null)?.close()
                }
            } catch (_: Exception) { /* ignore */ }

            if (dbFile.exists()) {
                FileInputStream(dbFile).use { input ->
                    zos.putNextEntry(ZipEntry(InternalDatabase.DB_NAME))
                    input.copyTo(zos)
                    zos.closeEntry()
                }
            }
        }
        return baos.toByteArray()
    }
}

/* helpers */
private fun Context.isTokenValidNow(): Boolean {
    val prefs = getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
    val token = prefs.getString("jwt_token", null)
    val exp = prefs.getLong("token_expiration", -1L) // segundos UNIX
    val now = System.currentTimeMillis() / 1000L
    return !token.isNullOrBlank() && exp > now
}
