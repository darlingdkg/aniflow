# AniFlow public framework architecture

AniFlow's public repository contains a reusable multimedia streaming application
shell. It exposes the application boundary, not private third-party content
integrations.

The current public project targets Android only.

## Layers

### App shell

`lib/app.dart` owns top-level navigation, theme/language preference wiring and
the local profile/settings surface.

### Presentation

`lib/widgets/tabs/placeholder_content_tabs.dart` contains placeholder views for
Home, Search and Library. These widgets deliberately do not request remote
content.

### Generic media contracts

The public model layer defines normalized media identities, episode data and
playback-source shapes.

The provider contract defines the adapter boundary and contains no concrete
network or source implementation.

### Local profile state

`lib/data/profile_store.dart` persists AniFlow profiles with
SharedPreferences. It is independent from content providers.

## Private integration boundary

Production or private builds may provide adapters behind the provider contract.
Those adapters can own networking, parsing, source-specific identifiers,
playback resolution and content caches.

None of those third-party integration implementations belong to this public
framework repository.

This keeps the framework reusable for streaming-style multimedia applications
without redistributing third-party content integration code.
