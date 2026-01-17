package com.zionhuang.music.ui.auth

import android.annotation.SuppressLint
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
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
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

import com.zionhuang.music.BuildConfig
import java.util.Locale

@SuppressLint("LocalContextGetResourceValueCall")
@Composable
fun WelcomeRoute(
    onAuthSuccess: () -> Unit,
    onSkip: () -> Unit = {}, // compatibilidad, ya no se usa
    viewModel: AuthViewModel = hiltViewModel()
) {
    val state by viewModel.state.collectAsState()
    val snackbarHost = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()
    val context = LocalContext.current

    // ViewModel de backup
    val backupVm: BackupRestoreViewModel = hiltViewModel()

    // === Cargar credenciales desde SecureKeys (centralizado) ===
    val baseUrl = com.zionhuang.music.utils.SecureKeys.jossRedBaseUrl
    val apiToken = com.zionhuang.music.utils.SecureKeys.jossRedApiToken

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
                    dialogChecking = true
                    dialogError = null
                    latestBackupName = null
                    latestBackupDate = null

                    val result = backupService.listBackups()
                    result.fold(onSuccess = { list ->
                        val candidates = list.files
                            .filter { it.app_name == "jossmusic_backup" }
                            .sortedByDescending { it.name } // Sort by name (contains timestamp)
                        val first = candidates.firstOrNull()
                        if (first != null) {
                            latestBackupName = first.name
                            // Fallback: parse date from filename if server fields are null
                            val rawDate = first.updated_at ?: first.created_at
                            latestBackupDate = if (!rawDate.isNullOrBlank()) {
                                rawDate
                            } else {
                                parseDateFromFilename(first.name)
                            }
                            showRestoreDialog = true
                        } else {
                            onAuthSuccess()
                        }
                        dialogChecking = false
                    }, onFailure = {
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
                            onRegister = { viewModel.setMode(AuthMode.REGISTER) }
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
                    onDismissRequest = { /* Obliga a elegir */ },
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
                                    append(stringResource(R.string.backup_restore_found_msg))
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
                                    showRestoreDialog = false
                                    onAuthSuccess()
                                    if (res.isFailure) {
                                        // opcional: snackbar
                                    }
                                }
                            }
                        ) { Text(stringResource(R.string.restore_now)) }
                    },
                    dismissButton = {
                        TextButton(
                            enabled = !dialogChecking && !dialogRestoring,
                            onClick = {
                                showRestoreDialog = false
                                onAuthSuccess()
                            }
                        ) { Text(stringResource(R.string.maybeLater)) }
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
) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp)
    ) {
        Spacer(Modifier.weight(1f))
        
        // Logo or Hero Text
        Text(
            text = stringResource(R.string.welcome_title),
            color = Color.White,
            style = MaterialTheme.typography.displayMedium.copy(
                fontWeight = FontWeight.ExtraBold,
                letterSpacing = (-1).sp
            ),
            textAlign = TextAlign.Center
        )
        
        Spacer(Modifier.height(16.dp))
        
        Text(
            text = stringResource(R.string.welcome_subtitle),
            color = Color.White.copy(alpha = 0.8f),
            style = MaterialTheme.typography.bodyLarge,
            textAlign = TextAlign.Center,
            modifier = Modifier.padding(horizontal = 16.dp)
        )
        
        Spacer(Modifier.weight(1f))
        
        Column(
            verticalArrangement = Arrangement.spacedBy(16.dp),
            modifier = Modifier.fillMaxWidth()
        ) {
            Button(
                onClick = onLogin,
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color.White,
                    contentColor = Color.Black
                ),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp)
            ) {
                Text(
                    text = stringResource(R.string.btn_login),
                    style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold)
                )
            }

            Button(
                onClick = onRegister,
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color(0xFFE94560),
                    contentColor = Color.White
                ),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp)
            ) {
                Text(
                    text = stringResource(R.string.btn_register),
                    style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold)
                )
            }
        }
        
        Spacer(Modifier.height(48.dp))
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
    var email by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }
    var emailErr by remember { mutableStateOf<Int?>(null) }
    var passErr by remember { mutableStateOf<Int?>(null) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(onClick = onBack) {
                Icon(
                    painter = painterResource(R.drawable.arrow_back), // Ensure this resource exists or use Icons.AutoMirrored.Filled.ArrowBack
                    contentDescription = stringResource(R.string.btn_back),
                    tint = Color.White
                )
            }
        }
        
        Spacer(Modifier.height(32.dp))
        
        Text(
            text = stringResource(R.string.login_greeting),
            color = Color.White,
            style = MaterialTheme.typography.headlineMedium.copy(fontWeight = FontWeight.Bold),
            textAlign = TextAlign.Center
        )
        
        Spacer(Modifier.height(48.dp))
        
        Column(verticalArrangement = Arrangement.spacedBy(20.dp)) {
            OutlinedTextField(
                value = email,
                onValueChange = {
                    email = it.replace(" ", "")
                    emailErr = errEmail(email) ?: if (email.isBlank()) null else null
                },
                label = { Text(stringResource(R.string.label_email)) },
                isError = emailErr != null,
                supportingText = { emailErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
                singleLine = true,
                colors = authTextFieldColors(),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier.fillMaxWidth()
            )
            
            Column {
                OutlinedTextField(
                    value = pass,
                    onValueChange = {
                        pass = noSpaces(it)
                        passErr = if (pass.isBlank()) null else null
                    },
                    label = { Text(stringResource(R.string.label_password)) },
                    isError = passErr != null,
                    supportingText = { passErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                    singleLine = true,
                    visualTransformation = PasswordVisualTransformation(),
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password),
                    colors = authTextFieldColors(),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier.fillMaxWidth()
                )
                
                TextButton(
                    onClick = onForgotPassword,
                    modifier = Modifier.align(Alignment.End)
                ) {
                    Text(
                        text = stringResource(R.string.forgot_password),
                        color = Color.White.copy(alpha = 0.7f),
                        style = MaterialTheme.typography.bodyMedium
                    )
                }
            }
        }

        Spacer(Modifier.height(32.dp))
        
        Button(
            onClick = {
                val okEmail = email.isNotBlank() && "@" in email && !email.contains(" ")
                val okPass = pass.isNotBlank()
                emailErr = if (!okEmail) R.string.error_invalid_email else null
                passErr = if (!okPass) R.string.error_empty_password else null
                if (okEmail && okPass) {
                    focus.clearFocus()
                    onLogin(email, pass)
                }
            },
            enabled = !isLoading,
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFE94560),
                contentColor = Color.White
            ),
            shape = RoundedCornerShape(12.dp),
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
        ) {
            if (isLoading) {
                CircularProgressIndicator(
                    modifier = Modifier.size(24.dp),
                    color = Color.White,
                    strokeWidth = 2.dp
                )
            } else {
                Text(
                    text = stringResource(R.string.btn_login),
                    style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold)
                )
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

    var user by remember { mutableStateOf("") }
    var name by remember { mutableStateOf("") }
    var last by remember { mutableStateOf("") }
    var email by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }
    var confirm by remember { mutableStateOf("") }
    var agree by remember { mutableStateOf(true) }

    var userErr by remember { mutableStateOf<Int?>(null) }
    var nameErr by remember { mutableStateOf<Int?>(null) }
    var lastErr by remember { mutableStateOf<Int?>(null) }
    var emailErr by remember { mutableStateOf<Int?>(null) }
    var passErr by remember { mutableStateOf<Int?>(null) }
    var confirmErr by remember { mutableStateOf<Int?>(null) }
    var termsErr by remember { mutableStateOf<Int?>(null) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(scroll)
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(onClick = onBack) {
                Icon(
                    painter = painterResource(R.drawable.arrow_back),
                    contentDescription = stringResource(R.string.btn_back),
                    tint = Color.White
                )
            }
        }

        Spacer(Modifier.height(16.dp))

        Text(
            text = stringResource(R.string.register_title),
            color = Color.White,
            style = MaterialTheme.typography.headlineMedium.copy(fontWeight = FontWeight.Bold),
            textAlign = TextAlign.Center
        )

        Spacer(Modifier.height(32.dp))

        Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
            // Username
            OutlinedTextField(
                value = user,
                onValueChange = {
                    val sanitized = sanitizeUsernameInline(it)
                    user = sanitized
                    userErr = errUsername(user)
                },
                label = { Text(stringResource(R.string.label_username)) },
                isError = userErr != null,
                supportingText = { userErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Ascii),
                colors = authTextFieldColors(),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier.fillMaxWidth()
            )

            // Nombres
            OutlinedTextField(
                value = name,
                onValueChange = {
                    val lettersAndSpaces = it.replace(Regex("[^\\p{L}\\p{M}\\s]"), "")
                    name = toTitleCaseWordsStreaming(lettersAndSpaces, Locale.getDefault())
                    nameErr = errHumanName(name)
                },
                label = { Text(stringResource(R.string.label_firstname)) },
                isError = nameErr != null,
                supportingText = { nameErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                singleLine = true,
                colors = authTextFieldColors(),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier.fillMaxWidth()
            )

            // Apellidos
            OutlinedTextField(
                value = last,
                onValueChange = {
                    val lettersAndSpaces = it.replace(Regex("[^\\p{L}\\p{M}\\s]"), "")
                    last = toTitleCaseWordsStreaming(lettersAndSpaces, Locale.getDefault())
                    lastErr = errHumanName(last)
                },
                label = { Text(stringResource(R.string.label_lastname)) },
                isError = lastErr != null,
                supportingText = { lastErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                singleLine = true,
                colors = authTextFieldColors(),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier.fillMaxWidth()
            )

            // Email
            OutlinedTextField(
                value = email,
                onValueChange = {
                    email = it.replace(" ", "")
                    emailErr = errEmail(email)
                },
                label = { Text(stringResource(R.string.label_email)) },
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
                isError = emailErr != null,
                supportingText = { emailErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                singleLine = true,
                colors = authTextFieldColors(),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier.fillMaxWidth()
            )

            // Password
            OutlinedTextField(
                value = pass,
                onValueChange = {
                    pass = noSpaces(it)
                    passErr = errPass(pass)
                    confirmErr = errConfirm(pass, confirm)
                },
                label = { Text(stringResource(R.string.label_password)) },
                visualTransformation = PasswordVisualTransformation(),
                isError = passErr != null,
                supportingText = { passErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password),
                colors = authTextFieldColors(),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier.fillMaxWidth()
            )

            PasswordStrengthIndicator(password = pass)

            // Confirmación
            OutlinedTextField(
                value = confirm,
                onValueChange = {
                    confirm = noSpaces(it)
                    confirmErr = errConfirm(pass, confirm)
                },
                label = { Text(stringResource(R.string.label_confirm_password)) },
                visualTransformation = PasswordVisualTransformation(),
                isError = confirmErr != null,
                supportingText = { confirmErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
                singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password),
                colors = authTextFieldColors(),
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier.fillMaxWidth()
            )
            
            Row(
                verticalAlignment = Alignment.CenterVertically, 
                modifier = Modifier.fillMaxWidth()
            ) {
                Checkbox(
                    checked = agree, 
                    onCheckedChange = {
                        agree = it
                        termsErr = null
                    },
                    colors = CheckboxDefaults.colors(
                        checkedColor = Color(0xFFE94560),
                        uncheckedColor = Color.White.copy(alpha = 0.6f),
                        checkmarkColor = Color.White
                    )
                )
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = stringResource(R.string.accept_terms),
                        color = Color.White,
                        style = MaterialTheme.typography.bodyMedium
                    )
                    termsErr?.let {
                        Text(
                            text = stringResource(it),
                            color = MaterialTheme.colorScheme.error,
                            style = MaterialTheme.typography.labelSmall
                        )
                    }
                }
            }
        }

        Spacer(Modifier.height(32.dp))

        Button(
            onClick = {
                // Validaciones finales
                val okUser = isValidUsername(user)
                val okName = isValidHumanName(name.trim())
                val okLast = isValidHumanName(last.trim())
                val okEmail = isValidEmailStrict(email)
                val okPass = isStrongPasswordNoSpaces(pass)
                val okConfirm = confirm == pass
                val okTerms = agree

                userErr    = if (!okUser)    R.string.error_invalid_username else null
                nameErr    = if (!okName)    R.string.error_empty_firstname else null
                lastErr    = if (!okLast)    R.string.error_empty_lastname else null
                emailErr   = if (!okEmail)   R.string.error_invalid_email_format else null
                passErr    = if (!okPass)    R.string.error_invalid_password_requirements else null
                confirmErr = if (!okConfirm) R.string.error_password_mismatch else null
                termsErr   = if (!okTerms)   R.string.error_accept_terms else null

                if (okUser && okName && okLast && okEmail && okPass && okConfirm && okTerms) {
                    focus.clearFocus()
                    onSubmit(user, name.trim(), last.trim(), email, pass, confirm, agree)
                }
            },
            enabled = !isLoading,
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFE94560),
                contentColor = Color.White
            ),
            shape = RoundedCornerShape(12.dp),
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
        ) {
            if (isLoading) {
                CircularProgressIndicator(
                    modifier = Modifier.size(24.dp),
                    color = Color.White,
                    strokeWidth = 2.dp
                )
            } else {
                Text(
                    text = stringResource(R.string.btn_register),
                    style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold)
                )
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
    var email by remember { mutableStateOf("") }
    var emailErr by remember { mutableStateOf<Int?>(null) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(onClick = onBack) {
                Icon(
                    painter = painterResource(R.drawable.arrow_back),
                    contentDescription = stringResource(R.string.btn_back),
                    tint = Color.White
                )
            }
        }

        Spacer(Modifier.height(32.dp))
        
        Text(
            stringResource(R.string.forgot_title),
            color = Color.White,
            style = MaterialTheme.typography.headlineMedium.copy(fontWeight = FontWeight.Bold),
            textAlign = TextAlign.Center
        )
        
        Spacer(Modifier.height(48.dp))
        
        OutlinedTextField(
            value = email,
            onValueChange = {
                email = it.replace(" ", "")
                emailErr = errEmail(email)
            },
            label = { Text(stringResource(R.string.label_email)) },
            singleLine = true,
            isError = emailErr != null,
            supportingText = { emailErr?.let { Text(stringResource(it), color = MaterialTheme.colorScheme.error) } },
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
            colors = authTextFieldColors(),
            shape = RoundedCornerShape(12.dp),
            modifier = Modifier.fillMaxWidth()
        )
        
        Spacer(Modifier.height(32.dp))
        
        Button(
            onClick = {
                val ok = email.isNotBlank() && "@" in email && !email.contains(" ")
                emailErr = if (!ok) R.string.error_invalid_email else null
                if (ok) { focus.clearFocus(); onSend(email) }
            },
            enabled = !isLoading,
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFE94560),
                contentColor = Color.White
            ),
            shape = RoundedCornerShape(12.dp),
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
        ) {
            if (isLoading) {
                 CircularProgressIndicator(
                    modifier = Modifier.size(24.dp), 
                    color = Color.White, 
                    strokeWidth = 2.dp
                )
            } else {
                Text(stringResource(R.string.btn_send_recovery), style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold))
            }
        }
    }
}

