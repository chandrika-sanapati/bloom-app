import 'package:bloom/app/bloom_app.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Bloom shell loads persisted Today, Plants, and Discover UI', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final services = await BloomServices.bootstrap(
      database: BloomDatabase.memory(),
      preferences: await SharedPreferences.getInstance(),
    );

    await tester.pumpWidget(BloomApp(services: services));
    await tester.pumpAndSettle();

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
    expect(find.text('Peace Lily').hitTestable(), findsOneWidget);

    await tester.tap(find.text('Peace Lily').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('Open tasks'), findsOneWidget);
    expect(find.text('Timeline'), findsOneWidget);
    expect(find.text('Watered'), findsOneWidget);
    expect(find.text('Log care'), findsOneWidget);

    await tester.tap(find.text('About').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('Plant overview'), findsOneWidget);
    expect(find.text('Care plan'), findsOneWidget);
    expect(find.textContaining('Keep soil lightly moist'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add plant').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('Popular houseplants'), findsOneWidget);
    expect(find.text('Scan a plant'), findsOneWidget);

    await tester.enterText(find.byType(SearchBar), 'pothos');
    await tester.pumpAndSettle();
    expect(find.text('Search results'), findsOneWidget);
    expect(find.text('Pothos'), findsOneWidget);
    expect(find.text('Snake Plant').hitTestable(), findsNothing);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Care reminders'), findsOneWidget);
    expect(find.text('Bloom'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });
}
