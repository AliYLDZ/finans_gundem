import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../models/news_item.dart';
import '../models/market_ticker.dart';
import '../data/mock_news_data.dart';
import '../data/mock_market_data.dart';

class NewsService {
  List<NewsItem> _cachedNews = [];

  NewsService() {
    _cachedNews = MockNewsData.getNews();
  }

  Future<List<NewsItem>> getNews({String? category, String? query}) async {
    try {
      if (_cachedNews.isEmpty) {
        _cachedNews = MockNewsData.getNews();
      }
    } catch (_) {
      _cachedNews = MockNewsData.getNews();
    }

    List<NewsItem> result = List.from(_cachedNews);

    if (category != null && category != 'Tümü' && category.isNotEmpty) {
      result = result.where((item) => item.category.toLowerCase() == category.toLowerCase()).toList();
    }

    if (query != null && query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
      result = result.where((item) {
        return item.title.toLowerCase().contains(q) ||
            item.summary.toLowerCase().contains(q) ||
            item.content.toLowerCase().contains(q) ||
            item.relatedSymbols.any((s) => s.toLowerCase().contains(q));
      }).toList();
    }

    return result;
  }

  Future<NewsItem?> getNewsById(String id) async {
    final all = await getNews();
    try {
      return all.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  List<MarketTicker> getMarketTickers() {
    return MockMarketData.getTickers();
  }

  Future<List<NewsItem>> fetchRssFeed(String feedUrl, String categoryName) async {
    try {
      final response = await http.get(Uri.parse(feedUrl)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final items = document.findAllElements('item');
        List<NewsItem> rssNews = [];

        int index = 0;
        for (var element in items) {
          final title = element.findElements('title').firstOrNull?.innerText ?? '';
          final description = element.findElements('description').firstOrNull?.innerText ?? '';
          final link = element.findElements('link').firstOrNull?.innerText ?? '';
          final pubDateStr = element.findElements('pubDate').firstOrNull?.innerText ?? '';

          if (title.isNotEmpty) {
            rssNews.add(
              NewsItem(
                id: 'rss_${categoryName}_$index',
                title: title,
                summary: description.replaceAll(RegExp(r'<[^>]*>'), '').trim(),
                content: description.replaceAll(RegExp(r'<[^>]*>'), '').trim(),
                category: categoryName,
                imageUrl: 'https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?w=800&q=80',
                source: 'Canlı RSS',
                publishedAt: DateTime.tryParse(pubDateStr) ?? DateTime.now(),
                relatedSymbols: [],
                url: link,
                readingTimeMinutes: 3,
              ),
            );
            index++;
          }
        }
        return rssNews;
      }
    } catch (e) {
      // Return empty list if offline or error
    }
    return [];
  }
}
