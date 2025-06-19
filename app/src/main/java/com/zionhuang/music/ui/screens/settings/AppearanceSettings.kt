package com.zionhuang.music.ui.screens.settings

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Gradient
import androidx.compose.material.icons.filled.Layers
import androidx.compose.material.icons.filled.LayersClear
import androidx.compose.material.icons.rounded.MoreHoriz
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.LargeTopAppBar
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Slider
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
import com.zionhuang.music.constants.DarkModeKey
import com.zionhuang.music.constants.DefaultOpenTabKey
import com.zionhuang.music.constants.DynamicThemeKey
import com.zionhuang.music.constants.GridCellSize
import com.zionhuang.music.constants.GridCellSizeKey
import com.zionhuang.music.constants.PlayerBackgroundStyle
import com.zionhuang.music.constants.PlayerMode
import com.zionhuang.music.constants.PlayerTextAlignmentKey
import com.zionhuang.music.constants.PureBlackKey
import com.zionhuang.music.constants.SliderStyle
import com.zionhuang.music.constants.SliderStyleKey
import com.zionhuang.music.constants.SlimNavBarKey
import com.zionhuang.music.ui.component.EnumSelectionDialog
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.InlineSelectPreference
import com.zionhuang.music.ui.component.SettingsHeader
import com.zionhuang.music.ui.component.SliderPreview
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberEnumPreference
import com.zionhuang.music.utils.rememberPreference
import me.saket.squiggles.SquigglySlider

