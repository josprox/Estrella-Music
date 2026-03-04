package com.zionhuang.music.viewmodels

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zionhuang.innertube.YouTube
import com.zionhuang.innertube.pages.PodcastPage
import com.zionhuang.music.utils.reportException
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class PodcastViewModel @Inject constructor(
    savedStateHandle: SavedStateHandle,
) : ViewModel() {
    val podcastId = savedStateHandle.get<String>("podcastId")!!
    
    private val _podcastPage = MutableStateFlow<PodcastPage?>(null)
    val podcastPage = _podcastPage.asStateFlow()

    init {
        viewModelScope.launch {
            YouTube.podcast(podcastId).onSuccess {
                _podcastPage.value = it
            }.onFailure {
                reportException(it)
            }
        }
    }
}
