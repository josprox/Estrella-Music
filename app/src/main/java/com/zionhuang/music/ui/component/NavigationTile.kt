package com.zionhuang.music.ui.component

import androidx.annotation.DrawableRes
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape // Usaremos RoundedCornerShape para más flexibilidad
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.contentColorFor
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp

@Composable
fun NavigationTile(
    title: String,
    @DrawableRes icon: Int,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    // Nuevo parámetro para controlar si el tile está seleccionado o no
    isSelected: Boolean = false,
) {
    val interactionSource = remember { MutableInteractionSource() }

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(4.dp), // Un poco más de espacio entre icono y texto
        modifier = modifier
            .padding(vertical = 8.dp) // Más espacio vertical para el tile completo
            .clickable(
                interactionSource = interactionSource,
                indication = null, // Dejamos el ripple por defecto o lo personalizamos
                onClick = onClick
            )
            .padding(horizontal = 4.dp) // Un pequeño padding horizontal para el clic
    ) {
        val containerColor = if (isSelected) {
            MaterialTheme.colorScheme.primaryContainer // Color para seleccionado
        } else {
            MaterialTheme.colorScheme.surfaceContainerHighest // Un contenedor un poco más elevado o sutil
        }
        val contentColor = if (isSelected) {
            MaterialTheme.colorScheme.onPrimaryContainer // Color del contenido para seleccionado
        } else {
            MaterialTheme.colorScheme.onSurfaceVariant // Color por defecto del contenido
        }

        Box(
            contentAlignment = Alignment.Center,
            modifier = Modifier
                .size(60.dp) // Un poco más grande para más "aire"
                .clip(RoundedCornerShape(16.dp)) // Una forma de "rectángulo redondeado" o "squircle"
                .background(containerColor)
        ) {
            Icon(
                painter = painterResource(icon),
                contentDescription = null,
                tint = contentColor // Aplicar el color de contenido basado en la selección
            )
        }

        Text(
            text = title,
            style = MaterialTheme.typography.labelMedium,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            color = MaterialTheme.colorScheme.onSurface // Color de texto más estándar de Material 3
        )
    }
}