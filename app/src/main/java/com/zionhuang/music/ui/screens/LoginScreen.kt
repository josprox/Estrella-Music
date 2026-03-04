package com.zionhuang.music.ui.screens

import android.annotation.SuppressLint
import android.webkit.CookieManager
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.surfaceColorAtElevation
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
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

    var isLoading by remember { mutableStateOf(true) }
    var webView: WebView? = null

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(MaterialTheme.colorScheme.background)
            .windowInsetsPadding(LocalPlayerAwareWindowInsets.current)
    ) {
        // Custom Header
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(MaterialTheme.colorScheme.surfaceColorAtElevation(3.dp)) // Nicer dark surface
                .statusBarsPadding()
                .padding(horizontal = 16.dp, vertical = 12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(
                onClick = navController::navigateUp,
                onLongClick = navController::backToMain
            ) {
                Icon(
                    painterResource(R.drawable.arrow_back),
                    contentDescription = null,
                    tint = MaterialTheme.colorScheme.onSurface
                )
            }
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = stringResource(R.string.login),
                style = MaterialTheme.typography.titleLarge.copy(
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.onSurface
                )
            )
        }

        if (isLoading) {
            LinearProgressIndicator(
                modifier = Modifier.fillMaxWidth(),
                color = MaterialTheme.colorScheme.primary
            )
        }

        // WebView takes remaining space
        AndroidView(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f),
            factory = { context ->
                WebView(context).apply {
                    webViewClient = object : WebViewClient() {
                        override fun onPageFinished(view: WebView, url: String?) {
                            isLoading = false
                            
                            // Native Force Dark takes care of most things, but we can still inject specific overrides if needed
                            // For now, let's rely on Force Dark for the heavy lifting

                            // Robust scraping with polling
                            view.loadUrl(
                                "javascript:(function() { " +
                                        "var interval = setInterval(function() { " +
                                        "   if (window.yt && window.yt.config_) { " +
                                        "       if (window.yt.config_.VISITOR_DATA) Android.onRetrieveVisitorData(window.yt.config_.VISITOR_DATA); " +
                                        "       if (window.yt.config_.DATASYNC_ID) Android.onRetrieveDataSyncId(window.yt.config_.DATASYNC_ID); " +
                                        "   } " +
                                        "}, 1000); " +
                                        "})()"
                            )

                            if (url?.startsWith("https://music.youtube.com") == true) {
                                val cookies = CookieManager.getInstance().getCookie(url)
                                if (cookies != null && innerTubeCookie != cookies) {
                                    innerTubeCookie = cookies
                                    coroutineScope.launch {
                                        YouTube.cookie = cookies // Ensure singleton update
                                        YouTube.accountInfo().onSuccess {
                                            accountName = it.name
                                            accountEmail = it.email.orEmpty()
                                            accountChannelHandle = it.channelHandle.orEmpty()
                                            // Optional: Auto-close on success?
                                            // navController.navigateUp() 
                                        }.onFailure {
                                            reportException(it)
                                        }
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
                        domStorageEnabled = true
                        userAgentString = "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36"
                        
                        // Enable Force Dark Mode
                        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q) {
                            forceDark = android.webkit.WebSettings.FORCE_DARK_ON
                        }
                    }
                    addJavascriptInterface(object {
                        @JavascriptInterface
                        fun onRetrieveVisitorData(newVisitorData: String?) {
                            if (!newVisitorData.isNullOrBlank()) {
                                visitorData = newVisitorData
                            }
                        }

                        @JavascriptInterface
                        fun onRetrieveDataSyncId(newDataSyncId: String?) {
                            if (!newDataSyncId.isNullOrBlank()) {
                                dataSyncId = newDataSyncId.substringBefore("||")
                            }
                        }
                    }, "Android")
                    webView = this
                    loadUrl("https://accounts.google.com/ServiceLogin?continue=https%3A%2F%2Fmusic.youtube.com")
                }
            }
        )
    }

    BackHandler(enabled = webView?.canGoBack() == true) {
        webView?.goBack()
    }
}