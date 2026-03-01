import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/bmi_service.dart';
import '../../services/history_service.dart';
import '../../models/calculation_history.dart';
import '../../widgets/custom_slider.dart';
import '../../widgets/bmi_indicator.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/glass_card.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> with TickerProviderStateMixin {
  double _height = 170;
  double _weight = 70;
  late AnimationController _animationController;
  final _historyService = HistoryService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateAndSave() {
    _animationController.forward(from: 0);

    final bmi = BMIService.calculateBMI(_height, _weight);
    final category = BMIService.getBMICategory(bmi);

    final history = CalculationHistory(
      type: 'BMI',
      title: 'BMI Calculation',
      value: bmi.toStringAsFixed(1),
      details: 'Height: ${_height.toInt()}cm, Weight: ${_weight.toInt()}kg',
    );

    _historyService.addCalculation(history);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('BMI saved: ${bmi.toStringAsFixed(1)} ($category)'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bmi = BMIService.calculateBMI(_height, _weight);
    final category = BMIService.getBMICategory(bmi);
    final advice = BMIService.getBMIAdvice(bmi);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1 + (_animationController.value * 0.05),
                      child: BMIIndicator(
                        bmi: bmi,
                        category: category,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              GlassCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CustomSlider(
                      label: 'Height',
                      unit: 'cm',
                      value: _height,
                      min: 100,
                      max: 250,
                      onChanged: (value) => setState(() => _height = value),
                    ),
                    const SizedBox(height: 32),
                    CustomSlider(
                      label: 'Weight',
                      unit: 'kg',
                      value: _weight,
                      min: 30,
                      max: 200,
                      onChanged: (value) => setState(() => _weight = value),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  advice,
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                label: 'Save Result',
                onPressed: _calculateAndSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
