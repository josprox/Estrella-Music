package com.zionhuang.music.auth

import androidx.annotation.StringRes
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject
import com.zionhuang.music.R

enum class AuthMode { WELCOME, LOGIN, REGISTER, FORGOT }

data class AuthUiState(
    val mode: AuthMode = AuthMode.WELCOME,
    val isLoading: Boolean = false
)

sealed interface AuthEvent {
    data class ShowMessageText(val text: String) : AuthEvent
    data class ShowMessageRes(@StringRes val resId: Int) : AuthEvent
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
            _events.emit(AuthEvent.Success)
        } else {
            // New logic: pass the message directly coming from Service
            val msg = res.message ?: "Login failed"
            // Optional: map specific messages if needed, otherwise show directly
            _events.emit(AuthEvent.ShowMessageText(msg))
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
            _events.emit(AuthEvent.ShowMessageRes(R.string.error_must_accept))
            return@launch
        }
        if (password != confirm) {
            _events.emit(AuthEvent.ShowMessageRes(R.string.error_password_mismatch))
            return@launch
        }
        _state.value = _state.value.copy(isLoading = true)
        val res = repo.register(username, firstName, lastName, email, password)
        _state.value = _state.value.copy(isLoading = false)
        if (res.success) {
            // Si el backend regresa mensaje, lo mostramos. Si no, mostramos el “register_success” estándar.
            _events.emit(
                if (!res.message.isNullOrBlank()) AuthEvent.ShowMessageText(res.message!!)
                else AuthEvent.ShowMessageRes(R.string.register_success)
            )
            _state.value = _state.value.copy(mode = AuthMode.LOGIN)
        } else {
            _events.emit(AuthEvent.ShowMessageRes(R.string.error_register))
        }
    }

    fun sendRecoveryEmail(email: String) = viewModelScope.launch {
        _state.value = _state.value.copy(isLoading = true)
        val res = repo.sendRecoveryEmail(email.trim())
        _state.value = _state.value.copy(isLoading = false)
        if (!res.message.isNullOrBlank()) {
            _events.emit(AuthEvent.ShowMessageText(res.message!!))
        }
        if (res.success) _state.value = _state.value.copy(mode = AuthMode.LOGIN)
    }
}
