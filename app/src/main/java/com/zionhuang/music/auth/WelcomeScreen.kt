package com.zionhuang.music.ui.auth

import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.zionhuang.music.R
import com.zionhuang.music.auth.AuthEvent
import com.zionhuang.music.auth.AuthMode
import com.zionhuang.music.auth.AuthViewModel
import com.zionhuang.music.ui.onboarding.AnimatedBlobsBackground
import kotlinx.coroutines.launch

// === NUEVO: para backups en login ===
import com.josprox.jossredconnect.services.BackupService
import com.zionhuang.music.viewmodels.BackupRestoreViewModel
import org.dotenv.vault.dotenvVault
import com.zionhuang.music.BuildConfig

@Composable
fun WelcomeRoute(
    onAuthSuccess: () -> Unit,
    onSkip: () -> Unit = {},
    viewModel: AuthViewModel = hiltViewModel()
) {
    val state by viewModel.state.collectAsState()
    val snackbarHost = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()
    val context = LocalContext.current

    // ViewModel de backup
    val backupVm: BackupRestoreViewModel = hiltViewModel()

    // === Cargar credenciales desde env.vault (igual que en Settings) ===
    val (baseUrl, apiToken) = remember {
        var url = ""
        var token = ""
        try {
            val (dirPath, fileName) = ensureVaultOnDisk(context, "env.vault")
            val dv = dotenvVault(BuildConfig.DOTENV_KEY) {
                directory = dirPath
                filename = fileName
            }
            url = dv.get("JOSSRED").orEmpty()       // debe incluir /api/
            token = dv.get("JOSSRED_API").orEmpty() // header X-JossRed-Auth
        } catch (_: Exception) { }
        url to token
    }

    val backupService = remember(baseUrl, apiToken) {
        BackupService(
            context = context,
            baseUrl = baseUrl,
            apiToken = apiToken
        )
    }

    // Estado del diálogo de restauración
    var showRestoreDialog by rememberSaveable { mutableStateOf(false) }
    var latestBackupName by rememberSaveable { mutableStateOf<String?>(null) }
    var latestBackupDate by rememberSaveable { mutableStateOf<String?>(null) }
    var dialogChecking by rememberSaveable { mutableStateOf(false) }
    var dialogRestoring by rememberSaveable { mutableStateOf(false) }
    var dialogError by rememberSaveable { mutableStateOf<String?>(null) }

    // Manejo de eventos de auth
    LaunchedEffect(Unit) {
        viewModel.events.collect { ev ->
            when (ev) {
                is AuthEvent.ShowMessageText -> scope.launch { snackbarHost.showSnackbar(ev.text) }
                is AuthEvent.ShowMessageRes -> scope.launch { snackbarHost.showSnackbar(context.getString(ev.resId)) }
                AuthEvent.Success -> {
                    // 1) Al autenticar, intentar ver si hay backup
                    dialogChecking = true
                    dialogError = null
                    latestBackupName = null
                    latestBackupDate = null

                    val result = backupService.listBackups()
                    result.fold(onSuccess = { list ->
                        val candidates = list.files
                            .filter { it.app_name == "jossmusic_backup" }
                            .sortedByDescending { it.updated_at ?: it.created_at ?: "" }
                        val first = candidates.firstOrNull()
                        if (first != null) {
                            latestBackupName = first.name
                            latestBackupDate = first.updated_at ?: first.created_at
                            showRestoreDialog = true  // 2) Mostrar diálogo
                        } else {
                            // No hay backup -> entrar directo
                            onAuthSuccess()
                        }
                        dialogChecking = false
                    }, onFailure = {
                        // En caso de error al listar, seguimos sin bloquear el login
                        dialogChecking = false
                        onAuthSuccess()
                    })
                }
            }
        }
    }

    // UI principal
    Scaffold(
        snackbarHost = { SnackbarHost(snackbarHost) },
        containerColor = Color.Transparent
    ) { padding ->
        Box(Modifier.fillMaxSize().padding(padding)) {
            AnimatedBlobsBackground(Modifier.fillMaxSize())

            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(horizontal = 24.dp),
                contentAlignment = Alignment.Center
            ) {
                AnimatedContent(
                    targetState = state.mode,
                    transitionSpec = { fadeIn() togetherWith fadeOut() },
                    label = "auth_mode"
                ) { mode ->
                    when (mode) {
                        AuthMode.WELCOME -> WelcomeView(
                            onLogin = { viewModel.setMode(AuthMode.LOGIN) },
                            onRegister = { viewModel.setMode(AuthMode.REGISTER) },
                            onSkip = onSkip
                        )
                        AuthMode.LOGIN -> LoginForm(
                            isLoading = state.isLoading,
                            onBack = { viewModel.setMode(AuthMode.WELCOME) },
                            onForgotPassword = { viewModel.setMode(AuthMode.FORGOT) },
                            onLogin = { email, pass -> viewModel.login(email, pass) }
                        )
                        AuthMode.REGISTER -> RegisterForm(
                            isLoading = state.isLoading,
                            onBack = { viewModel.setMode(AuthMode.WELCOME) },
                            onSubmit = { u, n, l, e, p, c, agree ->
                                viewModel.register(u, n, l, e, p, c, agree)
                            }
                        )
                        AuthMode.FORGOT -> ForgotPasswordForm(
                            isLoading = state.isLoading,
                            onBack = { viewModel.setMode(AuthMode.LOGIN) },
                            onSend = { email -> viewModel.sendRecoveryEmail(email) }
                        )
                    }
                }
            }

            // === Diálogo de restauración (solo si hay backup) ===
            if (showRestoreDialog) {
                AlertDialog(
                    onDismissRequest = { /* Obliga a elegir, pero podrías permitir dismiss */ },
                    title = { Text(stringResource(R.string.backup_restore)) },
                    text = {
                        Column {
                            if (dialogChecking) {
                                Text(stringResource(R.string.backup_restore_checking))
                                LinearProgressIndicator(Modifier.fillMaxWidth().padding(top = 8.dp))
                            } else if (dialogRestoring) {
                                Text(stringResource(R.string.backup_restore_restoring))
                                LinearProgressIndicator(Modifier.fillMaxWidth().padding(top = 8.dp))
                            } else if (dialogError != null) {
                                Text(dialogError!!, color = MaterialTheme.colorScheme.error)
                            } else {
                                val msg = buildString {
                                    append(stringResource(R.string.backup_restore_found_msg)) // “There is a cloud backup from”
                                    if (!latestBackupDate.isNullOrBlank()) append(" ${latestBackupDate}")
                                }
                                Text(msg)
                            }
                        }
                    },
                    confirmButton = {
                        TextButton(
                            enabled = !dialogChecking && !dialogRestoring && latestBackupName != null,
                            onClick = {
                                // Restaurar ahora
                                val name = latestBackupName ?: return@TextButton
                                dialogRestoring = true
                                dialogError = null
                                // Llamar restoreOnline
                                val job = scope.launch {
                                    val res = runCatching {
                                        backupVm.restoreOnline(
                                            context = context,
                                            backupService = backupService,
                                            remoteFileName = name
                                        )
                                    }
                                    dialogRestoring = false
                                    // Pase lo que pase, entrar a la app
                                    showRestoreDialog = false
                                    onAuthSuccess()
                                    if (res.isFailure) {
                                        // Si quieres, también puedes mostrar un snackbar aquí
                                    }
                                }
                            }
                        ) {
                            Text(stringResource(R.string.restore_now))
                        }
                    },
                    dismissButton = {
                        TextButton(
                            enabled = !dialogChecking && !dialogRestoring,
                            onClick = {
                                // Entrar sin restaurar
                                showRestoreDialog = false
                                onAuthSuccess()
                            }
                        ) {
                            Text(stringResource(R.string.maybeLater))
                        }
                    }
                )
            }
        }
    }
}

