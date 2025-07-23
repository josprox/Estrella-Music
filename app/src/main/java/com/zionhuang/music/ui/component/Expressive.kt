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
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close // Importa el ícono de "close"
import androidx.compose.material.icons.filled.Done // Importa el ícono de "Done" para "check"
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
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
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
import androidx.compose.ui.res.painterResource
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
        style = MaterialTheme.typography.displaySmall,
        color = MaterialTheme.colorScheme.onSurface,
        modifier = modifier
            .padding(horizontal = 24.dp, vertical = 16.dp)
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
        title = { Text(text = title, style = MaterialTheme.typography.headlineMedium) },
        text = {
            LazyColumn {
                items(options.size) { index ->
                    val option = options[index]
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(64.dp)
                            .selectable(
                                selected = (option == selectedOption),
                                onClick = {
                                    onOptionSelected(option)
                                    onDismiss()
                                },
                                role = Role.RadioButton
                            )
                            .padding(horizontal = 24.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = (option == selectedOption),
                            onClick = null,
                            colors = androidx.compose.material3.RadioButtonDefaults.colors(
                                selectedColor = MaterialTheme.colorScheme.primary,
                                unselectedColor = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        )
                        Text(
                            text = optionText(option),
                            style = MaterialTheme.typography.bodyLarge,
                            modifier = Modifier.padding(start = 24.dp)
                        )
                    }
                }
            }
        },
        confirmButton = {
            TextButton(
                onClick = onDismiss,
                shape = RoundedCornerShape(12.dp)
            ) {
                Text(stringResource(android.R.string.cancel))
            }
        },
        shape = RoundedCornerShape(28.dp)
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
                    .size(56.dp)
                    .clip(RoundedCornerShape(16.dp))
                    .background(MaterialTheme.colorScheme.primaryContainer),
                contentAlignment = Alignment.Center
            ) {
                icon()
            }
        },
        trailingContent = trailingContent,
        modifier = modifier
            .fillMaxWidth()
            .clickable(onClick = onClick)
            .padding(vertical = 8.dp, horizontal = 16.dp)
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
        modifier = Modifier.padding(bottom = 16.dp)
    ) {
        ListItem(
            headlineContent = title,
            leadingContent = {
                Box(
                    modifier = Modifier
                        .size(56.dp)
                        .clip(RoundedCornerShape(16.dp))
                        .background(MaterialTheme.colorScheme.primaryContainer),
                    contentAlignment = Alignment.Center
                ) {
                    icon()
                }
            }
        )
        Row(
            horizontalArrangement = Arrangement.spacedBy(12.dp),
            modifier = Modifier.padding(top = 8.dp, start = 24.dp, end = 24.dp)
        ) {
            options.forEach { (optionValue, content) ->
                val isSelected = (selectedValue == optionValue)
                Box(
                    modifier = Modifier
                        .weight(1f)
                        .clip(RoundedCornerShape(20.dp))
                        .background(if (isSelected) MaterialTheme.colorScheme.tertiaryContainer else MaterialTheme.colorScheme.surfaceContainerHigh)
                        .border(
                            width = 2.dp,
                            color = if (isSelected) MaterialTheme.colorScheme.tertiary else MaterialTheme.colorScheme.outlineVariant,
                            shape = RoundedCornerShape(20.dp)
                        )
                        .clickable { onValueSelected(optionValue) }
                        .padding(16.dp)
                ) {
                    content(isSelected)
                }
            }
        }
    }
}

@Composable
fun CustomSwitchPreference(
    modifier: Modifier = Modifier,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    isEnabled: Boolean = true,
) {
    Switch(
        modifier = modifier,
        checked = checked,
        onCheckedChange = onCheckedChange,
        enabled = isEnabled,
        thumbContent = {
            // Usamos Icons.Filled.Done para el estado checked (similar a un "check")
            // y Icons.Filled.Close para el estado unchecked.
            Icon(
                imageVector = if (checked) Icons.Filled.Done else Icons.Filled.Close,
                contentDescription = null, // Es un elemento puramente decorativo, no necesita descripción para accesibilidad
                modifier = Modifier.size(SwitchDefaults.IconSize),
            )
        }
    )
}
@Composable
fun SwitchPreference(
    modifier: Modifier = Modifier,
    title: @Composable () -> Unit,
    description: String? = null,
    icon: (@Composable () -> Unit)? = null,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    isEnabled: Boolean = true,
) {
    PreferenceEntry( // Asegúrate de que esta función 'PreferenceEntry' esté definida en algún lugar.
        modifier = modifier,
        title = title,
        description = description,
        icon = icon,
        trailingContent = {
            Switch(
                checked = checked,
                onCheckedChange = onCheckedChange,
                enabled = isEnabled,
                thumbContent = {
                    // Usamos Icons.Filled.Done para el estado checked (similar a un "check")
                    // y Icons.Filled.Close para el estado unchecked.
                    Icon(
                        imageVector = if (checked) Icons.Filled.Done else Icons.Filled.Close,
                        contentDescription = null, // La descripción de contenido puede ser nula para elementos puramente decorativos
                        modifier = Modifier.size(SwitchDefaults.IconSize),
                    )
                }
            )
        },
        onClick = { onCheckedChange(!checked) },
        isEnabled = isEnabled
    )
}

