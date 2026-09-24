# AniFlow

AniFlow is a Flutter Material 3 application framework for an anime-style media
client.

## What is public

This repository contains the AniFlow application shell:

- Material 3 theme and design tokens
- Vietnamese / English UI localization
- Home, Search and Library placeholder surfaces
- local profile and PIN persistence
- theme and language preferences
- normalized anime / episode / playback models
- the generic `AnimeProvider` adapter contract
- Android, iOS, desktop and web Flutter project scaffolding

## What is intentionally not public

Third-party content integrations are not included.

The public repository contains **no** production content provider implementation,
scraper, parser, endpoint list, catalog mapping, site-specific HTTP behavior,
playback resolver, provider cache, provider identity bridge, recommendation
source or provider-specific test fixture.

`AnimeProvider` is only an interface. A downstream application can implement
its own adapter without changing the framework shell.

The public source also excludes third-party media artwork used by private builds.

## Run the framework

Requirements:

- Flutter 3.44.x or a compatible SDK
- Android SDK for Android builds

Then:

    flutter pub get
    flutter analyze
    flutter test
    flutter run

The app starts in placeholder mode and performs no network content bootstrap.

## Releases

The GitHub Releases page contains the separately built AniFlow Android APK.

Official release APKs are signed outside the public repository. Private signing
keys and `android/key.properties` are never committed.

## Architecture

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## License

No software license has been selected yet. The source is publicly visible, but
reuse and redistribution terms are not granted until a license is added.