private enum class EditingPreferenceKey {
    DARK_MODE,
    GRID_CELL_SIZE,
    DEFAULT_OPEN_TAB,
    PLAYER_TEXT_ALIGNMENT,
    PLAYER_BACKGROUND
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppearanceSettings(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    val (dynamicTheme, onDynamicThemeChange) = rememberPreference(DynamicThemeKey, defaultValue = true)
    val (darkMode, onDarkModeChange) = rememberEnumPreference(DarkModeKey, defaultValue = DarkMode.AUTO)
    val (pureBlack, onPureBlackChange) = rememberPreference(PureBlackKey, defaultValue = false)
    val (playerTextAlignment, onPlayerTextAlignmentChange) = rememberEnumPreference(PlayerTextAlignmentKey, defaultValue = PlayerTextAlignment.CENTER)
    val (sliderStyle, onSliderStyleChange) = rememberEnumPreference(SliderStyleKey, defaultValue = SliderStyle.DEFAULT)
    val (defaultOpenTab, onDefaultOpenTabChange) = rememberEnumPreference(DefaultOpenTabKey, defaultValue = NavigationTab.HOME)
    val (gridCellSize, onGridCellSizeChange) = rememberEnumPreference(GridCellSizeKey, defaultValue = GridCellSize.SMALL)
    val (slimNav, onSlimNavChange) = rememberPreference(SlimNavBarKey, defaultValue = false)
    val (playerBackgroundStyle, onPlayerBackgroundStyleChange) = rememberEnumPreference(
        key = PlayerMode,
        defaultValue = PlayerBackgroundStyle.DEFAULT
    )

    val isSystemInDarkTheme = isSystemInDarkTheme()
    val useDarkTheme = remember(darkMode, isSystemInDarkTheme) {
        darkMode == DarkMode.ON || (darkMode == DarkMode.AUTO && isSystemInDarkTheme)
    }

    var editingPreference by remember { mutableStateOf<EditingPreferenceKey?>(null) }

    editingPreference?.let { preferenceKey ->
        when (preferenceKey) {
            EditingPreferenceKey.DARK_MODE -> EnumSelectionDialog(
                title = stringResource(R.string.dark_theme),
                options = DarkMode.entries,
                selectedOption = darkMode,
                onOptionSelected = onDarkModeChange,
                optionText = {
                    when (it) {
                        DarkMode.ON -> stringResource(R.string.dark_theme_on)
                        DarkMode.OFF -> stringResource(R.string.dark_theme_off)
                        DarkMode.AUTO -> stringResource(R.string.dark_theme_follow_system)
                    }
                },
                onDismiss = { editingPreference = null }
            )
            EditingPreferenceKey.GRID_CELL_SIZE -> EnumSelectionDialog(
                title = stringResource(R.string.grid_cell_size),
                options = GridCellSize.entries,
                selectedOption = gridCellSize,
                onOptionSelected = onGridCellSizeChange,
                optionText = {
                    when (it) {
                        GridCellSize.SMALL -> stringResource(R.string.small)
                        GridCellSize.BIG -> stringResource(R.string.big)
                    }
                },
                onDismiss = { editingPreference = null }
            )
            EditingPreferenceKey.DEFAULT_OPEN_TAB -> EnumSelectionDialog(
                title = stringResource(R.string.default_open_tab),
                options = NavigationTab.entries,
                selectedOption = defaultOpenTab,
                onOptionSelected = onDefaultOpenTabChange,
                optionText = {
                    when (it) {
                        NavigationTab.HOME -> stringResource(R.string.home)
                        NavigationTab.SONG -> stringResource(R.string.songs)
                        NavigationTab.ARTIST -> stringResource(R.string.artists)
                        NavigationTab.ALBUM -> stringResource(R.string.albums)
                        NavigationTab.PLAYLIST -> stringResource(R.string.playlists)
                    }
                },
                onDismiss = { editingPreference = null }
            )
            EditingPreferenceKey.PLAYER_TEXT_ALIGNMENT -> EnumSelectionDialog(
                title = stringResource(R.string.player_text_alignment),
                options = PlayerTextAlignment.entries,
                selectedOption = playerTextAlignment,
                onOptionSelected = onPlayerTextAlignmentChange,
                optionText = {
                    when (it) {
                        PlayerTextAlignment.SIDED -> stringResource(R.string.sided)
                        PlayerTextAlignment.CENTER -> stringResource(R.string.center)
                    }
                },
                onDismiss = { editingPreference = null }
            )
            EditingPreferenceKey.PLAYER_BACKGROUND -> EnumSelectionDialog(
                title = stringResource(R.string.selectPlayerBackground),
                options = PlayerBackgroundStyle.entries,
                selectedOption = playerBackgroundStyle,
                onOptionSelected = onPlayerBackgroundStyleChange,
                optionText = {
                    when(it) {
                        PlayerBackgroundStyle.DEFAULT -> stringResource(R.string.defaultText)
                        PlayerBackgroundStyle.TRANSPARENT -> stringResource(R.string.transparent)
                        PlayerBackgroundStyle.BLUR -> stringResource(R.string.album_art_blur)
                        PlayerBackgroundStyle.GRADIENT -> stringResource(R.string.gradientBackground)
                    }
                },
                onDismiss = { editingPreference = null }
            )
        }
    }


    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            LargeTopAppBar(
                title = { Text(stringResource(R.string.appearance)) },
                navigationIcon = {
                    IconButton(
                        onClick = navController::navigateUp,
                        onLongClick = navController::backToMain
                    ) {
                        Icon(painterResource(R.drawable.arrow_back), contentDescription = "Back")
                    }
                },
                scrollBehavior = scrollBehavior
            )
        },
        contentWindowInsets = LocalPlayerAwareWindowInsets.current
    ) { innerPadding ->
        LazyColumn(
            contentPadding = innerPadding,
            verticalArrangement = Arrangement.spacedBy(4.dp),
        ) {
            item { SettingsHeader(title = stringResource(R.string.theme)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.enable_dynamic_theme)) },
                    icon = { Icon(painterResource(R.drawable.palette), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onDynamicThemeChange(!dynamicTheme) },
                    trailingContent = {
                        Switch(checked = dynamicTheme, onCheckedChange = onDynamicThemeChange)
                    }
                )
            }
            item {
                val valueText = when (darkMode) {
                    DarkMode.ON -> stringResource(R.string.dark_theme_on)
                    DarkMode.OFF -> stringResource(R.string.dark_theme_off)
                    DarkMode.AUTO -> stringResource(R.string.dark_theme_follow_system)
                }
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.dark_theme)) },
                    description = { Text(valueText) },
                    icon = { Icon(painterResource(R.drawable.dark_mode), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { editingPreference = EditingPreferenceKey.DARK_MODE }
                )
            }
            item {
                AnimatedVisibility(visible = useDarkTheme) {
                    ExpressivePreferenceEntry(
                        title = { Text(stringResource(R.string.pure_black)) },
                        icon = { Icon(painterResource(R.drawable.contrast), null, tint = MaterialTheme.colorScheme.primary) },
                        onClick = { onPureBlackChange(!pureBlack) },
                        trailingContent = {
                            Switch(checked = pureBlack, onCheckedChange = onPureBlackChange)
                        }
                    )
                }
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = stringResource(R.string.interface_)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.slim_navbar_title)) },
                    description = { Text(stringResource(R.string.slim_navbar_description)) },
                    icon = { Icon(Icons.Rounded.MoreHoriz, null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onSlimNavChange(!slimNav) },
                    trailingContent = {
                        Switch(checked = slimNav, onCheckedChange = onSlimNavChange)
                    }
                )
            }
            item {
                val valueText = when (gridCellSize) {
                    GridCellSize.SMALL -> stringResource(R.string.small)
                    GridCellSize.BIG -> stringResource(R.string.big)
                }
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.grid_cell_size)) },
                    description = { Text(valueText) },
                    icon = { Icon(painterResource(R.drawable.grid_view), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { editingPreference = EditingPreferenceKey.GRID_CELL_SIZE }
                )
            }
            item {
                val valueText = when (defaultOpenTab) {
                    NavigationTab.HOME -> stringResource(R.string.home)
                    NavigationTab.SONG -> stringResource(R.string.songs)
                    NavigationTab.ARTIST -> stringResource(R.string.artists)
                    NavigationTab.ALBUM -> stringResource(R.string.albums)
                    NavigationTab.PLAYLIST -> stringResource(R.string.playlists)
                }
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.default_open_tab)) },
                    description = { Text(valueText) },
                    icon = { Icon(painterResource(R.drawable.tab), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { editingPreference = EditingPreferenceKey.DEFAULT_OPEN_TAB }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = stringResource(R.string.player)) }

            item {
                InlineSelectPreference(
                    title = { Text(stringResource(R.string.player_slider_style)) },
                    icon = { Icon(painterResource(R.drawable.sliders), null, tint = MaterialTheme.colorScheme.primary) },
                    selectedValue = sliderStyle,
                    onValueSelected = onSliderStyleChange,
                    options = listOf(
                        SliderStyle.DEFAULT to { isSelected ->
                            SliderPreview(stringResource(R.string.default_), isSelected) {
                                Slider(value = 0.5f, onValueChange = {}, modifier = it)
                            }
                        },
                        SliderStyle.SQUIGGLY to { isSelected ->
                            SliderPreview(stringResource(R.string.squiggly), isSelected) {
                                SquigglySlider(value = 0.5f, onValueChange = {}, modifier = it, valueRange = 0f..1f)
                            }
                        }
                    )
                )
            }
            item {
                val valueText = when (playerTextAlignment) {
                    PlayerTextAlignment.SIDED -> stringResource(R.string.sided)
                    PlayerTextAlignment.CENTER -> stringResource(R.string.center)
                }
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.player_text_alignment)) },
                    description = { Text(valueText) },
                    icon = {
                        Icon(painterResource(
                            when (playerTextAlignment) {
                                PlayerTextAlignment.CENTER -> R.drawable.format_align_center
                                PlayerTextAlignment.SIDED -> R.drawable.format_align_left
                            }), null, tint = MaterialTheme.colorScheme.primary)
                    },
                    onClick = { editingPreference = EditingPreferenceKey.PLAYER_TEXT_ALIGNMENT }
                )
            }
            item {
                val valueText = when (playerBackgroundStyle) {
                    PlayerBackgroundStyle.DEFAULT -> stringResource(R.string.defaultText)
                    PlayerBackgroundStyle.TRANSPARENT -> stringResource(R.string.transparent)
                    PlayerBackgroundStyle.BLUR -> stringResource(R.string.album_art_blur)
                    PlayerBackgroundStyle.GRADIENT -> stringResource(R.string.gradientBackground)
                }
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.selectPlayerBackground)) },
                    description = { Text(valueText) },
                    icon = {
                        Icon(
                            imageVector = when (playerBackgroundStyle) {
                                PlayerBackgroundStyle.DEFAULT -> Icons.Filled.Layers
                                PlayerBackgroundStyle.GRADIENT -> Icons.Filled.Gradient // Nuevo icono
                                else -> Icons.Filled.LayersClear
                            },
                            contentDescription = null,
                            tint = MaterialTheme.colorScheme.primary
                        )
                    },
                    onClick = { editingPreference = EditingPreferenceKey.PLAYER_BACKGROUND }
                )
            }
        }
    }
}

enum class DarkMode {
    ON, OFF, AUTO
}

enum class NavigationTab {
    HOME, SONG, ARTIST, ALBUM, PLAYLIST
}

enum class PlayerTextAlignment {
    SIDED, CENTER
}