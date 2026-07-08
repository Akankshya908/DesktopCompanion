import 'package:app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Drink Water updates progress and goal text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Desktop Companion'), findsOneWidget);
    expect(find.text('💧 0 / 8 Glasses'), findsOneWidget);
    expect(find.text('💧 1 / 8 Glasses'), findsNothing);

    await tester.tap(find.text('Drink Water'));
    await tester.pump();

    expect(find.text('💧 1 / 8 Glasses'), findsOneWidget);
    expect(find.text('100% of your goal reached'), findsOneWidget);
  });
}
