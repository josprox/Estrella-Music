plugins {
    id("com.android.library")
    alias(libs.plugins.kotlin.serialization)
}

android {
    namespace = "com.zionhuang.innertube"
    compileSdk = 36

    defaultConfig {
        minSdk = 26
    }

    kotlin {
        jvmToolchain(21)
    }

    buildFeatures {
        buildConfig = true
    }
}

dependencies {
    implementation(libs.ktor.client.core)
    implementation(libs.ktor.client.okhttp)
    implementation(libs.ktor.client.content.negotiation)
    implementation(libs.ktor.serialization.json)
    implementation(libs.ktor.client.encoding)
    implementation(libs.brotli)
    implementation(libs.newpipe.extractor)
    implementation(libs.timber)
    testImplementation(libs.junit)
}
