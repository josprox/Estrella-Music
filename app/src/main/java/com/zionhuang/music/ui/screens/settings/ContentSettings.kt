package com.zionhuang.music.ui.screens.settings

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
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
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zionhuang.innertube.utils.parseCookieString
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.constants.AccountChannelHandleKey
import com.zionhuang.music.constants.AccountEmailKey
import com.zionhuang.music.constants.AccountNameKey
import com.zionhuang.music.constants.ContentCountryKey
import com.zionhuang.music.constants.ContentLanguageKey
import com.zionhuang.music.constants.CountryCodeToName
import com.zionhuang.music.constants.EnableKugouKey
import com.zionhuang.music.constants.EnableLrcLibKey
import com.zionhuang.music.constants.HideExplicitKey
import com.zionhuang.music.constants.InnerTubeCookieKey
import com.zionhuang.music.constants.LanguageCodeToName
import com.zionhuang.music.constants.ProxyEnabledKey
import com.zionhuang.music.constants.ProxyTypeKey
import com.zionhuang.music.constants.ProxyUrlKey
import com.zionhuang.music.constants.SYSTEM_DEFAULT
import com.zionhuang.music.ui.component.EditTextDialog
import com.zionhuang.music.ui.component.EnumSelectionDialog
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.component.SettingsHeader
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberEnumPreference
import com.zionhuang.music.utils.rememberPreference
import java.net.Proxy
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.input.nestedscroll.nestedScroll
import com.zionhuang.music.ui.component.CustomSwitchPreference

