package com.zionhuang.music.ui.screens.settings

import android.content.Context
import android.content.SharedPreferences
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CloudUpload
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.LargeTopAppBar
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.State
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalLayoutDirection
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.josprox.jossredconnect.services.BackupService
import com.zionhuang.music.BuildConfig
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.constants.JossRedMultimedia
import com.zionhuang.music.ui.component.CustomSwitchPreference
import com.zionhuang.music.ui.component.ExpressivePreferenceEntry
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberPreference
import com.zionhuang.music.viewmodels.BackupRestoreViewModel
import kotlinx.coroutines.launch
import org.dotenv.vault.dotenvVault

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun JossRedSettings(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
) {
    val (jossRedMultimedia, onJossRedMultimediaChange) = rememberPreference(
        key = JossRedMultimedia, defaultValue = false
    )

    val context = LocalContext.current
    val isLoggedIn by rememberIsLoggedIn()

    // ViewModel para backup/restore
    val backupVm: BackupRestoreViewModel = hiltViewModel()

    // === Cargar credenciales desde env.vault ===
    val (baseUrl, apiToken) = remember {
        var url = ""
        var token = ""
        try {
            val (dirPath, fileName) = ensureVaultOnDisk(context, "env.vault")
            val dv = dotenvVault(BuildConfig.DOTENV_KEY) {
                directory = dirPath
                filename = fileName
            }
            url = dv.get("JOSSRED").orEmpty()
            token = dv.get("JOSSRED_API").orEmpty()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        url to token
    }

    val backupService = remember(baseUrl, apiToken) {
        BackupService(
            context = context,
            baseUrl = baseUrl,
            apiToken = apiToken
        )
    }

    // Tick para refrescar manualmente la tarjeta tras subir/restaurar
    var backupRefreshTick by rememberSaveable { mutableStateOf(0) }

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
        val layoutDirection = LocalLayoutDirection.current
        val combinedPadding = PaddingValues(
            start = innerPadding.calculateLeftPadding(layoutDirection),
            top = innerPadding.calculateTopPadding(),
            end = innerPadding.calculateRightPadding(layoutDirection),
            bottom = innerPadding.calculateBottomPadding() + 8.dp
        )

        LazyColumn(contentPadding = combinedPadding) {

            // ---- Tarjeta de cuenta / acceso ----
            item {
                JossRedAccountCard(
                    modifier = Modifier.padding(16.dp),
                    onLoginClick = { navController.navigate("auth/welcome") }
                )
            }

            item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }

            // Mensaje
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

            // Preferencias varias...

            item {
                val enabled = isLoggedIn
                ExpressivePreferenceEntry(
                    title = { Text(stringResource(R.string.playSongJR)) },
                    description = { Text(stringResource(R.string.playSongJRDesc)) },
                    icon = {
                        Icon(
                            painter = painterResource(R.drawable.music_note),
                            contentDescription = null,
                            tint = MaterialTheme.colorScheme.primary
                        )
                    },
                    onClick = { if (enabled) onJossRedMultimediaChange(!jossRedMultimedia) },
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


            // ---- Tarjeta: Respaldo en la nube ----
            item(key = "backup_cloud_card") {
                BackupCloudCard(
                    isLoggedIn = isLoggedIn,
                    backupService = backupService,
                    backupVm = backupVm,
                    refreshSignal = backupRefreshTick, // <- control explícito
                    onRequestRefreshDone = { /* opcional */ },
                    onAfterSuccessfulAction = {
                        // fuerza un reload explícito tras subir/restaurar
                        backupRefreshTick++
                    },
                    modifier = Modifier
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                        .alpha(if (isLoggedIn) 1f else 0.6f)
                )
            }
        }
    }
}

/* ------------ Tarjeta de Backup en la nube ------------ */

@Composable
fun BackupCloudCard(
    isLoggedIn: Boolean,
    backupService: com.josprox.jossredconnect.services.BackupService,
    backupVm: com.zionhuang.music.viewmodels.BackupRestoreViewModel,
    refreshSignal: Int,
    onRequestRefreshDone: () -> Unit,
    onAfterSuccessfulAction: () -> Unit,
    modifier: Modifier = Modifier
) {
    val context = LocalContext.current
    val scope = rememberCoroutineScope()

    var hasLoaded by rememberSaveable { mutableStateOf(false) }
    var loading by rememberSaveable { mutableStateOf(false) }
    var error by rememberSaveable { mutableStateOf<String?>(null) }
    var latestName by rememberSaveable { mutableStateOf<String?>(null) }
    var latestDateText by rememberSaveable { mutableStateOf<String?>(null) }
    var isUploading by rememberSaveable { mutableStateOf(false) }
    var uploadPct by rememberSaveable { mutableStateOf(0) }
    var isRestoring by rememberSaveable { mutableStateOf(false) }

    fun loadLatest() {
        if (!isLoggedIn) {
            loading = false
            error = null
            latestName = null
            latestDateText = null
            hasLoaded = true
            return
        }
        loading = true
        error = null
        scope.launch {
            val res = backupService.listBackups()
            res.fold(onSuccess = { list ->
                val candidates = list.files
                    .filter { it.app_name == "jossmusic_backup" }
                    .sortedByDescending { it.updated_at ?: it.created_at ?: "" }
                val first = candidates.firstOrNull()
                latestName = first?.name
                latestDateText = first?.updated_at ?: first?.created_at
                loading = false
                hasLoaded = true
            }, onFailure = {
                error = it.message ?: "Error al listar respaldos"
                loading = false
                hasLoaded = true
            })
        }
    }

    LaunchedEffect(isLoggedIn) {
        if (!hasLoaded) loadLatest()
    }
    LaunchedEffect(refreshSignal) {
        loadLatest()
        onRequestRefreshDone()
    }

    Card(
        modifier = modifier,
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surfaceContainer),
        elevation = CardDefaults.cardElevation(defaultElevation = 1.dp)
    ) {
        Column(Modifier.padding(16.dp)) {
            Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth()) {
                Text(
                    text = stringResource(R.string.backup_cloud_title),
                    style = MaterialTheme.typography.titleMedium
                )
                Icon(
                    imageVector = Icons.Filled.CloudUpload,
                    contentDescription = null,
                    tint = MaterialTheme.colorScheme.primary
                )
            }

            when {
                !isLoggedIn -> {
                    Text(
                        text = stringResource(R.string.backup_cloud_login_required),
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        modifier = Modifier.padding(top = 8.dp)
                    )
                }
                !hasLoaded || loading -> {
                    LinearProgressIndicator(modifier = Modifier.padding(top = 8.dp))
                    Text(
                        text = stringResource(R.string.backup_cloud_loading),
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        modifier = Modifier.padding(top = 8.dp)
                    )
                }
                error != null -> {
                    Text(
                        text = error ?: "",
                        color = MaterialTheme.colorScheme.error,
                        modifier = Modifier.padding(top = 8.dp)
                    )
                    TextButton(onClick = { loadLatest() }) { Text(stringResource(R.string.retry)) }
                }
                latestName != null -> {
                    Text(
                        text = stringResource(R.string.backup_cloud_latest) + " " + latestName,
                        style = MaterialTheme.typography.bodyMedium,
                        modifier = Modifier.padding(top = 8.dp)
                    )
                    if (!latestDateText.isNullOrBlank()) {
                        Text(
                            text = stringResource(R.string.updated) + " " + latestDateText,
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
                else -> {
                    Text(
                        text = stringResource(R.string.backup_cloud_empty),
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        modifier = Modifier.padding(top = 8.dp)
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                Button(
                    onClick = {
                        if (!isLoggedIn || isUploading || isRestoring) return@Button
                        isUploading = true
                        uploadPct = 0
                        scope.launch {
                            backupVm.backupOnline(
                                context = context,
                                backupService = backupService,
                                onProgress = { up, total ->
                                    uploadPct = if (total > 0) ((up * 100) / total).toInt() else 0
                                }
                            )
                            isUploading = false
                            onAfterSuccessfulAction()
                        }
                    },
                    enabled = isLoggedIn && !isUploading && !isRestoring
                ) {
                    if (isUploading) {
                        CircularProgressIndicator(
                            modifier = Modifier.size(18.dp),
                            strokeWidth = 2.dp
                        )
                        Spacer(Modifier.width(8.dp))
                        Text(stringResource(R.string.backup_cloud_uploading) + " $uploadPct%")
                    } else {
                        Text(stringResource(R.string.update_now))
                    }
                }

                OutlinedButton(
                    onClick = {
                        val name = latestName ?: return@OutlinedButton
                        if (!isLoggedIn || isUploading || isRestoring) return@OutlinedButton
                        isRestoring = true
                        scope.launch {
                            try {
                                backupVm.restoreOnline(
                                    context = context,
                                    backupService = backupService,
                                    remoteFileName = name
                                )
                                onAfterSuccessfulAction()
                            } finally {
                                isRestoring = false
                            }
                        }
                    },
                    enabled = isLoggedIn && (latestName != null) && !isUploading && !isRestoring
                ) {
                    if (isRestoring) {
                        CircularProgressIndicator(
                            modifier = Modifier.size(18.dp),
                            strokeWidth = 2.dp
                        )
                        Spacer(Modifier.width(8.dp))
                        Text(stringResource(R.string.backup_cloud_restoring))
                    } else {
                        Text(stringResource(R.string.restore))
                    }
                }
            }
        }
    }
}

/* ------------ Helpers ------------ */

private fun ensureVaultOnDisk(context: Context, assetFileName: String): Pair<String, String> {
    val cacheDir = context.cacheDir
    val outFile = java.io.File(cacheDir, assetFileName)
    if (!outFile.exists()) {
        context.assets.open(assetFileName).use { input ->
            java.io.FileOutputStream(outFile).use { output ->
                input.copyTo(output)
            }
        }
    }
    return cacheDir.absolutePath to assetFileName
}

@Composable
private fun rememberIsLoggedIn(): State<Boolean> {
    val context = LocalContext.current
    val state = remember { mutableStateOf(false) }
    LaunchedEffect(Unit) { state.value = context.isTokenValidNow() }
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
    val exp = prefs.getLong("token_expiration", -1L)
    val now = System.currentTimeMillis() / 1000L
    return !token.isNullOrBlank() && exp > now
}
