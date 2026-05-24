plugins {
    id("com.android.library") // Declaramos el uso de esta librería como Android

}

android {
    namespace = "com.jossred.client" // Nombre del paquete registrado en Joss Red
    compileSdk = 37

    defaultConfig {
        minSdk = 21

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("consumer-rules.pro")
    }

    // Simplificado
    kotlin {
        jvmToolchain(21)
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