/* ---------- Helpers UI ----------- */
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
        errorTextColor = MaterialTheme.colorScheme.error,

        // 👉 Fondo transparente como solicitado
        focusedContainerColor = Color.Transparent,
        unfocusedContainerColor = Color.Transparent,
        disabledContainerColor = Color.Transparent,
        errorContainerColor = Color.Transparent,

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



/* ---------- Helpers de saneo/validación dura ----------- */

// Quita todos los espacios (para username/password)
private fun noSpaces(s: String): String =
    s.replace(Regex("\\s+"), "")

// Colapsa espacios múltiples a uno y recorta
private fun collapseSpaces(s: String): String =
    s.replace(Regex("\\s+"), " ").trim()

// Nombres/Apellidos: solo letras (incluye acentos) y un espacio simple entre palabras.
// Sin puntos ni guiones, sin dobles espacios. (2-100 chars)
private fun isValidHumanName(name: String): Boolean {
    val re = Regex("^(?!.* {2,})(?=.{2,100}$)[\\p{L}\\p{M}]+(?: [\\p{L}\\p{M}]+)*\$", RegexOption.IGNORE_CASE)
    return re.matches(name)
}

// Username: 3-30, [a-z0-9._-], sin espacios, no empieza/termina con ._- , sin "..", "__", "--"
private fun sanitizeUsernameInline(username: String): String {
    var u = username.trim().lowercase()
    u = u.replace(Regex("\\s+"), "")
    u = u.replace(Regex("[._-]{2,}"), "-")             // colapsa repeticiones
    u = u.replace(Regex("^[._-]+|[._-]+\$"), "")       // quita ._- al inicio/fin
    return u
}
private fun isValidUsername(username: String): Boolean {
    if (username.length !in 3..30) return false
    if (!Regex("^[a-z0-9._-]+\$").matches(username)) return false
    if (Regex("(\\.|_|-){2,}").containsMatchIn(username)) return false
    if (Regex("^[._-]|[._-]\$").containsMatchIn(username)) return false
    return true
}

