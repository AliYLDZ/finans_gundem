import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/news_item.dart';
import '../models/market_ticker.dart';
import '../services/news_service.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';
import '../widgets/market_ticker_bar.dart';
import '../widgets/breaking_news_card.dart';
import '../widgets/daily_summary_card.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class NewsFeedScreen extends StatefulWidget {
  final NewsService newsService;
  final StorageService storageService;

  const NewsFeedScreen({
    super.key,
    required this.newsService,
    required this.storageService,
  });

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  String _selectedCategory = 'Tümü';
  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  List<NewsItem> _newsList = [];
  List<MarketTicker> _tickers = [];
  bool _isLoading = true;

  final List<String> _categories = [
    'Tümü',
    'BIST',
    'ABD Borsaları',
    'Kripto Para',
    'Döviz & Altın',
    'Ekonomi',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final news = await widget.newsService.getNews(
      category: _selectedCategory,
      query: _searchQuery,
    );
    final tickers = widget.newsService.getMarketTickers();

    setState(() {
      _newsList = news;
      _tickers = tickers;
      _isLoading = false;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _loadData();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final todayStr = DateFormat('dd MMMM yyyy, EEEE', 'tr_TR').format(DateTime.now());
    final breakingNews = _newsList.where((n) => n.isBreaking).firstOrNull ?? _newsList.firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Hisseler, coinler veya haberler ara...',
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.show_chart, color: AppColors.primaryGold, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'FINANS GÜNDEM',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    todayStr,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  _searchQuery = '';
                  _loadData();
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Live Market Ticker Header
          if (_tickers.isNotEmpty) MarketTickerBar(tickers: _tickers),

          // Horizontal Category Filter Chips
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => _onCategorySelected(cat),
                    selectedColor: AppColors.primaryGold,
                    checkmarkColor: Colors.black,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 12.5,
                    ),
                    backgroundColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
          ),

          // Main News Feed Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _loadData,
                    child: _newsList.isEmpty
                        ? const Center(
                            child: Text(
                              'Aradığınız kriterlere uygun haber bulunamadı.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 24),
                            itemCount: _newsList.length + 2, // 1 for Hero, 1 for AI Summary
                            itemBuilder: (context, index) {
                              // Item 0: Hero / Breaking News
                              if (index == 0) {
                                if (breakingNews == null) return const SizedBox.shrink();
                                return BreakingNewsCard(
                                  news: breakingNews,
                                  isBookmarked: widget.storageService.isBookmarked(breakingNews.id),
                                  onBookmarkTap: () {
                                    widget.storageService.toggleBookmark(breakingNews.id);
                                    setState(() {});
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => NewsDetailScreen(
                                          news: breakingNews,
                                          storageService: widget.storageService,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }

                              // Item 1: Daily AI Financial Briefing Summary
                              if (index == 1) {
                                return const DailySummaryCard();
                              }

                              // Regular News List Items
                              final newsItem = _newsList[index - 2];
                              return NewsCard(
                                news: newsItem,
                                isBookmarked: widget.storageService.isBookmarked(newsItem.id),
                                onBookmarkTap: () {
                                  widget.storageService.toggleBookmark(newsItem.id);
                                  setState(() {});
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NewsDetailScreen(
                                        news: newsItem,
                                        storageService: widget.storageService,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
