buildscript {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven (url = uri("https://developer.huawei.com/repo/"))
    }

    dependencies {
        // Required by Huawei AGConnect plugin for compatibility check
        classpath("com.android.tools.build:gradle:8.11.1")
    }
}

repositories {
    mavenCentral()
    google()
    gradlePluginPortal()
    maven (url = uri("https://developer.huawei.com/repo/"))
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

