import 'package:flutter/material.dart';

class ScientificScreen extends StatelessWidget {
  const ScientificScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scientific Calculator')),
      body: const Center(
        child: Text('Scientific Calculator coming soon', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
