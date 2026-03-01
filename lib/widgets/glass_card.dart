import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../core/theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final Gradient? gradient;

  const GlassCard({
    Key? key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              gradient: gradient ?? _defaultGradient(),
              color: Colors.black.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.06),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  LinearGradient _defaultGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.surfaceLight.withOpacity(0.8),
        AppColors.surface.withOpacity(0.6),
      ],
    );
  }
}
