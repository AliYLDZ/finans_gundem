class MarketTicker {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final double changePercent;
  final String category; // 'BIST', 'ABD', 'KRIPTO', 'DOVIZ'
  final List<double> sparkline;
  final String currencySymbol;

  bool get isPositive => changePercent >= 0;

  MarketTicker({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.category,
    required this.sparkline,
    this.currencySymbol = '₺',
  });
}