/* ---------- Welcome ----------- */
@Composable
fun WelcomeView(
    onLogin: () -> Unit,
    onRegister: () -> Unit,
    onSkip: () -> Unit
) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier.fillMaxWidth()
    ) {
        Spacer(Modifier.height(48.dp))
        Text(
            text = stringResource(R.string.welcome_title),
            color = Color.White,
            style = MaterialTheme.typography.headlineLarge.copy(fontWeight = FontWeight.Bold),
            textAlign = TextAlign.Center
        )
        Spacer(Modifier.height(12.dp))
        Text(
            text = stringResource(R.string.welcome_subtitle),
            color = Color.White.copy(alpha = 0.75f),
            textAlign = TextAlign.Center
        )
        Spacer(Modifier.height(64.dp))

        Row(modifier = Modifier.fillMaxWidth()) {
            Button(
                onClick = onLogin,
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color.White, contentColor = Color(0xFF1A1A2E)
                ),
                modifier = Modifier.weight(1f)
            ) { Text(stringResource(R.string.btn_login), fontWeight = FontWeight.Bold) }

            Spacer(Modifier.width(16.dp))

            Button(
                onClick = onRegister,
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color(0xFFE94560), contentColor = Color.White
                ),
                modifier = Modifier.weight(1f)
            ) { Text(stringResource(R.string.btn_register), fontWeight = FontWeight.Bold) }
        }

        Spacer(Modifier.height(12.dp))
        TextButton(onClick = onSkip) {
            Text(
                stringResource(R.string.btn_skip),
                color = Color.White.copy(alpha = 0.9f)
            )
        }

        Spacer(Modifier.height(60.dp))
    }
}

