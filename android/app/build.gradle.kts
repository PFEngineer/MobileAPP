plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.galena.invest_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.galena.invest_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Flavors de ambiente: homologação (hml) e produção (prd). Cada um gera um
    // applicationId distinto para conviverem no mesmo device. O ambiente da
    // Galena API é passado ao Dart via --dart-define=GALENA_ENV (ver Makefile).
    flavorDimensions += "env"
    productFlavors {
        create("hml") {
            dimension = "env"
            applicationId = "com.galena.hml"
            versionNameSuffix = "-hml"
            manifestPlaceholders["appName"] = "Invest App HML"
        }
        create("prd") {
            dimension = "env"
            applicationId = "com.galena.prd"
            manifestPlaceholders["appName"] = "Invest App"
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
