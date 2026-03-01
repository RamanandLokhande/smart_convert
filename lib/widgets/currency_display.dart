import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class CurrencyDisplay extends StatelessWidget {
  final String currency;
  final String amount;
  final String symbol;

  const CurrencyDisplay({
    Key? key,
    required this.currency,
    required this.amount,
    required this.symbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceLight.withOpacity(0.8),
            AppColors.surface.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(currency, style: AppTextStyles.bodySmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(symbol, style: AppTextStyles.heading2),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  amount,
                  style: AppTextStyles.heading2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