/* ---------- Login ----------- */
@Composable
fun LoginForm(
    isLoading: Boolean,
    onBack: () -> Unit,
    onForgotPassword: () -> Unit,
    onLogin: (email: String, password: String) -> Unit
) {
    val focus = LocalFocusManager.current
    val context = LocalContext.current
    var email by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }
    var emailError by remember { mutableStateOf<String?>(null) }
    var passError by remember { mutableStateOf<String?>(null) }

    AuthCard {
        Text(
            stringResource(R.string.login_greeting),
            color = Color.White,
            style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold)
        )
        Spacer(Modifier.height(24.dp))

        OutlinedTextField(
            value = email,
            onValueChange = { email = it; emailError = null },
            label = { Text(stringResource(R.string.label_email)) },
            isError = emailError != null,
            supportingText = {
                if (emailError != null) Text(emailError!!, color = MaterialTheme.colorScheme.error)
            },
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
            singleLine = true,
            colors = authTextFieldColors(),
            modifier = Modifier.fillMaxWidth()
        )
        Spacer(Modifier.height(16.dp))
        OutlinedTextField(
            value = pass,
            onValueChange = { pass = it; passError = null },
            label = { Text(stringResource(R.string.label_password)) },
            isError = passError != null,
            supportingText = {
                if (passError != null) Text(passError!!, color = MaterialTheme.colorScheme.error)
            },
            singleLine = true,
            visualTransformation = PasswordVisualTransformation(),
            colors = authTextFieldColors(),
            modifier = Modifier.fillMaxWidth()
        )

        Spacer(Modifier.height(24.dp))
        Button(
            onClick = {
                val okEmail = email.isNotBlank() && "@" in email && !email.contains(" ")
                val okPass = pass.isNotBlank()
                emailError = if (!okEmail) context.getString(R.string.error_invalid_email) else null
                passError = if (!okPass) context.getString(R.string.error_empty_password) else null
                if (okEmail && okPass) {
                    focus.clearFocus()
                    onLogin(email, pass)
                }
            },
            enabled = !isLoading,
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFE94560), contentColor = Color.White
            ),
            modifier = Modifier.fillMaxWidth()
        ) { Text(if (isLoading) stringResource(R.string.btn_entering) else stringResource(R.string.btn_login)) }

        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            TextButton(onClick = onBack) { Text(stringResource(R.string.btn_back), color = Color.White.copy(alpha = 0.7f)) }
            TextButton(onClick = onForgotPassword) {
                Text(stringResource(R.string.forgot_password), color = Color.White.copy(alpha = 0.7f))
            }
        }
    }
}

