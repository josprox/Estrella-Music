package com.zionhuang.music.viewmodels

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.Toast
import androidx.lifecycle.ViewModel
import com.josprox.jossredconnect.services.BackupService
import com.zionhuang.music.MainActivity
import com.zionhuang.music.R
import com.zionhuang.music.db.InternalDatabase
import com.zionhuang.music.db.MusicDatabase
import com.zionhuang.music.extensions.div
import com.zionhuang.music.extensions.tryOrNull
import com.zionhuang.music.extensions.zipInputStream
import com.zionhuang.music.extensions.zipOutputStream
import com.zionhuang.music.playback.MusicService
import com.zionhuang.music.playback.MusicService.Companion.PERSISTENT_QUEUE_FILE
import com.zionhuang.music.utils.BackupZip
import com.zionhuang.music.utils.reportException
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import java.io.FileInputStream
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.zip.ZipEntry
import javax.inject.Inject
import kotlin.system.exitProcess
import java.util.zip.ZipInputStream

@HiltViewModel
class BackupRestoreViewModel @Inject constructor(
    val database: MusicDatabase,
) : ViewModel() {

    fun backup(context: Context, uri: Uri) {
        runCatching {
            context.applicationContext.contentResolver.openOutputStream(uri)?.use {
                it.buffered().zipOutputStream().use { outputStream ->
                    (context.filesDir / "datastore" / SETTINGS_FILENAME).inputStream().buffered().use { inputStream ->
                        outputStream.putNextEntry(ZipEntry(SETTINGS_FILENAME))
                        inputStream.copyTo(outputStream)
                    }
                    runBlocking(Dispatchers.IO) { database.checkpoint() }
                    FileInputStream(database.openHelper.writableDatabase.path).use { inputStream ->
                        outputStream.putNextEntry(ZipEntry(InternalDatabase.DB_NAME))
                        inputStream.copyTo(outputStream)
                    }
                }
            }
        }.onSuccess {
            Toast.makeText(context, R.string.backup_create_success, Toast.LENGTH_SHORT).show()
        }.onFailure {
            reportException(it)
            Toast.makeText(context, R.string.backup_create_failed, Toast.LENGTH_SHORT).show()
        }
    }

    fun restore(context: Context, uri: Uri) {
        runCatching {
            context.applicationContext.contentResolver.openInputStream(uri)?.use {
                it.zipInputStream().use { inputStream ->
                    var entry = tryOrNull { inputStream.nextEntry } // prevent ZipException
                    while (entry != null) {
                        when (entry.name) {
                            SETTINGS_FILENAME -> {
                                (context.filesDir / "datastore" / SETTINGS_FILENAME).outputStream().use { outputStream ->
                                    inputStream.copyTo(outputStream)
                                }
                            }
                            InternalDatabase.DB_NAME -> {
                                runBlocking(Dispatchers.IO) { database.checkpoint() }
                                database.close()
                                FileOutputStream(database.openHelper.writableDatabase.path).use { outputStream ->
                                    inputStream.copyTo(outputStream)
                                }
                            }
                        }
                        entry = tryOrNull { inputStream.nextEntry } // prevent ZipException
                    }
                }
            }
            restartAppAfterRestore(context)
        }.onFailure {
            reportException(it)
            Toast.makeText(context, R.string.restore_failed, Toast.LENGTH_SHORT).show()
        }
    }

    // ===== NUEVO: Backup online OCI =====
    suspend fun backupOnline(
        context: Context,
        backupService: BackupService,
        onProgress: ((uploaded: Long, total: Long) -> Unit)? = null
    ) {
        try {
            // 1) construir zip en memoria
            val zipBytes = BackupZip.buildZipBytes(context, database)

            // 2) nombre requerido (extensión .backup)
            val stamp = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
            val fileName = "jossmusic_$stamp.backup"

            // 3) subir
            val res = backupService.uploadBackup(
                appName = "jossmusic_backup",
                fileNameWithAllowedExtension = fileName,
                bytes = zipBytes,
                onProgress = onProgress
            )

            if (res.isSuccess) {
                Toast.makeText(context, R.string.backup_create_success, Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(
                    context,
                    res.exceptionOrNull()?.message ?: context.getString(R.string.backup_create_failed),
                    Toast.LENGTH_LONG
                ).show()
            }
        } catch (e: Exception) {
            Toast.makeText(context, R.string.backup_create_failed, Toast.LENGTH_SHORT).show()
        }
    }

    // ===== NUEVO: Restaurar desde OCI =====
    suspend fun restoreOnline(
        context: Context,
        backupService: BackupService,
        remoteFileName: String // ej. "jossmusic_20250817_141000.backup"
    ) {
        try {
            // 1) descargar bytes
            val res = backupService.downloadBackup("jossmusic_backup", remoteFileName)
            if (res.isFailure) {
                Toast.makeText(
                    context,
                    res.exceptionOrNull()?.message ?: context.getString(R.string.restore_failed),
                    Toast.LENGTH_LONG
                ).show()
                return
            }
            val bytes = res.getOrNull() ?: byteArrayOf()

            // 2) aplicar ZIP al igual que tu restore local
            applyZipToApp(context, bytes)

            Toast.makeText(context, R.string.restore_success, Toast.LENGTH_SHORT).show()
            restartAppAfterRestore(context)
        } catch (e: Exception) {
            Toast.makeText(context, R.string.restore_failed, Toast.LENGTH_SHORT).show()
        }
    }

    private suspend fun applyZipToApp(context: Context, zipBytes: ByteArray) {
        withContext(Dispatchers.IO) {
            ZipInputStream(zipBytes.inputStream()).use { zis ->
                var entry = zis.nextEntry
                while (entry != null) {
                    when (entry.name) {
                        BackupZip.SETTINGS_FILENAME -> {
                            (context.filesDir / "datastore" / BackupZip.SETTINGS_FILENAME)
                                .outputStream().use { zis.copyTo(it) }
                        }
                        InternalDatabase.DB_NAME -> {
                            runBlocking(Dispatchers.IO) { database.checkpoint() }
                            database.close()
                            FileOutputStream(database.openHelper.writableDatabase.path).use { zis.copyTo(it) }
                        }
                    }
                    entry = zis.nextEntry
                }
            }
        }
    }

    private fun restartAppAfterRestore(context: Context) {
        context.stopService(Intent(context, MusicService::class.java))
        context.filesDir.resolve(PERSISTENT_QUEUE_FILE).delete()
        context.startActivity(Intent(context, MainActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK)
        })
        exitProcess(0)
    }

    companion object {
        const val SETTINGS_FILENAME = "settings.preferences_pb"
    }
}
