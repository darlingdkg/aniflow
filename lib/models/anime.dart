import 'anime_ref.dart';

export 'anime_ref.dart';

enum PlaybackType { hls, dash, mp4, embed }

class SubtitleTrack {
  const SubtitleTrack({
    required this.uri,
    required this.language,
    required this.label,
  });

  final Uri uri;
  final String language;
  final String label;
}

class PlaybackVariant {
  const PlaybackVariant({
    required this.uri,
    required this.type,
    required this.label,
    this.height,
    this.headers = const {},
  });

  final Uri uri;
  final PlaybackType type;
  final String label;
  final int? height;
  final Map<String, String> headers;
}

class PlaybackSource {
  const PlaybackSource({
    required this.uri,
    required this.type,
    this.headers = const {},
    this.subtitles = const [],
    this.variants = const [],
  });

  final Uri uri;
  final PlaybackType type;
  final Map<String, String> headers;
  final List<SubtitleTrack> subtitles;
  final List<PlaybackVariant> variants;
}

class Anime {
  const Anime({
    required this.id,
    required this.providerId,
    required this.title,
    required this.series,
    required this.description,
    this.artworkUrl,
    this.currentEpisodeCount,
    this.totalEpisodeCount,
  });

  final String providerId;
  final String id;
  final String title;
  final String series;
  final String description;
  final Uri? artworkUrl;
  final int? currentEpisodeCount;
  final int? totalEpisodeCount;

  AnimeRef get ref => AnimeRef(providerId: providerId, animeId: id);
}

class Episode {
  const Episode({
    required this.id,
    required this.providerId,
    required this.animeId,
    required this.number,
    required this.title,
  });

  final String providerId;
  final String id;
  final String animeId;
  final int number;
  final String title;

  AnimeRef get animeRef => AnimeRef(providerId: providerId, animeId: animeId);
}
