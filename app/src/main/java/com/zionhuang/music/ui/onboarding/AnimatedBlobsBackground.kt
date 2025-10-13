package com.zionhuang.music.ui.onboarding

import android.annotation.SuppressLint
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import kotlin.math.roundToInt

@SuppressLint("UnusedBoxWithConstraintsScope")
@Composable
fun AnimatedBlobsBackground(modifier: Modifier = Modifier) {
    val transition = rememberInfiniteTransition(label = "bg_transition")
    val a by transition.animateFloat(
        initialValue = 0f,
        targetValue = 1f,
        animationSpec = infiniteRepeatable(tween(4500, easing = FastOutSlowInEasing), RepeatMode.Reverse),
        label = "a_anim"
    )
    val b by transition.animateFloat(
        initialValue = 0f,
        targetValue = 1f,
        animationSpec = infiniteRepeatable(tween(5200, easing = FastOutSlowInEasing), RepeatMode.Reverse),
        label = "b_anim"
    )
    val c by transition.animateFloat(
        initialValue = 0f,
        targetValue = 1f,
        animationSpec = infiniteRepeatable(tween(5700, easing = FastOutSlowInEasing), RepeatMode.Reverse),
        label = "c_anim"
    )

    BoxWithConstraints(
        modifier = modifier
            .fillMaxSize()
            .background(Brush.linearGradient(listOf(Color(0xFF1A1A2E), Color(0xFF16213E))))
    ) {
        val density = LocalDensity.current
        val wPx = with(density) { maxWidth.toPx() }
        val hPx = with(density) { maxHeight.toPx() }
        val size320 = with(density) { 320.dp.toPx() }
        val size420 = with(density) { 420.dp.toPx() }
        val size260 = with(density) { 260.dp.toPx() }

        Blob(
            color = Color(0xFFE94560),
            size = 320.dp,
            xPx = ((wPx - size320) * a).roundToInt(),
            yPx = ((hPx - size320) * b).roundToInt()
        )
        Blob(
            color = Color(0xFF0F3460),
            size = 420.dp,
            xPx = ((wPx - size420) * b).roundToInt(),
            yPx = ((hPx - size420) * c).roundToInt()
        )
        Blob(
            color = Color(0xFF533483),
            size = 260.dp,
            xPx = ((wPx - size260) * c).roundToInt(),
            yPx = ((hPx - size260) * a).roundToInt()
        )
    }
}

// ✅ NUEVA IMPLEMENTACIÓN DE BLOB, MUCHO MÁS EFICIENTE
@Composable
private fun Blob(
    color: Color,
    size: Dp,
    xPx: Int,
    yPx: Int
) {
    // Usamos un Brush.radialGradient para simular el desenfoque.
    // Pasa del color sólido en el centro (con algo de transparencia) a completamente transparente en los bordes.
    // Esto es extremadamente rápido y eficiente en comparación con Modifier.blur().
    val brush = Brush.radialGradient(
        colors = listOf(color.copy(alpha = 0.5f), color.copy(alpha = 0f))
    )

    Box(
        modifier = Modifier
            .offset { IntOffset(xPx, yPx) }
            .size(size)
            .clip(CircleShape) // Opcional, pero puede ayudar al rendimiento en algunos casos
            .background(brush)
    )
}
