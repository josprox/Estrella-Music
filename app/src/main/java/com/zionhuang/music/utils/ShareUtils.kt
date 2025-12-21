package com.zionhuang.music.utils // O el paquete donde lo tengas

import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.net.Uri
import android.view.View
import androidx.compose.ui.graphics.toArgb
import androidx.core.content.FileProvider
import java.io.File
import java.io.FileOutputStream
import kotlin.text.format

/**
 * Captura la vista actual (View) y la convierte en un Bitmap.
 * ¡CON EL ARREGLO PARA 'Hardware Bitmaps'!
 */
fun captureViewAsBitmap(view: View): Bitmap {
    val bitmap = Bitmap.createBitmap(view.width, view.height, Bitmap.Config.ARGB_8888)
    val canvas = Canvas(bitmap)

    // --- ¡LA SOLUCIÓN AL CRASHEO! ---
    // 1. Guardamos el estado original
    val originalLayerType = view.layerType

    // 2. Forzamos la vista a "modo de renderizado por software" temporalmente
    view.setLayerType(View.LAYER_TYPE_SOFTWARE, null)

    // 3. Dibujamos el fondo
    val bgDrawable = view.background
    if (bgDrawable != null) {
        bgDrawable.draw(canvas)
    } else {
        canvas.drawColor(Color.WHITE) // Fondo blanco por defecto
    }

    // 4. Dibujamos el contenido de la vista en el lienzo
    view.draw(canvas)

    // 5. Restauramos el estado original
    view.setLayerType(originalLayerType, null)
    // --- FIN DE LA SOLUCIÓN ---

    return bitmap
}

/**
 * Guarda el Bitmap en el directorio caché y devuelve su Content URI.
 * 
 * @param context Contexto de la aplicación
 * @param bitmap Bitmap a guardar
 * @param quality Calidad de compresión JPEG (0-100), por defecto 90
 * @return URI del archivo guardado, o null si hay error
 */
fun saveBitmapToCache(context: Context, bitmap: Bitmap, quality: Int = 90): Uri? {
    return try {
        // Esta ruta "images" coincide con tu provider_paths.xml (<cache-path name="cached_images" path="images/" />)
        val cachePath = File(context.cacheDir, "images")
        cachePath.mkdirs() // Asegura que el directorio exista

        // Cambiar a JPEG para archivos más pequeños
        val file = File(cachePath, "wrapped_share.jpg")
        val fileOutputStream = FileOutputStream(file)
        bitmap.compress(Bitmap.CompressFormat.JPEG, quality, fileOutputStream)
        fileOutputStream.close()

        // Cambiamos ".provider" a ".FileProvider" para que coincida con tu AndroidManifest.xml
        val authority = "${context.packageName}.FileProvider"

        FileProvider.getUriForFile(context, authority, file)
    } catch (e: Exception)
    {
        e.printStackTrace()
        null
    }
}

/**
 * Lanza un Intent genérico de ACTION_SEND para compartir la imagen.
 */
fun shareBitmapGenerically(context: Context, imageUri: Uri) {
    val intent = Intent(Intent.ACTION_SEND).apply {
        type = "image/jpeg"
        putExtra(Intent.EXTRA_STREAM, imageUri)
        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
    }

    context.startActivity(Intent.createChooser(intent, "Compartir Wrapped"))
}

/**
 * Comparte una imagen directamente a Instagram Stories.
 * 
 * @param context Contexto de la aplicación
 * @param imageUri URI de la imagen a compartir
 * @param backgroundColor Color de fondo opcional para el sticker
 * @return true si se pudo abrir Instagram, false si no está instalado
 */
fun shareToInstagramStory(context: Context, imageUri: Uri, backgroundColor: androidx.compose.ui.graphics.Color? = null): Boolean {
    if (!isInstagramInstalled(context)) {
        return false
    }
    
    val intent = Intent("com.instagram.share.ADD_TO_STORY").apply {
        setDataAndType(imageUri, "image/jpeg")
        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        
        // Agregar color de fondo si se proporciona
        backgroundColor?.let { color ->
            val colorString = String.format("#%06X", 0xFFFFFF and color.toArgb())
            putExtra("top_background_color", colorString)
            putExtra("bottom_background_color", colorString)
        }
        
        setPackage("com.instagram.android")
    }
    
    try {
        context.startActivity(intent)
        return true
    } catch (e: Exception) {
        e.printStackTrace()
        return false
    }
}

/**
 * Comparte una imagen directamente a WhatsApp Status (Estados).
 * 
 * @param context Contexto de la aplicación
 * @param imageUri URI de la imagen a compartir
 * @return true si se pudo abrir WhatsApp, false si no está instalado
 */
fun shareToWhatsAppStatus(context: Context, imageUri: Uri): Boolean {
    if (!isWhatsAppInstalled(context)) {
        return false
    }
    
    val intent = Intent(Intent.ACTION_SEND).apply {
        type = "image/jpeg"
        putExtra(Intent.EXTRA_STREAM, imageUri)
        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        setPackage("com.whatsapp")
    }
    
    try {
        context.startActivity(intent)
        return true
    } catch (e: Exception) {
        e.printStackTrace()
        return false
    }
}

/**
 * Verifica si Instagram está instalado en el dispositivo.
 * 
 * @param context Contexto de la aplicación
 * @return true si Instagram está instalado
 */
fun isInstagramInstalled(context: Context): Boolean {
    return try {
        context.packageManager.getPackageInfo("com.instagram.android", 0)
        true
    } catch (e: Exception) {
        false
    }
}

/**
 * Verifica si WhatsApp está instalado en el dispositivo.
 * 
 * @param context Contexto de la aplicación
 * @return true si WhatsApp está instalado
 */
fun isWhatsAppInstalled(context: Context): Boolean {
    return try {
        context.packageManager.getPackageInfo("com.whatsapp", 0)
        true
    } catch (e: Exception) {
        false
    }
}