package com.zionhuang.music.auth

data class AuthResult(
    val success: Boolean,
    val message: String? = null,
    val token: String? = null
)

interface AuthRepository {
    suspend fun login(email: String, password: String): AuthResult
    suspend fun register(
        username: String,
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ): AuthResult
    suspend fun sendRecoveryEmail(email: String): AuthResult
}
