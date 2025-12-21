package com.zionhuang.music.utils

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.os.Handler
import android.os.Looper
import android.view.WindowManager
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.unit.IntSize
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

/**
 * Generador de imágenes optimizadas para Instagram/WhatsApp Stories.
 * 
 * Genera bitmaps en formato 9:16 (1080x1920) utilizando WindowManager
 * para asegurar un renderizado completo y correcto.
 */
object WrappedImageGenerator {
    
    const val STORY_WIDTH = 1080
    const val STORY_HEIGHT = 1920
    
    /**
     * Genera un bitmap de un composable asegurando que se renderice correctamente.
     * Utiliza WindowManager para agregar una vista temporal a la ventana, lo que garantiza
     * que el sistema de UI de Android ejecute los pases de layout y draw correctamente.
     */
    suspend fun generateStoryBitmap(
        context: Context,
        backgroundColor: Color = Color.Black,
        content: @Composable () -> Unit
    ): Bitmap = suspendCoroutine { continuation ->
        // Necesitamos ejecutar esto en el hilo principal
        Handler(Looper.getMainLooper()).post {
            val resumed = java.util.concurrent.atomic.AtomicBoolean(false)
            try {
                // DEBUG TOAST
                android.widget.Toast.makeText(context, "Generando story...", android.widget.Toast.LENGTH_SHORT).show()

                // 1. Crear el ComposeView
                val composeView = ComposeView(context).apply {
                    // Configuración crítica: Asignar Owners
                    // Al agregar la vista al WindowManager, no hereda los owners de la actividad automáticamente.
                    // Necesitamos asignarlos manualmente para que Compose funcione (LifeCycle, SavedState).
                    val lifecycleOwner = context as? androidx.lifecycle.LifecycleOwner 
                        ?: throw IllegalStateException("Context must be a LifecycleOwner")
                    val savedStateRegistryOwner = context as? androidx.savedstate.SavedStateRegistryOwner 
                        ?: throw IllegalStateException("Context must be a SavedStateRegistryOwner")
                    
                    // Usamos los IDs de recursos internos de AndroidX para setTag
                    // Esto equivale a ViewTreeLifecycleOwner.set(this, owner)
                    setTag(androidx.lifecycle.runtime.R.id.view_tree_lifecycle_owner, lifecycleOwner)
                    setTag(androidx.savedstate.R.id.view_tree_saved_state_registry_owner, savedStateRegistryOwner)
                    // También ViewModelStoreOwner si es necesario, aunque para rendering puro a veces no,
                    // pero mejor prevenir.
                    if (context is androidx.lifecycle.ViewModelStoreOwner) {
                        setTag(androidx.lifecycle.viewmodel.R.id.view_tree_view_model_store_owner, context)
                    }

                    // CRÍTICO: Forzar renderizado por software para evitar crash con Bitmaps de hardware
                    // "Software rendering doesn't support hardware bitmaps"
                    setLayerType(android.view.View.LAYER_TYPE_SOFTWARE, null)

                    setContent {
                        // Configurar Coil para NO usar hardware bitmaps en esta vista capturada
                        val imageLoader = coil.ImageLoader.Builder(context)
                            .allowHardware(false)
                            .build()
                        
                        androidx.compose.runtime.CompositionLocalProvider(
                            coil.compose.LocalImageLoader provides imageLoader,
                            // Estandarizar densidad: 1080px / 2.25 = 480dp width / 853dp height
                            // Densidad 3.0 (360x640) era muy pequeña y causaba overflow vertical en listas.
                            // 2.25 ofrece un lienzo "grande" donde todo cabe seguro.
                            androidx.compose.ui.platform.LocalDensity provides androidx.compose.ui.unit.Density(2.25f, 1f)
                        ) {
                            // Envolver en el tema de la aplicación para tener colores y tipografía correctos
                            com.zionhuang.music.ui.theme.InnerTuneTheme {
                                // Forzar tamaño explícito en el contenido para asegurar que Compose mida correctamente
                                // incluso si el WindowManager tiene flags exóticos.
                                androidx.compose.foundation.layout.Box(
                                    modifier = androidx.compose.ui.Modifier.size(
                                        with(androidx.compose.ui.platform.LocalDensity.current) { 1080.toDp() },
                                        with(androidx.compose.ui.platform.LocalDensity.current) { 1920.toDp() }
                                    )
                                ) {
                                    content()
                                }
                            }
                        }
                    }
                }

                // 2. Configurar LayoutParams para agregar al WindowManager
                // Flags clave:
                // - FLAG_NOT_TOUCHABLE: No recibe toques
                // - FLAG_LAYOUT_NO_LIMITS: Permite tamaños mayores a la pantalla
                // - format: Transparente para evitar fondos negros por defecto
                // NEW APPROACH: Attach to DecorView (Activity Root)
                val activity = context.findActivity()
                if (activity == null) {
                    android.util.Log.e("WrappedImgGen", "FATAL: No Activity found! Cannot attach view.")
                    continuation.resumeWithException(IllegalStateException("No Activity context found"))
                    return@post
                }
                
                val decorView = activity.window.decorView as android.view.ViewGroup
                
                // Use FrameLayout.LayoutParams if possible, or generic MarginLayoutParams
                val params = android.widget.FrameLayout.LayoutParams(
                    STORY_WIDTH,
                    STORY_HEIGHT
                )
                // Position off-screen/invisible but ensuring it's part of layout
                composeView.alpha = 0.01f 
                
                android.util.Log.e("WrappedImgGen", "Attempting to attach view to DecorView: ${activity.localClassName}")

                // SAFETY TIMEOUT: If onPreDraw never fires (e.g. Activity paused/destroyed), fail after 3s
                val timeoutHandler = Handler(Looper.getMainLooper())
                val timeoutRunnable = Runnable {
                    android.util.Log.e("WrappedImgGen", "TIMEOUT: Generation took too long (3s). Force resuming.")
                    try {
                         decorView.removeView(composeView)
                    } catch(e: Exception) { e.printStackTrace() }
                    if (resumed.compareAndSet(false, true)) {
                         continuation.resumeWithException(java.util.concurrent.TimeoutException("Bitmap generation timed out"))
                    }
                }
                timeoutHandler.postDelayed(timeoutRunnable, 3000)

                val onDrawListener = object : android.view.ViewTreeObserver.OnPreDrawListener {
                    var captured = false
                    override fun onPreDraw(): Boolean {
                        if (captured) return true
                        captured = true
                        android.util.Log.e("WrappedImgGen", "onPreDraw fired! View is measured and ready.")

                        // Increase delay to 1000ms to allow complex lists (Coil) to load
                        composeView.postDelayed({
                            try {
                                timeoutHandler.removeCallbacks(timeoutRunnable) // Cancel timeout
                                
                                android.util.Log.e("WrappedImgGen", "Starting Bitmap.createBitmap...")
                                val bitmap = Bitmap.createBitmap(
                                    STORY_WIDTH, 
                                    STORY_HEIGHT, 
                                    Bitmap.Config.ARGB_8888
                                )
                                val canvas = Canvas(bitmap)
                                canvas.drawColor(backgroundColor.toArgb())
                                composeView.draw(canvas)
                                android.util.Log.e("WrappedImgGen", "Bitmap drawn successfully!")

                                try {
                                    composeView.viewTreeObserver.removeOnPreDrawListener(this)
                                    decorView.removeView(composeView)
                                    android.util.Log.e("WrappedImgGen", "View removed from DecorView")
                                } catch (e: Exception) {
                                    e.printStackTrace()
                                }
                                if (resumed.compareAndSet(false, true)) {
                                    continuation.resume(bitmap)
                                }
                            } catch (e: Exception) {
                                android.util.Log.e("WrappedImgGen", "CRITICAL ERROR in postDelayed drawing", e)
                                try { decorView.removeView(composeView) } catch(_:Exception){}
                                if (resumed.compareAndSet(false, true)) {
                                    continuation.resumeWithException(e)
                                }
                            }
                        }, 1000)

                        return false 
                    }
                }

                composeView.viewTreeObserver.addOnPreDrawListener(onDrawListener)
                decorView.addView(composeView, params)
                android.util.Log.e("WrappedImgGen", "addView(composeView) executed on DecorView.")

            } catch (e: Exception) {
                android.util.Log.e("WrappedImgGen", "Error initiating generation", e)
                if (resumed.compareAndSet(false, true)) {
                    continuation.resumeWithException(e)
                }
            }
        }
    }

