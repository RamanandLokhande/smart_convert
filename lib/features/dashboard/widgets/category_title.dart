import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String title;

  const CategoryTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
