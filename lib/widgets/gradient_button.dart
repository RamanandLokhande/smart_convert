import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final List<Color>? gradient;
  final double? width;
  final double height;
  final bool isLoading;

  const GradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.gradient,
    this.width,
    this.height = 56,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient ?? AppColors.gradientPrimary,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: (gradient ?? AppColors.gradientPrimary)[0].withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.8),
                    ),
                  ),
                )
              : Text(label, style: AppTextStyles.button),
        ),
      ),
    );
  }
}
