# AniFlow

AniFlow is an open-source Flutter framework for building modern multimedia
streaming applications with a Material 3 interface.

The project focuses on the reusable application shell commonly found in
on-demand video and online streaming apps: Home, Search, Library, profiles,
preferences, media models and an adapter boundary for external content sources.

This repository intentionally publishes the **application framework only**.
Private integrations with third-party content sources are not part of the
open-source project.

## What is included

The public framework contains reusable application infrastructure:

- Material 3 application shell and bottom navigation
- AniFlow theme, design tokens and typography
- Vietnamese and English UI localization
- Home, Search and Library placeholder surfaces
- local profile and PIN persistence
- theme and language preferences
- normalized media, episode and playback models
- a generic content-provider adapter contract
- Android Flutter project scaffolding
- framework-level tests

The public build starts in placeholder mode and does not bootstrap remote
catalog content.

## What is not included

Third-party content integrations are intentionally private.

This repository does **not** include:

- production content-provider implementations
- scrapers or site-specific parsers
- third-party endpoint or domain lists
- catalog mappings
- source-specific HTTP behavior
- production playback resolvers
- provider caches or identity bridges
- provider-specific recommendation sources
- provider fixtures, captured HTML, JSON or playlists
- third-party artwork used by private builds
- AniFlow signing keys or release credentials

Applications built on AniFlow can supply their own adapters behind the public
provider contract without changing the framework shell.

This separation keeps the framework reusable while avoiding redistribution of
third-party integration code or content.

## Architecture

The public boundary is intentionally small:

```text
AniFlow framework
├── App shell / navigation
├── Theme / localization
├── Profile / preferences
├── Generic media models
└── Content provider contract
        └── Adapter implementation supplied separately
```

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for more detail.

## Platform

The public project currently targets **Android only**.

## Getting started

Requirements:

- Flutter 3.44.x or a compatible Flutter SDK
- Android SDK

Clone the repository, then run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

The framework source does not require any third-party content provider to boot.

## Releases

Official Android builds are published through GitHub Releases.

Release APKs are built and signed outside the public source repository.
Production signing material, including `android/key.properties` and the private
keystore, is never committed.

The public framework source and the distributed AniFlow application are
deliberately separated so the reusable application architecture can remain open
without publishing private third-party integrations.

## Contributing

Changes to the public framework should remain source-agnostic. Provider,
scraper, parser, endpoint and source-specific playback logic should not be added
to this repository.

Before submitting changes, run:

```bash
flutter analyze
flutter test
```

## License

AniFlow's public framework is licensed under the [MIT License](LICENSE).

The MIT License applies to the source code published in this repository. It does
not grant rights to third-party content, trademarks, artwork, media, services or
external integrations that are not part of this repository.
