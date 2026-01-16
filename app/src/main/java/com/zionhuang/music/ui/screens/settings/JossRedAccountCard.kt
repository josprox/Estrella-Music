package com.zionhuang.music.ui.screens.settings

import android.content.Intent
import android.net.Uri
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.josprox.jossredconnect.services.AuthService
import com.zionhuang.music.BuildConfig
import com.zionhuang.music.R
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.dotenv.vault.dotenvVault
import org.json.JSONObject
import timber.log.Timber

@Composable
fun JossRedAccountCard(
    modifier: Modifier = Modifier,
    baseUrl: String,
    apiToken: String,
    onLoginClick: (() -> Unit)? = null,
) {
    val ctx = LocalContext.current
    val scope = rememberCoroutineScope()

    // Internal .env loading removed. Using passed parameters.

    val auth = remember(baseUrl, apiToken) {
        // Ensure baseUrl has trailing slash for AuthService if not present
        val effectiveUrl = if (baseUrl.endsWith("/")) baseUrl else "$baseUrl/"
        AuthService(ctx.applicationContext, effectiveUrl, apiToken)
    }

    var loading by remember { mutableStateOf(true) }
    var error by remember { mutableStateOf<String?>(null) }
    var user by remember { mutableStateOf<JSONObject?>(null) }

    fun refresh() {
        scope.launch {
            loading = true
            error = null
            user = null
            try {
                val check = withContext(Dispatchers.IO) { auth.checkToken() }
                if (check["success"] == true && check["valid"] == true) {
                    val prof = withContext(Dispatchers.IO) { auth.fetchUserProfile() }
                    if (prof["success"] == true) {
                        user = prof["user"] as? JSONObject
                    } else {
                        error = (prof["message"] as? String) ?: ctx.getString(R.string.error_profile)
                    }
                } else {
                    error = check["message"] as? String
                }
            } catch (e: Exception) {
                Timber.e(e)
                error = ctx.getString(R.string.error_connection)
            } finally {
                loading = false
            }
        }
    }

    LaunchedEffect(Unit) { refresh() }

    Card(
        modifier = modifier.fillMaxWidth(),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceContainer
        )
    ) {
        Column(Modifier.padding(16.dp)) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(
                    text = stringResource(R.string.account_joss_red),
                    style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold),
                    modifier = Modifier.weight(1f)
                )
                IconButton(onClick = { refresh() }) {
                    Icon(
                        painter = painterResource(id = R.drawable.replay),
                        contentDescription = stringResource(R.string.refresh)
                    )
                }
            }

            when {
                loading -> {
                    Spacer(Modifier.height(8.dp))
                    LinearProgressIndicator(modifier = Modifier.fillMaxWidth())
                    Spacer(Modifier.height(8.dp))
                    Text(stringResource(R.string.checking_session), color = MaterialTheme.colorScheme.onSurfaceVariant)
                }

                user == null -> {
                    Text(
                        text = error ?: stringResource(R.string.error_no_session),
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Spacer(Modifier.height(12.dp))
                    Button(
                        onClick = { onLoginClick?.invoke() },
                        enabled = onLoginClick != null
                    ) {
                        Text(stringResource(R.string.btn_login))
                    }
                }

                else -> {
                    val first = user?.optString("first_name").orEmpty()
                    val last = user?.optString("last_name").orEmpty()
                    val email = user?.optString("email").orEmpty()
                    val username = user?.optString("username").orEmpty()

                    Spacer(Modifier.height(8.dp))
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Box(
                            modifier = Modifier
                                .size(56.dp)
                                .clip(CircleShape)
                                .background(MaterialTheme.colorScheme.primary.copy(alpha = 0.15f)),
                            contentAlignment = Alignment.Center
                        ) {
                            Text(
                                (first.ifBlank { username }.take(1)).uppercase(),
                                color = MaterialTheme.colorScheme.primary,
                                style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold)
                            )
                        }
                        Spacer(Modifier.width(12.dp))
                        Column {
                            Text(
                                text = listOf(first, last).filter { it.isNotBlank() }.joinToString(" ").ifBlank { username },
                                style = MaterialTheme.typography.titleMedium
                            )
                            Text(
                                text = email.ifBlank { "—" },
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                    }

                    Spacer(Modifier.height(16.dp))
                    Row(
                        horizontalArrangement = Arrangement.spacedBy(12.dp),
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        OutlinedButton(
                            onClick = {
                                val url = "https://play.google.com/store/apps/details?id=com.josprox.jossestrada"
                                ctx.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
                            },
                            modifier = Modifier.weight(1f)
                        ) {
                            Text(stringResource(R.string.btn_edit_profile))
                        }
                        Button(
                            onClick = {
                                scope.launch {
                                    loading = true
                                    withContext(Dispatchers.IO) { auth.logout() }
                                    user = null
                                    loading = false
                                }
                            },
                            colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.error),
                            modifier = Modifier.weight(1f)
                        ) {
                            Text(stringResource(R.string.logout))
                        }
                    }
                }
            }
        }
    }
}
