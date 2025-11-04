// WrappedViewModel.kt simplificado
package com.zionhuang.music.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zionhuang.music.db.MusicDatabase
import com.zionhuang.music.db.entities.SimpleWrappedData
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import java.time.LocalDateTime
import java.time.Year
import java.time.ZoneOffset
import javax.inject.Inject

@HiltViewModel
class WrappedViewModel @Inject constructor(
    private val database: MusicDatabase
) : ViewModel() {

    private val _wrappedData = MutableStateFlow<SimpleWrappedData?>(null)
    val wrappedData: StateFlow<SimpleWrappedData?> = _wrappedData

    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading

    fun loadWrappedData(year: Int = Year.now().value) {
        _isLoading.value = true

        val startTime = LocalDateTime.of(year, 1, 1, 0, 0)
            .toInstant(ZoneOffset.UTC)
            .toEpochMilli()
        val endTime = LocalDateTime.of(year, 12, 31, 23, 59, 59)
            .toInstant(ZoneOffset.UTC)
            .toEpochMilli()

        viewModelScope.launch {
            try {
                combine(
                    database.topArtistsSimple(startTime, endTime, 10),
                    database.topSongsSimple(startTime, endTime, 20),
                    database.uniqueArtistsCount(startTime, endTime),
                    database.uniqueSongsCount(startTime, endTime),
                    database.totalListeningTime(startTime, endTime)
                ) { topArtists, topSongs, uniqueArtists, uniqueSongs, totalTime ->
                    SimpleWrappedData(
                        topArtists = topArtists,
                        topSongs = topSongs,
                        uniqueArtistsCount = uniqueArtists,
                        uniqueSongsCount = uniqueSongs,
                        totalListeningTime = totalTime ?: 0,
                        period = year.toString()
                    )
                }.collect { data ->
                    _wrappedData.value = data
                    _isLoading.value = false
                }
            } catch (e: Exception) {
                e.printStackTrace()
                _isLoading.value = false
            }
        }
    }
}