/* ---------- Register ----------- */
@Composable
fun RegisterForm(
    isLoading: Boolean,
    onBack: () -> Unit,
    onSubmit: (String, String, String, String, String, String, Boolean) -> Unit
) {
    val focus = LocalFocusManager.current
    val scroll = rememberScrollState()
    val context = LocalContext.current

    var user by remember { mutableStateOf("") }
    var name by remember { mutableStateOf("") }
    var last by remember { mutableStateOf("") }
    var email by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }
    var confirm by remember { mutableStateOf("") }
    var agree by remember { mutableStateOf(true) }

    var userErr by remember { mutableStateOf<String?>(null) }
    var nameErr by remember { mutableStateOf<String?>(null) }
    var lastErr by remember { mutableStateOf<String?>(null) }
    var emailErr by remember { mutableStateOf<String?>(null) }
    var passErr by remember { mutableStateOf<String?>(null) }
    var confirmErr by remember { mutableStateOf<String?>(null) }

    AuthCard {
        Column(Modifier.verticalScroll(scroll)) {
            Text(
                stringResource(R.string.register_title),
                color = Color.White,
                style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Black)
            )
            Spacer(Modifier.height(24.dp))

            OutlinedTextField(
                user, { user = it; userErr = null },
                label = { Text(stringResource(R.string.label_username)) },
                isError = userErr != null,
                supportingText = {
                    if (userErr != null) Text(userErr!!, color = MaterialTheme.colorScheme.error)
                },
                singleLine = true,
                colors = authTextFieldColors(),
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(Modifier.height(16.dp))
            OutlinedTextField(
                name, { name = it; nameErr = null },
                label = { Text(stringResource(R.string.label_firstname)) },
                isError = nameErr != null,
                supportingText = {
                    if (nameErr != null) Text(nameErr!!, color = MaterialTheme.colorScheme.error)
                },
                singleLine = true,
                colors = authTextFieldColors(),
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(Modifier.height(16.dp))
            OutlinedTextField(
                last, { last = it; lastErr = null },
                label = { Text(stringResource(R.string.label_lastname)) },
                isError = lastErr != null,
                supportingText = {
                    if (lastErr != null) Text(lastErr!!, color = MaterialTheme.colorScheme.error)
                },
                singleLine = true,
                colors = authTextFieldColors(),
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(Modifier.height(16.dp))
            OutlinedTextField(
                email, { email = it; emailErr = null },
                label = { Text(stringResource(R.string.label_email)) },
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
                isError = emailErr != null,
                supportingText = {
                    if (emailErr != null) Text(emailErr!!, color = MaterialTheme.colorScheme.error)
                },
                singleLine = true,
                colors = authTextFieldColors(),
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(Modifier.height(16.dp))
            OutlinedTextField(
                pass, { pass = it; passErr = null },
                label = { Text(stringResource(R.string.label_password)) },
                visualTransformation = PasswordVisualTransformation(),
                isError = passErr != null,
                supportingText = {
                    if (passErr != null) Text(passErr!!, color = MaterialTheme.colorScheme.error)
                },
                singleLine = true,
                colors = authTextFieldColors(),
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(Modifier.height(8.dp))
            PasswordStrengthIndicator(password = pass)
            Spacer(Modifier.height(16.dp))
            OutlinedTextField(
                confirm, { confirm = it; confirmErr = null },
                label = { Text(stringResource(R.string.label_confirm_password)) },
                visualTransformation = PasswordVisualTransformation(),
                isError = confirmErr != null,
                supportingText = {
                    if (confirmErr != null) Text(confirmErr!!, color = MaterialTheme.colorScheme.error)
                },
                singleLine = true,
                colors = authTextFieldColors(),
                modifier = Modifier.fillMaxWidth()
            )

            Spacer(Modifier.height(16.dp))
            Row(verticalAlignment = Alignment.CenterVertically) {
                Checkbox(checked = agree, onCheckedChange = { agree = it })
                Text(stringResource(R.string.accept_terms), color = Color.White)
            }

            Spacer(Modifier.height(24.dp))
            Button(
                onClick = {
                    val okUser = user.isNotBlank() && !user.contains(" ") &&
                            user.matches(Regex("^[a-zA-Z0-9_]+$"))
                    val okName = name.isNotBlank()
                    val okLast = last.isNotBlank()
                    val okEmail = email.isNotBlank() && "@" in email
                    val okPass = pass.length >= 8 &&
                            pass.any { it.isUpperCase() } &&
                            pass.any { it.isLowerCase() } &&
                            pass.any { it.isDigit() } &&
                            pass.any { it in "!@#$%^&*(),.?\":{}|<>" }
                    val okConfirm = confirm == pass

                    userErr    = if (!okUser)   context.getString(R.string.error_invalid_username) else null
                    nameErr    = if (!okName)   context.getString(R.string.error_empty_firstname) else null
                    lastErr    = if (!okLast)   context.getString(R.string.error_empty_lastname) else null
                    emailErr   = if (!okEmail)  context.getString(R.string.error_invalid_email_format) else null
                    passErr    = if (!okPass)   context.getString(R.string.error_invalid_password_requirements) else null
                    confirmErr = if (!okConfirm) context.getString(R.string.error_password_mismatch) else null

                    if (okUser && okName && okLast && okEmail && okPass && okConfirm) {
                        focus.clearFocus()
                        onSubmit(user, name, last, email, pass, confirm, agree)
                    }
                },
                enabled = !isLoading,
                colors = ButtonDefaults.buttonColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    contentColor = Color.White
                ),
                modifier = Modifier.fillMaxWidth()
            ) { Text(if (isLoading) stringResource(R.string.btn_creating) else stringResource(R.string.btn_register)) }

            TextButton(onClick = onBack) {
                Text(stringResource(R.string.btn_back), color = MaterialTheme.colorScheme.primary)
            }
        }
    }
}

/* ---------- Forgot ----------- */
@Composable
fun ForgotPasswordForm(
    isLoading: Boolean,
    onBack: () -> Unit,
    onSend: (email: String) -> Unit
) {
    val focus = LocalFocusManager.current
    val context = LocalContext.current
    var email by remember { mutableStateOf("") }
    var emailErr by remember { mutableStateOf<String?>(null) }

    AuthCard {
        Text(
            stringResource(R.string.forgot_title),
            color = Color.White,
            style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold)
        )
        Spacer(Modifier.height(24.dp))
        OutlinedTextField(
            value = email,
            onValueChange = { email = it; emailErr = null },
            label = { Text(stringResource(R.string.label_email)) },
            singleLine = true,
            isError = emailErr != null,
            supportingText = {
                if (emailErr != null) Text(emailErr!!, color = MaterialTheme.colorScheme.error)
            },
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
            colors = authTextFieldColors(),
            modifier = Modifier.fillMaxWidth()
        )
        Spacer(Modifier.height(24.dp))
        Button(
            onClick = {
                val ok = email.isNotBlank() && "@" in email
                emailErr = if (!ok) context.getString(R.string.error_invalid_email) else null
                if (ok) { focus.clearFocus(); onSend(email) }
            },
            enabled = !isLoading,
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFE94560), contentColor = Color.White
            ),
            modifier = Modifier.fillMaxWidth()
        ) { Text(if (isLoading) stringResource(R.string.btn_sending) else stringResource(R.string.btn_send_recovery)) }

        TextButton(onClick = onBack) {
            Text(stringResource(R.string.btn_back), color = Color.White.copy(alpha = 0.7f))
        }
    }
}

