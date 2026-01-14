@file:Suppress("UnstableApiUsage")

plugins {
    alias(libs.plugins.hilt) apply false
    alias(libs.plugins.kotlin.ksp) apply false
    alias(libs.plugins.compose.compiler) apply false
    alias(libs.plugins.jetbrains.kotlin.jvm) apply false
}

buildscript {
    // Variable para identificar si es un build con servicios (full) o sin ellos (foss)
    val isFullBuild by extra {
        gradle.startParameter.taskNames.none { task -> task.contains("foss", ignoreCase = true) }
    }

    dependencies {
        classpath(libs.gradle)
        classpath(kotlin("gradle-plugin", libs.versions.kotlin.get()))
        classpath(libs.agcp)
        if (isFullBuild) {
            classpath(libs.google.services)
            classpath(libs.firebase.crashlytics.plugin)
            classpath(libs.firebase.perf.plugin)
        }
    }
}

tasks.register<Delete>("Clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinJvmCompile>().configureEach {
        compilerOptions {
            if (project.findProperty("enableComposeCompilerReports") == "true") {
                arrayOf("reports", "metrics").forEach { reportType ->
                    val outputDir = project.layout.buildDirectory
                        .dir("compose_metrics")
                        .get()
                        .asFile
                        .absolutePath

                    freeCompilerArgs.addAll(
                        listOf(
                            "-P",
                            "plugin:androidx.compose.compiler.plugins.kotlin:${reportType}Destination=$outputDir"
                        )
                    )
                }
            }
        }
    }
}