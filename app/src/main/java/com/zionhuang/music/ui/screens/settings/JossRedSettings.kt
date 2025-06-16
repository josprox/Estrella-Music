package com.zionhuang.music.ui.screens.settings

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.LargeTopAppBar
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.constants.AutoSkipNextOnErrorKey
import com.zionhuang.music.constants.JossRedEnabledKey
import com.zionhuang.music.constants.JossRedMultimedia
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberPreference

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun JossRedSettings(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    val (jossRedEnabled, onJossRedEnabledChange) = rememberPreference(key = JossRedEnabledKey, defaultValue = false)
    val (jossRedMultimedia, onJossRedMultimediaChange) = rememberPreference(key = JossRedMultimedia, defaultValue = false)
    val (autoSkipNextOnError, onAutoSkipNextOnErrorChange) = rememberPreference(AutoSkipNextOnErrorKey, defaultValue = false)

    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            LargeTopAppBar(
                title = { Text("Joss Red") },
                navigationIcon = {
                    IconButton(
                        onClick = navController::navigateUp,
                        onLongClick = navController::backToMain
                    ) {
                        Icon(painterResource(R.drawable.arrow_back), contentDescription = null)
                    }
                },
                scrollBehavior = scrollBehavior
            )
        },
        contentWindowInsets = LocalPlayerAwareWindowInsets.current
    ) { innerPadding ->
        LazyColumn(contentPadding = innerPadding) {

            // --- Mensaje de Bienvenida Estilizado ---
            item {
                Text(
                    text = stringResource(R.string.jossredSettings_welcome),
                    style = MaterialTheme.typography.bodyLarge,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(16.dp)
                )
            }

            item {
                HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp))
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.enable_proxy) + " Joss Red") },
                    icon = {
                        Icon(
                            painter = painterResource(id = R.drawable.joss_music_logo),
                            contentDescription = null,
                            modifier = Modifier
                                .size(24.dp)
                                .clip(CircleShape)
                                .background(MaterialTheme.colorScheme.surfaceContainer)
                        )
                    },
                    onClick = { onJossRedEnabledChange(!jossRedEnabled) },
                    trailingContent = {
                        Switch(checked = jossRedEnabled, onCheckedChange = onJossRedEnabledChange)
                    }
                )
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.playSongJR)) },
                    description = { Text(stringResource(R.string.playSongJRDesc)) },
                    icon = {
                        Icon(
                            painter = painterResource(id = R.drawable.music_note),
                            contentDescription = null,
                            tint = MaterialTheme.colorScheme.primary
                        )
                    },
                    onClick = { onJossRedMultimediaChange(!jossRedMultimedia) },
                    trailingContent = {
                        Switch(checked = jossRedMultimedia, onCheckedChange = onJossRedMultimediaChange)
                    }
                )
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.auto_skip_next_on_error)) },
                    description = { Text(stringResource(R.string.auto_skip_next_on_error_desc)) },
                    icon = {
                        Icon(
                            painter = painterResource(R.drawable.skip_next),
                            contentDescription = null,
                            tint = MaterialTheme.colorScheme.primary
                        )
                    },
                    onClick = { onAutoSkipNextOnErrorChange(!autoSkipNextOnError) },
                    trailingContent = {
                        Switch(checked = autoSkipNextOnError, onCheckedChange = onAutoSkipNextOnErrorChange)
                    }
                )
            }
        }
    }
}