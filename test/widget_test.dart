import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:raaga_music_player/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RaagaApp());

    // Just verify that the app renders without crashing.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
