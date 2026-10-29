import 'package:flutter/material.dart';
import '../models/market_ticker.dart';
import '../services/news_service.dart';
import '../theme/app_colors.dart';
import '../widgets/market_quote_card.dart';

class MarketsScreen extends StatefulWidget {
  final NewsService newsService;

  const MarketsScreen({super.key, required this.newsService});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MarketTicker> _allTickers = [];

  final List<String> _tabs = ['Tümü', 'BIST', 'ABD', 'KRIPTO', 'DOVIZ'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _loadTickers();
  }

  void _loadTickers() {
    setState(() {
      _allTickers = widget.newsService.getMarketTickers();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.candlestick_chart, color: AppColors.primaryGold),
            SizedBox(width: 8),
            Text(
              'Canlı Piyasalar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.primaryGold,
          labelColor: AppColors.primaryGold,
          unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tabName) {
          final filtered = tabName == 'Tümü'
              ? _allTickers
              : _allTickers.where((t) => t.category.toUpperCase() == tabName.toUpperCase()).toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return MarketQuoteCard(ticker: filtered[index]);
            },
          );
        }).toList(),
      ),
    );
  }
}
