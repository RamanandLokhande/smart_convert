import 'package:flutter/material.dart';
import '../../core/utils/validators.dart';
import '../../services/fuel_service.dart';
import '../../widgets/custom_input_field.dart';

class FuelScreen extends StatefulWidget {
  const FuelScreen({Key? key}) : super(key: key);

  @override
  State<FuelScreen> createState() => _FuelScreenState();
}

class _FuelScreenState extends State<FuelScreen> {
  final TextEditingController _distanceCtrl = TextEditingController();
  final TextEditingController _mileageCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  double? _fuelNeeded;
  double? _totalCost;

  void _calculate() {
    final d = Validators.parseDouble(_distanceCtrl.text);
    final m = Validators.parseDouble(_mileageCtrl.text);
    final p = Validators.parseDouble(_priceCtrl.text);
    if (d == null || m == null || p == null) {
      setState(() { _fuelNeeded = null; _totalCost = null; });
      return;
    }
    final f = FuelService.fuelNeeded(distanceKm: d, mileageKmPerL: m);
    final cost = FuelService.totalCost(distanceKm: d, mileageKmPerL: m, pricePerL: p);
    setState(() { _fuelNeeded = f; _totalCost = cost; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel Cost Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CustomInputField(controller: _distanceCtrl, hint: 'Distance (km)', onChanged: (_) => _calculate()),
            const SizedBox(height: 8),
            CustomInputField(controller: _mileageCtrl, hint: 'Mileage (km per liter)', onChanged: (_) => _calculate()),
            const SizedBox(height: 8),
            CustomInputField(controller: _priceCtrl, hint: 'Fuel price per liter', onChanged: (_) => _calculate()),
            const SizedBox(height: 16),
            if (_fuelNeeded != null) Text('Fuel needed: ${_fuelNeeded!.toStringAsFixed(2)} L', style: Theme.of(context).textTheme.titleLarge),
            if (_totalCost != null) Text('Total cost: ${_totalCost!.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
