package com.zionhuang.music.auth

import com.josprox.jossredconnect.services.AuthService
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class AuthRepositoryImpl @Inject constructor(
    private val service: AuthService
) : AuthRepository {

    override suspend fun login(email: String, password: String): AuthResult {
        val r = service.login(email = email, password = password)
        return AuthResult(
            success = (r["success"] as? Boolean) == true,
            message = r["message"] as? String,
            token   = r["token"] as? String
        )
    }

    override suspend fun register(
        username: String,
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ): AuthResult {
        val r = service.register(username, firstName, lastName, email, password)
        return AuthResult(
            success = (r["success"] as? Boolean) == true,
            message = r["message"] as? String,
            token   = r["token"] as? String
        )
    }

    override suspend fun sendRecoveryEmail(email: String): AuthResult {
        val r = service.sendRecoveryEmail(email)
        return AuthResult(
            success = (r["success"] as? Boolean) == true,
            message = r["message"] as? String
        )
    }
}
