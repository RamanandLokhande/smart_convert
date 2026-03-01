import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/dashboard_screen.dart';

void main() {
  runApp(const DailyUtilityApp());
}

class DailyUtilityApp extends StatelessWidget {
  const DailyUtilityApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Utility Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const DashboardScreen(),
    );
  }
}
