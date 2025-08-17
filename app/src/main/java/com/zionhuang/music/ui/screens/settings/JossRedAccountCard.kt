package com.zionhuang.music.ui.screens.settings

import android.content.Intent
import android.net.Uri
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import timber.log.Timber
import com.josprox.jossredconnect.services.AuthService
import org.dotenv.vault.dotenvVault
import com.zionhuang.music.BuildConfig
import com.zionhuang.music.R

@Composable
fun JossRedAccountCard(
    modifier: Modifier = Modifier,
    // Si tienes navegación al flujo de auth, pásala aquí:
    onLoginClick: (() -> Unit)? = null,
) {
    val ctx = LocalContext.current
    val scope = rememberCoroutineScope()

    // Carga segura del env.vault (no crashea si falta algo)
    val (baseUrl, apiToken) = remember {
        val dv = runCatching {
            dotenvVault(BuildConfig.DOTENV_KEY) {
                directory = "/assets"
                filename = "env.vault"
            }
        }.getOrNull()
        val url = runCatching { dv?.get("JOSSRED") }.getOrNull()
            ?: "" // <-- tu fallback si aplica
        val token = runCatching { dv?.get("JOSSRED_API") }.getOrNull().orEmpty()
        url to token
    }

    // Un AuthService por composición
    val auth = remember(baseUrl, apiToken) {
        AuthService(ctx.applicationContext, baseUrl, apiToken)
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
                // 1) Verifica/Refresca token si faltan <= 15 días (la lib ya lo hace)
                val check = withContext(Dispatchers.IO) { auth.checkToken() }
                if (check["success"] == true && check["valid"] == true) {
                    // 2) Trae perfil
                    val prof = withContext(Dispatchers.IO) { auth.fetchUserProfile() }
                    if (prof["success"] == true) {
                        user = prof["user"] as? JSONObject
                    } else {
                        error = (prof["message"] as? String) ?: "Error al obtener perfil"
                    }
                } else {
                    // No hay sesión o refresh falló
                    error = check["message"] as? String
                }
            } catch (e: Exception) {
                Timber.e(e)
                error = "Error de conexión"
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
                    text = "Cuenta Joss Red",
                    style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold),
                    modifier = Modifier.weight(1f)
                )
                IconButton(onClick = { refresh() }) {
                    Icon(
                        painter = painterResource(id = R.drawable.replay),
                        contentDescription = "Refrescar"
                    )
                }
            }

            when {
                loading -> {
                    Spacer(Modifier.height(8.dp))
                    LinearProgressIndicator(modifier = Modifier.fillMaxWidth())
                    Spacer(Modifier.height(8.dp))
                    Text("Verificando sesión…", color = MaterialTheme.colorScheme.onSurfaceVariant)
                }

                // Sesión NO válida o sin token
                user == null -> {
                    // Muestra mensaje y botón de iniciar sesión
                    Text(
                        text = error ?: "No has iniciado sesión.",
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Spacer(Modifier.height(12.dp))
                    Button(
                        onClick = { onLoginClick?.invoke() },
                        enabled = onLoginClick != null
                    ) {
                        Text("Iniciar sesión")
                    }
                }

                // Sesión válida
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
                    // Acciones
                    Row(
                        horizontalArrangement = Arrangement.spacedBy(12.dp),
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        OutlinedButton(
                            onClick = {
                                // “Editar perfil” -> Play Store
                                val url = "https://play.google.com/store/apps/details?id=com.josprox.jossestrada"
                                ctx.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
                            },
                            modifier = Modifier.weight(1f)
                        ) {
                            Text("Editar perfil")
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
                            Text("Cerrar sesión")
                        }
                    }
                }
            }
        }
    }
}