@Composable
fun SliderPreview(
    label: String,
    isSelected: Boolean,
    content: @Composable (Modifier) -> Unit
) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
        modifier = Modifier
            .defaultMinSize(minHeight = 120.dp)
            .clip(RoundedCornerShape(24.dp))
            .border(
                width = 3.dp,
                color = if (isSelected) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.outlineVariant,
                shape = RoundedCornerShape(24.dp)
            )
            .background(if (isSelected) MaterialTheme.colorScheme.primaryContainer.copy(alpha = 0.2f) else MaterialTheme.colorScheme.surfaceContainer)
            .padding(24.dp)
    ) {
        content(
            Modifier
                .pointerInput(Unit) { detectTapGestures(onPress = {}) }
        )
        Spacer(Modifier.height(12.dp))
        Text(
            text = label,
            style = MaterialTheme.typography.titleSmall,
            color = if (isSelected) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurface
        )
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
        title = { Text(text = title, style = MaterialTheme.typography.headlineSmall) },
        text = {
            OutlinedTextField(
                value = text,
                onValueChange = { text = it },
                singleLine = true,
                placeholder = placeholder,
                supportingText = supportingText,
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(16.dp),
                colors = androidx.compose.material3.OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = MaterialTheme.colorScheme.primary,
                    unfocusedBorderColor = MaterialTheme.colorScheme.outlineVariant,
                    focusedLabelColor = MaterialTheme.colorScheme.primary,
                    unfocusedLabelColor = MaterialTheme.colorScheme.onSurfaceVariant
                )
            )
        },
        confirmButton = {
            TextButton(
                onClick = {
                    onValueChange(text)
                    onDismiss()
                },
                shape = RoundedCornerShape(12.dp)
            ) {
                Text(stringResource(android.R.string.ok))
            }
        },
        dismissButton = {
            TextButton(
                onClick = onDismiss,
                shape = RoundedCornerShape(12.dp)
            ) {
                Text(stringResource(android.R.string.cancel))
            }
        },
        shape = RoundedCornerShape(28.dp)
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
    OutlinedCard(
        modifier = Modifier
            .padding(horizontal = 16.dp, vertical = 12.dp),
        shape = RoundedCornerShape(24.dp)
    ) {
        Column(modifier = Modifier.padding(top = 24.dp)) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 24.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(text = title, style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.SemiBold)
                TextButton(
                    onClick = onClearClick,
                    shape = RoundedCornerShape(16.dp)
                ) {
                    Icon(Icons.Default.DeleteSweep, contentDescription = stringResource(R.string.clean), modifier = Modifier.padding(end = 8.dp))
                    Text(stringResource(R.string.clean))
                }
            }
            LinearProgressIndicator(
                progress = { progress },
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 24.dp, vertical = 12.dp),
                color = MaterialTheme.colorScheme.tertiary
            )
            Text(
                text = usageText,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                modifier = Modifier
                    .padding(horizontal = 24.dp)
                    .align(Alignment.End)
            )
            HorizontalDivider(
                modifier = Modifier.padding(top = 24.dp),
                thickness = 1.dp,
                color = MaterialTheme.colorScheme.outlineVariant
            )
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
        title = { Text(text = title, style = MaterialTheme.typography.headlineSmall) },
        text = { Text(text = text, style = MaterialTheme.typography.bodyLarge) },
        confirmButton = {
            TextButton(
                onClick = {
                    onConfirm()
                    onDismissRequest()
                },
                shape = RoundedCornerShape(12.dp)
            ) {
                Text(stringResource(android.R.string.ok))
            }
        },
        dismissButton = {
            TextButton(
                onClick = onDismissRequest,
                shape = RoundedCornerShape(12.dp)
            ) {
                Text(stringResource(android.R.string.cancel))
            }
        },
        shape = RoundedCornerShape(28.dp)
    )
}