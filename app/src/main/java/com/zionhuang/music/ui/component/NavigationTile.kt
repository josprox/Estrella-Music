package com.zionhuang.music.ui.component

import androidx.annotation.DrawableRes
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.spring
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp

@Composable
fun NavigationTile(
    title: String,
    @DrawableRes icon: Int,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    isSelected: Boolean = false,
) {
    val interactionSource = remember { MutableInteractionSource() }

    // --- ANIMACIONES EXPRESIVAS ---

    // 1. Animar el color del contenedor
    val containerColor by animateColorAsState(
        targetValue = if (isSelected) {
            MaterialTheme.colorScheme.primaryContainer
        } else {
            MaterialTheme.colorScheme.surfaceContainerHighest
        },
        animationSpec = tween(300),
        label = "containerColor"
    )

    // 2. Animar el color del ícono
    val contentColor by animateColorAsState(
        targetValue = if (isSelected) {
            MaterialTheme.colorScheme.onPrimaryContainer
        } else {
            MaterialTheme.colorScheme.onSurfaceVariant
        },
        animationSpec = tween(300),
        label = "contentColor"
    )

    // 3. Animar la escala del ícono con "rebote" (spring)
    val iconScale by animateFloatAsState(
        targetValue = if (isSelected) 1.1f else 1.0f,
        animationSpec = spring(
            dampingRatio = 0.5f,
            stiffness = 200f
        ),
        label = "iconScale"
    )

    // 4. Animar la forma del contenedor
    val cornerSize by animateDpAsState(
        targetValue = if (isSelected) 24.dp else 16.dp,
        animationSpec = spring(),
        label = "cornerSize"
    )

    // 5. Animar la aparición del indicador (el punto)
    val indicatorHeight by animateDpAsState(
        targetValue = if (isSelected) 4.dp else 0.dp,
        animationSpec = tween(300),
        label = "indicatorHeight"
    )

    // 6. Animar el grosor del texto
    val textWeight = if (isSelected) FontWeight.Bold else FontWeight.Normal

    // --- LAYOUT ---

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center, // Centramos la columna
        modifier = modifier
            .clip(RoundedCornerShape(20.dp)) // Redondear toda el área clicable
            .clickable(
                interactionSource = interactionSource,
                indication = null, // Quitamos el ripple para un look más limpio
                onClick = onClick
            )
            .padding(vertical = 8.dp, horizontal = 4.dp)
    ) {
        // Contenedor del ícono
        Box(
            contentAlignment = Alignment.Center,
            modifier = Modifier
                .size(60.dp)
                // Aplicamos la escala animada
                .graphicsLayer {
                    scaleX = iconScale
                    scaleY = iconScale
                }
                .clip(RoundedCornerShape(cornerSize)) // Forma animada
                .background(containerColor) // Color animado
        ) {
            Icon(
                painter = painterResource(icon),
                contentDescription = null,
                tint = contentColor // Color de ícono animado
            )
        }

        // Espaciador para el indicador
        Spacer(modifier = Modifier.height(4.dp))

        // Indicador (punto)
        Box(
            modifier = Modifier
                .size(width = 4.dp, height = indicatorHeight) // Altura animada
                .background(
                    color = MaterialTheme.colorScheme.primary,
                    shape = CircleShape
                )
        )

        // Espaciador para el texto (si el indicador es visible)
        if (indicatorHeight > 0.dp) {
            Spacer(modifier = Modifier.height(4.dp))
        }

        // Texto
        Text(
            text = title,
            style = MaterialTheme.typography.labelMedium,
            fontWeight = textWeight, // Grosor animado
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            color = MaterialTheme.colorScheme.onSurface
        )
    }
}