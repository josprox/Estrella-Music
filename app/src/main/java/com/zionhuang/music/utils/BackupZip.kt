package com.zionhuang.music.utils

import android.content.Context
import com.zionhuang.music.db.InternalDatabase
import com.zionhuang.music.db.MusicDatabase
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import java.io.ByteArrayOutputStream
import java.io.FileInputStream
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream

object BackupZip {
    const val SETTINGS_FILENAME = "settings.preferences_pb"

    /** Genera el ZIP (mismo contenido que tu backup local) y lo devuelve como ByteArray */
    suspend fun buildZipBytes(context: Context, database: MusicDatabase): ByteArray =
        withContext(Dispatchers.IO) {
            val baos = ByteArrayOutputStream()
            ZipOutputStream(baos).use { zip ->
                // settings
                val settingsFile = context.filesDir.resolve("datastore").resolve(SETTINGS_FILENAME)
                zip.putNextEntry(ZipEntry(SETTINGS_FILENAME))
                settingsFile.inputStream().use { it.copyTo(zip) }
                // db checkpoint y DB
                runBlocking(Dispatchers.IO) { database.checkpoint() }
                FileInputStream(database.openHelper.writableDatabase.path).use { fis ->
                    zip.putNextEntry(ZipEntry(InternalDatabase.DB_NAME))
                    fis.copyTo(zip)
                }
            }
            baos.toByteArray()
        }
}
