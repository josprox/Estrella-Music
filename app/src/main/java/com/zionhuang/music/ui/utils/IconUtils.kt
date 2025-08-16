package com.zionhuang.music.ui.utils

import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.graphics.vector.rememberVectorPainter
import androidx.compose.ui.res.painterResource
import com.zionhuang.music.ui.component.IconResult

@Composable
fun iconResultToPainter(icon: IconResult): Painter =
    when (icon) {
        is IconResult.Vector -> rememberVectorPainter(icon.icon)
        is IconResult.Drawable -> painterResource(id = icon.resId)
    }
