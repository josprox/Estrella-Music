package com.zionhuang.innertube.models.body

import com.zionhuang.innertube.models.Context
import com.zionhuang.innertube.models.Continuation
import kotlinx.serialization.Serializable

@Serializable
data class BrowseBody(
    val context: Context,
    val browseId: String?,
    val params: String?,
    val continuation: String?
)
