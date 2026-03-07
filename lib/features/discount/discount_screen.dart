import 'package:flutter/material.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discount Calculator')),
      body: const Center(
        child: Text('Discount Calculator coming soon', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
