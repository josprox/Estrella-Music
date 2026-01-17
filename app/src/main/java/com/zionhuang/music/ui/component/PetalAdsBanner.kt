package com.zionhuang.music.ui.component

import android.widget.FrameLayout
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.viewinterop.AndroidView
import com.huawei.hms.ads.AdParam
import com.huawei.hms.ads.BannerAdSize
import com.huawei.hms.ads.banner.BannerView

import com.zionhuang.music.utils.SecureKeys

@Composable
fun PetalAdsBanner(
    modifier: Modifier = Modifier,
    adId: String = SecureKeys.petalBannerId,
    bannerSize: BannerAdSize = BannerAdSize.BANNER_SIZE_320_50
) {
    val showAdMob = androidx.compose.runtime.remember { androidx.compose.runtime.mutableStateOf(false) }

    if (showAdMob.value) {
        AdMobBanner(modifier = modifier)
    } else {
        AndroidView(
            modifier = modifier,
            factory = { context ->
                BannerView(context).apply {
                    this.adId = adId
                    this.bannerAdSize = bannerSize
                    this.adListener = object : com.huawei.hms.ads.AdListener() {
                        override fun onAdLoaded() {
                            timber.log.Timber.d("PetalAds: Ad loaded successfully for $adId")
                        }
                        override fun onAdFailed(errorCode: Int) {
                            timber.log.Timber.e("PetalAds: Ad failed to load. Error code: $errorCode. Switching to AdMob.")
                            // Fallback to AdMob
                            showAdMob.value = true
                        }
                        override fun onAdOpened() {
                            timber.log.Timber.d("PetalAds: Ad opened")
                        }
                        override fun onAdClicked() {
                            timber.log.Timber.d("PetalAds: Ad clicked")
                        }
                        override fun onAdLeave() {
                            timber.log.Timber.d("PetalAds: Ad left application")
                        }
                        override fun onAdClosed() {
                            timber.log.Timber.d("PetalAds: Ad closed")
                        }
                    }
                    val param = AdParam.Builder().build()
                    timber.log.Timber.d("PetalAds: Loading ad with param $param")
                    loadAd(param)
                }
            }
        )
    }
}
