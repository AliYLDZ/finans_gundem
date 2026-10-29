import 'package:flutter/material.dart';
import '../models/market_ticker.dart';
import '../theme/app_colors.dart';

class MarketTickerBar extends StatelessWidget {
  final List<MarketTicker> tickers;
  final Function(MarketTicker)? onTickerTap;

  const MarketTickerBar({
    super.key,
    required this.tickers,
    this.onTickerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: tickers.length,
        separatorBuilder: (context, index) => const VerticalDivider(
          width: 16,
          indent: 6,
          endIndent: 6,
          color: AppColors.darkBorder,
        ),
        itemBuilder: (context, index) {
          final ticker = tickers[index];
          final isPositive = ticker.isPositive;
          final color = isPositive ? AppColors.bullishGreen : AppColors.bearishRed;
          final icon = isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down;

          return InkWell(
            onTap: () => onTickerTap?.call(ticker),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ticker.symbol,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${ticker.price.toStringAsFixed(ticker.price > 100 ? 2 : 4)} ${ticker.currencySymbol}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(icon, size: 14, color: color),
                        Text(
                          '${isPositive ? '+' : ''}${ticker.changePercent.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
