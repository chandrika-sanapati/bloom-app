import 'package:bloom/app/bloom_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Bloom shell shows fixture Today, Plants, and Discover UI', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BloomApp());

    expect(find.text("Today's tasks"), findsOneWidget);
    expect(find.text('Snake Plant'), findsWidgets);
    expect(find.text('Water'), findsWidgets);

    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();
    expect(find.text('Completed'), findsOneWidget);

    await tester.tap(find.text('My Plants').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('plants in your collection'), findsOneWidget);
    expect(find.text('Add plant'), findsOneWidget);
    expect(find.text('Peace Lily'), findsOneWidget);

    await tester.tap(find.text('Add plant'));
    await tester.pumpAndSettle();
    expect(find.text('Popular houseplants'), findsOneWidget);
    expect(find.text('Scan a plant'), findsOneWidget);

    await tester.enterText(find.byType(SearchBar), 'pothos');
    await tester.pumpAndSettle();
    expect(find.text('Search results'), findsOneWidget);
    expect(find.text('Pothos'), findsOneWidget);
    expect(find.text('Snake Plant'), findsNothing);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Care reminders'), findsOneWidget);
    expect(find.text('Bloom'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });
}
