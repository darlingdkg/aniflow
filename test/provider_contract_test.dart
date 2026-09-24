import 'package:aniflow/data/anime_provider.dart';
import 'package:aniflow/models/anime.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AnimeRef uses adapter-local identity only', () {
    const ref = AnimeRef(providerId: 'example', animeId: 'item-1');

    expect(ref.toJson(), {'providerId': 'example', 'animeId': 'item-1'});
    expect(AnimeRef.fromJson(ref.toJson()), ref);
  });

  test('provider guard rejects references owned by another adapter', () {
    const ref = AnimeRef(providerId: 'alpha', animeId: 'item-1');

    expect(() => requireProvider(ref, 'beta'), throwsArgumentError);
  });
}
