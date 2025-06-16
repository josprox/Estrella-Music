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
import com.zionhuang.innertube.YouTube
import com.zionhuang.music.LocalDatabase
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.constants.DisableScreenshotKey
import com.zionhuang.music.constants.PauseListenHistoryKey
import com.zionhuang.music.constants.PauseSearchHistoryKey
import com.zionhuang.music.constants.UseLoginForBrowse
import com.zionhuang.music.ui.component.ConfirmationDialog
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.SettingsHeader
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberPreference
import androidx.compose.foundation.layout.padding

private enum class PrivacyDialogKey {
    CLEAR_LISTEN_HISTORY,
    CLEAR_SEARCH_HISTORY
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PrivacySettings(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    val database = LocalDatabase.current
    val (pauseListenHistory, onPauseListenHistoryChange) = rememberPreference(key = PauseListenHistoryKey, defaultValue = false)
    val (pauseSearchHistory, onPauseSearchHistoryChange) = rememberPreference(key = PauseSearchHistoryKey, defaultValue = false)
    val (useLoginForBrowse, onUseLoginForBrowseChange) = rememberPreference(key = UseLoginForBrowse, defaultValue = false)
    val (disableScreenshot, onDisableScreenshotChange) = rememberPreference(key = DisableScreenshotKey, defaultValue = false)

    var activeDialog by remember { mutableStateOf<PrivacyDialogKey?>(null) }

    activeDialog?.let { dialog ->
        val title: String
        val text: String
        val onConfirm: () -> Unit

        when (dialog) {
            PrivacyDialogKey.CLEAR_LISTEN_HISTORY -> {
                title = stringResource(R.string.clear_listen_history)
                text = stringResource(R.string.clear_listen_history_confirm)
                onConfirm = { database.query { clearListenHistory() } }
            }
            PrivacyDialogKey.CLEAR_SEARCH_HISTORY -> {
                title = stringResource(R.string.clear_search_history)
                text = stringResource(R.string.clear_search_history_confirm)
                onConfirm = { database.query { clearSearchHistory() } }
            }
        }
        ConfirmationDialog(
            onDismissRequest = { activeDialog = null },
            onConfirm = onConfirm,
            title = title,
            text = text
        )
    }

    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            LargeTopAppBar(
                title = { Text(stringResource(R.string.privacy)) },
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

            item { SettingsHeader(title = stringResource(R.string.listen_history)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.pause_listen_history)) },
                    icon = { Icon(painterResource(R.drawable.history), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onPauseListenHistoryChange(!pauseListenHistory) },
                    trailingContent = { Switch(checked = pauseListenHistory, onCheckedChange = onPauseListenHistoryChange) }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.clear_listen_history)) },
                    icon = { Icon(painterResource(R.drawable.delete_history), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { activeDialog = PrivacyDialogKey.CLEAR_LISTEN_HISTORY }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = stringResource(R.string.search_history)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.pause_search_history)) },
                    icon = { Icon(painterResource(R.drawable.search_off), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onPauseSearchHistoryChange(!pauseSearchHistory) },
                    trailingContent = { Switch(checked = pauseSearchHistory, onCheckedChange = onPauseSearchHistoryChange) }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.clear_search_history)) },
                    icon = { Icon(painterResource(R.drawable.clear_all), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { activeDialog = PrivacyDialogKey.CLEAR_SEARCH_HISTORY }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = stringResource(R.string.account)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.use_login_for_browse)) },
                    description = { Text(stringResource(R.string.use_login_for_browse_desc)) },
                    icon = { Icon(painterResource(R.drawable.person), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = {
                        val newValue = !useLoginForBrowse
                        YouTube.useLoginForBrowse = newValue
                        onUseLoginForBrowseChange(newValue)
                    },
                    trailingContent = {
                        Switch(
                            checked = useLoginForBrowse,
                            onCheckedChange = {
                                YouTube.useLoginForBrowse = it
                                onUseLoginForBrowseChange(it)
                            }
                        )
                    }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = stringResource(R.string.misc)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.disable_screenshot)) },
                    description = { Text(stringResource(R.string.disable_screenshot_desc)) },
                    icon = { Icon(painterResource(R.drawable.screenshot), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onDisableScreenshotChange(!disableScreenshot) },
                    trailingContent = { Switch(checked = disableScreenshot, onCheckedChange = onDisableScreenshotChange) }
                )
            }
        }
    }
}