package com.zionhuang.music.di

import android.content.Context
import com.josprox.jossredconnect.services.AuthService
import com.zionhuang.music.utils.SecureKeys
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Named
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object SecretsModule {

    @Provides
    @Singleton
    fun provideAuthService(@ApplicationContext context: Context): AuthService =
        SecureKeys.createAuthService(context)

    @Provides
    @Named("OneSignalAppId")
    fun provideOneSignalAppId(): String = SecureKeys.oneSignalAppId

    @Provides
    @Named("StreamingHeadJossRed")
    fun provideStreamingHead(): String = SecureKeys.getJossRedKey()

    @Provides
    @Named("JossRedBaseUrl")
    fun provideJossRedBaseUrl(): String = SecureKeys.jossRedBaseUrl


    @Provides @Named("HomepageUrl")
    fun provideHomepageUrl(): String = SecureKeys.homepageUrl
}
