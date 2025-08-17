package com.zionhuang.music.ui.screens.settings

import android.content.Context
import android.content.SharedPreferences
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
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalContext
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
import com.zionhuang.music.ui.component.CustomSwitchPreference
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

    // 🔐 Detecta si hay sesión iniciada (token válido)
    val isLoggedIn by rememberIsLoggedIn()

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

            // ---- Tarjeta de cuenta / acceso ----
            item {
                JossRedAccountCard(
                    modifier = Modifier.padding(16.dp),
                    onLoginClick = { navController.navigate("auth/welcome") }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            // Mensaje de bienvenida
            item {
                Text(
                    text = stringResource(R.string.jossredSettings_welcome),
                    style = MaterialTheme.typography.bodyLarge,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(16.dp)
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            // Preferencia: habilitar proxy Joss Red
            item {
                val enabled = isLoggedIn
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
                    onClick = {
                        if (enabled) onJossRedEnabledChange(!jossRedEnabled)
                    },
                    trailingContent = {
                        CustomSwitchPreference(
                            checked = jossRedEnabled,
                            onCheckedChange = { if (enabled) onJossRedEnabledChange(it) },
                            isEnabled = enabled // 👈 requiere el parámetro 'enabled' en tu CustomSwitchPreference
                        )
                    },
                    modifier = Modifier.alpha(if (enabled) 1f else 0.5f) // feedback visual
                )
            }

            // Preferencia: reproducir con JR
            item {
                val enabled = isLoggedIn
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
                    onClick = {
                        if (enabled) onJossRedMultimediaChange(!jossRedMultimedia)
                    },
                    trailingContent = {
                        CustomSwitchPreference(
                            checked = jossRedMultimedia,
                            onCheckedChange = { if (enabled) onJossRedMultimediaChange(it) },
                            isEnabled = enabled
                        )
                    },
                    modifier = Modifier.alpha(if (enabled) 1f else 0.5f)
                )
            }

            // Preferencia: auto-skip
            item {
                val enabled = isLoggedIn
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
                    onClick = {
                        if (enabled) onAutoSkipNextOnErrorChange(!autoSkipNextOnError)
                    },
                    trailingContent = {
                        CustomSwitchPreference(
                            checked = autoSkipNextOnError,
                            onCheckedChange = { if (enabled) onAutoSkipNextOnErrorChange(it) },
                            isEnabled = enabled
                        )
                    },
                    modifier = Modifier.alpha(if (enabled) 1f else 0.5f)
                )
            }
        }
    }
}

/* ---------------- Helpers ---------------- */

@Composable
private fun rememberIsLoggedIn(): State<Boolean> {
    val context = LocalContext.current
    val state = remember { mutableStateOf(false) }

    // Revisa al entrar
    LaunchedEffect(Unit) {
        state.value = context.isTokenValidNow()
    }

    // Escucha cambios en SharedPreferences para actualizar en vivo (login/logout)
    DisposableEffect(Unit) {
        val prefs = context.getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
        val listener = SharedPreferences.OnSharedPreferenceChangeListener { _, key ->
            if (key == "jwt_token" || key == "token_expiration") {
                state.value = context.isTokenValidNow()
            }
        }
        prefs.registerOnSharedPreferenceChangeListener(listener)
        onDispose { prefs.unregisterOnSharedPreferenceChangeListener(listener) }
    }

    return state
}

private fun Context.isTokenValidNow(): Boolean {
    val prefs = getSharedPreferences("jossred_prefs", Context.MODE_PRIVATE)
    val token = prefs.getString("jwt_token", null)
    val exp = prefs.getLong("token_expiration", -1L) // segundos UNIX
    val now = System.currentTimeMillis() / 1000L
    return !token.isNullOrBlank() && exp > now
}
