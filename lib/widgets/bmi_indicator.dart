import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class BMIIndicator extends StatelessWidget {
  final double bmi;
  final String category;
  final Duration animationDuration;

  const BMIIndicator({
    Key? key,
    required this.bmi,
    required this.category,
    this.animationDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  Color _getCategoryColor() {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal':
        return AppColors.success;
      case 'Overweight':
        return AppColors.warning;
      case 'Obese':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (bmi - 10) / 40;
    final clampedPercentage = percentage.clamp(0.0, 1.0);

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: clampedPercentage,
                  strokeWidth: 12,
                  backgroundColor: AppColors.surfaceLight,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getCategoryColor(),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bmi.toStringAsFixed(1),
                    style: AppTextStyles.heading1.copyWith(
                      color: _getCategoryColor(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'BMI',
                    style: AppTextStyles.label,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _getCategoryColor().withOpacity(0.2),
            border: Border.all(color: _getCategoryColor(), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            category,
            style: AppTextStyles.heading4.copyWith(
              color: _getCategoryColor(),
            ),
          ),
        ),
      ],
    );
  }
}
