import 'package:flutter/material.dart';

class TipScreen extends StatelessWidget {
  const TipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tip Calculator')),
      body: const Center(
        child: Text('Tip Calculator coming soon', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
