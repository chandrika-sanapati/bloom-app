import 'package:bloom/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Bloom starts with a Material 3 home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BloomApp());

    expect(find.text('Bloom'), findsOneWidget);
    expect(find.text('Your plant-care companion'), findsOneWidget);
    expect(find.byIcon(Icons.eco_outlined), findsOneWidget);

    final context = tester.element(find.text('Bloom'));
    expect(Theme.of(context).useMaterial3, isTrue);
  });
}
