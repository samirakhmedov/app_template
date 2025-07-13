# ===================================================================================
# == RULES FOR FLUTTER ENGINE
# These rules are mandatory for any Flutter application.
# They prevent the removal of Flutter engine code that is used by native code (JNI).
# ===================================================================================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }
# Don't warn about some specific Flutter classes
-dontwarn io.flutter.embedding.**

# ===================================================================================
# == RULES FOR FIREBASE
# Firebase uses a lot of reflection and dynamic loading, so it requires
# detailed rules. These are standard rules recommended by Google.
# ===================================================================================
# General rules for the Firebase SDK
-keepattributes Signature,InnerClasses,EnclosingMethod
-keepnames class com.google.android.gms.** { *; }
-keepnames class com.google.firebase.** { *; }
#-keep class com.google.firebase.provider.FirebaseInitProvider
#-keep class com.google.android.gms.common.api.internal.GoogleApiManager
#-keep class com.google.android.gms.common.internal.service.Common
-dontwarn com.google.android.gms.**

# Firebase Analytics
#-keep class com.google.android.gms.measurement.AppMeasurement { *; }
#-keep class com.google.android.gms.measurement.AppMeasurement$OnDeviceConversionGmpMeasurementReceiver { *; }
#-keep class com.google.android.gms.measurement.AppMeasurementReceiver { *; }
#-keep class com.google.android.gms.measurement.AppMeasurementService { *; }

# Firebase Crashlytics
-keepattributes *Annotation*
-keep public class * extends java.lang.Exception
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

# Firestore / Realtime Database (if you use them)
-keepnames class com.fasterxml.jackson.databind.** { *; }
-dontwarn com.fasterxml.jackson.databind.**
#-keep class com.google.firebase.database.core.Repo
#-keep class com.google.firebase.firestore.internal.ExponentialBackoff

# Firebase Auth
-keepattributes InnerClasses
#-keep class com.google.android.gms.internal.firebase-auth.**
-keep class com.google.firebase.auth.internal.**

# Cloud Messaging
-keep class com.google.firebase.messaging.** { *; }


# ===================================================================================
# == RULES FOR DRIFT / SQLITE
# Drift generates code at compile time, so R8 usually handles it well.
# However, the underlying SQLite library might require rules.
# ===================================================================================
# Standard rules for the native SQLite binding
-keep class androidx.sqlite.** { *; }
-keep class org.sqlite.** { *; }
-dontwarn org.sqlite.**

# ===================================================================================
# == GENERAL RECOMMENDATIONS
# ===================================================================================
# Keep annotations that might be used at runtime
-keepattributes *Annotation*

# If you use native Android Views (Platform Views)
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
}

# Keep Parcelable classes (if you use them in native code)
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# Keep Enum classes if you rely on their name for serialization (valueOf)
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}