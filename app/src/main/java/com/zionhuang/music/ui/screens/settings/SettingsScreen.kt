package com.zionhuang.music.ui.screens.settings

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.Badge
import androidx.compose.material3.BadgedBox
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.LargeTopAppBar
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.SettingsHeader
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.UpdateMainViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SettingsScreen(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
    viewModel: UpdateMainViewModel,
) {
    val uriHandler = LocalUriHandler.current

    val showUpdate by viewModel.showUpdateBadge.collectAsState()
    val latestVersion by viewModel.latestVersionName.collectAsState()
    val currentVersion by viewModel.currentVersionName.collectAsState()

    // Scaffold es la estructura base de una pantalla en Material 3
    Scaffold(
        modifier = Modifier,
        topBar = {
            LargeTopAppBar(
                title = { Text(stringResource(R.string.settings)) },
                navigationIcon = {
                    IconButton(
                        onClick = navController::navigateUp,
                        onLongClick = navController::backToMain
                    ) {
                        Icon(
                            painterResource(R.drawable.arrow_back),
                            contentDescription = "Back"
                        )
                    }
                },
                // Esto conecta el scroll de la lista con la TopAppBar
                scrollBehavior = scrollBehavior
            )
        },
        // Usamos los insets del Scaffold, que ya tienen en cuenta la TopAppBar y el sistema
        contentWindowInsets = LocalPlayerAwareWindowInsets.current
    ) { innerPadding ->
        // LazyColumn es más eficiente para listas que Column + verticalScroll
        LazyColumn(
            contentPadding = innerPadding,
            verticalArrangement = Arrangement.spacedBy(8.dp),
            // Conectamos el scroll de la LazyColumn al comportamiento de la TopAppBar
            modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection)
        ) {
            // --- Grupo: Personalización ---
            item { SettingsHeader(title = stringResource(R.string.customization)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.appearance)) },
                    icon = { Icon(painterResource(R.drawable.palette), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/appearance") }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.content)) },
                    icon = { Icon(painterResource(R.drawable.language), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/content") }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.player_and_audio)) },
                    icon = { Icon(painterResource(R.drawable.play), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/player") }
                )
            }

            // --- Grupo: Extras ---
            item { SettingsHeader(title = "Extras") }

            item {
                ExpressivePreferenceEntry(
                    title = { Text("Joss Red") },
                    icon = {
                        Icon(
                            painter = painterResource(id = R.drawable.joss_music_logo),
                            contentDescription = null,
                            modifier = Modifier.size(24.dp)
                        )
                    },
                    onClick = { navController.navigate("JossRedSettings") }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.discord_integration)) },
                    icon = { Icon(painterResource(R.drawable.discord), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/discord") }
                )
            }

            // --- Grupo: Datos y Privacidad ---
            item { SettingsHeader(title = stringResource(R.string.data_and_privacy)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.storage)) },
                    icon = { Icon(painterResource(R.drawable.storage), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/storage") }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.privacy)) },
                    icon = { Icon(painterResource(R.drawable.security), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/privacy") }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.backup_restore)) },
                    icon = { Icon(painterResource(R.drawable.restore), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/backup_restore") }
                )
            }


            // --- Grupo: Acerca de ---
            item { SettingsHeader(title = stringResource(R.string.about_the_app)) }

            // Actualización (si está disponible)
            item {
                if (showUpdate && latestVersion != null) {
                    Card(
                        onClick = { navController.navigate("settings/update") },
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.tertiaryContainer),
                        modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp)
                    ) {
                        ExpressivePreferenceEntry(
                            title = { Text(stringResource(R.string.new_version_available), style = MaterialTheme.typography.titleSmall) },
                            description = { Text(stringResource(R.string.current) + ": $currentVersion → " + stringResource(R.string.newString) + ": $latestVersion", style = MaterialTheme.typography.bodySmall) },
                            icon = { Icon(painterResource(R.drawable.update), null, tint = MaterialTheme.colorScheme.onTertiaryContainer) },
                            onClick = { navController.navigate("settings/update") },
                            trailingContent = { BadgedBox(badge = { Badge() }) {} }
                        )
                    }
                }
            }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.about)) },
                    icon = { Icon(painterResource(R.drawable.info), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { navController.navigate("settings/about") }
                )
            }

            // Donación destacada
            item {
                Card(
                    onClick = { uriHandler.openUri("https://www.paypal.me/jossestradamx") },
                    shape = MaterialTheme.shapes.large,
                    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.primaryContainer),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                ) {
                    Row(
                        modifier = Modifier.padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        Icon(
                            painterResource(id = R.drawable.joss_music_logo),
                            contentDescription = null,
                            tint = MaterialTheme.colorScheme.onPrimaryContainer,
                            modifier = Modifier
                                .size(24.dp))
                        Text(
                            text = stringResource(R.string.donate),
                            style = MaterialTheme.typography.titleMedium,
                            color = MaterialTheme.colorScheme.onPrimaryContainer
                        )
                    }
                }
            }

            // Versión actual (si no hay actualización)
            if (!showUpdate) {
                item {
                    Box(modifier = Modifier.fillMaxWidth().padding(vertical=16.dp), contentAlignment = Alignment.Center) {
                        Text(
                            text = stringResource(R.string.app_version) + ": $currentVersion",
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
            }
        }
    }
}