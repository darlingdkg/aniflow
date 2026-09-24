# AniFlow public framework architecture

The public repository exposes the application boundary, not AniFlow's private
third-party content integrations.

## Layers

### App shell

`lib/app.dart` owns top-level navigation, theme/language preference wiring and
the local profile/settings surface.

### Presentation

`lib/widgets/tabs/placeholder_content_tabs.dart` contains content-shaped
placeholder views for Home, Search and Library. These widgets deliberately do
not request remote data.

### Generic contracts

`lib/models/anime.dart` and `lib/models/anime_ref.dart` define normalized
media identities, episode data and playback-source shapes.

`lib/data/anime_provider.dart` defines the adapter boundary. It contains no
concrete implementation.

### Local profile state

`lib/data/profile_store.dart` persists AniFlow profiles with
SharedPreferences. It is independent from content providers.

## Private integration boundary

Production/private builds may provide adapters implementing `AnimeProvider`.
Those adapters can own networking, parsing, source-specific identifiers,
playback resolution and content caches. None of those implementations belong to
this public framework repository.

This keeps the open framework reusable while avoiding redistribution of
third-party content integration code.
