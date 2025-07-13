import android.databinding.tool.ext.classSpec
import org.gradle.internal.declarativedsl.dom.resolution.resolutionContainer

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

plugins {
//    id("com.google.gms.google-services") version "4.4.3" apply false
//    id("com.huawei.agconnect.agcp") version "1.9.1.301" apply false
}


tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

