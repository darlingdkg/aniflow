import 'dart:convert';

/// Stable identity owned by an adapter implementation.
///
/// The public framework intentionally knows nothing about external catalog IDs.
class AnimeRef {
  const AnimeRef({required this.providerId, required this.animeId});

  final String providerId;
  final String animeId;

  String get storageKey => jsonEncode([providerId, animeId]);

  Map<String, Object?> toJson() => {
    'providerId': providerId,
    'animeId': animeId,
  };

  factory AnimeRef.fromJson(Object? value) {
    if (value is! Map) throw const FormatException('Invalid reference');
    final providerId = value['providerId'];
    final animeId = value['animeId'];
    if (providerId is! String ||
        animeId is! String ||
        !RegExp(r'^[a-z][a-z0-9_-]*$').hasMatch(providerId.trim()) ||
        animeId.trim().isEmpty) {
      throw const FormatException('Invalid identity');
    }
    return AnimeRef(providerId: providerId.trim(), animeId: animeId.trim());
  }

  @override
  bool operator ==(Object other) =>
      other is AnimeRef &&
      providerId == other.providerId &&
      animeId == other.animeId;

  @override
  int get hashCode => Object.hash(providerId, animeId);
}
