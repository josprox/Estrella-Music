@file:Suppress("UnstableApiUsage")

val isFullBuild: Boolean by rootProject.extra

plugins {
    id("com.android.application")
    kotlin("android")
    kotlin("kapt")
    alias(libs.plugins.hilt)
    alias(libs.plugins.kotlin.ksp)
    alias(libs.plugins.compose.compiler)
    kotlin("plugin.serialization") version "1.9.0"
}

// Plugins de Firebase solo si isFullBuild es true y no es pull request
if (isFullBuild && System.getenv("PULL_REQUEST") == null) {
    apply(plugin = "com.google.gms.google-services")
    apply(plugin = "com.google.firebase.crashlytics")
    apply(plugin = "com.google.firebase.firebase-perf")
}

android {
    namespace = "com.zionhuang.music"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.josprox.jossmusic"
        minSdk = 26
        targetSdk = 36
        versionCode = 56
        versionName = "2.2.4"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            isCrunchPngs = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            buildConfigField("String", "DOTENV_KEY", System.getenv("DOTENV_KEY") ?: "\"\"")
            signingConfig = signingConfigs.getByName("debug")
        }

        debug {
            applicationIdSuffix = ".debug"
            buildConfigField("String", "DOTENV_KEY", System.getenv("DOTENV_KEY") ?: "\"\"")
        }
    }

    flavorDimensions += listOf("version", "abi")

    productFlavors {
        // Version flavors
        create("full") { dimension = "version" }
        create("foss") { dimension = "version" }

        // ABI flavors
        create("arm64") {
            dimension = "abi"
            ndk { abiFilters.add("arm64-v8a") }
            setProperty("archivesBaseName", "jossmusic-arm64")
        }
        create("universal") {
            dimension = "abi"
            ndk { abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64", "x86")) }
            setProperty("archivesBaseName", "jossmusic-universal")
        }
    }

    signingConfigs {
        getByName("debug") {
            System.getenv("MUSIC_DEBUG_SIGNING_STORE_PASSWORD")?.let {
                storeFile = file(System.getenv("MUSIC_DEBUG_KEYSTORE_FILE"))
                storePassword = it
                keyAlias = "debug"
                keyPassword = System.getenv("MUSIC_DEBUG_SIGNING_KEY_PASSWORD")
            }
        }
    }

    buildFeatures {
        buildConfig = true
        compose = true
    }

    kotlin {
        jvmToolchain(21)
    }

    testOptions {
        unitTests.isIncludeAndroidResources = true
        unitTests.isReturnDefaultValues = true
    }

    lint {
        disable += "MissingTranslation"
    }

    dependenciesInfo {
        includeInApk = false
        includeInBundle = false
    }

    androidResources {
        generateLocaleConfig = true
    }
}

ksp {
    arg("room.schemaLocation", "$projectDir/schemas")
}

dependencies {
    // --- DEPENDENCIAS BASE ---
    implementation(libs.guava)
    implementation(libs.coroutines.guava)
    implementation(libs.concurrent.futures)

    implementation(libs.activity)
    implementation(libs.navigation)
    implementation(libs.hilt.navigation)
    implementation(libs.datastore)

    implementation(libs.compose.runtime)
    implementation(libs.compose.foundation)
    implementation(libs.compose.ui)
    implementation(libs.compose.ui.util)
    implementation(libs.compose.ui.tooling)
    implementation(libs.compose.animation)
    implementation(libs.compose.animation.graphics)
    implementation(libs.compose.reorderable)

    implementation(libs.viewmodel)
    implementation(libs.viewmodel.compose)

    implementation(libs.material3)
    implementation(libs.palette)
    implementation(projects.materialColorUtilities)
    implementation(libs.squigglyslider)

    implementation(libs.coil)
    implementation(libs.coil.compose.v260)

    implementation(libs.shimmer)

    implementation(libs.media3)
    implementation(libs.media3.session)
    implementation(libs.media3.okhttp)
    implementation(libs.androidx.media3.exoplayer.workmanager)

    implementation(libs.room.runtime)
    implementation(libs.androidx.media3.ui)
    implementation(libs.androidx.foundation)
    ksp(libs.room.compiler)
    implementation(libs.room.ktx)

    implementation(libs.apache.lang3)

    implementation(libs.hilt)
    kapt(libs.hilt.compiler)

    implementation(projects.innertube)
    implementation(projects.kugou)
    implementation(projects.lrclib)
    implementation(projects.kizzy)
    implementation(project(":jossredconnect"))

    implementation(libs.ktor.client.core)

    coreLibraryDesugaring(libs.desugaring)

    implementation(libs.timber)
    implementation(libs.nanojson)
    implementation(libs.androidx.webkit)
    implementation(libs.dotenv.vault.kotlin)
    implementation(libs.kotlinx.serialization.json)
    implementation(libs.androidx.material.icons.extended)
    implementation(libs.richtext.ui.material3)
    implementation(libs.richtext.commonmark)
    implementation(libs.androidx.palette.ktx)
    implementation(libs.billing.ktx)
    implementation(libs.runtime.livedata)
    implementation(libs.lifecycle.process)
    implementation(libs.onesignal)
    implementation(libs.androidx.media3.exoplayer.v131)

    implementation("androidx.work:work-runtime-ktx:2.10.5")
    implementation("androidx.hilt:hilt-work:1.3.0")

    // --- DEPENDENCIAS PARA LA VERSIÓN "full" ---
    "fullImplementation"(libs.firebase.analytics)
    "fullImplementation"(libs.firebase.crashlytics)
    "fullImplementation"(libs.firebase.config)
    "fullImplementation"(libs.firebase.perf)
}
