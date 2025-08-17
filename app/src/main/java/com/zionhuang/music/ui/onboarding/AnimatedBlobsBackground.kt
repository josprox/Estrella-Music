package com.zionhuang.music.ui.onboarding

import android.annotation.SuppressLint
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.BlurredEdgeTreatment
import androidx.compose.ui.draw.blur
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
    val transition = rememberInfiniteTransition(label = "bg")
    val a by transition.animateFloat(
        0f, 1f,
        animationSpec = infiniteRepeatable(tween(4500, easing = FastOutSlowInEasing), RepeatMode.Reverse),
        label = "a"
    )
    val b by transition.animateFloat(
        0f, 1f,
        animationSpec = infiniteRepeatable(tween(5200, easing = FastOutSlowInEasing), RepeatMode.Reverse),
        label = "b"
    )
    val c by transition.animateFloat(
        0f, 1f,
        animationSpec = infiniteRepeatable(tween(5700, easing = FastOutSlowInEasing), RepeatMode.Reverse),
        label = "c"
    )

    BoxWithConstraints(
        modifier = modifier
            .fillMaxSize()
            .background(Brush.linearGradient(listOf(Color(0xFF1A1A2E), Color(0xFF16213E))))
    ) {
        val density = LocalDensity.current
        val wPx = with(density) { maxWidth.toPx() }
        val hPx = with(density) { maxHeight.toPx() }

        Blob(
            color = Color(0xFFE94560),
            size = 320.dp,
            xPx = ((wPx - with(density) { 320.dp.toPx() }) * a).roundToInt(),
            yPx = ((hPx - with(density) { 320.dp.toPx() }) * b).roundToInt(),
            blur = 120.dp
        )
        Blob(
            color = Color(0xFF0F3460),
            size = 420.dp,
            xPx = ((wPx - with(density) { 420.dp.toPx() }) * b).roundToInt(),
            yPx = ((hPx - with(density) { 420.dp.toPx() }) * c).roundToInt(),
            blur = 120.dp
        )
        Blob(
            color = Color(0xFF533483),
            size = 260.dp,
            xPx = ((wPx - with(density) { 260.dp.toPx() }) * c).roundToInt(),
            yPx = ((hPx - with(density) { 260.dp.toPx() }) * a).roundToInt(),
            blur = 120.dp
        )
    }
}

@Composable
private fun Blob(
    color: Color,
    size: Dp,
    xPx: Int,
    yPx: Int,
    blur: Dp
) {
    androidx.compose.foundation.layout.Box(
        modifier = Modifier
            .offset { IntOffset(xPx, yPx) }
            .size(size)
            .clip(CircleShape)
            .background(color.copy(alpha = 0.9f))
            .blur(blur, edgeTreatment = BlurredEdgeTreatment.Unbounded)
    )
}
