import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final IconData icon;

  const CustomCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.card,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.heading),
                  const SizedBox(height: 6),
                  Text(subtitle, style: AppTextStyles.subtitle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
