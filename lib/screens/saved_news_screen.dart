import 'package:flutter/material.dart';
import '../models/news_item.dart';
import '../services/news_service.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class SavedNewsScreen extends StatefulWidget {
  final NewsService newsService;
  final StorageService storageService;

  const SavedNewsScreen({
    super.key,
    required this.newsService,
    required this.storageService,
  });

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  List<NewsItem> _savedNews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedNews();
  }

  Future<void> _loadSavedNews() async {
    setState(() => _isLoading = true);
    final savedIds = widget.storageService.getBookmarkedIds();
    final allNews = await widget.newsService.getNews();

    final filtered = allNews.where((news) => savedIds.contains(news.id)).toList();

    setState(() {
      _savedNews = filtered;
      _isLoading = false;
    });
  }

  void _clearAll() async {
    await widget.storageService.clearBookmarks();
    _loadSavedNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.bookmark, color: AppColors.primaryGold),
            SizedBox(width: 8),
            Text('Kaydedilen Haberler'),
          ],
        ),
        actions: [
          if (_savedNews.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Tümünü Temizle',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Tümünü Temizle'),
                    content: const Text('Kaydedilen tüm haberler silinecek. Onaylıyor musunuz?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('İptal'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _clearAll();
                        },
                        child: const Text('Sil', style: TextStyle(color: AppColors.bearishRed)),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedNews.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 64,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Henüz kaydedilmiş bir haber bulunmuyor.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'İlginizi çeken haberleri kaydederek daha sonra okuyabilirsiniz.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _savedNews.length,
                  itemBuilder: (context, index) {
                    final news = _savedNews[index];
                    return NewsCard(
                      news: news,
                      isBookmarked: true,
                      onBookmarkTap: () async {
                        await widget.storageService.toggleBookmark(news.id);
                        _loadSavedNews();
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsDetailScreen(
                              news: news,
                              storageService: widget.storageService,
                            ),
                          ),
                        ).then((_) => _loadSavedNews());
                      },
                    );
                  },
                ),
    );
  }
}
