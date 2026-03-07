import 'package:flutter/material.dart';

class TimezoneScreen extends StatelessWidget {
  const TimezoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timezone Converter')),
      body: const Center(
        child: Text('Timezone Converter coming soon', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
