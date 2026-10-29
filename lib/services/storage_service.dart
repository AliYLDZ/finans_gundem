import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyBookmarks = 'saved_news_ids';
  static const String _keyDarkMode = 'is_dark_mode';
  static const String _keyNotificationEnabled = 'notifications_enabled';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // Bookmarks
  List<String> getBookmarkedIds() {
    return _prefs.getStringList(_keyBookmarks) ?? [];
  }

  Future<bool> toggleBookmark(String newsId) async {
    final list = getBookmarkedIds();
    if (list.contains(newsId)) {
      list.remove(newsId);
      await _prefs.setStringList(_keyBookmarks, list);
      return false; // Removed
    } else {
      list.add(newsId);
      await _prefs.setStringList(_keyBookmarks, list);
      return true; // Added
    }
  }

  bool isBookmarked(String newsId) {
    return getBookmarkedIds().contains(newsId);
  }

  Future<void> clearBookmarks() async {
    await _prefs.remove(_keyBookmarks);
  }

  // Dark Mode
  bool isDarkMode() {
    return _prefs.getBool(_keyDarkMode) ?? true; // Default Dark Theme
  }

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_keyDarkMode, value);
  }

  // Notifications
  bool isNotificationEnabled() {
    return _prefs.getBool(_keyNotificationEnabled) ?? true;
  }

  Future<void> setNotificationEnabled(bool value) async {
    await _prefs.setBool(_keyNotificationEnabled, value);
  }
}
