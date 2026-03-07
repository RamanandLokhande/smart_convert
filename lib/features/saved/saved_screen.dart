import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Items')),
      body: const Center(
        child: Text('Nothing saved yet', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
