import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/news_item.dart';
import '../theme/app_colors.dart';

class BreakingNewsCard extends StatelessWidget {
  final NewsItem news;
  final VoidCallback onTap;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const BreakingNewsCard({
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
    final timeAgo = DateFormat('HH:mm').format(news.publishedAt);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(news.imageUrl),
            fit: BoxFit.cover,
            onError: (_, __) {},
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.black.withValues(alpha: 0.85),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Bar: Category Chip & Breaking Tag + Bookmark Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: catColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          news.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (news.isBreaking) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.bearishRed,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.flash_on, color: Colors.white, size: 12),
                              SizedBox(width: 2),
                              Text(
                                'SON DAKİKA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? AppColors.primaryGold : Colors.white,
                    ),
                    onPressed: onBookmarkTap,
                  ),
                ],
              ),

              // Title & Meta Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        news.source,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(' • ', style: TextStyle(color: Colors.white54)),
                      Text(
                        timeAgo,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const Text(' • ', style: TextStyle(color: Colors.white54)),
                      const Icon(Icons.access_time, size: 12, color: Colors.white70),
                      const SizedBox(width: 2),
                      Text(
                        '${news.readingTimeMinutes} dk',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
