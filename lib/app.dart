import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/profile_store.dart';
import 'language.dart';
import 'theme.dart';
import 'widgets/tabs/placeholder_content_tabs.dart';

class AniFlowApp extends StatefulWidget {
  const AniFlowApp({super.key});

  @override
  State<AniFlowApp> createState() => _AniFlowAppState();
}

class _AniFlowAppState extends State<AniFlowApp> {
  final _themePreferences = ThemeModePreferences();
  final _languagePreferences = AppLanguagePreferences();

  ThemeMode _themeMode = ThemeMode.light;
  AppLanguage _language = AppLanguage.vietnamese;

  @override
  void initState() {
    super.initState();
    unawaited(_restorePreferences());
  }

  Future<void> _restorePreferences() async {
    final results = await Future.wait<Object>([
      _themePreferences.load(),
      _languagePreferences.load(),
    ]);
    if (!mounted) return;
    setState(() {
      _themeMode = results[0] as ThemeMode;
      _language = results[1] as AppLanguage;
    });
  }

  Future<void> _setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    setState(() => _themeMode = mode);
    await _themePreferences.save(mode);
  }

  Future<void> _setLanguage(AppLanguage language) async {
    if (_language == language) return;
    setState(() => _language = language);
    await _languagePreferences.save(language);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AniFlow',
    locale: _language.locale,
    supportedLocales: const [Locale('vi'), Locale('en')],
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: aniFlowTheme(),
    darkTheme: aniFlowDarkTheme(),
    themeMode: _themeMode,
    home: AppShell(
      themeMode: _themeMode,
      language: _language,
      onThemeModeChanged: _setThemeMode,
      onLanguageChanged: _setLanguage,
    ),
  );
}

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.themeMode,
    required this.language,
    required this.onThemeModeChanged,
    required this.onLanguageChanged,
  });

  final ThemeMode themeMode;
  final AppLanguage language;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<AppLanguage> onLanguageChanged;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _homeScrollController = ScrollController();
  var _index = 0;
  var _showingWatchLater = false;

  @override
  void dispose() {
    _homeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      PlaceholderHomeTab(scrollController: _homeScrollController),
      const PlaceholderSearchTab(),
      PlaceholderLibraryTab(
        showingWatchLater: _showingWatchLater,
        onShowFavorites: () => setState(() => _showingWatchLater = false),
        onShowWatchLater: () => setState(() => _showingWatchLater = true),
      ),
      FrameworkPersonalTab(
        themeMode: widget.themeMode,
        language: widget.language,
        onThemeModeChanged: widget.onThemeModeChanged,
        onLanguageChanged: widget.onLanguageChanged,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _index, children: tabs),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Material(
          key: const ValueKey('bottom-nav-shell'),
          color: Theme.of(context).colorScheme.surfaceContainer,
          elevation: 6,
          borderRadius: BorderRadius.circular(AniFlowRadii.card),
          clipBehavior: Clip.antiAlias,
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (value) => setState(() => _index = value),
            backgroundColor: Colors.transparent,
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: context.l10n.home,
              ),
              NavigationDestination(
                icon: const Icon(Icons.search_rounded),
                label: context.l10n.search,
              ),
              NavigationDestination(
                icon: const Icon(Icons.video_library_outlined),
                selectedIcon: const Icon(Icons.video_library_rounded),
                label: context.l10n.library,
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline_rounded),
                selectedIcon: const Icon(Icons.person_rounded),
                label: context.l10n.personal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FrameworkPersonalTab extends StatefulWidget {
  const FrameworkPersonalTab({
    super.key,
    required this.themeMode,
    required this.language,
    required this.onThemeModeChanged,
    required this.onLanguageChanged,
  });

  final ThemeMode themeMode;
  final AppLanguage language;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<AppLanguage> onLanguageChanged;

  @override
  State<FrameworkPersonalTab> createState() => _FrameworkPersonalTabState();
}

class _FrameworkPersonalTabState extends State<FrameworkPersonalTab> {
  final ProfileStore _store = SharedPreferencesProfileStore();
  ProfileCollection _profiles = const ProfileCollection();
  var _loading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_loadProfiles());
  }

  Future<void> _loadProfiles() async {
    final profiles = await _store.load();
    if (!mounted) return;
    setState(() {
      _profiles = profiles;
      _loading = false;
    });
  }

  Future<void> _saveProfiles(ProfileCollection value) async {
    await _store.save(value);
    if (!mounted) return;
    setState(() => _profiles = value);
  }

  Future<void> _createProfile() async {
    final nameController = TextEditingController();
    final pinController = TextEditingController();
    var mode = ProfileContentMode.adult;

    final result = await showDialog<AniFlowProfile>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(context.l10n.createProfile),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: context.l10n.profileName,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                decoration: InputDecoration(labelText: context.l10n.pin),
              ),
              const SizedBox(height: 4),
              DropdownButtonFormField<ProfileContentMode>(
                initialValue: mode,
                decoration: InputDecoration(
                  labelText: context.l10n.contentSuitability,
                ),
                items: [
                  DropdownMenuItem(
                    value: ProfileContentMode.adult,
                    child: Text(context.l10n.adultNsfw),
                  ),
                  DropdownMenuItem(
                    value: ProfileContentMode.child,
                    child: Text(context.l10n.childSfw),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setDialogState(() => mode = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                final pin = pinController.text.trim();
                if (name.isEmpty || !isValidProfilePin(pin)) return;
                Navigator.pop(
                  dialogContext,
                  AniFlowProfile(
                    id: 'profile_${DateTime.now().microsecondsSinceEpoch}',
                    name: name,
                    avatarId: 'default',
                    contentMode: mode,
                    pin: pin,
                  ),
                );
              },
              child: Text(context.l10n.save),
            ),
          ],
        ),
      ),
    );

    nameController.dispose();
    pinController.dispose();
    if (result == null) return;

    await _saveProfiles(
      ProfileCollection(
        profiles: [..._profiles.profiles, result],
        activeProfileId: result.id,
      ),
    );
  }

  Future<void> _activateProfile(AniFlowProfile profile) => _saveProfiles(
    ProfileCollection(
      profiles: _profiles.profiles,
      activeProfileId: profile.id,
    ),
  );

  Future<void> _deleteProfile(AniFlowProfile profile) {
    final next = _profiles.profiles
        .where((item) => item.id != profile.id)
        .toList(growable: false);
    final active = _profiles.activeProfileId == profile.id
        ? (next.isEmpty ? null : next.first.id)
        : _profiles.activeProfileId;
    return _saveProfiles(
      ProfileCollection(profiles: next, activeProfileId: active),
    );
  }

  @override
  Widget build(BuildContext context) => ListView(
    key: const ValueKey('framework-personal-tab'),
    padding: const EdgeInsets.fromLTRB(
      AniFlowSpacing.pageHorizontal,
      20,
      AniFlowSpacing.pageHorizontal,
      120,
    ),
    children: [
      Text(
        context.l10n.personal,
        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 18),
      _ProfileSection(
        loading: _loading,
        profiles: _profiles,
        onCreate: _createProfile,
        onActivate: _activateProfile,
        onDelete: _deleteProfile,
      ),
      const SizedBox(height: 24),
      Text(
        context.l10n.settings,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 8),
      Card(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            SwitchListTile(
              title: Text(context.l10n.darkMode),
              value: widget.themeMode == ThemeMode.dark,
              onChanged: (value) => widget.onThemeModeChanged(
                value ? ThemeMode.dark : ThemeMode.light,
              ),
            ),
            const Divider(height: 1),
            ListTile(
              title: Text(context.l10n.language),
              trailing: DropdownButton<AppLanguage>(
                value: widget.language,
                underline: const SizedBox.shrink(),
                items: [
                  for (final language in AppLanguage.values)
                    DropdownMenuItem(
                      value: language,
                      child: Text(language.label),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) widget.onLanguageChanged(value);
                },
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Text(
        context.l10n.frameworkNotice,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    ],
  );
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
    required this.loading,
    required this.profiles,
    required this.onCreate,
    required this.onActivate,
    required this.onDelete,
  });

  final bool loading;
  final ProfileCollection profiles;
  final VoidCallback onCreate;
  final ValueChanged<AniFlowProfile> onActivate;
  final ValueChanged<AniFlowProfile> onDelete;

  @override
  Widget build(BuildContext context) {
    if (loading) return const LinearProgressIndicator();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AniFlowSpacing.cardContent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  child: const Icon(Icons.person_rounded, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profiles.activeProfile?.name ?? context.l10n.noProfile,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.l10n.profileStoredLocally,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: context.l10n.createProfile,
                  onPressed: onCreate,
                  icon: const Icon(Icons.add_rounded),
                ),
              ],
            ),
            if (profiles.profiles.isNotEmpty) ...[
              const SizedBox(height: 12),
              for (final profile in profiles.profiles)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    profile.id == profiles.activeProfileId
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                  ),
                  title: Text(profile.name),
                  subtitle: Text(
                    profile.contentMode == ProfileContentMode.child
                        ? context.l10n.childSfw
                        : context.l10n.adultNsfw,
                  ),
                  onTap: () => onActivate(profile),
                  trailing: IconButton(
                    tooltip: context.l10n.delete,
                    onPressed: () => onDelete(profile),
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
