import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/news_item.dart';
import '../theme/app_colors.dart';

class NewsCard extends StatelessWidget {
  final NewsItem news;
  final VoidCallback onTap;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const NewsCard({
    super.key,
    required this.news,
    required this.onTap,
    required this.isBookmarked,
    required this.onBookmarkTap,
  });

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'BIST':
        return AppColors.catBist;
      case 'ABD Borsaları':
        return AppColors.catUsMarkets;
      case 'Kripto Para':
        return AppColors.catCrypto;
      case 'Döviz & Altın':
        return AppColors.catForex;
      default:
        return AppColors.catMacro;
    }
  }

  @override
  Widget build(BuildContext context) {
    final catColor = _getCategoryColor(news.category);
    final timeStr = DateFormat('HH:mm').format(news.publishedAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // News Thumbnail Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  news.imageUrl,
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 95,
                    height: 95,
                    color: AppColors.darkBorder,
                    child: const Icon(Icons.newspaper, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // News Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category & Bookmark
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: catColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: catColor.withOpacity(0.4), width: 0.5),
                          ),
                          child: Text(
                            news.category,
                            style: TextStyle(
                              color: catColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onBookmarkTap,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                              size: 18,
                              color: isBookmarked ? AppColors.primaryGold : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Text(
                      news.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Related Symbols & Source Time
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${news.source} • $timeStr',
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                        if (news.relatedSymbols.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              news.relatedSymbols.first,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryGold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