// Email fuerte (sin espacios; estructura general user@domain.tld)
private fun isValidEmailStrict(email: String): Boolean {
    if (email.isBlank() || email.contains(" ")) return false
    val re = Regex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]{2,}\$")
    return re.matches(email)
}

// Password fuerte y sin espacios
private fun isStrongPasswordNoSpaces(pw: String): Boolean {
    if (pw.length < 8) return false
    if (pw.any { it.isWhitespace() }) return false
    val hasUpper = pw.any { it.isUpperCase() }
    val hasLower = pw.any { it.isLowerCase() }
    val hasDigit = pw.any { it.isDigit() }
    val hasSym   = pw.any { it in "!@#\$%^&*(),.?\":{}|<>_-=+[];'`~\\/|" }
    return hasUpper && hasLower && hasDigit && hasSym
}

// Title Case en streaming
private fun toTitleCaseWordsStreaming(
    input: String,
    locale: Locale = Locale.getDefault()
): String {
    val hadTrailingSpace = input.endsWith(" ")
    val lowered = input.lowercase(locale)
    val noLeading = lowered.trimStart()
    val collapsed = noLeading.replace(Regex(" {2,}"), " ")
    val parts = collapsed.split(' ')
    val titled = parts.joinToString(" ") { word ->
        if (word.isEmpty()) "" else word.replaceFirstChar { ch -> ch.titlecase(locale) }
    }
    return if (hadTrailingSpace && titled.isNotEmpty() && !titled.endsWith(" ")) {
        "$titled "
    } else {
        titled
    }
}

