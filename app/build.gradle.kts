@file:Suppress("UnstableApiUsage")

import java.util.Properties
import java.io.FileInputStream

val isFullBuild: Boolean by rootProject.extra

plugins {
    id("com.android.application")


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
        versionCode = 59
        versionName = "2.2.7"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("keystore.properties")
            if (keystorePropertiesFile.exists()) {
                val keystoreProperties = Properties()
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))

                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            } else {
                 // Fallback to env vars or debug for CI/CD if needed
                 println("keystore.properties not found, skipping signing config setup.")
            }
        }
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
            signingConfig = signingConfigs.getByName("release")
        }

        debug {
            // applicationIdSuffix = ".debug" // Temporarily removed for Huawei Ads testing
            buildConfigField("String", "DOTENV_KEY", System.getenv("DOTENV_KEY") ?: "\"\"")
            signingConfig = signingConfigs.getByName("release")
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

        }
        create("universal") {
            dimension = "abi"
            ndk { abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64", "x86")) }

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
    // --- ¡¡BOM DE COMPOSE AÑADIDO AQUÍ!! ---
    implementation(platform(libs.compose.bom))

    // --- DEPENDENCIAS BASE ---
    implementation(libs.guava)
    implementation(libs.coroutines.guava)
    implementation(libs.concurrent.futures)

    implementation(libs.activity)
    implementation(libs.navigation)
    implementation(libs.hilt.navigation)
    implementation(libs.datastore)

    // --- Dependencias de Compose (ahora sin versión) ---
    implementation(libs.compose.runtime)
    implementation(libs.compose.foundation)
    implementation(libs.compose.ui)
    implementation(libs.compose.ui.util)
    implementation(libs.compose.ui.tooling)
    implementation(libs.compose.animation)
    implementation(libs.compose.animation.graphics)
    implementation(libs.compose.reorderable)
    implementation(libs.material3)
    implementation(libs.androidx.material.icons.extended)
    implementation(libs.runtime.livedata)
    implementation(libs.androidx.foundation) // Asegúrate de que esta línea esté (ya la tenías)

    implementation(libs.viewmodel)
    implementation(libs.viewmodel.compose)

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
    ksp(libs.room.compiler)
    implementation(libs.room.ktx)

    implementation(libs.apache.lang3)

    implementation(libs.hilt)
    ksp(libs.hilt.compiler)

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
    implementation(libs.richtext.ui.material3)
    implementation(libs.richtext.commonmark)
    implementation(libs.androidx.palette.ktx)
    implementation(libs.billing.ktx)
    implementation(libs.lifecycle.process)
    implementation(libs.lifecycle.runtime.ktx)
    // But since user has 2.9.4 for process, let's try to match it if previous failed?
    // Actually, let's stick to a known stable version for these specific libraries if implicit resolution failed.
    // 2.8.7 IS stable.
    // Wait, the previous error was Unresolved Reference.
    // Maybe I should add lifecycle-common-java8 or just lifecycle-common?
    implementation(libs.lifecycle.common.java8)
    implementation(libs.savedstate.ktx)
    implementation(libs.onesignal)
    implementation(libs.androidx.media3.exoplayer.v131)
    implementation(libs.media3.exoplayer.hls)
    implementation(libs.media3.exoplayer.dash)

    implementation(libs.work.runtime.ktx)
    implementation(libs.hilt.work)
    // --- PETAL ADS (HUAWEI) ---
    // Versión "Fat" para que funcione en todos los Android sin importar la marca
    implementation(libs.ads.prime)
    // Librería vital para el cifrado en dispositivos No-Huawei
    implementation(libs.bouncycastle)
    // Librería de consentimiento obligatoria para evitar el error 499
    implementation(libs.ads.consent)

    // --- DEPENDENCIAS PARA LA VERSIÓN "full" ---
    "fullImplementation"(libs.firebase.analytics)
    "fullImplementation"(libs.firebase.crashlytics)
    "fullImplementation"(libs.firebase.config)
    "fullImplementation"(libs.firebase.perf)
}