/* ---------- Helpers ----------- */
@Composable
private fun AuthCard(content: @Composable ColumnScope.() -> Unit) {
    Column(
        modifier = Modifier
            .clip(RoundedCornerShape(24.dp))
            .background(Color.White.copy(alpha = 0.08f))
            .border(
                BorderStroke(1.dp, Color.White.copy(alpha = 0.18f)),
                RoundedCornerShape(24.dp)
            )
            .padding(horizontal = 24.dp, vertical = 28.dp)
            .fillMaxWidth()
    ) { content() }
}

@Composable
private fun authTextFieldColors(): TextFieldColors =
    TextFieldDefaults.colors(
        focusedTextColor = Color.White,
        unfocusedTextColor = Color.White,
        disabledTextColor = Color.White.copy(alpha = 0.6f),

        focusedContainerColor = Color.White.copy(alpha = 0.08f),
        unfocusedContainerColor = Color.White.copy(alpha = 0.06f),
        disabledContainerColor = Color.White.copy(alpha = 0.04f),

        cursorColor = Color.White,
        focusedIndicatorColor = Color.White.copy(alpha = 0.70f),
        unfocusedIndicatorColor = Color.White.copy(alpha = 0.35f),
        disabledIndicatorColor = Color.White.copy(alpha = 0.20f),
        errorIndicatorColor = MaterialTheme.colorScheme.error,

        focusedLabelColor = Color.White,
        unfocusedLabelColor = Color.White.copy(alpha = 0.70f),
        disabledLabelColor = Color.White.copy(alpha = 0.6f),
        errorLabelColor = MaterialTheme.colorScheme.error,

        focusedPlaceholderColor = Color.White.copy(alpha = 0.55f),
        unfocusedPlaceholderColor = Color.White.copy(alpha = 0.55f),
        disabledPlaceholderColor = Color.White.copy(alpha = 0.40f),
        errorPlaceholderColor = Color.White.copy(alpha = 0.55f),

        focusedSupportingTextColor = Color.White.copy(alpha = 0.85f),
        unfocusedSupportingTextColor = Color.White.copy(alpha = 0.85f),
        disabledSupportingTextColor = Color.White.copy(alpha = 0.6f),
        errorSupportingTextColor = MaterialTheme.colorScheme.error,
    )

