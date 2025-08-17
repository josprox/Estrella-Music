package com.josprox.jossredconnect.net

import okhttp3.MediaType
import okhttp3.RequestBody
import okio.BufferedSink
import okio.source

class ProgressRequestBody(
    private val bytes: ByteArray,
    private val contentType: MediaType?,
    private val onProgress: ((uploaded: Long, total: Long) -> Unit)? = null
) : RequestBody() {

    override fun contentType(): MediaType? = contentType
    override fun contentLength(): Long = bytes.size.toLong()

    override fun writeTo(sink: BufferedSink) {
        val total = contentLength()
        bytes.inputStream().source().use { source ->
            var uploaded = 0L
            var read: Long
            val bufferSize = 8 * 1024L
            val buffer = okio.Buffer()
            while (source.read(buffer, bufferSize).also { read = it } != -1L) {
                sink.write(buffer, read)
                uploaded += read
                onProgress?.invoke(uploaded, total)
            }
        }
    }
}
