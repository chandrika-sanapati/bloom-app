# Bloom

Bloom is an Android-first, local-first plant care application built with
Flutter and standard Material 3 components.

## Current scope

- Primary release platform: Android
- Application ID: `design.chandrika.bloom`
- Flutter SDK: pinned through [FVM](https://fvm.app/) in `.fvmrc`
- Future platforms: iOS and web may be added after the Android product is
  validated

## Prerequisites

- FVM
- Android Studio with Android SDK 36 and accepted SDK licenses
- A compatible JDK (Android Studio's bundled JDK is supported)

On macOS, the base tools can be installed with Homebrew:

```sh
brew install fvm
brew install --cask android-studio android-commandlinetools
```

## Set up

```sh
fvm install
fvm flutter pub get
fvm flutter doctor -v
```

The Android toolchain must be healthy. Xcode and CocoaPods are not required for
the Android-first phase.

## Run and validate

```sh
fvm flutter run
fvm dart format --output=none --set-exit-if-changed lib test
fvm flutter analyze
fvm flutter test
fvm flutter build apk --debug
```

## Product documents

- [Execution plan](docs/BLOOM_EXECUTION_PLAN.md)
- [Product requirements](docs/PRD.md)
- [Design specification](docs/DESIGN.md)

The execution plan is the source of truth for sequencing, scope, and exit
gates. Product features should not begin until the current phase's exit gate is
satisfied.