private enum class ContentEditingKey {
    LANGUAGE,
    COUNTRY,
    PROXY_TYPE
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ContentSettings(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    // --- ESTADOS DE LAS PREFERENCIAS ---
    val accountName by rememberPreference(AccountNameKey, "")
    val accountEmail by rememberPreference(AccountEmailKey, "")
    val accountChannelHandle by rememberPreference(AccountChannelHandleKey, "")
    val innerTubeCookie by rememberPreference(InnerTubeCookieKey, "")
    val isLoggedIn = remember(innerTubeCookie) { "SAPISID" in parseCookieString(innerTubeCookie) }
    val (contentLanguage, onContentLanguageChange) = rememberPreference(key = ContentLanguageKey, defaultValue = "system")
    val (contentCountry, onContentCountryChange) = rememberPreference(key = ContentCountryKey, defaultValue = "system")
    val (hideExplicit, onHideExplicitChange) = rememberPreference(key = HideExplicitKey, defaultValue = false)
    val (enableKugou, onEnableKugouChange) = rememberPreference(key = EnableKugouKey, defaultValue = true)
    val (enableLrcLib, onEnableLrcLibChange) = rememberPreference(key = EnableLrcLibKey, defaultValue = true)
    val (proxyEnabled, onProxyEnabledChange) = rememberPreference(key = ProxyEnabledKey, defaultValue = false)
    val (proxyType, onProxyTypeChange) = rememberEnumPreference(key = ProxyTypeKey, defaultValue = Proxy.Type.HTTP)
    val (proxyUrl, onProxyUrlChange) = rememberPreference(key = ProxyUrlKey, defaultValue = "host:port")

    // --- ESTADOS PARA CONTROLAR DIÁLOGOS ---
    var editingKey by remember { mutableStateOf<ContentEditingKey?>(null) }
    var showProxyUrlDialog by remember { mutableStateOf(false) }

    // --- LÓGICA DE DIÁLOGOS ---
    if (showProxyUrlDialog) {
        EditTextDialog(
            title = stringResource(R.string.proxy_url),
            initialValue = proxyUrl,
            onValueChange = onProxyUrlChange,
            onDismiss = { showProxyUrlDialog = false }
        )
    }

    editingKey?.let { key ->
        when (key) {
            ContentEditingKey.LANGUAGE -> EnumSelectionDialog(
                title = stringResource(R.string.content_language),
                options = listOf(SYSTEM_DEFAULT) + LanguageCodeToName.keys.toList(),
                selectedOption = contentLanguage,
                onOptionSelected = onContentLanguageChange,
                optionText = { LanguageCodeToName.getOrElse(it) { stringResource(R.string.system_default) } },
                onDismiss = { editingKey = null }
            )
            ContentEditingKey.COUNTRY -> EnumSelectionDialog(
                title = stringResource(R.string.content_country),
                options = listOf(SYSTEM_DEFAULT) + CountryCodeToName.keys.toList(),
                selectedOption = contentCountry,
                onOptionSelected = onContentCountryChange,
                optionText = { CountryCodeToName.getOrElse(it) { stringResource(R.string.system_default) } },
                onDismiss = { editingKey = null }
            )
            ContentEditingKey.PROXY_TYPE -> EnumSelectionDialog(
                title = stringResource(R.string.proxy_type),
                options = Proxy.Type.entries,
                selectedOption = proxyType,
                onOptionSelected = onProxyTypeChange,
                optionText = { it.name },
                onDismiss = { editingKey = null }
            )
        }
    }

    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            LargeTopAppBar(
                title = { Text(stringResource(R.string.content)) },
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

            item {
                Card(
                    onClick = { navController.navigate("login") },
                    modifier = Modifier.padding(16.dp),
                    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surfaceContainerHigh)
                ) {
                    Row(
                        modifier = Modifier.padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        Icon(painter = painterResource(R.drawable.person), contentDescription = null, modifier = Modifier.size(32.dp))
                        Column(modifier = Modifier.weight(1f)) {
                            Text(text = if (isLoggedIn) accountName else stringResource(R.string.login), style = MaterialTheme.typography.titleMedium)
                            val description = if (isLoggedIn) {
                                accountEmail.takeIf { it.isNotEmpty() } ?: accountChannelHandle.takeIf { it.isNotEmpty() }
                            } else null
                            if (description != null) {
                                Text(
                                    text = description,
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                    maxLines = 1,
                                    overflow = TextOverflow.Ellipsis
                                )
                            }
                        }
                    }
                }
            }

            item { SettingsHeader(title = stringResource(R.string.content_preferences)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.content_language)) },
                    description = { Text(LanguageCodeToName.getOrElse(contentLanguage) { stringResource(R.string.system_default) }) },
                    icon = { Icon(painterResource(R.drawable.language), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { editingKey = ContentEditingKey.LANGUAGE }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.content_country)) },
                    description = { Text(CountryCodeToName.getOrElse(contentCountry) { stringResource(R.string.system_default) }) },
                    icon = { Icon(painterResource(R.drawable.location_on), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { editingKey = ContentEditingKey.COUNTRY }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.hide_explicit)) },
                    icon = { Icon(painterResource(R.drawable.explicit), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onHideExplicitChange(!hideExplicit) },
                    trailingContent = { CustomSwitchPreference(checked = hideExplicit, onCheckedChange = onHideExplicitChange) }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = stringResource(R.string.lyrics_sources)) }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.enable_lrclib)) },
                    icon = { Icon(painterResource(R.drawable.lyrics), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onEnableLrcLibChange(!enableLrcLib) },
                    trailingContent = { CustomSwitchPreference(checked = enableLrcLib, onCheckedChange = onEnableLrcLibChange) }
                )
            }
            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.enable_kugou)) },
                    icon = { Icon(painterResource(R.drawable.lyrics), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onEnableKugouChange(!enableKugou) },
                    trailingContent = { CustomSwitchPreference(checked = enableKugou, onCheckedChange = onEnableKugouChange) }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            item { SettingsHeader(title = "Proxy") }

            item {
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.enable_proxy)) },
                    icon = { Icon(painterResource(R.drawable.wifi_proxy), null, tint = MaterialTheme.colorScheme.primary) },
                    onClick = { onProxyEnabledChange(!proxyEnabled) },
                    trailingContent = { CustomSwitchPreference(checked = proxyEnabled, onCheckedChange = onProxyEnabledChange) }
                )
            }
            item {
                AnimatedVisibility(proxyEnabled) {
                    Column(modifier = Modifier.padding(start = 16.dp)) { // Añadimos padding para alinear
                        ExpressivePreferenceEntry(
                            title = { Text(stringResource(R.string.proxy_type)) },
                            description = { Text(proxyType.name) },
                            icon = { Spacer(Modifier.size(24.dp)) },
                            onClick = { editingKey = ContentEditingKey.PROXY_TYPE }
                        )
                        ExpressivePreferenceEntry(
                            title = { Text(stringResource(R.string.proxy_url)) },
                            description = { Text(proxyUrl) },
                            icon = { Spacer(Modifier.size(24.dp)) },
                            onClick = { showProxyUrlDialog = true }
                        )
                    }
                }
            }
        }
    }
}