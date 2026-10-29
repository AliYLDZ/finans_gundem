import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/storage_service.dart';
import 'services/news_service.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);

  final storageService = await StorageService.init();
  final newsService = NewsService();

  runApp(FinansGundemApp(
    storageService: storageService,
    newsService: newsService,
  ));
}

class FinansGundemApp extends StatefulWidget {
  final StorageService storageService;
  final NewsService newsService;

  const FinansGundemApp({
    super.key,
    required this.storageService,
    required this.newsService,
  });

  @override
  State<FinansGundemApp> createState() => _FinansGundemAppState();
}

class _FinansGundemAppState extends State<FinansGundemApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.storageService.isDarkMode();
  }

  void _onThemeModeChanged(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finans Gündem',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainNavigationScreen(
        newsService: widget.newsService,
        storageService: widget.storageService,
        onThemeModeChanged: _onThemeModeChanged,
      ),
    );
  }
}
