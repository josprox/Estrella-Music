package com.zionhuang.music.ui.screens.settings

import androidx.compose.foundation.lazy.LazyColumn
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
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.constants.AudioNormalizationKey
import com.zionhuang.music.constants.AudioQuality
import com.zionhuang.music.constants.AudioQualityKey
import com.zionhuang.music.constants.AutoLoadMoreKey
import com.zionhuang.music.constants.AutoSkipNextOnErrorKey
import com.zionhuang.music.constants.PersistentQueueKey
import com.zionhuang.music.constants.SkipSilenceKey
import com.zionhuang.music.constants.SleepFinishSong
import com.zionhuang.music.constants.StopMusicOnTaskClearKey
import com.zionhuang.music.ui.component.EnumSelectionDialog
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.SettingsHeader
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberEnumPreference
import com.zionhuang.music.utils.rememberPreference
import androidx.compose.foundation.layout.padding
import com.zionhuang.music.ui.component.CustomSwitchPreference

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PlayerSettings(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    val (audioQuality, onAudioQualityChange) = rememberEnumPreference(AudioQualityKey, defaultValue = AudioQuality.AUTO)
    val (persistentQueue, onPersistentQueueChange) = rememberPreference(PersistentQueueKey, defaultValue = true)
    val (skipSilence, onSkipSilenceChange) = rememberPreference(SkipSilenceKey, defaultValue = false)
    val (audioNormalization, onAudioNormalizationChange) = rememberPreference(AudioNormalizationKey, defaultValue = true)
    val (autoLoadMore, onAutoLoadMoreChange) = rememberPreference(AutoLoadMoreKey, defaultValue = true)
    val (autoSkipNextOnError, onAutoSkipNextOnErrorChange) = rememberPreference(AutoSkipNextOnErrorKey, defaultValue = false)
    val (stopMusicOnTaskClear, onStopMusicOnTaskClearChange) = rememberPreference(StopMusicOnTaskClearKey, defaultValue = false)
    val (sleepFinishSong, onSleepFinishSongChange) = rememberPreference(key = SleepFinishSong, defaultValue = false)

    // --- ESTADO PARA CONTROLAR EL DIÁLOGO ---
    var showAudioQualityDialog by remember { mutableStateOf(false) }

    if (showAudioQualityDialog) {
        EnumSelectionDialog(
            title = stringResource(R.string.audio_quality),
            options = AudioQuality.entries,
            selectedOption = audioQuality,
            onOptionSelected = onAudioQualityChange,
            optionText = {
                when (it) {
                    AudioQuality.AUTO -> stringResource(R.string.audio_quality_auto)
                    AudioQuality.HIGH -> stringResource(R.string.audio_quality_high)
                    AudioQuality.LOW -> stringResource(R.string.audio_quality_low)
                }
            },
            onDismiss = { showAudioQualityDialog = false }
        )
    }

    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            LargeTopAppBar(
                title = { Text(stringResource(R.string.player_and_audio)) },
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

            // --- Grupo: Reproductor ---
            item { SettingsHeader(title = stringResource(R.string.player)) }

            item {
                val valueText = when (audioQuality) {
                    AudioQuality.AUTO -> stringResource(R.string.audio_quality_auto)
                    AudioQuality.HIGH -> stringResource(R.string.audio_quality_high)
                    AudioQuality.LOW -> stringResource(R.string.audio_quality_low)
                }
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.audio_quality)) },
                    description = { Text(valueText) },
                    icon = { Icon(painterResource(R.drawable.graphic_eq), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { showAudioQualityDialog = true }
                )
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.skip_silence)) },
                    icon = { Icon(painterResource(R.drawable.fast_forward), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onSkipSilenceChange(!skipSilence) },
                    trailingContent = { CustomSwitchPreference(checked = skipSilence, onCheckedChange = onSkipSilenceChange) }
                )
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.audio_normalization)) },
                    icon = { Icon(painterResource(R.drawable.volume_up), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onAudioNormalizationChange(!audioNormalization) },
                    trailingContent = { CustomSwitchPreference(checked = audioNormalization, onCheckedChange = onAudioNormalizationChange) }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            // --- Grupo: Cola de Reproducción ---
            item { SettingsHeader(title = stringResource(R.string.queue)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.persistent_queue)) },
                    description = { Text(stringResource(R.string.persistent_queue_desc)) },
                    icon = { Icon(painterResource(R.drawable.queue_music), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onPersistentQueueChange(!persistentQueue) },
                    trailingContent = { CustomSwitchPreference(checked = persistentQueue, onCheckedChange = onPersistentQueueChange) }
                )
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.auto_load_more)) },
                    description = { Text(stringResource(R.string.auto_load_more_desc)) },
                    icon = { Icon(painterResource(R.drawable.playlist_add), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onAutoLoadMoreChange(!autoLoadMore) },
                    trailingContent = { CustomSwitchPreference(checked = autoLoadMore, onCheckedChange = onAutoLoadMoreChange) }
                )
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.auto_skip_next_on_error)) },
                    description = { Text(stringResource(R.string.auto_skip_next_on_error_desc)) },
                    icon = { Icon(painterResource(R.drawable.skip_next), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onAutoSkipNextOnErrorChange(!autoSkipNextOnError) },
                    trailingContent = { CustomSwitchPreference(checked = autoSkipNextOnError, onCheckedChange = onAutoSkipNextOnErrorChange) }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            // --- Grupo: Misceláneo ---
            item { SettingsHeader(title = stringResource(R.string.misc)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.stop_music_on_task_clear)) },
                    icon = { Icon(painterResource(R.drawable.clear_all), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onStopMusicOnTaskClearChange(!stopMusicOnTaskClear) },
                    trailingContent = { CustomSwitchPreference(checked = stopMusicOnTaskClear, onCheckedChange = onStopMusicOnTaskClearChange) }
                )
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.sleepTimerSong)) },
                    description = { Text(stringResource(R.string.sleepTimerSongText)) },
                    icon = { Icon(painterResource(id = R.drawable.bedtime), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onSleepFinishSongChange(!sleepFinishSong) },
                    trailingContent = { CustomSwitchPreference(checked = sleepFinishSong, onCheckedChange = onSleepFinishSongChange) }
                )
            }
        }
    }
}