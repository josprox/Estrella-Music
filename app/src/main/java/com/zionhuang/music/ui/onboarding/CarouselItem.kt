package com.zionhuang.music.ui.onboarding

import androidx.annotation.DrawableRes

data class CarouselItem(
    @DrawableRes val imageRes: Int,
    val title: String,
    val description: String
)
