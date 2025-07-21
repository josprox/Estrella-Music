plugins {
    id("com.android.library") // Declaramos el uso de esta librería como Android
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.jossred.client" // Nombre del paquete registrado en Joss Red
    compileSdk = 36

    defaultConfig {
        minSdk = 21

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("consumer-rules.pro")
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    // REMOVE THIS BLOCK:
    // kotlinOptions {
    //     jvmTarget = "17"
    // }

    // ADD THIS BLOCK OR MERGE WITH EXISTING compilerOptions IF PRESENT:
    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }


    buildFeatures {
        buildConfig = true
    }
}

dependencies {
    // OkHttp para llamadas HTTP
    implementation(libs.okhttp)
    implementation(libs.logging.interceptor)

    // Media3 para soporte de streaming (DataSpec, etc.)
    implementation(libs.androidx.media3.datasource.v161)
    implementation(libs.hilt.android.v248)
}