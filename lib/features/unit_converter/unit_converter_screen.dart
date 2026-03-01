import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/validators.dart';
import '../../services/unit_service.dart';
import '../../widgets/custom_input_field.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({Key? key}) : super(key: key);

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  String _category = AppConstants.unitCategories.keys.first;
  String? _fromUnit;
  String? _toUnit;
  final TextEditingController _inputController = TextEditingController();
  double _result = 0;

  @override
  void initState() {
    super.initState();
    _setUnits();
  }

  void _setUnits() {
    final list = AppConstants.unitCategories[_category]!;
    _fromUnit = list.first;
    _toUnit = list.length > 1 ? list[1] : list.first;
    _recalculate();
  }

  void _recalculate() {
    final value = Validators.parseDouble(_inputController.text) ?? 0;
    if (_fromUnit == null || _toUnit == null) return;
    final res = UnitService.convert(category: _category, from: _fromUnit!, to: _toUnit!, value: value);
    setState(() => _result = res);
  }

  @override
  Widget build(BuildContext context) {
    final units = AppConstants.unitCategories[_category]!;
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _category,
              items: AppConstants.unitCategories.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() { _category = v; _setUnits(); });
              },
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _fromUnit,
                  items: units.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() { _fromUnit = v; _recalculate(); }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<String>(
                  value: _toUnit,
                  items: units.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() { _toUnit = v; _recalculate(); }),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            CustomInputField(
              controller: _inputController,
              hint: 'Enter value',
              onChanged: (_) => _recalculate(),
            ),
            const SizedBox(height: 18),
            Text('Result', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('$_result', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
