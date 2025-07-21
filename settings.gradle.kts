@file:Suppress("UnstableApiUsage")

pluginManagement {
    repositories {
        google() // Repositorio de Google (¡crucial para KSP!)
        mavenCentral() // Repositorio Maven Central
        gradlePluginPortal() // Repositorio oficial de plugins de Gradle
        maven { setUrl("https://jitpack.io") }
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)

    repositories {
        google()
        mavenCentral()
        maven { setUrl("https://jitpack.io") }
    }
}

rootProject.name = "InnerTune" // Nombre de tu proyecto
include(":app")
include(":jossredconnect")
include(":innertube")
include(":kugou")
include(":lrclib")
include(":material-color-utilities")
include(":kizzy")

enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")