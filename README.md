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

Start an Android API 36 emulator from Android Studio's Device Manager, or use
the configured command-line emulator:

```sh
fvm flutter emulators
fvm flutter emulators --launch bloom_api_36
fvm flutter devices
```

Run the debug build on the connected Android target:

```sh
fvm flutter run -d <device-id>
```

While `flutter run` is attached, press `r` for hot reload, `R` for a full hot
restart, and `q` to stop the development session. If only one supported device
is connected, `fvm flutter run` selects it automatically.

Run the same validation used by CI:

```sh
fvm dart format --output=none --set-exit-if-changed lib test
fvm flutter analyze
fvm flutter test
fvm flutter build apk --debug
```

After changing Drift tables under `lib/spikes/persistence/`, regenerate code:

```sh
fvm dart run build_runner build
```

## Product documents

- [Execution plan](docs/BLOOM_EXECUTION_PLAN.md)
- [Product requirements](docs/PRD.md)
- [Design system](docs/DESIGN.md)
- [Figma source and vision pack](docs/design/FIGMA_SOURCE.md)
- [Screen inventory](docs/design/SCREEN_INVENTORY.md)
- [Flutter theme mapping](docs/design/FLUTTER_THEME.md)
- [v1 scope decisions](docs/SCOPE.md)
- [Phase 2 validation pack](docs/PHASE2_VALIDATION.md)
- [Technical spike sequence](docs/TECHNICAL_SPIKES.md)
- [Persistence spike decision](docs/spikes/PERSISTENCE_SPIKE.md)

The execution plan is the source of truth for sequencing, scope, and exit
gates. Product features should not begin until the current phase's exit gate is
satisfied.
