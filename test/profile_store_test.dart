import 'package:aniflow/data/profile_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('profiles persist locally without content-provider state', () async {
    final store = SharedPreferencesProfileStore();
    const profile = AniFlowProfile(
      id: 'profile-a',
      name: 'Profile A',
      avatarId: 'default',
      contentMode: ProfileContentMode.adult,
      pin: '123456',
    );

    await store.save(
      const ProfileCollection(
        profiles: [profile],
        activeProfileId: 'profile-a',
      ),
    );

    final restored = await SharedPreferencesProfileStore().load();
    expect(restored.profiles, hasLength(1));
    expect(restored.activeProfile?.name, 'Profile A');
    expect(restored.activeProfile?.avatarId, 'default');
  });

  test('invalid PIN is rejected', () async {
    final store = SharedPreferencesProfileStore();

    expect(
      () => store.save(
        const ProfileCollection(
          profiles: [
            AniFlowProfile(
              id: 'profile-a',
              name: 'Profile A',
              avatarId: 'default',
              contentMode: ProfileContentMode.child,
              pin: '12345',
            ),
          ],
        ),
      ),
      throwsArgumentError,
    );
  });
}