/* ---------- Helpers de error en vivo: DEVUELVEN Int? (IDs) ----------- */

private fun parseDateFromFilename(filename: String): String? {
    // Expected: jossmusic_yyyyMMdd_HHmmss.backup
    val regex = Regex(".*_(\\d{8})_(\\d{6})\\.backup$")
    val match = regex.find(filename) ?: return null
    val (datePart, timePart) = match.destructured
    if (datePart.length != 8 || timePart.length != 6) return null

    // Format: YYYY-MM-DD HH:mm:ss
    return "${datePart.substring(0, 4)}-${datePart.substring(4, 6)}-${datePart.substring(6, 8)} " +
           "${timePart.substring(0, 2)}:${timePart.substring(2, 4)}:${timePart.substring(4, 6)}"
}

private fun errUsername(u: String): Int? =
    when {
        u.isBlank() -> null // no molestes en vacío
        !isValidUsername(u) -> R.string.invalidUsername
        else -> null
    }

private fun errHumanName(n: String): Int? =
    when {
        n.isBlank() -> null
        !isValidHumanName(n.trim()) -> R.string.errorHumanName
        else -> null
    }

private fun errEmail(e: String): Int? =
    when {
        e.isBlank() -> null
        !isValidEmailStrict(e) -> R.string.error_invalid_email
        else -> null
    }

private fun errPass(p: String): Int? =
    when {
        p.isBlank() -> null
        !isStrongPasswordNoSpaces(p) -> R.string.error_invalid_password_requirements
        else -> null
    }

private fun errConfirm(p: String, c: String): Int? =
    when {
        c.isBlank() -> null
        p != c -> R.string.error_password_mismatch
        else -> null
    }
