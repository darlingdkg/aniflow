import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum ProfileContentMode { adult, child }

class AniFlowProfile {
  const AniFlowProfile({
    required this.id,
    required this.name,
    required this.avatarId,
    required this.contentMode,
    required this.pin,
  });

  final String id;
  final String name;
  final String avatarId;
  final ProfileContentMode contentMode;
  final String pin;

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'avatarId': avatarId,
    'contentMode': contentMode.name,
    'pin': pin,
  };

  static AniFlowProfile? fromJson(
    Object? value, {
    bool allowLegacyPassword = false,
  }) {
    if (value is! Map) return null;
    final id = value['id'];
    final name = value['name'];
    final avatarId = value['avatarId'];
    final contentMode = value['contentMode'];
    final pin =
        value['pin'] ?? (allowLegacyPassword ? value['password'] : null);
    if (id is! String ||
        id.isEmpty ||
        name is! String ||
        name.trim().isEmpty ||
        avatarId is! String ||
        avatarId.isEmpty ||
        contentMode is! String ||
        pin is! String ||
        !isValidProfilePin(pin)) {
      return null;
    }
    ProfileContentMode? parsedMode;
    for (final mode in ProfileContentMode.values) {
      if (mode.name == contentMode) {
        parsedMode = mode;
        break;
      }
    }
    if (parsedMode == null) return null;
    return AniFlowProfile(
      id: id,
      name: name,
      avatarId: avatarId,
      contentMode: parsedMode,
      pin: pin,
    );
  }
}

bool isValidProfilePin(String value) => RegExp(r'^\d{6}$').hasMatch(value);

class ProfileCollection {
  const ProfileCollection({this.profiles = const [], this.activeProfileId});

  final List<AniFlowProfile> profiles;
  final String? activeProfileId;

  AniFlowProfile? get activeProfile {
    final id = activeProfileId;
    if (id == null) return null;
    for (final profile in profiles) {
      if (profile.id == id) return profile;
    }
    return null;
  }
}

abstract class ProfileStore {
  Future<ProfileCollection> load();
  Future<void> save(ProfileCollection collection);
}

class SharedPreferencesProfileStore implements ProfileStore {
  static const key = 'aniflow_profiles_v2';
  static const legacyKey = 'aniflow_profiles_v1';
  static const _schema = 2;

  SharedPreferences? _preferences;

  Future<SharedPreferences> _prefs() async =>
      _preferences ??= await SharedPreferences.getInstance();

  @override
  Future<ProfileCollection> load() async {
    final prefs = await _prefs();
    final raw = prefs.getString(key);
    if (raw == null || raw.isEmpty) {
      return _loadLegacy(prefs);
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map || decoded['schema'] != _schema) {
        return const ProfileCollection();
      }
      final rawProfiles = decoded['profiles'];
      final profiles = <AniFlowProfile>[];
      if (rawProfiles is List) {
        for (final value in rawProfiles) {
          final profile = AniFlowProfile.fromJson(value);
          if (profile != null &&
              !profiles.any((existing) => existing.id == profile.id)) {
            profiles.add(profile);
          }
        }
      }
      final requestedActive = decoded['activeProfileId'];
      final activeProfileId =
          requestedActive is String &&
              profiles.any((profile) => profile.id == requestedActive)
          ? requestedActive
          : null;
      return ProfileCollection(
        profiles: List.unmodifiable(profiles),
        activeProfileId: activeProfileId,
      );
    } catch (_) {
      return const ProfileCollection();
    }
  }

  Future<ProfileCollection> _loadLegacy(SharedPreferences prefs) async {
    final raw = prefs.getString(legacyKey);
    if (raw == null || raw.isEmpty) return const ProfileCollection();
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map || decoded['schema'] != 1) {
        return const ProfileCollection();
      }
      final rawProfiles = decoded['profiles'];
      final profiles = <AniFlowProfile>[];
      if (rawProfiles is List) {
        for (final value in rawProfiles) {
          final profile = AniFlowProfile.fromJson(
            value,
            allowLegacyPassword: true,
          );
          if (profile != null &&
              !profiles.any((existing) => existing.id == profile.id)) {
            profiles.add(profile);
          }
        }
      }
      final requestedActive = decoded['activeProfileId'];
      final activeProfileId =
          requestedActive is String &&
              profiles.any((profile) => profile.id == requestedActive)
          ? requestedActive
          : null;
      final migrated = ProfileCollection(
        profiles: List.unmodifiable(profiles),
        activeProfileId: activeProfileId,
      );
      if (profiles.isNotEmpty) {
        try {
          await save(migrated);
        } catch (_) {
          // The valid in-memory migration remains usable for this session.
        }
      }
      return migrated;
    } catch (_) {
      return const ProfileCollection();
    }
  }

  @override
  Future<void> save(ProfileCollection collection) async {
    if (collection.profiles.any((profile) => !isValidProfilePin(profile.pin))) {
      throw ArgumentError.value(
        collection.profiles,
        'profiles',
        'Every profile PIN must contain exactly six digits.',
      );
    }
    final activeId = collection.activeProfileId;
    final normalizedActive =
        activeId != null &&
            collection.profiles.any((profile) => profile.id == activeId)
        ? activeId
        : null;
    final payload = jsonEncode({
      'schema': _schema,
      'activeProfileId': normalizedActive,
      'profiles': [for (final profile in collection.profiles) profile.toJson()],
    });
    final saved = await (await _prefs()).setString(key, payload);
    if (!saved) throw StateError('Unable to persist profiles.');
  }
}
