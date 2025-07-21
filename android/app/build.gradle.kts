val mediaService = (project.findProperty("mediaService") ?: "gms").toString().lowercase()
val ifHms = mediaService == "hms"

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
//    id("com.huawei.agconnect")
//    id("com.google.gms.google-services")
}

apply(from = "../keystore/signingConfigs.gradle")

android {
    namespace = "com.example.app_template"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.app_template"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        multiDexEnabled = true
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }

        debug {
            isDebuggable = true
        }
    }

    flavorDimensions += "release-type"
    flavorDimensions += "service-type"

    productFlavors {
        create("dev") {
            dimension = "release-type"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "App Template (Dev)")
            resValue("string", "app_icon", "@mipmap/ic_launcher_dev")
            if (ifHms) {
                signingConfig = signingConfigs.getByName("huawei")
            } else {
                signingConfig = signingConfigs.getByName("dev")
            }
        }

        create("prod") {
            dimension = "release-type"
            resValue("string", "app_name", "App Template")
            resValue("string", "app_icon", "@mipmap/ic_launcher")
            if (ifHms) {
                signingConfig = signingConfigs.getByName("huawei")
            } else {
                signingConfig = signingConfigs.getByName("prod")
            }
        }
    }

    productFlavors {
        create("gms") {
            dimension = "service-type"
            applicationIdSuffix = ".gms"
            manifestPlaceholders["serviceType"] = "gms"
            resValue("string", "service_provider", "Google Mobile Services")
        }

        create("hms") {
            dimension = "service-type"
            applicationIdSuffix = ".hms"
            manifestPlaceholders["serviceType"] = "hms"
            resValue("string", "service_provider", "Huawei Mobile Services")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("androidx.core:core-splashscreen:1.0.1")
    /// HMS dependencies
    if (ifHms) {
//        implementation("com.huawei.agconnect:agconnect-core:1.9.3.301")
    } else {
        /// GMS dependencies
//        implementation("com.google.gms:google-services:4.4.3")
    }
}