    /**
     * Captura un composable como bitmap con tamaño personalizado.
     */
    suspend fun captureComposableAsBitmap(
        context: Context,
        size: IntSize = IntSize(STORY_WIDTH, STORY_HEIGHT),
        backgroundColor: Color = Color.Black,
        content: @Composable () -> Unit
    ): Bitmap = suspendCoroutine { continuation ->
        Handler(Looper.getMainLooper()).post {
            val resumed = java.util.concurrent.atomic.AtomicBoolean(false)
            try {
                val composeView = ComposeView(context).apply {
                    val lifecycleOwner = context as? androidx.lifecycle.LifecycleOwner 
                        ?: throw IllegalStateException("Context must be a LifecycleOwner")
                    val savedStateRegistryOwner = context as? androidx.savedstate.SavedStateRegistryOwner 
                        ?: throw IllegalStateException("Context must be a SavedStateRegistryOwner")
                    
                    setTag(androidx.lifecycle.runtime.R.id.view_tree_lifecycle_owner, lifecycleOwner)
                    setTag(androidx.savedstate.R.id.view_tree_saved_state_registry_owner, savedStateRegistryOwner)
                    if (context is androidx.lifecycle.ViewModelStoreOwner) {
                        setTag(androidx.lifecycle.viewmodel.R.id.view_tree_view_model_store_owner, context)
                    }

                    setLayerType(android.view.View.LAYER_TYPE_SOFTWARE, null)

                    setContent {
                        val imageLoader = coil.ImageLoader.Builder(context)
                            .allowHardware(false)
                            .build()
                        
                        androidx.compose.runtime.CompositionLocalProvider(
                            coil.compose.LocalImageLoader provides imageLoader,
                            androidx.compose.ui.platform.LocalDensity provides androidx.compose.ui.unit.Density(2.25f, 1f)
                        ) {
                            com.zionhuang.music.ui.theme.InnerTuneTheme {
                                androidx.compose.foundation.layout.Box(
                                    modifier = androidx.compose.ui.Modifier.size(
                                        with(androidx.compose.ui.platform.LocalDensity.current) { size.width.toDp() },
                                        with(androidx.compose.ui.platform.LocalDensity.current) { size.height.toDp() }
                                    )
                                ) {
                                    content()
                                }
                            }
                        }
                    }
                }

                val activity = context.findActivity()
                if (activity == null) {
                    android.util.Log.e("WrappedImgGen", "FATAL capture: No Activity found!")
                    continuation.resumeWithException(IllegalStateException("No Activity context found"))
                    return@post
                }
                
                val decorView = activity.window.decorView as android.view.ViewGroup
                
                val params = android.widget.FrameLayout.LayoutParams(
                    size.width,
                    size.height
                )
                
                // Invisible but rendering
                composeView.alpha = 0.01f 
                
                android.util.Log.e("WrappedImgGen", "captureComposableAsBitmap - Adding view to DecorView")

                // SAFETY TIMEOUT protection
                val timeoutHandler = Handler(Looper.getMainLooper())
                val timeoutRunnable = Runnable {
                    android.util.Log.e("WrappedImgGen", "TIMEOUT capture: Generation took too long (3s). Force resuming.")
                    try {
                         decorView.removeView(composeView)
                    } catch(e: Exception) { e.printStackTrace() }
                    
                    if (resumed.compareAndSet(false, true)) {
                         continuation.resumeWithException(java.util.concurrent.TimeoutException("Capture generation timed out"))
                    }
                }
                timeoutHandler.postDelayed(timeoutRunnable, 3000)

                val onDrawListener = object : android.view.ViewTreeObserver.OnPreDrawListener {
                    var captured = false
                    override fun onPreDraw(): Boolean {
                        if (captured) return true
                        captured = true
                        android.util.Log.e("WrappedImgGen", "captureComposableAsBitmap - onPreDraw fired")

                        composeView.postDelayed({
                            try {
                                timeoutHandler.removeCallbacks(timeoutRunnable)
                                
                                android.util.Log.e("WrappedImgGen", "Drawing bitmap (capture)...")
                                val bitmap = Bitmap.createBitmap(
                                    size.width, 
                                    size.height, 
                                    Bitmap.Config.ARGB_8888
                                )
                                val canvas = Canvas(bitmap)
                                canvas.drawColor(backgroundColor.toArgb())
                                composeView.draw(canvas)
                                android.util.Log.e("WrappedImgGen", "Bitmap capture success")

                                try {
                                    composeView.viewTreeObserver.removeOnPreDrawListener(this)
                                    decorView.removeView(composeView)
                                    android.util.Log.e("WrappedImgGen", "View removed (capture)")
                                } catch (e: Exception) {
                                    e.printStackTrace()
                                }

                                if (resumed.compareAndSet(false, true)) {
                                    continuation.resume(bitmap)
                                }
                            } catch (e: Exception) {
                                android.util.Log.e("WrappedImgGen", "Error in postDelayed (capture)", e)
                                try { decorView.removeView(composeView) } catch(_:Exception){}
                                if (resumed.compareAndSet(false, true)) {
                                    continuation.resumeWithException(e)
                                }
                            }
                        }, 1000)

                        return false
                    }
                }

                composeView.viewTreeObserver.addOnPreDrawListener(onDrawListener)
                decorView.addView(composeView, params)

            } catch (e: Exception) {
                android.util.Log.e("WrappedImgGen", "Error initiating (captureComposable)", e)
                if (resumed.compareAndSet(false, true)) {
                    continuation.resumeWithException(e)
                }
            }
        }
    }

    fun isValidStoryFormat(bitmap: Bitmap): Boolean {
        val aspectRatio = bitmap.height.toFloat() / bitmap.width.toFloat()
        val targetRatio = STORY_HEIGHT.toFloat() / STORY_WIDTH.toFloat()
        return kotlin.math.abs(aspectRatio - targetRatio) < 0.01f
    }
    
    private fun Context.findActivity(): android.app.Activity? {
        var context = this
        while (context is android.content.ContextWrapper) {
            if (context is android.app.Activity) return context
            context = context.baseContext
        }
        return null
    }
}
