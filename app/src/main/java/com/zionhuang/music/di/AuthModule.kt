// app/src/main/java/com/zionhuang/music/di/AuthModule.kt
package com.zionhuang.music.di

import com.zionhuang.music.auth.AuthRepository
import com.zionhuang.music.auth.AuthRepositoryImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
abstract class AuthBindModule {
    @Binds
    @Singleton
    abstract fun bindAuthRepository(impl: AuthRepositoryImpl): AuthRepository
}
