package com.zionhuang.music.ui.screens.settings

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject
import javax.inject.Named

@HiltViewModel
class DiscordEnvViewModel @Inject constructor(
    @Named("HomepageUrl") val homepageUrl: String
) : ViewModel()
