import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables if available. Missing file shouldn't crash the app.
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // file might not exist in repo (e.g. on CI or developer machine).
    // Log but proceed with defaults.
    debugPrint('dotenv load failed: $e');
  }

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