import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../services/storage_service.dart';
import 'news_feed_screen.dart';
import 'markets_screen.dart';
import 'saved_news_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final NewsService newsService;
  final StorageService storageService;
  final Function(bool) onThemeModeChanged;

  const MainNavigationScreen({
    super.key,
    required this.newsService,
    required this.storageService,
    required this.onThemeModeChanged,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      NewsFeedScreen(
        newsService: widget.newsService,
        storageService: widget.storageService,
      ),
      MarketsScreen(
        newsService: widget.newsService,
      ),
      SavedNewsScreen(
        newsService: widget.newsService,
        storageService: widget.storageService,
      ),
      SettingsScreen(
        storageService: widget.storageService,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            activeIcon: Icon(Icons.newspaper, color: Colors.amber),
            label: 'Gündem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            activeIcon: Icon(Icons.show_chart, color: Colors.amber),
            label: 'Piyasalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark, color: Colors.amber),
            label: 'Kaydedilenler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings, color: Colors.amber),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}
