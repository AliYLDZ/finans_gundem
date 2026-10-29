import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_item.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsItem news;
  final StorageService storageService;

  const NewsDetailScreen({
    super.key,
    required this.news,
    required this.storageService,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late bool _isBookmarked;
  double _fontSizeDelta = 0; // -2 to +6 font size adjustment

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.storageService.isBookmarked(widget.news.id);
  }

  void _toggleBookmark() async {
    final newState = await widget.storageService.toggleBookmark(widget.news.id);
    setState(() {
      _isBookmarked = newState;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            newState ? 'Haber kaydedilenlere eklendi' : 'Haber kaydedilenlerden çıkarıldı',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _openOriginalUrl() async {
    final Uri url = Uri.parse(widget.news.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sayfa açılamadı')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;
    final dateStr = DateFormat('dd MMMM yyyy - HH:mm', 'tr_TR').format(news.publishedAt);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image Header
          SliverAppBar(
            expandedHeight: 260.0,
            floating: false,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: _isBookmarked ? AppColors.primaryGold : null,
                ),
                onPressed: _toggleBookmark,
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Haber bağlantısı kopyalandı')),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    news.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppColors.darkSurface),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Article Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Reading Time Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          news.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.text_decrease, size: 20),
                            onPressed: () {
                              if (_fontSizeDelta > -3) {
                                setState(() => _fontSizeDelta -= 1);
                              }
                            },
                          ),
                          Text(
                            'A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14 + _fontSizeDelta,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.text_increase, size: 20),
                            onPressed: () {
                              if (_fontSizeDelta < 6) {
                                setState(() => _fontSizeDelta += 1);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    news.title,
                    style: TextStyle(
                      fontSize: 22 + _fontSizeDelta,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Source & Date
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.primaryGold,
                        child: Icon(Icons.newspaper, size: 14, color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        news.source,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),

                  // Related Symbols
                  if (news.relatedSymbols.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: news.relatedSymbols.map((sym) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.primaryGold.withOpacity(0.4)),
                          ),
                          child: Text(
                            '\$$sym',
                            style: const TextStyle(
                              color: AppColors.primaryGold,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  const Divider(height: 32),

                  // Summary Highlight Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: const Border(
                        left: BorderSide(color: AppColors.primaryGold, width: 4),
                      ),
                    ),
                    child: Text(
                      news.summary,
                      style: TextStyle(
                        fontSize: 15 + _fontSizeDelta,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Article Main Content
                  Text(
                    news.content,
                    style: TextStyle(
                      fontSize: 15 + _fontSizeDelta,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Open Source Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _openOriginalUrl,
                      icon: const Icon(Icons.open_in_browser),
                      label: Text(
                        '${news.source} Kaynağında Oku',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
