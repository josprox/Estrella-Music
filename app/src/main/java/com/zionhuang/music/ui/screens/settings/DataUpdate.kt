package com.zionhuang.music.ui.screens.settings

import android.content.Intent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Error
import androidx.compose.material3.AssistChip
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.core.net.toUri
import androidx.navigation.NavController
import com.halilibo.richtext.markdown.Markdown
import com.halilibo.richtext.ui.material3.RichText
import com.zionhuang.music.BuildConfig
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.utils.UpdateMainViewModel
import com.zionhuang.music.utils.Updater
import kotlinx.coroutines.launch
import org.dotenv.vault.dotenvVault

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DataUpdate(
    navController: NavController,
    scrollBehavior: TopAppBarScrollBehavior,
    viewModel: UpdateMainViewModel
) {
    val showUpdate by viewModel.showUpdateBadge.collectAsState()

    // Manejo de estados para la carga de datos
    val releaseState = remember { mutableStateOf<ReleaseState>(ReleaseState.Loading) }

    val coroutineScope = rememberCoroutineScope()
    LaunchedEffect(Unit) {
        coroutineScope.launch {
            Updater.getLatestReleaseDetails()
                .onSuccess { details -> releaseState.value = ReleaseState.Success(details) }
                .onFailure { error -> releaseState.value = ReleaseState.Error(error.localizedMessage ?: "Unknown error") }
        }
    }

    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.update_info)) },
                navigationIcon = {
                    IconButton(onClick = navController::navigateUp) {
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
        ) {
            item {
                AppHeader()
            }

            // Renderizado condicional basado en el estado de la carga
            when (val state = releaseState.value) {
                is ReleaseState.Loading -> {
                    item { LoadingState() }
                }
                is ReleaseState.Error -> {
                    item { ErrorState() }
                }
                is ReleaseState.Success -> {
                    item {
                        UpdateDetails(
                            details = state.details,
                            showUpdate = showUpdate
                        )
                    }
                }
            }
        }
    }
}

// --- Componentes de Estado ---

@Composable
private fun LoadingState() {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 32.dp),
        contentAlignment = Alignment.Center
    ) {
        CircularProgressIndicator()
    }
}

@Composable
private fun ErrorState() {
    Card(
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.errorContainer),
        modifier = Modifier.padding(16.dp)
    ) {
        Row(
            modifier = Modifier.padding(16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Icon(Icons.Default.Error, contentDescription = null, tint = MaterialTheme.colorScheme.onErrorContainer)
            Text(
                text = stringResource(R.string.error_fetching_update),
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onErrorContainer
            )
        }
    }
}

// --- Componentes de UI ---

@Composable
private fun AppHeader() {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(8.dp),
        modifier = Modifier.padding(vertical = 16.dp)
    ) {
        Image(
            painter = painterResource(R.drawable.joss_music_logo),
            contentDescription = "App Logo",
            modifier = Modifier.size(100.dp).clip(CircleShape)
        )
        Text(text = "Estrella Music", style = MaterialTheme.typography.headlineMedium)
        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            AssistChip(onClick = {}, label = { Text("Google Play") })
            AssistChip(onClick = {}, label = { Text(BuildConfig.FLAVOR.uppercase()) })
        }
    }
}

@Composable
fun UpdateDetails(details: Updater.ReleaseDetails, showUpdate: Boolean) {
    val context = LocalContext.current
    val uriHandler = LocalUriHandler.current
    val homePageWeb: String = dotenvVault(BuildConfig.DOTENV_KEY) {
        directory = "/assets"
        filename = "env.vault"
    }["HOMEPAGE"]

    Column(
        modifier = Modifier.padding(horizontal = 16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = stringResource(R.string.latestVersion_is, details.version),
            style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold
        )
        Spacer(Modifier.height(16.dp))

        // ¡AQUÍ ESTÁ EL CAMBIO!
        RichText(
            modifier = Modifier.fillMaxWidth(),
        ) {
            Markdown(content = details.description)
        }

        Spacer(Modifier.height(24.dp))

        if (showUpdate) {
            Button(
                onClick = {
                    val intent = Intent(Intent.ACTION_VIEW, details.downloadUrl.toUri())
                    context.startActivity(intent)
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(text = stringResource(R.string.download_update))
            }
        } else {
            Button(
                onClick = { uriHandler.openUri(homePageWeb) },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(text = stringResource(R.string.website_url))
            }
        }
    }
}
// --- Clase de Estado para manejar los resultados ---
private sealed class ReleaseState {
    object Loading : ReleaseState()
    data class Success(val details: Updater.ReleaseDetails) : ReleaseState()
    data class Error(val message: String) : ReleaseState()
}