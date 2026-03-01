import 'package:flutter/material.dart';
import '../../core/utils/validators.dart';
import '../../services/emi_service.dart';
import '../../widgets/custom_input_field.dart';

class EmiScreen extends StatefulWidget {
  const EmiScreen({Key? key}) : super(key: key);

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
  final TextEditingController _principalCtrl = TextEditingController();
  final TextEditingController _rateCtrl = TextEditingController();
  final TextEditingController _monthsCtrl = TextEditingController();
  double? _emi;

  void _calculate() {
    final p = Validators.parseDouble(_principalCtrl.text);
    final r = Validators.parseDouble(_rateCtrl.text);
    final n = int.tryParse(_monthsCtrl.text);
    if (p == null || r == null || n == null || n <= 0) {
      setState(() => _emi = null);
      return;
    }
    final value = EmiService.calculateEmi(principal: p, annualRate: r, months: n);
    setState(() => _emi = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CustomInputField(controller: _principalCtrl, hint: 'Loan amount', onChanged: (_) => _calculate()),
            const SizedBox(height: 8),
            CustomInputField(controller: _rateCtrl, hint: 'Annual interest (%)', onChanged: (_) => _calculate()),
            const SizedBox(height: 8),
            CustomInputField(controller: _monthsCtrl, hint: 'Duration (months)', keyboardType: TextInputType.number, onChanged: (_) => _calculate()),
            const SizedBox(height: 16),
            if (_emi != null) Text('Monthly EMI: ${_emi!.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
