
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
            signingConfig = signingConfigs.getByName("dev")
        }

        create("prod") {
            dimension = "release-type"
            resValue("string", "app_name", "App Template")
            resValue("string", "app_icon", "@mipmap/ic_launcher")
            signingConfig = signingConfigs.getByName("prod")
        }
    }

    productFlavors {
        create("gms") {
            dimension = "service-type"
            applicationIdSuffix = ".gms"
        }

        create("hms") {
            dimension = "service-type"
            applicationIdSuffix = ".hms"
            signingConfig = signingConfigs.getByName("huawei")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("androidx.core:core-splashscreen:1.0.1")
    "hmsImplementation"("com.huawei.agconnect:agconnect-core:1.9.3.301")
    "gmsImplementation"("com.google.gms:google-services:4.4.3")
}