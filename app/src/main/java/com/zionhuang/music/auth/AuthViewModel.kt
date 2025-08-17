package com.zionhuang.music.auth

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

enum class AuthMode { WELCOME, LOGIN, REGISTER, FORGOT }

data class AuthUiState(
    val mode: AuthMode = AuthMode.WELCOME,
    val isLoading: Boolean = false
)

sealed interface AuthEvent {
    data class ShowMessage(val text: String) : AuthEvent
    object Success : AuthEvent
}

@HiltViewModel
class AuthViewModel @Inject constructor(
    private val repo: AuthRepository
) : ViewModel() {

    private val _state = MutableStateFlow(AuthUiState())
    val state = _state.asStateFlow()

    private val _events = MutableSharedFlow<AuthEvent>()
    val events = _events.asSharedFlow()

    fun setMode(mode: AuthMode) {
        _state.value = _state.value.copy(mode = mode)
    }

    fun login(email: String, password: String) = viewModelScope.launch {
        _state.value = _state.value.copy(isLoading = true)
        val res = repo.login(email.trim(), password.trim())
        _state.value = _state.value.copy(isLoading = false)
        if (res.success) {
            _events.emit(AuthEvent.Success) // AuthService ya guardó token en prefs
        } else {
            val msg = when (res.message) {
                "EMAIL_NOT_FOUND" -> "El correo no existe"
                "INVALID_PASSWORD" -> "Contraseña incorrecta"
                null, "" -> "Error al iniciar sesión"
                else -> res.message!!
            }
            _events.emit(AuthEvent.ShowMessage(msg))
        }
    }

    fun register(
        username: String,
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        confirm: String,
        agree: Boolean
    ) = viewModelScope.launch {
        if (!agree) {
            _events.emit(AuthEvent.ShowMessage("Debes aceptar el acceso a tus datos en Joss Red."))
            return@launch
        }
        if (password != confirm) {
            _events.emit(AuthEvent.ShowMessage("No coinciden las contraseñas."))
            return@launch
        }
        _state.value = _state.value.copy(isLoading = true)
        val res = repo.register(username, firstName, lastName, email, password)
        _state.value = _state.value.copy(isLoading = false)
        if (res.success) {
            _events.emit(AuthEvent.ShowMessage(res.message ?: "Registro exitoso"))
            _state.value = _state.value.copy(mode = AuthMode.LOGIN)
        } else {
            _events.emit(AuthEvent.ShowMessage(res.message ?: "Error en el registro"))
        }
    }

    fun sendRecoveryEmail(email: String) = viewModelScope.launch {
        _state.value = _state.value.copy(isLoading = true)
        val res = repo.sendRecoveryEmail(email.trim())
        _state.value = _state.value.copy(isLoading = false)
        _events.emit(AuthEvent.ShowMessage(res.message ?: ""))
        if (res.success) _state.value = _state.value.copy(mode = AuthMode.LOGIN)
    }
}
