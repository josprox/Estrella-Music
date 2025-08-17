package com.zionhuang.music.ui.auth

import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TextFieldColors
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.zionhuang.music.auth.AuthEvent
import com.zionhuang.music.auth.AuthMode
import com.zionhuang.music.auth.AuthViewModel
import com.zionhuang.music.ui.onboarding.AnimatedBlobsBackground
import kotlinx.coroutines.launch

@Composable
fun WelcomeRoute(
    onAuthSuccess: () -> Unit,
    onSkip: () -> Unit = {},
    viewModel: AuthViewModel = hiltViewModel()
) {
    val state by viewModel.state.collectAsState()
    val snackbarHost = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()

    LaunchedEffect(Unit) {
        viewModel.events.collect { ev ->
            when (ev) {
                is AuthEvent.ShowMessage -> scope.launch { snackbarHost.showSnackbar(ev.text) }
                AuthEvent.Success -> onAuthSuccess()
            }
        }
    }

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
            text = "Bienvenido a Joss Red",
            color = Color.White,
            style = MaterialTheme.typography.headlineLarge.copy(fontWeight = FontWeight.Bold),
            textAlign = TextAlign.Center
        )
        Spacer(Modifier.height(12.dp))
        Text(
            text = "Escucha, descarga y organiza tu música en tu dispositivo.",
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
            ) { Text("Iniciar sesión", fontWeight = FontWeight.Bold) }

            Spacer(Modifier.width(16.dp))

            Button(
                onClick = onRegister,
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color(0xFFE94560), contentColor = Color.White
                ),
                modifier = Modifier.weight(1f)
            ) { Text("Crear cuenta", fontWeight = FontWeight.Bold) }
        }

        // 👇 Tercer botón: “No iniciar sesión por ahora”
        Spacer(Modifier.height(12.dp))
        TextButton(onClick = onSkip) {
            Text(
                "No iniciar sesión por ahora",
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
    val focus = androidx.compose.ui.platform.LocalFocusManager.current
    var email by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }
    var emailError by remember { mutableStateOf<String?>(null) }
    var passError by remember { mutableStateOf<String?>(null) }

    AuthCard {
        Text(
            "¡Qué gusto verte de nuevo!",
            color = Color.White,
            style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold)
        )
        Spacer(Modifier.height(24.dp))

        OutlinedTextField(
            value = email,
            onValueChange = { email = it; emailError = null },
            label = { Text("Correo") },
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
            label = { Text("Contraseña") },
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
                emailError = if (!okEmail) "Ingresa un correo válido" else null
                passError = if (!okPass) "Ingresa tu contraseña" else null
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
        ) { Text(if (isLoading) "Entrando..." else "Iniciar sesión") }

        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            TextButton(onClick = onBack) { Text("Volver", color = Color.White.copy(alpha = 0.7f)) }
            TextButton(onClick = onForgotPassword) {
                Text("¿Olvidaste tu contraseña?", color = Color.White.copy(alpha = 0.7f))
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
    val focus = androidx.compose.ui.platform.LocalFocusManager.current
    val scroll = rememberScrollState()

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
                "Crear cuenta",
                color = Color.White,
                style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Black)
            )
            Spacer(Modifier.height(24.dp))

            OutlinedTextField(
                user, { user = it; userErr = null },
                label = { Text("Usuario") },
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
                label = { Text("Nombre") },
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
                label = { Text("Apellidos") },
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
                label = { Text("Correo") },
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
                label = { Text("Contraseña") },
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
                label = { Text("Repite la contraseña") },
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
                Text("Acepto el acceso a mis datos en Joss Red", color = Color.White)
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

                    userErr = if (!okUser) "Usuario inválido" else null
                    nameErr = if (!okName) "Ingresa tu nombre" else null
                    lastErr = if (!okLast) "Ingresa tus apellidos" else null
                    emailErr = if (!okEmail) "Correo inválido" else null
                    passErr = if (!okPass) "Revisa los requisitos de contraseña" else null
                    confirmErr = if (!okConfirm) "Las contraseñas no coinciden" else null

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
            ) { Text(if (isLoading) "Creando..." else "Crear cuenta") }

            TextButton(onClick = onBack) {
                Text("Volver", color = MaterialTheme.colorScheme.primary)
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
    val focus = androidx.compose.ui.platform.LocalFocusManager.current
    var email by remember { mutableStateOf("") }
    var emailErr by remember { mutableStateOf<String?>(null) }

    AuthCard {
        Text(
            "Recuperar contraseña",
            color = Color.White,
            style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold)
        )
        Spacer(Modifier.height(24.dp))
        OutlinedTextField(
            value = email,
            onValueChange = { email = it; emailErr = null },
            label = { Text("Correo") },
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
                emailErr = if (!ok) "Ingresa un correo válido" else null
                if (ok) { focus.clearFocus(); onSend(email) }
            },
            enabled = !isLoading,
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFE94560), contentColor = Color.White
            ),
            modifier = Modifier.fillMaxWidth()
        ) { Text(if (isLoading) "Enviando..." else "Enviar correo de recuperación") }

        TextButton(onClick = onBack) {
            Text("Volver", color = Color.White.copy(alpha = 0.7f))
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

/** Colores de TextField para inputs blancos sobre fondo oscuro */
@Composable
private fun authTextFieldColors(): TextFieldColors =
    TextFieldDefaults.colors(
        // texto
        focusedTextColor = Color.White,
        unfocusedTextColor = Color.White,
        disabledTextColor = Color.White.copy(alpha = 0.6f),

        // contenedor (fondo del TextField)
        focusedContainerColor = Color.White.copy(alpha = 0.08f),
        unfocusedContainerColor = Color.White.copy(alpha = 0.06f),
        disabledContainerColor = Color.White.copy(alpha = 0.04f),

        // cursor / borde (indicator en OutlinedTextField)
        cursorColor = Color.White,
        focusedIndicatorColor = Color.White.copy(alpha = 0.70f),
        unfocusedIndicatorColor = Color.White.copy(alpha = 0.35f),
        disabledIndicatorColor = Color.White.copy(alpha = 0.20f),
        errorIndicatorColor = MaterialTheme.colorScheme.error,

        // label
        focusedLabelColor = Color.White,
        unfocusedLabelColor = Color.White.copy(alpha = 0.70f),
        disabledLabelColor = Color.White.copy(alpha = 0.6f),
        errorLabelColor = MaterialTheme.colorScheme.error,

        // placeholders -> usar las *cuatro* variantes
        focusedPlaceholderColor = Color.White.copy(alpha = 0.55f),
        unfocusedPlaceholderColor = Color.White.copy(alpha = 0.55f),
        disabledPlaceholderColor = Color.White.copy(alpha = 0.40f),
        errorPlaceholderColor = Color.White.copy(alpha = 0.55f),

        // (opcional) supporting text
        focusedSupportingTextColor = Color.White.copy(alpha = 0.85f),
        unfocusedSupportingTextColor = Color.White.copy(alpha = 0.85f),
        disabledSupportingTextColor = Color.White.copy(alpha = 0.6f),
        errorSupportingTextColor = MaterialTheme.colorScheme.error,
    )

/* Indicador simple de fuerza de contraseña */
@Composable
fun PasswordStrengthIndicator(
    password: String,
    validColor: Color = MaterialTheme.colorScheme.primary,
    invalidColor: Color = Color.Gray
) {
    val checks = remember(password) {
        listOf(
            "8+ caracteres" to (password.length >= 8),
            "Mayúscula"      to password.any { it.isUpperCase() },
            "Minúscula"      to password.any { it.isLowerCase() },
            "Número"         to password.any { it.isDigit() },
            "Especial"       to password.any { it in "!@#$%^&*(),.?\":{}|<>" }
        )
    }

    Column(Modifier.fillMaxWidth()) {
        checks.forEach { (label, ok) ->
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.padding(vertical = 2.dp)
            ) {
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
