@file:Suppress("KotlinConstantConditions")

package com.zionhuang.music.ui.screens.settings

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.LargeTopAppBar
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import coil.annotation.ExperimentalCoilApi
import coil.imageLoader
import com.zionhuang.music.BuildConfig.FLAVOR
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.LocalPlayerConnection
import com.zionhuang.music.R
import com.zionhuang.music.constants.MaxImageCacheSizeKey
import com.zionhuang.music.constants.MaxSongCacheSizeKey
import com.zionhuang.music.extensions.tryOrNull
import com.zionhuang.music.ui.component.CacheInfoCard
import com.zionhuang.music.ui.component.EnumSelectionDialog
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.SettingsHeader
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.ui.utils.formatFileSize
import com.zionhuang.music.utils.TranslationHelper
import com.zionhuang.music.utils.rememberPreference
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch

private enum class EditingCacheKey { IMAGE, SONG }

@OptIn(ExperimentalCoilApi::class, ExperimentalMaterial3Api::class)
@Composable
fun StorageSettings(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    val context = LocalContext.current
    val imageDiskCache = context.imageLoader.diskCache ?: return
    val playerCache = LocalPlayerConnection.current?.service?.playerCache ?: return
    val downloadCache = LocalPlayerConnection.current?.service?.downloadCache ?: return

    val coroutineScope = rememberCoroutineScope()
    val (maxImageCacheSize, onMaxImageCacheSizeChange) = rememberPreference(key = MaxImageCacheSizeKey, defaultValue = 512)
    val (maxSongCacheSize, onMaxSongCacheSizeChange) = rememberPreference(key = MaxSongCacheSizeKey, defaultValue = 1024)

    var imageCacheSize by remember { mutableLongStateOf(imageDiskCache.size) }
    var playerCacheSize by remember { mutableLongStateOf(tryOrNull { playerCache.cacheSpace } ?: 0) }
    var downloadCacheSize by remember { mutableLongStateOf(tryOrNull { downloadCache.cacheSpace } ?: 0) }

    val imageCacheProgress by animateFloatAsState(targetValue = (imageCacheSize.toFloat() / imageDiskCache.maxSize).coerceIn(0f, 1f), label = "ImageCacheProgress")
    val playerCacheProgress by animateFloatAsState(targetValue = (playerCacheSize.toFloat() / (maxSongCacheSize * 1024 * 1024L)).coerceIn(0f, 1f), label = "PlayerCacheProgress")

    var editingCacheKey by remember { mutableStateOf<EditingCacheKey?>(null) }

    LaunchedEffect(Unit) {
        while (isActive) {
            imageCacheSize = imageDiskCache.size
            playerCacheSize = tryOrNull { playerCache.cacheSpace } ?: 0
            downloadCacheSize = tryOrNull { downloadCache.cacheSpace } ?: 0
            delay(1000) // Actualizar cada segundo es suficiente
        }
    }

    editingCacheKey?.let { key ->
        when (key) {
            EditingCacheKey.SONG -> EnumSelectionDialog(
                title = stringResource(R.string.max_cache_size),
                options = listOf(128, 256, 512, 1024, 2048, 4096, 8192, -1),
                selectedOption = maxSongCacheSize,
                onOptionSelected = onMaxSongCacheSizeChange,
                optionText = { if (it == -1) stringResource(R.string.unlimited) else formatFileSize(it * 1024 * 1024L) },
                onDismiss = { editingCacheKey = null }
            )
            EditingCacheKey.IMAGE -> EnumSelectionDialog(
                title = stringResource(R.string.max_cache_size),
                options = listOf(128, 256, 512, 1024, 2048, 4096, 8192),
                selectedOption = maxImageCacheSize,
                onOptionSelected = onMaxImageCacheSizeChange,
                optionText = { formatFileSize(it * 1024 * 1024L) },
                onDismiss = { editingCacheKey = null }
            )
        }
    }

    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            LargeTopAppBar(
                title = { Text(stringResource(R.string.storage)) },
                navigationIcon = {
                    IconButton(onClick = navController::navigateUp, onLongClick = navController::backToMain) {
                        Icon(painterResource(R.drawable.arrow_back), contentDescription = null)
                    }
                },
                scrollBehavior = scrollBehavior
            )
        },
        contentWindowInsets = LocalPlayerAwareWindowInsets.current
    ) { innerPadding ->
        LazyColumn(contentPadding = innerPadding) {
            item { SettingsHeader(title = stringResource(R.string.cache)) }

            item {
                CacheInfoCard(
                    title = stringResource(R.string.song_cache),
                    usageText = if (maxSongCacheSize == -1) {
                        stringResource(R.string.size_used, formatFileSize(playerCacheSize))
                    } else {
                        stringResource(R.string.size_used, "${formatFileSize(playerCacheSize)} / ${formatFileSize(maxSongCacheSize * 1024 * 1024L)}")
                    },
                    progress = playerCacheProgress,
                    onClearClick = {
                        coroutineScope.launch(Dispatchers.IO) { playerCache.keys.forEach { playerCache.removeResource(it) } }
                    },
                    maxSizePreference = {
                        ExpressivePreferenceEntry(
                            title = { Text(stringResource(R.string.max_cache_size)) },
                            description = { Text(if (maxSongCacheSize == -1) stringResource(R.string.unlimited) else formatFileSize(maxSongCacheSize * 1024 * 1024L)) },
                            icon = { Icon(painterResource(R.drawable.tune), null, tint = MaterialTheme.colorScheme.primary) },
                            onClick = { editingCacheKey = EditingCacheKey.SONG }
                        )
                    }
                )
            }

            item {
                CacheInfoCard(
                    title = stringResource(R.string.image_cache),
                    usageText = stringResource(R.string.size_used, "${formatFileSize(imageCacheSize)} / ${formatFileSize(imageDiskCache.maxSize)}"),
                    progress = imageCacheProgress,
                    onClearClick = {
                        coroutineScope.launch(Dispatchers.IO) { imageDiskCache.clear() }
                    },
                    maxSizePreference = {
                        ExpressivePreferenceEntry(
                            title = { Text(stringResource(R.string.max_cache_size)) },
                            description = { Text(formatFileSize(maxImageCacheSize * 1024 * 1024L)) },
                            icon = { Icon(painterResource(R.drawable.tune), null, tint = MaterialTheme.colorScheme.primary) },
                            onClick = { editingCacheKey = EditingCacheKey.IMAGE }
                        )
                    }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }
            item { SettingsHeader(title = stringResource(R.string.downloads)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.clear_all_downloads)) },
                    description = { Text(stringResource(R.string.size_used, formatFileSize(downloadCacheSize))) },
                    icon = { Icon(painterResource(R.drawable.download), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = {
                        coroutineScope.launch(Dispatchers.IO) { downloadCache.keys.forEach { downloadCache.removeResource(it) } }
                    }
                )
            }


            if (FLAVOR != "foss") {
                item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }
                item { SettingsHeader(title = stringResource(R.string.translation_models)) }
                item {
                    ExpressivePreferenceEntry(
                        title = { Text(stringResource(R.string.clear_translation_models)) },
                        icon = { Icon(painterResource(R.drawable.language), null, tint = MaterialTheme.colorScheme.primary) },
                        onClick = { coroutineScope.launch(Dispatchers.IO) { TranslationHelper.clearModels() } }
                    )
                }
            }
        }
    }
}