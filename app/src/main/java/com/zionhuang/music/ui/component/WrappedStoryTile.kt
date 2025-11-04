package com.zionhuang.music.ui.component

import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.zionhuang.music.R

/**
 * Un "tile" estilo "historia de Instagram" para destacar el Wrapped.
 * Incluye un borde de gradiente animado que gira.
 *
 * @param modifier El modificador a aplicar al componente.
 * @param onClick La acción a ejecutar cuando se hace clic.
 */
@Composable
fun WrappedStoryTile(
    modifier: Modifier = Modifier,
    onClick: () -> Unit
) {
    Column(
        modifier = modifier
            .clickable(onClick = onClick)
            .padding(vertical = 4.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        // 1. Gradiente animado que gira
        val infiniteTransition = rememberInfiniteTransition(label = "wrapped-border")
        val angle by infiniteTransition.animateFloat(
            initialValue = 0f,
            targetValue = 360f,
            animationSpec = infiniteRepeatable(
                animation = tween(2500, easing = LinearEasing),
                repeatMode = RepeatMode.Restart
            ), label = "wrapped-angle"
        )

        val gradientBrush = Brush.sweepGradient(
            colors = listOf(
                Color(0xFFB400D4), // Morado
                Color(0xFFFF005C), // Rosa
                Color(0xFFFFB800), // Naranja
                Color(0xFFB400D4)  // Morado otra vez para cerrar el ciclo
            )
        )

        // 2. Círculo exterior (el borde)
        Box(
            modifier = Modifier
                .size(56.dp) // Tamaño del círculo
                .graphicsLayer { rotationZ = angle } // Aplica la rotación
                .background(gradientBrush, CircleShape)
                .padding(3.dp), // Grosor del borde
            contentAlignment = Alignment.Center
        ) {
            // 3. Círculo interior (el ícono)
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .background(MaterialTheme.colorScheme.surface, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.celebration),
                    contentDescription = "Mi Wrapped",
                    modifier = Modifier.size(28.dp),
                    tint = MaterialTheme.colorScheme.primary
                )
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        // 4. Texto
        Text(
            text = "Mi Wrapped",
            style = MaterialTheme.typography.labelMedium,
            color = MaterialTheme.colorScheme.onSurface,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis
        )
    }
}