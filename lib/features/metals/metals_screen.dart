import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/metal_service.dart';
import '../../services/history_service.dart';
import '../../models/calculation_history.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';

class MetalsScreen extends StatefulWidget {
  const MetalsScreen({Key? key}) : super(key: key);

  @override
  State<MetalsScreen> createState() => _MetalsScreenState();
}

class _MetalsScreenState extends State<MetalsScreen> {
  final _metalService = MetalService();
  final _historyService = HistoryService();
  final _goldController = TextEditingController();

  double _goldPrice = 0;
  double _silverPrice = 0;

  @override
  void initState() {
    super.initState();
    _loadPrices();
  }

  Future<void> _loadPrices() async {
    try {
      final gold = await _metalService.getGoldPrice();
      final silver = await _metalService.getSilverPrice();

      setState(() {
        _goldPrice = gold;
        _silverPrice = silver;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load prices')),
      );
    }
  }

  void _saveConversion() {
    final goldGrams = double.tryParse(_goldController.text);
    if (goldGrams == null || goldGrams <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid amount')),
      );
      return;
    }

    final silverGrams = _metalService.convertGoldToSilver(goldGrams);

    final history = CalculationHistory(
      type: 'Metals',
      title: 'Gold to Silver',
      value: '${goldGrams.toStringAsFixed(2)}g Gold',
      details: '${silverGrams.toStringAsFixed(2)}g Silver',
    );

    _historyService.addCalculation(history);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Conversion saved'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  void dispose() {
    _goldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goldGrams = double.tryParse(_goldController.text) ?? 0;
    final silverGrams = _metalService.convertGoldToSilver(goldGrams);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Metal Converter'),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _PriceCard(
                      label: 'Gold Price',
                      price: '\$${_goldPrice.toStringAsFixed(2)}/oz',
                      icon: Icons.diamond,
                      color: const Color(0xFFFCD34D),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _PriceCard(
                      label: 'Silver Price',
                      price: '\$${_silverPrice.toStringAsFixed(2)}/oz',
                      icon: Icons.circle,
                      color: Colors.grey[400]!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              GlassCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'Gold to Silver Conversion',
                      style: AppTextStyles.heading4,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _goldController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Enter gold amount (grams)',
                        prefixIcon: const Icon(Icons.diamond),
                        suffixText: 'g',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ratio', style: AppTextStyles.bodySmall),
                              Text(
                                '1:80',
                                style: AppTextStyles.heading4.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Result', style: AppTextStyles.bodySmall),
                              Text(
                                '${silverGrams.toStringAsFixed(2)}g',
                                style: AppTextStyles.heading4.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                label: 'Save Conversion',
                onPressed: _saveConversion,
              ),
              const SizedBox(height: 16),
              GradientButton(
                label: 'Refresh Prices',
                gradient: AppColors.gradientAccent,
                onPressed: _loadPrices,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String label;
  final String price;
  final IconData icon;
  final Color color;

  const _PriceCard({
    required this.label,
    required this.price,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.label),
          const SizedBox(height: 4),
          Text(price, style: AppTextStyles.heading4),
        ],
      ),
    );
  }
}
