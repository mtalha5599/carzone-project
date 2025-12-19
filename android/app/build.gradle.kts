plugins {
    id("com.android.application")
    id("kotlin-android")
    // Required for Flutter
    id("dev.flutter.flutter-gradle-plugin")
    // Firebase plugins if needed (optional here)
}

android {
    namespace = "com.example.carzone"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13846066"

    defaultConfig {
        applicationId = "com.example.carzone" // ✅ Your app package name
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // TODO: Replace with release signing config
        }
    }
}

flutter {
    source = "../.."
}
