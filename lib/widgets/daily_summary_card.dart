import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue.withOpacity(0.2),
            AppColors.primaryGold.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryGold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.black, size: 16),
              ),
              const SizedBox(width: 8),
              const Text(
                'Günün Finans Özeti',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.primaryGold,
                ),
              ),
              const Spacer(),
              Text(
                'BUGÜN',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildBullet(context, 'BIST 100 bankacılık ve THYAO öncülüğünde %1.47 yükselerek 9.845 puana ulaştı.'),
          const SizedBox(height: 6),
          _buildBullet(context, 'Fed faiz indirimi beklentileriyle Wall Street yükselişte; Nvidia %2.31 prim yaptı.'),
          const SizedBox(height: 6),
          _buildBullet(context, 'Bitcoin spot ETF girişleriyle 68.400\$ seviyesini aştı, Ons Altın rekor tazeledi.'),
        ],
      ),
    );
  }

  Widget _buildBullet(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(Icons.fiber_manual_record, size: 6, color: AppColors.primaryGold),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.35,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}
