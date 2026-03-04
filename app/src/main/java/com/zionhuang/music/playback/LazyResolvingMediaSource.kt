package com.zionhuang.music.playback

import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.common.Timeline
import androidx.media3.exoplayer.source.CompositeMediaSource
import androidx.media3.exoplayer.source.MediaPeriod
import androidx.media3.exoplayer.source.MediaSource
import androidx.media3.exoplayer.source.SinglePeriodTimeline
import androidx.media3.exoplayer.upstream.Allocator
import androidx.media3.datasource.TransferListener
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/**
 * A MediaSource that defers the creation of its underlying MediaSource (and associated network requests)
 * until the source is actually prepared by ExoPlayer.
 * This prevents blocking the main thread during playlist set up and prevents stream URLs from expiring.
 */
@androidx.annotation.OptIn(androidx.media3.common.util.UnstableApi::class)
class LazyResolvingMediaSource(
    private val mediaItem: MediaItem,
    private val sourceFactory: suspend () -> MediaSource
) : CompositeMediaSource<Void>() {

    private var wrappedSource: MediaSource? = null
    private var timelineHasBeenRefreshed = false

    override fun prepareSourceInternal(mediaTransferListener: TransferListener?) {
        super.prepareSourceInternal(mediaTransferListener)
        
        // Background resolution
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val source = sourceFactory()
                withContext(Dispatchers.Main) {
                    wrappedSource = source
                    prepareChildSource(null, source)
                }
            } catch (e: Exception) {
                // Return an error timeline so ExoPlayer skips or fails cleanly rather than hanging forever
                withContext(Dispatchers.Main) {
                     val errorTimeline = SinglePeriodTimeline(C.TIME_UNSET, false, false, false, null, mediaItem)
                     refreshSourceInfo(errorTimeline)
                }
            }
        }
    }

    override fun getMediaItem(): MediaItem = mediaItem

    override fun onChildSourceInfoRefreshed(id: Void?, mediaSource: MediaSource, timeline: Timeline) {
        timelineHasBeenRefreshed = true
        refreshSourceInfo(timeline)
    }

    override fun createPeriod(id: MediaSource.MediaPeriodId, allocator: Allocator, startPositionUs: Long): MediaPeriod {
        return wrappedSource!!.createPeriod(id, allocator, startPositionUs)
    }

    override fun releasePeriod(mediaPeriod: MediaPeriod) {
        wrappedSource?.releasePeriod(mediaPeriod)
    }

    override fun releaseSourceInternal() {
        super.releaseSourceInternal()
        wrappedSource = null
    }
}
