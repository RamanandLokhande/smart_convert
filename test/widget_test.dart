// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:currency_converter/main.dart' as app;

void main() {
  testWidgets('App loads and shows dashboard title', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const app.DailyUtilityApp());

    // Verify that the dashboard app bar title is present.
    expect(find.text('Smart Converter'), findsOneWidget);

    // The search bar hint text should also be visible.
    expect(find.text('Search utility...'), findsOneWidget);

    // Ensure no counter text exists (legacy from boilerplate).
    expect(find.text('0'), findsNothing);
  });
}
