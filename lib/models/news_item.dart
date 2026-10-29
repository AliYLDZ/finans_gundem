class NewsItem {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String category; // 'BIST', 'ABD Borsaları', 'Kripto Para', 'Döviz & Altın', 'Ekonomi'
  final String imageUrl;
  final String source;
  final DateTime publishedAt;
  final bool isBreaking;
  final List<String> relatedSymbols;
  final String url;
  final int readingTimeMinutes;

  NewsItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    this.isBreaking = false,
    required this.relatedSymbols,
    required this.url,
    this.readingTimeMinutes = 3,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'category': category,
      'imageUrl': imageUrl,
      'source': source,
      'publishedAt': publishedAt.toIso8601String(),
      'isBreaking': isBreaking,
      'relatedSymbols': relatedSymbols,
      'url': url,
      'readingTimeMinutes': readingTimeMinutes,
    };
  }

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      source: json['source'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      isBreaking: json['isBreaking'] as bool? ?? false,
      relatedSymbols: List<String>.from(json['relatedSymbols'] ?? []),
      url: json['url'] as String? ?? 'https://finance.yahoo.com',
      readingTimeMinutes: json['readingTimeMinutes'] as int? ?? 3,
    );
  }
}
