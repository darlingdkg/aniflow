import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage {
  vietnamese,
  english;

  Locale get locale => switch (this) {
    AppLanguage.vietnamese => const Locale('vi'),
    AppLanguage.english => const Locale('en'),
  };

  String get label => switch (this) {
    AppLanguage.vietnamese => 'Việt Nam',
    AppLanguage.english => 'English',
  };

  String get storageValue => locale.languageCode;

  static AppLanguage fromStorage(String? value) =>
      value == 'en' ? AppLanguage.english : AppLanguage.vietnamese;
}

class AppLanguagePreferences {
  static const key = 'aniflow.settings.language.v1';

  Future<AppLanguage> load() async {
    final value = (await SharedPreferences.getInstance()).getString(key);
    return AppLanguage.fromStorage(value);
  }

  Future<void> save(AppLanguage language) async {
    await (await SharedPreferences.getInstance()).setString(
      key,
      language.storageValue,
    );
  }
}

@immutable
class AniFlowL10n {
  const AniFlowL10n(this.locale);

  final Locale locale;

  bool get _vi => locale.languageCode != 'en';

  String _t(String vi, String en) => _vi ? vi : en;

  static AniFlowL10n of(BuildContext context) =>
      AniFlowL10n(Localizations.localeOf(context));

  String get home => _t('Trang chủ', 'Home');
  String get search => _t('Tìm kiếm', 'Search');
  String get library => _t('Thư viện', 'Library');
  String get personal => _t('Cá nhân', 'Profile');
  String get settings => _t('Cài đặt', 'Settings');
  String get cancel => _t('Hủy', 'Cancel');
  String get save => _t('Lưu', 'Save');
  String get delete => _t('Xóa', 'Delete');

  String get newest => _t('Mới cập nhật', 'Newest');
  String get continueWatching => _t('Tiếp tục xem', 'Continue Watching');
  String get todaySchedule => _t('Lịch phát sóng hôm nay', "Today's schedule");
  String get searchAnime => _t('Tìm kiếm anime', 'Search anime');
  String get favorites => _t('Yêu thích', 'Favorites');
  String get watchLater => _t('Xem sau', 'Watch later');

  String get placeholderContentTitle =>
      _t('Nội dung đang được chuẩn bị', 'Content is being prepared');
  String get placeholderContentCaption =>
      _t('Nội dung sẽ xuất hiện tại đây.', 'Content will appear here.');

  String get darkMode => _t('Chế độ tối', 'Dark mode');
  String get language => _t('Ngôn ngữ', 'Language');

  String get noProfile => _t('Chưa có hồ sơ', 'No profile');
  String get createProfile => _t('Tạo hồ sơ', 'Create profile');
  String get profileName => _t('Tên hồ sơ', 'Profile name');
  String get pin => 'PIN';
  String get contentSuitability =>
      _t('Nội dung phù hợp', 'Content suitability');
  String get adultNsfw => _t('Người lớn (NSFW)', 'Adult (NSFW)');
  String get childSfw => _t('Trẻ em (SFW)', 'Kids (SFW)');
  String get profileStoredLocally =>
      _t('Hồ sơ được lưu cục bộ', 'Profile stored locally');
  String get frameworkNotice => _t(
    'Bản mã nguồn công khai chỉ chứa khung ứng dụng. Không bao gồm nguồn nội dung, trình phân tích, endpoint hoặc bộ giải phát video của bên thứ ba.',
    'The public source contains only the app framework. Third-party content sources, parsers, endpoints and playback resolvers are not included.',
  );
}

extension AniFlowLocalizationContext on BuildContext {
  AniFlowL10n get l10n => AniFlowL10n.of(this);
}
