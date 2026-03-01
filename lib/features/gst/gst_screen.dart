import 'package:flutter/material.dart';
import '../../core/utils/validators.dart';
import '../../services/gst_service.dart';
import '../../widgets/custom_input_field.dart';

class GstScreen extends StatefulWidget {
  const GstScreen({Key? key}) : super(key: key);

  @override
  State<GstScreen> createState() => _GstScreenState();
}

class _GstScreenState extends State<GstScreen> {
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _gstCtrl = TextEditingController();
  bool _add = true;
  double? _result;

  void _calculate() {
    final a = Validators.parseDouble(_amountCtrl.text);
    final g = Validators.parseDouble(_gstCtrl.text);
    if (a == null || g == null) { setState(() => _result = null); return; }
    final res = _add ? GstService.addGst(amount: a, gstPercent: g) : GstService.removeGst(amountWithGst: a, gstPercent: g);
    setState(() => _result = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GST Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(children: [
              Expanded(child: ElevatedButton(onPressed: () { setState(() { _add = true; _calculate(); }); }, child: const Text('Add GST'))),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(onPressed: () { setState(() { _add = false; _calculate(); }); }, child: const Text('Remove GST'))),
            ]),
            const SizedBox(height: 12),
            CustomInputField(controller: _amountCtrl, hint: _add ? 'Amount' : 'Amount with GST', onChanged: (_) => _calculate()),
            const SizedBox(height: 8),
            CustomInputField(controller: _gstCtrl, hint: 'GST %', onChanged: (_) => _calculate()),
            const SizedBox(height: 16),
            if (_result != null) Text(_add ? 'Final amount: ${_result!.toStringAsFixed(2)}' : 'Original amount: ${_result!.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