@Composable
fun PasswordStrengthIndicator(
    password: String,
    validColor: Color = MaterialTheme.colorScheme.primary,
    invalidColor: Color = Color.Gray
) {
    val reqLen    = stringResource(R.string.password_req_length)
    val reqUpper  = stringResource(R.string.password_req_upper)
    val reqLower  = stringResource(R.string.password_req_lower)
    val reqDigit  = stringResource(R.string.password_req_digit)
    val reqSpec   = stringResource(R.string.password_req_special)

    val checks = remember(password) {
        listOf(
            reqLen   to (password.length >= 8),
            reqUpper to password.any { it.isUpperCase() },
            reqLower to password.any { it.isLowerCase() },
            reqDigit to password.any { it.isDigit() },
            reqSpec  to password.any { it in "!@#$%^&*(),.?\":{}|<>" }
        )
    }

    Column(Modifier.fillMaxWidth()) {
        checks.forEach { (label, ok) ->
            Row(verticalAlignment = Alignment.CenterVertically, modifier = Modifier.padding(vertical = 2.dp)) {
                Box(
                    modifier = Modifier
                        .size(10.dp)
                        .clip(RoundedCornerShape(50))
                        .background(if (ok) validColor else invalidColor)
                )
                Spacer(Modifier.width(8.dp))
                Text(label, color = Color.White.copy(alpha = 0.9f))
            }
        }
    }
}

/* === Util para leer env.vault desde assets al cache y que dotenvVault lo lea vía ruta absoluta === */
private fun ensureVaultOnDisk(context: android.content.Context, assetFileName: String): Pair<String, String> {
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
