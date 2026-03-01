import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'widgets/quick_convert_widget.dart';
import 'widgets/tool_card.dart';
import 'widgets/frequent_item.dart';
import 'widgets/category_title.dart';
import '../unit_converter/unit_converter_screen.dart';
import '../currency/currency_screen.dart';
import '../emi/emi_screen.dart';
import '../fuel/fuel_screen.dart';
import '../gst/gst_screen.dart';
import '../bmi/bmi_screen.dart';
import '../metals/metals_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text(
          'Smart Converter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.user, color: Colors.white),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      LucideIcons.rotateCw,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Sync',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search utility...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      LucideIcons.search,
                      color: Color(0xFF94A3B8),
                    ),
                    suffixIcon: const Icon(
                      LucideIcons.mic,
                      color: Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Quick Convert Widget
              const QuickConvertWidget(),
              const SizedBox(height: 32),

              // Frequent Section
              const Text(
                'FREQUENT',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FrequentItem(
                      label: 'Length',
                      icon: Icons.straighten,
                      color: const Color(0xFF06B6D4),
                    ),
                    FrequentItem(
                      label: 'Currency',
                      icon: LucideIcons.dollarSign,
                      color: const Color(0xFF10B981),
                    ),
                    FrequentItem(
                      label: 'EMI',
                      icon: LucideIcons.calculator,
                      color: const Color(0xFFF59E0B),
                    ),
                    FrequentItem(
                      label: 'Fuel',
                      icon: LucideIcons.fuel,
                      color: const Color(0xFFEF4444),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // All Tools Section - Finance & Shopping
              const CategoryTitle('Finance & Shopping'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  ToolCard(
                    title: 'Currency Converter',
                    icon: LucideIcons.dollarSign,
                    iconColor: const Color(0xFF10B981),
                    description: 'Live exchange rates',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CurrencyScreen(),
                      ),
                    ),
                  ),
                  ToolCard(
                    title: 'EMI Calculator',
                    icon: LucideIcons.calculator,
                    iconColor: const Color(0xFFF59E0B),
                    description: 'Loan EMI & schedule',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EmiScreen()),
                    ),
                  ),
                  ToolCard(
                    title: 'GST Calculator',
                    icon: LucideIcons.receipt,
                    iconColor: const Color(0xFF3B82F6),
                    description: 'Add or remove tax',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GstScreen()),
                    ),
                  ),
                  ToolCard(
                    title: 'Discount Calculator',
                    icon: LucideIcons.tag,
                    iconColor: const Color(0xFF8B5CF6),
                    description: 'Calculate discounts',
                    onTap: () {
                      // Placeholder - adjust when screen is created
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Discount Calculator - Coming Soon'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // All Tools Section - Daily Life & Health
              const CategoryTitle('Daily Life & Health'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  ToolCard(
                    title: 'Unit Converter',
                    icon: Icons.straighten,
                    iconColor: const Color(0xFF06B6D4),
                    description: 'Length, weight & more',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UnitConverterScreen(),
                      ),
                    ),
                  ),
                  ToolCard(
                    title: 'Fuel Cost',
                    icon: LucideIcons.fuel,
                    iconColor: const Color(0xFFEF4444),
                    description: 'Estimate fuel & cost',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FuelScreen()),
                    ),
                  ),
                  ToolCard(
                    title: 'BMI Calculator',
                    icon: LucideIcons.activity,
                    iconColor: const Color(0xFF3B82F6),
                    description: 'Health metrics',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BMIScreen()),
                    ),
                  ),
                  ToolCard(
                    title: 'Tip Calculator',
                    icon: Icons.money,
                    iconColor: const Color(0xFF10B981),
                    description: 'Calculate tips',
                    onTap: () {
                      // Placeholder - adjust when screen is created
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tip Calculator - Coming Soon'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // All Tools Section - Tech & Science
              const CategoryTitle('Tech & Science'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  ToolCard(
                    title: 'Timezone Converter',
                    icon: LucideIcons.globe,
                    iconColor: const Color(0xFF8B5CF6),
                    description: 'World timezones',
                    onTap: () {
                      // Placeholder - adjust when screen is created
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Timezone Converter - Coming Soon'),
                        ),
                      );
                    },
                  ),
                  ToolCard(
                    title: 'Scientific Calculator',
                    icon: LucideIcons.calculator,
                    iconColor: const Color(0xFFF59E0B),
                    description: 'Advanced calculations',
                    onTap: () {
                      // Placeholder - adjust when screen is created
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Scientific Calculator - Coming Soon'),
                        ),
                      );
                    },
                  ),
                  ToolCard(
                    title: 'Metals Calculator',
                    icon: LucideIcons.sparkles,
                    iconColor: const Color(0xFFFCD34D),
                    description: 'Gold & silver prices',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MetalsScreen()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: const Color(0xFF64748B),
        currentIndex: _currentBottomNavIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.clock),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.grid),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
      ),
    );
  }
}

