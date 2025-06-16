package com.zionhuang.music.ui.screens.settings

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Gavel
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.PrivacyTip
import androidx.compose.material.icons.filled.SupportAgent
import androidx.compose.material3.AssistChip
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilledTonalIconButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zionhuang.music.BuildConfig
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.SettingsHeader
import com.zionhuang.music.ui.utils.backToMain

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AboutScreen(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    val uriHandler = LocalUriHandler.current

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.about)) },
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
        LazyColumn(
            contentPadding = innerPadding,
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            item {
                AppHeader()
            }

            item {
                Text(
                    text = stringResource(R.string.aboutScreenText1),
                    style = MaterialTheme.typography.bodyLarge,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(horizontal = 16.dp)
                )
            }

            item {
                ImportantMessageCard()
            }

            item { SettingsHeader(title = stringResource(R.string.links)) }

            item {
                Column(modifier = Modifier.padding(horizontal = 16.dp)) {
                    ExpressivePreferenceEntry(
                        title = { Text(stringResource(R.string.websupport)) },
                        description = { Text("josprox.com/soporte") },
                        icon = {
                            Icon(
                                imageVector = Icons.Default.SupportAgent,
                                contentDescription = null,
                                tint = MaterialTheme.colorScheme.primary
                            )
                        },
                        onClick = { uriHandler.openUri("https://josprox.com/soporte/") }
                    )
                    ExpressivePreferenceEntry(
                        title = { Text(stringResource(R.string.privacyPolicy)) },
                        description = { Text("josprox.com/privacidad") },
                        icon = {
                            Icon(
                                imageVector = Icons.Default.PrivacyTip,
                                contentDescription = null,
                                tint = MaterialTheme.colorScheme.primary
                            )
                        },
                        onClick = { uriHandler.openUri("https://josprox.com/privacidad/") }
                    )
                    ExpressivePreferenceEntry(
                        title = { Text(stringResource(R.string.termsConditions)) },
                        description = { Text("josprox.com/terminos-y-condiciones") },
                        icon = {
                            Icon(
                                imageVector = Icons.Default.Gavel,
                                contentDescription = null,
                                tint = MaterialTheme.colorScheme.primary
                            )
                        },
                        onClick = { uriHandler.openUri("https://josprox.com/terminos-y-condiciones/") }
                    )
                }
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = stringResource(R.string.credits)) }

            item {
                CreditEntry(
                    name = "Zion Huang (innertune)",
                    links = listOf(
                        "https://liberapay.com/zionhuang" to R.drawable.liberapay,
                        "https://www.buymeacoffee.com/zionhuang" to R.drawable.buymeacoffee
                    )
                )
            }
            item {
                CreditEntry(
                    name = "ViMusic Team",
                    links = listOf("https://github.com/vfsfitvnm/ViMusic" to R.drawable.github)
                )
            }

            item {
                Text(
                    text = stringResource(R.string.gplMessage),
                    style = MaterialTheme.typography.bodySmall,
                    textAlign = TextAlign.Center,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    modifier = Modifier.padding(16.dp)
                )
            }
        }
    }
}

@Composable
private fun AppHeader() {
    val uriHandler = LocalUriHandler.current

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(8.dp),
        modifier = Modifier.padding(vertical = 16.dp)
    ) {
        Image(
            painter = painterResource(R.drawable.joss_music_logo),
            contentDescription = "App Logo",
            modifier = Modifier
                .size(100.dp)
                .clip(CircleShape)
        )

        Text(
            text = "Joss Music",
            style = MaterialTheme.typography.headlineMedium
        )

        Text(
            text = stringResource(R.string.appByJosproxMx),
            style = MaterialTheme.typography.titleMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            AssistChip(onClick = {}, label = { Text("Github Version") })
            AssistChip(onClick = {}, label = { Text(BuildConfig.FLAVOR.uppercase()) })
            if (BuildConfig.DEBUG) {
                AssistChip(onClick = {}, label = { Text(stringResource(R.string.testMode)) })
            }
        }

        Row(horizontalArrangement = Arrangement.spacedBy(16.dp), modifier = Modifier.padding(top = 8.dp)) {
            val links = mapOf(
                R.drawable.github to "https://github.com/josprox/",
                R.drawable.facebook to "https://www.facebook.com/Josproxmx",
                R.drawable.google_play to "https://play.google.com/store/apps/dev?id=8312669195856231840"
            )
            links.forEach { (iconRes, url) ->
                FilledTonalIconButton(onClick = { uriHandler.openUri(url) }) {
                    Icon(painterResource(iconRes), contentDescription = null)
                }
            }
        }
    }
}

@Composable
private fun ImportantMessageCard() {
    Card(
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.errorContainer),
        modifier = Modifier.padding(horizontal = 16.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                Icon(
                    imageVector = Icons.Default.Info,
                    contentDescription = "Important",
                    tint = MaterialTheme.colorScheme.onErrorContainer
                )
                Text(
                    text = stringResource(R.string.importantmessage),
                    style = MaterialTheme.typography.titleMedium,
                    color = MaterialTheme.colorScheme.onErrorContainer,
                )
            }
            Text(
                text = stringResource(R.string.aboutScreenText2),
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onErrorContainer
            )
        }
    }
}

@Composable
private fun CreditEntry(name: String, links: List<Pair<String, Int>>) {
    val uriHandler = LocalUriHandler.current
    Column(
        modifier = Modifier.padding(horizontal = 16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = name, style = MaterialTheme.typography.titleSmall)
        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            links.forEach { (url, iconRes) ->
                IconButton(
                    onClick = { uriHandler.openUri(url) },
                    onLongClick = { uriHandler.openUri(url) }
                ) {
                    Icon(painterResource(iconRes), contentDescription = name)
                }
            }
        }
    }
}