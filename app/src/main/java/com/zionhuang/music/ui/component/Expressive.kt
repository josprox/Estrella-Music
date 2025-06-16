package com.zionhuang.music.ui.component

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DeleteSweep
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedCard
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.zionhuang.music.R

// Ayudante para las cabeceras de cada sección
@Composable
fun SettingsHeader(title: String, modifier: Modifier = Modifier) {
    Text(
        text = title,
        style = MaterialTheme.typography.labelLarge,
        color = MaterialTheme.colorScheme.primary,
        modifier = modifier
            .padding(horizontal = 16.dp, vertical = 8.dp)
            .padding(top = 16.dp) // Espacio extra arriba de cada sección
    )
}

/**
 * Diálogo genérico para seleccionar una opción de un enum.
 */
@Composable
fun <T> EnumSelectionDialog(
    title: String,
    options: List<T>,
    selectedOption: T,
    onOptionSelected: (T) -> Unit,
    optionText: @Composable (T) -> String,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(text = title) },
        text = {
            LazyColumn {
                items(options.size) { index ->
                    val option = options[index]
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(56.dp)
                            .selectable(
                                selected = (option == selectedOption),
                                onClick = {
                                    onOptionSelected(option)
                                    onDismiss()
                                },
                                role = Role.RadioButton
                            )
                            .padding(horizontal = 16.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = (option == selectedOption),
                            onClick = null // El onClick de la Row ya maneja la selección
                        )
                        Text(
                            text = optionText(option),
                            style = MaterialTheme.typography.bodyLarge,
                            modifier = Modifier.padding(start = 16.dp)
                        )
                    }
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text(stringResource(android.R.string.cancel))
            }
        }
    )
}

@Composable
fun ExpressivePreferenceEntry(
    title: @Composable () -> Unit,
    modifier: Modifier = Modifier,
    description: (@Composable () -> Unit)? = null,
    icon: @Composable () -> Unit,
    onClick: () -> Unit,
    trailingContent: (@Composable () -> Unit)? = null
) {
    ListItem(
        headlineContent = { title() },
        supportingContent = description,
        leadingContent = {
            Box(
                modifier = Modifier
                    .size(40.dp)
                    .clip(CircleShape)
                    .background(MaterialTheme.colorScheme.surfaceContainerHighest),
                contentAlignment = Alignment.Center
            ) {
                icon()
            }
        },
        trailingContent = trailingContent,
        modifier = modifier
            .fillMaxWidth()
            .clickable(onClick = onClick)
    )
}

@Composable
fun <T> InlineSelectPreference(
    title: @Composable () -> Unit,
    icon: @Composable () -> Unit,
    selectedValue: T,
    options: List<Pair<T, @Composable (isSelected: Boolean) -> Unit>>,
    onValueSelected: (T) -> Unit
) {
    Column(
        modifier = Modifier.padding(bottom = 8.dp)
    ) {
        ListItem(
            headlineContent = title,
            leadingContent = {
                Box(
                    modifier = Modifier
                        .size(40.dp)
                        .clip(CircleShape)
                        .background(MaterialTheme.colorScheme.surfaceContainerHighest),
                    contentAlignment = Alignment.Center
                ) {
                    icon()
                }
            }
        )
        Row(
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            modifier = Modifier.padding(top = 8.dp, start = 16.dp, end = 16.dp)
        ) {
            options.forEach { (optionValue, content) ->
                Box(
                    modifier = Modifier
                        .weight(1f)
                        .clickable { onValueSelected(optionValue) }
                ) {
                    content(selectedValue == optionValue)
                }
            }
        }
    }
}

@Composable
fun SliderPreview(
    label: String,
    isSelected: Boolean,
    content: @Composable (Modifier) -> Unit
) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        // Centramos el contenido verticalmente
        verticalArrangement = Arrangement.Center,
        modifier = Modifier
            // Aseguramos una altura mínima para que no se sienta apretado
            .defaultMinSize(minHeight = 100.dp)
            .clip(RoundedCornerShape(16.dp))
            .border(
                width = 2.dp,
                color = if (isSelected) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.outlineVariant,
                shape = RoundedCornerShape(16.dp)
            )
            .padding(16.dp)
    ) {
        content(
            Modifier
                // Eliminamos .weight(1f) para que el slider no se estire
                .pointerInput(Unit) { detectTapGestures(onPress = {}) }
        )
        // CAMBIO 4 (Opcional pero recomendado): Añadimos un pequeño espacio extra
        Spacer(Modifier.height(8.dp))
        Text(text = label, style = MaterialTheme.typography.labelLarge)
    }
}

/**
 * Diálogo que muestra un campo de texto para editar un valor de preferencia.
 */
@Composable
fun EditTextDialog(
    title: String,
    initialValue: String,
    onValueChange: (String) -> Unit,
    onDismiss: () -> Unit,
    placeholder: @Composable (() -> Unit)? = null,
    supportingText: @Composable (() -> Unit)? = null
) {
    var text by remember { mutableStateOf(initialValue) }

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(text = title) },
        text = {
            // Usamos un OutlinedTextField para el estilo estándar de Material 3
            OutlinedTextField(
                value = text,
                onValueChange = { text = it },
                singleLine = true,
                placeholder = placeholder,
                supportingText = supportingText,
                modifier = Modifier.fillMaxWidth()
            )
        },
        confirmButton = {
            TextButton(
                onClick = {
                    onValueChange(text) // Guardar el valor
                    onDismiss()
                }
            ) {
                Text(stringResource(android.R.string.ok))
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text(stringResource(android.R.string.cancel))
            }
        }
    )
}

@Composable
fun CacheInfoCard(
    title: String,
    usageText: String,
    progress: Float,
    onClearClick: () -> Unit,
    maxSizePreference: @Composable () -> Unit,
) {
    OutlinedCard(modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp)) {
        Column(modifier = Modifier.padding(top = 16.dp)) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(text = title, style = MaterialTheme.typography.titleMedium, fontWeight = FontWeight.Bold)
                TextButton(onClick = onClearClick) {
                    Icon(Icons.Default.DeleteSweep, contentDescription = stringResource(R.string.clean), modifier = Modifier.padding(end = 4.dp))
                    Text(stringResource(R.string.clean))
                }
            }
            LinearProgressIndicator(
                progress = { progress },
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp, vertical = 8.dp)
            )
            Text(
                text = usageText,
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                modifier = Modifier
                    .padding(horizontal = 16.dp)
                    .align(Alignment.End)
            )
            HorizontalDivider(modifier = Modifier.padding(top = 16.dp))
            maxSizePreference()
        }
    }
}

/**
 * Un diálogo de confirmación estándar de Material 3.
 * @param onDismissRequest Se llama cuando el usuario quiere cerrar el diálogo.
 * @param onConfirm Se llama cuando el usuario pulsa el botón de confirmación.
 * @param title El título del diálogo.
 * @param text El texto descriptivo del cuerpo del diálogo.
 */
@Composable
fun ConfirmationDialog(
    onDismissRequest: () -> Unit,
    onConfirm: () -> Unit,
    title: String,
    text: String,
) {
    AlertDialog(
        onDismissRequest = onDismissRequest,
        title = { Text(text = title) },
        text = { Text(text = text, style = MaterialTheme.typography.bodyMedium) },
        confirmButton = {
            TextButton(
                onClick = {
                    onConfirm()
                    onDismissRequest()
                }
            ) {
                Text(stringResource(android.R.string.ok))
            }
        },
        dismissButton = {
            TextButton(onClick = onDismissRequest) {
                Text(stringResource(android.R.string.cancel))
            }
        }
    )
}