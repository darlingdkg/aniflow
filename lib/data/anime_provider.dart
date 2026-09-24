import '../models/anime.dart';

/// Contract implemented by content adapters outside the public framework.
///
/// AniFlow's public source intentionally ships without any third-party adapter,
/// parser, endpoint, scraper or playback resolver implementation.
abstract class AnimeProvider {
  String get id;

  Future<List<Anime>> getHome();

  Future<List<Anime>> search(String query);

  Future<Anime> getDetail(AnimeRef ref);

  Future<List<Episode>> getEpisodes(AnimeRef ref);

  Future<PlaybackSource> resolve(Episode episode);
}

void requireProvider(AnimeRef ref, String providerId) {
  if (ref.providerId != providerId) {
    throw ArgumentError(
      'Reference belongs to ${ref.providerId}, not $providerId',
    );
  }
}
