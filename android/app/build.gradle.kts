plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

apply(from = "../keystore/signingConfigs.gradle")

val mediaService = (project.findProperty("mediaService") ?: "gms").toString().lowercase()
if (mediaService == "hms") {
//    apply(plugin = "com.huawei.agconnect")
} else {
//    apply(plugin = "com.google.gms.google-services")
}

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

            signingConfig = signingConfigs.getByName("prod")
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
            // Assigns this product flavor to the "version" flavor dimension.
            // If you are using only one dimension, this property is optional,
            // and the plugin automatically assigns all the module's flavors to
            // that dimension.
            dimension = "service-type"
        }

        create("hms") {
            dimension = "service-type"
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("androidx.core:core-splashscreen:1.0.1")
}

