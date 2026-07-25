import 'package:bloom/app/bloom_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Bloom launches into a navigable Material 3 shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BloomApp());

    expect(find.text('Today'), findsWidgets);
    expect(find.text('My Plants'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.byTooltip('Settings'), findsOneWidget);

    final context = tester.element(find.byType(NavigationBar));
    expect(Theme.of(context).useMaterial3, isTrue);

    await tester.tap(find.text('My Plants').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('saved houseplant collection'), findsOneWidget);

    await tester.tap(find.text('Discover').last);
    await tester.pumpAndSettle();
    expect(find.text('Scan a plant'), findsOneWidget);
    expect(find.text('Search for plants'), findsOneWidget);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Care reminders'), findsOneWidget);
    expect(find.text('Privacy'), findsOneWidget);
  });
}
