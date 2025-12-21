package com.zionhuang.music.ui.screens

import android.annotation.SuppressLint
import android.webkit.CookieManager
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.navigation.NavController
import com.zionhuang.innertube.YouTube
import com.zionhuang.music.LocalPlayerAwareWindowInsets
import com.zionhuang.music.R
import com.zionhuang.music.constants.AccountChannelHandleKey
import com.zionhuang.music.constants.AccountEmailKey
import com.zionhuang.music.constants.AccountNameKey
import com.zionhuang.music.constants.DataSyncIdKey
import com.zionhuang.music.constants.InnerTubeCookieKey
import com.zionhuang.music.constants.VisitorDataKey
import com.zionhuang.music.ui.component.IconButton
import com.zionhuang.music.ui.utils.backToMain
import com.zionhuang.music.utils.rememberPreference
import com.zionhuang.music.utils.reportException
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.launch

@SuppressLint("SetJavaScriptEnabled")
@OptIn(ExperimentalMaterial3Api::class, DelicateCoroutinesApi::class)
@Composable
fun LoginScreen(
    navController: NavController,
) {
    val coroutineScope = rememberCoroutineScope()
    var visitorData by rememberPreference(VisitorDataKey, "")
    var dataSyncId by rememberPreference(DataSyncIdKey, "")
    var innerTubeCookie by rememberPreference(InnerTubeCookieKey, "")
    var accountName by rememberPreference(AccountNameKey, "")
    var accountEmail by rememberPreference(AccountEmailKey, "")
    var accountChannelHandle by rememberPreference(AccountChannelHandleKey, "")

    var webView: WebView? = null

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(
                brush = Brush.verticalGradient(
                    colors = listOf(
                        Color(0xFF2E2E2E),
                        Color(0xFF000000)
                    )
                )
            )
            .windowInsetsPadding(LocalPlayerAwareWindowInsets.current)
    ) {
        AndroidView(
            modifier = Modifier.fillMaxSize(),
            factory = { context ->
                WebView(context).apply {
                    webViewClient = object : WebViewClient() {
                        override fun onPageFinished(view: WebView, url: String?) {
                            loadUrl("javascript:Android.onRetrieveVisitorData(window.yt.config_.VISITOR_DATA)")
                            loadUrl("javascript:Android.onRetrieveDataSyncId(window.yt.config_.DATASYNC_ID)")

                            if (url?.startsWith("https://music.youtube.com") == true) {
                                innerTubeCookie = CookieManager.getInstance().getCookie(url)
                                coroutineScope.launch {
                                    YouTube.accountInfo().onSuccess {
                                        accountName = it.name
                                        accountEmail = it.email.orEmpty()
                                        accountChannelHandle = it.channelHandle.orEmpty()
                                    }.onFailure {
                                        reportException(it)
                                    }
                                }
                            }
                        }
                    }
                    settings.apply {
                        javaScriptEnabled = true
                        setSupportZoom(true)
                        builtInZoomControls = true
                        displayZoomControls = false
                        // Optional: Try to make transparent if the page supports it (Google Login usually doesn't, but good for loading)
                        setBackgroundColor(0x00000000)
                    }
                    addJavascriptInterface(object {
                        @JavascriptInterface
                        fun onRetrieveVisitorData(newVisitorData: String?) {
                            if (newVisitorData != null) {
                                visitorData = newVisitorData
                            }
                        }
                        @JavascriptInterface
                        fun onRetrieveDataSyncId(newDataSyncId: String?) {
                            if (newDataSyncId != null) {
                                dataSyncId = newDataSyncId.substringBefore("||")
                            }
                        }
                    }, "Android")
                    webView = this
                    loadUrl("https://accounts.google.com/ServiceLogin?continue=https%3A%2F%2Fmusic.youtube.com")
                }
            }
        )

        // Custom Glass Header
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(
                    brush = Brush.verticalGradient(
                        colors = listOf(
                            Color.Black.copy(alpha = 0.7f),
                            Color.Transparent
                        )
                    )
                )
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(
                onClick = navController::navigateUp,
                onLongClick = navController::backToMain
            ) {
                Icon(
                    painterResource(R.drawable.arrow_back),
                    contentDescription = null,
                    tint = Color.White
                )
            }
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = stringResource(R.string.login),
                style = MaterialTheme.typography.titleLarge.copy(
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
            )
        }
    }

    BackHandler(enabled = webView?.canGoBack() == true) {
        webView?.goBack()
    }
}