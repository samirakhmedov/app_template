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
            manifestPlaceholders["serviceType"] = "gms"
            buildConfigField("String", "SERVICE_TYPE", "\"gms\"")
            resValue("string", "service_provider", "Google Mobile Services")
        }

        create("hms") {
            dimension = "service-type"
            applicationIdSuffix = ".hms"
            manifestPlaceholders["serviceType"] = "hms"
            buildConfigField("String", "SERVICE_TYPE", "\"hms\"")
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

    // GMS-specific dependencies
    "devGmsImplementation"("com.google.android.gms:play-services-auth:20.7.0")
    "devGmsImplementation"("com.google.firebase:firebase-messaging:23.4.0")
    "devGmsImplementation"("com.google.android.gms:play-services-maps:18.2.0")
    "devGmsImplementation"("com.google.android.gms:play-services-location:21.0.1")
    
    "prodGmsImplementation"("com.google.android.gms:play-services-auth:20.7.0")
    "prodGmsImplementation"("com.google.firebase:firebase-messaging:23.4.0")
    "prodGmsImplementation"("com.google.android.gms:play-services-maps:18.2.0")
    "prodGmsImplementation"("com.google.android.gms:play-services-location:21.0.1")
    
    // HMS-specific dependencies
    "devHmsImplementation"("com.huawei.hms:hwid:6.11.0.300")
    "devHmsImplementation"("com.huawei.hms:push:6.11.0.300")
    "devHmsImplementation"("com.huawei.hms:maps:6.11.0.300")
    "devHmsImplementation"("com.huawei.hms:location:6.11.0.300")
    
    "prodHmsImplementation"("com.huawei.hms:hwid:6.11.0.300")
    "prodHmsImplementation"("com.huawei.hms:push:6.11.0.300")
    "prodHmsImplementation"("com.huawei.hms:maps:6.11.0.300")
    "prodHmsImplementation"("com.huawei.hms:location:6.11.0.300")
}

configurations.all {
    resolutionStrategy {
        eachDependency {  DependencyResolveDetails details ->
            when {
                it.requested.group.startsWith("com.google") &&
                android.defaultConfig.applicationId?.contains("hms") == true -> {
                    details.useTarget("com.huawei.hms:${details.requested.name}:${details.requested.version}")
                    details.because("Switching to HMS equivalent")
                }
                details.requested.group.startsWith("com.huawei") && 
                android.defaultConfig.applicationId?.contains("gms") == true -> {
                    details.useTarget("com.google.android.gms:${details.requested.name}:${details.requested.version}")
                    details.because("Switching to GMS equivalent")
                }
            }
        }
    }
}